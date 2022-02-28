# How to retrieve a dropped table in a database?

Duration: 1 minute

If the RECYCLEBIN initialization parameter is set to ON (the default in 10g), then dropping this table will place it in the recycle bin. To see if you can un-drop a table run the following data dictionary query:

```
<copy>
select object_name, 
    original_name, 
    type, 
    can_undrop, 
    can_purge
from recyclebin;
</copy>
```

To retrieve tables we use the flashback command:

```
<copy>
FLASHBACK TABLE TABLE_NAME TO BEFORE DROP;
</copy>
```

For example, to retrieve employees table after checking the recycle bin:

```
flashback table EMPLOYEES to before drop;
select count(*) employees
from employees;
```

## Learn More

* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
