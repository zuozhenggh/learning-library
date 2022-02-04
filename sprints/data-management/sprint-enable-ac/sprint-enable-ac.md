# How to enable Application Continuity?
Duration: 1 minutes

## Enable Application Continuity

Enable application continuity for the TPURGENT service as the ADMIN user:

```
<copy>
execute DBMS_APP_CONT_ADMIN.ENABLE_AC('databaseid_tpurgent.adb.oraclecloud.com', 'LEVEL1', 600);
</copy>
```

## Learn More

* [Configure Your Service to Enable Application Continuity](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/application-continuity-configure.html#GUID-BFD31E09-1BA2-4D4B-AFBC-42D54B3E2BF0)
