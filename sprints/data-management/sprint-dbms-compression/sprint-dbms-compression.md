# How do I get Compression Ratio? 
Duration: 10 minutes

The DBMS_COMPRESSION package gathers compression-related information within a database environment. This includes tools for estimating compressibility of a table for both partitioned and non-partitioned tables, and gathering row-level compression information on previously compressed tables. This gives the user with adequate information to make compression-related decision. 

## Get Compression Ratio

**Login to SQLPlus and run the following statement:**

Using Advisor – The GET\_COMPRESSION\_RATIO Procedure. Compression advisor typically provides fairly accurate estimates, of the actual compression results that may be obtained, after implementing compression. line..   

```
<copy>  
set serveroutput on
DECLARE
blkcnt_cnt pls_integer;
blkcnt_uncmp pls_integer;
row_cmp pls_integer;
row_uncmp pls_integer;
cmp_ratio pls_integer;
blkcnt_cmp  PLS_INTEGER;
comptype_str varchar2(100);
cmptype_str VARCHAR2(1000);
BEGIN
DBMS_COMPRESSION.GET_COMPRESSION_RATIO ('SYSTEM', 'SH', 'SALES', '',
DBMS_COMPRESSION.COMP_ADVANCED, blkcnt_cmp, blkcnt_uncmp, row_cmp,
row_uncmp, cmp_ratio, cmptype_str);
DBMS_OUTPUT.PUT_LINE('Block count compressed = '|| blkcnt_cmp);
DBMS_OUTPUT.PUT_LINE('Block count uncompressed = '|| blkcnt_uncmp);
DBMS_OUTPUT.PUT_LINE('Row count per block compressed = '|| row_cmp);
DBMS_OUTPUT.PUT_LINE('Row count per block uncompressed = '|| row_uncmp);
DBMS_OUTPUT.PUT_LINE('Compression type = '|| comptype_str);
DBMS_OUTPUT.PUT_LINE('Compression ratio = '|| cmp_ratio);
END;
/  
</copy>
```
 
## Learn More
* [Get Service Name](https://docs.oracle.com/cd/B19306_01/server.102/b14237/initparams188.htm )
