# How do I connect to different Oracle databases that are installed in a same Linux server?

Duration: 5 minutes

If you use a oracle container database, you can login to the database using the steps that are below:

1. login to the database via sqlplus

    ```
    <copy> show pdbs; <copy/>
    ```

3. alter session set container to 

    ```
    <copy> container_db_name; <copy/>
    ```