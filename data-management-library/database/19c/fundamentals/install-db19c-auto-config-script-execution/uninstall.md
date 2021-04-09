## **STEP 8**: Uninstall Oracle Database 19c (Optional)

If you need to uninstall the database, follow the steps below. If you plan to continue on to the other labs in this workshop, do not uninstall the database.

1. Change to the directory where the Oracle Database 19c software is installed.

    ```nohighlighting
    $ <copy>cd /u01/app/oracle/product/19.0.0/dbhome_2/deinstall</copy>
    ```
2. Launch deinstall.

    ```nohighlighting
    $ <copy>./deinstall</copy>
    ```
3. For the first question, press **Enter** because you did not create a database after the installation.

    ```nohighlighting
    Specify the list of database names that are configured in this Oracle home []:
    ```
4. Specify the Oracle Home path.

    ```nohighlighting
    Oracle Home selected for deinstall is: <copy>/u01/app/oracle/product/19.0.0/dbhome_2</copy>
    ```
5. Enter the inventory location.

    ```nohighlighting
    Inventory Location where the Oracle home registered is: <copy>/u01/app/oraInventory</copy>
    ```
6. Enter **y** to continue.

    ```nohighlighting
    Do you want to continue (y - yes, n - no)? [n]: <copy>y</copy>
    ```
7. Review the [deinstall_output.txt](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-install-oracle-database-with-automatic-root-scripts-execution/files/deinstall_output.txt) file to ensure that the software is uninstalled successfully.

    ```nohighlighting
    Oracle Universal Installer cleanup was successful.
    ...
    Oracle deinstall tool successfully cleaned up temporary directories.
    ############# ORACLE DEINSTALL TOOL END #############
    Quit the session.
    ```
8. Quit the session.

    ```nohighlighting
    $ <copy>exit</copy>
    ```
