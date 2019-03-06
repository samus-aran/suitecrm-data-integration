#/bin/sh

echo ""
echo " We are about to install SuiteCRM Analytics Data Integration"
echo " Make sure you have configured the install.properties correctly"
echo ""
echo " *** IMPORTANT! *** Running this setup will discard any previous installations!"
echo ""

WORKING_DIR=$(pwd);

read -r -p " Have you configured install.properties? [y/N] " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
	echo ""
	echo " Installing..."
	echo ""

	if [ ! -d install/installation-files ]; then

		echo " Downloading Installation Files"

        	mkdir install/installation-files

		wget --progress=dot:giga https://downloads.sourceforge.net/project/pentaho/Pentaho%208.0/client-tools/pdi-ce-8.0.0.0-28.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fpentaho%2Ffiles%2FPentaho%25208.0%2Fclient-tools%2Fpdi-ce-8.0.0.0-28.zip -O install/installation-files/suitecrm-client.zip
	
		# For local testing ONLY
		#wget --progress=dot:giga http://localhost:8000/pdi-ce-8.0.0.0-28.zip -O install/installation-files/suitecrm-client.zip

	fi

	 if [ ! -d suitecrm-data-integration/data-integration ]; then

		echo " Extracting files.."
		echo ""

	        unzip install/installation-files/suitecrm-client.zip -d suitecrm-data-integration/ | awk 'BEGIN {ORS=" "} {if(NR%100==0)print "."}'
		cp -Rf install/mysql-connector-java-5.1.47.jar suitecrm-data-integration/data-integration/lib/

		echo ""

        fi

	file="./install.properties"

	if [ -f "$file" ]
	then

		while IFS='=' read -r key value
		do
			key=$(echo $key | tr '.' '_')
			eval ${key}=\${value}
		done < "$file"

		cp -Rf install/suitecrm-data-integration/{.[!.],}* suitecrm-data-integration/configuration

		sed -i 's|@@SOLUTION_ROOT_DIR@@|'${WORKING_DIR}'|' suitecrm-data-integration/configuration/config
		sed -i 's|@@JVM_SIZE@@|'${JVM_SIZE}'|' suitecrm-data-integration/configuration/config

		# JNDI Configuration

		sed -i 's|@@SUITECRM_HOST@@|'${SUITECRM_HOST}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_DATABASE@@|'${SUITECRM_DATABASE}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_PORT@@|'${SUITECRM_PORT}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_USERNAME@@|'${SUITECRM_USERNAME}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_PASSWORD@@|'${SUITECRM_PASSWORD}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties

		sed -i 's|@@SUITECRM_ANALYTICS_HOST@@|'${SUITECRM_ANALYTICS_HOST}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_ANALYTICS_PORT@@|'${SUITECRM_ANALYTICS_PORT}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_ANALYTICS_DATABASE@@|'${SUITECRM_ANALYTICS_DATABASE}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_ANALYTICS_USERNAME@@|'${SUITECRM_ANALYTICS_USERNAME}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties
		sed -i 's|@@SUITECRM_ANALYTICS_PASSWORD@@|'${SUITECRM_ANALYTICS_PASSWORD}'|'  suitecrm-data-integration/configuration/simple-jndi/jdbc.properties

		sed -i 's|@@ETL_ROOT_DIR@@|'${WORKING_DIR}/suitecrm-data-integration/solution'|'  suitecrm-data-integration/configuration/.kettle/kettle.properties

		# Run ETL scripts to check DB connections and create DDL

		echo " Checking database Connections..."

		cd ${WORKING_DIR}/install/
		./check-db-connections.sh

		if [ ! -f installation-files/suitecrm-db-passed ]; then
			echo ""
			echo " We could not establish a connection to the SuiteCRM database!"
			echo " Please check the JDBC connection properties and run setup again."
		else
			echo ""
			echo " Connection to the SuiteCRM database was successful!"

			rm -Rf installation-files/suitecrm-db-passed

			if [ ! -f installation-files/suitecrm-dwh-db-passed ]; then
				echo ""
	                        echo " We could not establish a connection to the SuiteCRM Analytics database!"
        	                echo " Please check the JDBC connection properties and run setup again."
			else
				echo ""
				echo " Connection to the SuiteCRM Analytics database was successful!"
				echo ""

				rm -Rf installation-files/suitecrm-dwh-db-passed

				# Execute DDL Scripts

				echo " Creating tables..."

				./execute-ddl-scripts.sh

				if [ ! -f installation-files/ddl-passed ]; then
					echo ""
                        		echo " We could not create all the tables in the SuiteCRM DWH!"
                        		echo " Please make sure the SuiteCRM Analytics user has create table privileges and run setup again."
                		else
					echo ""
                        		echo " The SuiteCRM DWH tables were created successfully!"

					rm -Rf installation-files/ddl-passed

					# Populate Control table with additional properties

					./populate-control.sh
				fi
                	fi
		fi

		if [ "$SMTP_ENABLED" -eq "1" ]; then
			echo " We will configure your email properties and send you a test email"
                        echo " If you do not get this email then please check the log in ......"
			./send-test-email.sh

                fi

		echo ""
                echo "-------------------------------------------------------------"
                echo ""
                echo " Installation is complete!"
                echo ""
                echo "-------------------------------------------------------------"


		

	else
		echo "$file not found."
	fi

	
else
	echo " Exiting!"
	echo ""
	exit

fi



