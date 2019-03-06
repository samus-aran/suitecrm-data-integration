# SuiteCRM Data Integration
SuiteCRM Data Integration handles the population of the Data Warehouse. Its job is to pull data from SuiteCRM, denormalise the data and prepare it for analytics using SuiteCRM Analytics
# Prerequisites
Linux OS (Tested with Ubuntu 18.04)
    • Oracle Java 1.8
    • wget
    • curl
    • unzip
    • root privileges to MySQL

# Install Java
On the commandline execute the following:

    • sudo add-apt-repository ppa:webupd8team/java
    • sudo apt-get update
    • sudo apt-get install oracle-java8-installer
# Create the SuiteCRM Data Integration Database
We need to create an empty database in MySQL to hold the data warehouse tables.
Once created keep a note of the name of the database as we will need it later when we configure the solution
# Download Package
    • Download the SuiteCRM-Data-Integration.zip
    • Unzip somewhere on the file system
# Configure Installation
    • Open the install.properties in a text editor
    • Configure the database connection properties
        ◦ Properties that start with SUITECRM_ should point to your existing SuiteCRM Installation
        ◦ Properties that start with SUITECRM_ANALYTICS_ should point to the newly created database in the previous steps.
        ◦ NOTE: The user for the SUITECRM_ANALYTCS database should have root permissions so that the installation can create the Data Warehouse tables
# Run The Setup
Run the setup script to create the data warehouse and configure the solution. On the commandline execute:
./setup-suitecrm-data-integration.sh
# Populate the Data Warehouse
Now that the solution is configured we can populate the Data Warehouse with data from SuiteCRM. Simply run:
./run-suitecrm-data-integration.sh
This script will get all the data from from SuiteCRM on the first run and with any future runs, it will get the latest changed data. This means the first run could take some time but subsequent runs will be faster depending on the volume of new data.
Check The Data Warehouse
Once the script above has been completed without errors you can log into MySQL to check that the SuiteCRM Data Warehouse contains data.
# SuiteCRM Analytics
# Prerequisites
Linux OS (Tested with Ubuntu 18.04)
    • Oracle Java 1.8
    • wget
    • curl
    • unzip
# Install Java
On the commandline execute the following:

    • sudo add-apt-repository ppa:webupd8team/java
    • sudo apt-get update
    • sudo apt-get install oracle-java8-installer
# Download Package
    • Download the SuiteCRM-Analytics.zip
    • Unzip somewhere on the file system
# Configure Installation
    • Open the install.properties in a text editor
    • Configure the database connection properties
        ◦ SuiteCRM Analytics only needs connection details to the SuiteCRM Data Warehouse.
# Run The setup
Run the setup script to configure the server database connections and deploy the app. On the commandline execute:
./setup-suitecrm-analytics.sh
Once the installation has finished we can start the SuiteCRM Analytics Server. On the commandline execute:
./start-suitecrm-analytics.sh
You can stop the SuiteCRM Analytics server by executing:
./stop-suitecrm-analytics.sh
# Accessing the SuiteCRM Analytics Frontend
    • Open a Web Browser
    • Navigate to the host of the app on port 8080. For example:
        ◦ http://localhost:8080

The default username is admin
The default password is password