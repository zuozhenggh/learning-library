--------------------------------------------------------
--  DDL for Table SRC_SALES_PERSON
--------------------------------------------------------

  CREATE TABLE "ODI_PARAMETERS"."SRC_SALES_PERSON" 
   (	"SALES_PERS_ID" NUMBER(5,0), 
	"FIRST_NAME" VARCHAR2(50 BYTE), 
	"LAST_NAME" VARCHAR2(50 BYTE), 
	"HIRE_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
   ;
--------------------------------------------------------
--  DDL for Table SRC_AGE_GROUP
--------------------------------------------------------

  CREATE TABLE "ODI_PARAMETERS"."SRC_AGE_GROUP" 
   (	"AGE_MIN" NUMBER(3,0), 
	"AGE_MAX" NUMBER(3,0), 
	"AGE_RANGE" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
   ;
REM INSERTING into ODI_PARAMETERS.SRC_SALES_PERSON
SET DEFINE OFF;
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (10,' Georges                                          ',' Hamilton                                         ',to_date('15-JAN-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (11,' Andrew                                           ',' Andersen                                         ',to_date('22-FEB-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (12,' John                                             ',' Galagers                                         ',to_date('20-APR-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (13,' Jeffrey                                          ',' Jeferson                                         ',to_date('10-JUN-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (20,' Jennie                                           ',' Daumesnil                                        ',to_date('28-FEB-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (21,' Steve                                            ',' Barrot                                           ',to_date('24-SEP-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (22,' Mary                                             ',' Carlin                                           ',to_date('14-MAR-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (30,' Paul                                             ',' Moore                                            ',to_date('11-MAR-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (31,' Paul                                             ',' Edwood                                           ',to_date('18-MAR-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (32,' Megan                                            ',' Keegan                                           ',to_date('29-MAY-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (40,' Rodolph                                          ',' Bauman                                           ',to_date('29-MAY-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (41,' Stanley                                          ',' Fischer                                          ',to_date('12-AUG-20','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (42,' Brian                                            ',' Schmidt                                          ',to_date('25-AUG-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (50,' Anish                                            ',' Ishimoto                                         ',to_date('30-JAN-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (51,' Cynthia                                          ',' Nagata                                           ',to_date('28-FEB-19','DD-MON-RR'));
Insert into ODI_PARAMETERS.SRC_SALES_PERSON (SALES_PERS_ID,FIRST_NAME,LAST_NAME,HIRE_DATE) values (52,' William                                          ',' Kudo                                             ',to_date('28-MAR-19','DD-MON-RR'));
REM INSERTING into ODI_PARAMETERS.SRC_AGE_GROUP
SET DEFINE OFF;
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (0,19,'Less than 20 years
');
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (20,29,'20-29 years
');
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (30,39,'30-39 years
');
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (40,49,'40-49 years
');
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (50,59,'50-59 years
');
Insert into ODI_PARAMETERS.SRC_AGE_GROUP (AGE_MIN,AGE_MAX,AGE_RANGE) values (60,110,'60 years or more
');
Commit;