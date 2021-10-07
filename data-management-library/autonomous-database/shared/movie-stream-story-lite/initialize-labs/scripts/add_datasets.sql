create or replace procedure add_datasets 
as 

    user_name       varchar2(100) := 'moviestream';
    uri_landing     varchar2(1000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_landing/o';
    uri_gold        varchar2(1000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_gold/o';
--    uri_sandbox     varchar2(1000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_sandbox/o';    
    uri_sandbox     varchar2(1000) := 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/adwc4pm/b/moviestream_sandbox/o';    

    csv_format      varchar2(1000) := '{"dateformat":"YYYY-MM-DD", "skipheaders":"1", "delimiter":",", "ignoreblanklines":"true", "removequotes":"true", "blankasnull":"true", "trimspaces":"lrtrim", "truncatecol":"true", "ignoremissingcolumns":"true"}';
    pipe_format     varchar2(1000) := '{"dateformat":"YYYY-MM-DD", "skipheaders":"1", "delimiter":"|", "ignoreblanklines":"true", "removequotes":"true", "blankasnull":"true", "trimspaces":"lrtrim", "truncatecol":"true", "ignoremissingcolumns":"true"}';
    json_format     varchar2(1000) := '{"skipheaders":"0", "delimiter":"\n", "ignoreblanklines":"true"}';
    parquet_format  varchar2(1000) := '{"type":"parquet",  "schema": "all"}';
    type table_array IS VARRAY(24) OF VARCHAR2(30); 
    table_list table_array := table_array( 'ext_genre',
                                            'ext_movie',
                                            'ext_customer_contact',
                                            'ext_customer_extension',
                                            'ext_customer_promotions',
                                            'ext_customer_segment',
                                            'ext_moviestream_churn',
                                            'ext_pizza_location',
                                            'ext_potential_churners',
                                            'ext_custsales',
                                            'json_movie_data_ext',
                                            'custsales',
                                            'custsales_promotions',
                                            'customer_contact',
                                            'customer_extension',
                                            'customer_promotions',
                                            'customer',
                                            'genre',
                                            'movie',
                                            'moviestream_churn',
                                            'customer_segment',
                                            'pizza_location',
                                            'customer_nearest_pizza',
                                            'time');



begin   

    -- Start
    moviestream_write ('begin');
    -- initialize
    moviestream_write('** dropping tables **');

    -- Loop over tables and drop
    for i in 1 .. table_list.count loop
        begin
            moviestream_write(' - ' || table_list(i));
            moviestream_exec ( 'drop table ' || table_list(i), true );
        exception
            when others then
                moviestream_write(' - ...... tried to delete ' || table_list(i) || ' but table was not found');
        end;
    end loop;
    
    moviestream_write('** remove spatial metadata **');
    delete from user_sdo_geom_metadata
    where table_name in ('CUSTOMER_CONTACT','PIZZA_LOCATION');
    commit;


    -- Create a time table  over 2 years.  Used to densify time series calculations
    moviestream_write('** create time table **');

    moviestream_exec ( 'create table time as
    select trunc (to_date(''20210101'',''YYYYMMDD'')-rownum) as day_id
    from dual connect by rownum < 732');

    moviestream_write(' - populate time table');
    moviestream_exec ( 'alter table time
        add (
            day_name as (to_char(day_id, ''DAY'')),
            day_dow as (to_char(day_id, ''D'')),
            day_dom as (to_char(day_id, ''DD'')),
            day_doy as (to_char(day_id, ''DDD'')),
            week_wom as (to_char(day_id, ''W'')),
            week_woy as (to_char(day_id, ''WW'')),
            month_moy as (to_char(day_id, ''MM'')),
            month_name as (to_char(day_id, ''MONTH'')),
            month_aname as (to_char(day_id, ''MON'')),
            quarter_name as (''Q''||to_char(day_id, ''Q'')||''-''||to_char(day_id, ''YYYY'')),
            quarter_qoy as (to_char(day_id, ''Q'')),
            year_name as (to_char(day_id, ''YYYY''))
        )');

    -- Using public buckets  so credentials are not required
    -- Create external tables then do a CTAS
    -- BASE DATA SETS
    begin
        moviestream_write(' ** create temporary external tables ** ');
        moviestream_write(' - ext_genre');
        dbms_cloud.create_external_table(
            table_name => 'ext_genre',
            file_uri_list => uri_gold || '/genre/*.csv',
            format => csv_format,
            column_list => 'genre_id number, name varchar2(30)'
            );

        moviestream_write(' - ext_customer_segment');
        dbms_cloud.create_external_table(
            table_name => 'ext_customer_segment',
            file_uri_list => uri_landing || '/customer_segment/*.csv',
            format => csv_format,
            column_list => 'segment_id number, name varchar2(100), short_name varchar2(100)'
            );

        moviestream_write(' - ext_potential_churner');            
        dbms_cloud.create_external_table(
            table_name => 'ext_potential_churners',
            file_uri_list => uri_sandbox || '/potential_churners/*.csv',
            format => csv_format,
            column_list => 'cust_id number, will_churn number, prob_churn number'
            );             

        moviestream_write(' - ext_movie'); 
        dbms_cloud.create_external_table(
            table_name => 'ext_movie',
            file_uri_list => uri_gold || '/movie/*.json',
            format => json_format,
            column_list => 'doc varchar2(30000)'
            );

        moviestream_write(' - ext_custsales');
        dbms_cloud.create_external_table(
            table_name => 'ext_custsales',
            file_uri_list => uri_gold || '/custsales/*.parquet',
            format => parquet_format,
            column_list => 'MOVIE_ID NUMBER(20,0),
                            LIST_PRICE BINARY_DOUBLE,
                            DISCOUNT_TYPE VARCHAR2(4000 BYTE),
                            PAYMENT_METHOD VARCHAR2(4000 BYTE),
                            GENRE_ID NUMBER(20,0),
                            DISCOUNT_PERCENT BINARY_DOUBLE,
                            ACTUAL_PRICE BINARY_DOUBLE,
                            DEVICE VARCHAR2(4000 BYTE),
                            CUST_ID NUMBER(20,0),
                            OS VARCHAR2(4000 BYTE),
                            DAY_ID date,
                            APP VARCHAR2(4000 BYTE)'
        ); 

        moviestream_write(' - ext_pizza_location');       
        dbms_cloud.create_external_table(
            table_name => 'ext_pizza_location',
            file_uri_list => uri_landing || '/pizza_location/*.csv',
            format => csv_format,
            column_list => 'PIZZA_LOC_ID NUMBER,
                            LAT NUMBER,
                            LON NUMBER,
                            CHAIN_ID NUMBER,
                            CHAIN VARCHAR2(30 BYTE),
                            ADDRESS VARCHAR2(250 BYTE),
                            CITY VARCHAR2(250 BYTE),
                            STATE VARCHAR2(26 BYTE),
                            POSTAL_CODE VARCHAR2(38 BYTE),
                            COUNTY VARCHAR2(250 BYTE)'
            ); 

        moviestream_write(' - ext_customer_contact');  
        dbms_cloud.create_external_table(
            table_name => 'ext_customer_contact',
            file_uri_list => uri_gold || '/customer_contact/*.csv',
            format => csv_format,
            column_list => 'CUST_ID                  NUMBER,         
                            LAST_NAME                VARCHAR2(200 byte), 
                            FIRST_NAME               VARCHAR2(200 byte), 
                            EMAIL                    VARCHAR2(500 byte), 
                            STREET_ADDRESS           VARCHAR2(400 byte), 
                            POSTAL_CODE              VARCHAR2(10 byte), 
                            CITY                     VARCHAR2(100 byte), 
                            STATE_PROVINCE           VARCHAR2(100 byte), 
                            COUNTRY                  VARCHAR2(400 byte), 
                            COUNTRY_CODE             VARCHAR2(2 byte), 
                            CONTINENT                VARCHAR2(400 byte),
                            YRS_CUSTOMER             NUMBER, 
                            PROMOTION_RESPONSE       NUMBER,         
                            LOC_LAT                  NUMBER,         
                            LOC_LONG                 NUMBER' 

            ); 

        moviestream_write(' - ext_customer_extension');
        dbms_cloud.create_external_table(
            table_name => 'ext_customer_extension',
            file_uri_list => uri_landing || '/customer_extension/*.csv',
            format => csv_format,
            column_list => 'CUST_ID                      NUMBER,         
                            LAST_NAME                    VARCHAR2(200 byte),
                            FIRST_NAME                   VARCHAR2(200 byte), 
                            EMAIL                        VARCHAR2(500 byte),
                            AGE                          NUMBER,         
                            COMMUTE_DISTANCE             NUMBER,         
                            CREDIT_BALANCE               NUMBER,         
                            EDUCATION                    VARCHAR2(40 byte),
                            FULL_TIME                    VARCHAR2(40 byte),
                            GENDER                       VARCHAR2(20 byte), 
                            HOUSEHOLD_SIZE               NUMBER,         
                            INCOME                       NUMBER,         
                            INCOME_LEVEL                 VARCHAR2(20 byte), 
                            INSUFF_FUNDS_INCIDENTS       NUMBER,         
                            JOB_TYPE                     VARCHAR2(200 byte),
                            LATE_MORT_RENT_PMTS          NUMBER,         
                            MARITAL_STATUS               VARCHAR2(8 byte),
                            MORTGAGE_AMT                 NUMBER,         
                            NUM_CARS                     NUMBER,         
                            NUM_MORTGAGES                NUMBER,         
                            PET                          VARCHAR2(40 byte), 
                            RENT_OWN                     VARCHAR2(40 byte), 
                            SEGMENT_ID                   NUMBER,
                            WORK_EXPERIENCE              NUMBER,         
                            YRS_CURRENT_EMPLOYER         NUMBER,         
                            YRS_RESIDENCE                NUMBER'
            );


        moviestream_write(' - ext_customer_promotions');
        dbms_cloud.create_external_table(
            table_name => 'ext_customer_promotions',
            file_uri_list => uri_sandbox || '/customer_promotions/*.csv',
            format => csv_format,
            column_list => 'CUST_ID NUMBER, 
                            LAST_NAME VARCHAR2(200 BYTE), 
                            FIRST_NAME VARCHAR2(200 BYTE), 
                            EMAIL VARCHAR2(500 BYTE), 
                            STREET_ADDRESS VARCHAR2(400 BYTE), 
                            POSTAL_CODE VARCHAR2(10 BYTE), 
                            CITY VARCHAR2(100 BYTE), 
                            STATE_PROVINCE VARCHAR2(100 BYTE), 
                            COUNTRY VARCHAR2(400 BYTE), 
                            COUNTRY_CODE VARCHAR2(2 BYTE), 
                            CONTINENT VARCHAR2(400 BYTE), 
                            YRS_CUSTOMER NUMBER, 
                            PROMOTION_RESPONSE NUMBER, 
                            LOC_LAT NUMBER, 
                            LOC_LONG NUMBER, 
                            AGE NUMBER, 
                            COMMUTE_DISTANCE NUMBER, 
                            CREDIT_BALANCE NUMBER, 
                            EDUCATION VARCHAR2(40 BYTE), 
                            FULL_TIME VARCHAR2(40 BYTE), 
                            GENDER VARCHAR2(20 BYTE), 
                            HOUSEHOLD_SIZE NUMBER, 
                            INCOME NUMBER, 
                            INCOME_LEVEL VARCHAR2(20 BYTE), 
                            INSUFF_FUNDS_INCIDENTS NUMBER, 
                            JOB_TYPE VARCHAR2(200 BYTE), 
                            LATE_MORT_RENT_PMTS NUMBER, 
                            MARITAL_STATUS VARCHAR2(8 BYTE), 
                            MORTGAGE_AMT NUMBER, 
                            NUM_CARS NUMBER, 
                            NUM_MORTGAGES NUMBER, 
                            PET VARCHAR2(40 BYTE), 
                            RENT_OWN VARCHAR2(40 BYTE), 
                            SEGMENT_ID NUMBER, 
                            WORK_EXPERIENCE NUMBER, 
                            YRS_CURRENT_EMPLOYER NUMBER, 
                            YRS_RESIDENCE NUMBER'
            );        

        moviestream_write(' - ext_moviestream_churn');
        dbms_cloud.create_external_table(
            table_name => 'ext_moviestream_churn',
            file_uri_list => uri_sandbox || '/moviestream_churn/*.csv',
            format => csv_format,
            column_list => 'CUST_ID NUMBER, 
                            AGE NUMBER, 
                            CITY VARCHAR2(100 BYTE), 
                            COMMUTE_DISTANCE NUMBER, 
                            CONTINENT VARCHAR2(400 BYTE), 
                            COUNTRY VARCHAR2(400 BYTE), 
                            COUNTRY_CODE VARCHAR2(2 BYTE), 
                            CREDIT_BALANCE NUMBER, 
                            EDUCATION VARCHAR2(40 BYTE), 
                            EMAIL VARCHAR2(500 BYTE), 
                            FIRST_NAME VARCHAR2(200 BYTE), 
                            FULL_TIME VARCHAR2(40 BYTE), 
                            GENDER VARCHAR2(20 BYTE), 
                            HOUSEHOLD_SIZE NUMBER, 
                            INCOME NUMBER, 
                            INCOME_LEVEL VARCHAR2(20 BYTE), 
                            INSUFF_FUNDS_INCIDENTS NUMBER, 
                            JOB_TYPE VARCHAR2(200 BYTE), 
                            LAST_NAME VARCHAR2(200 BYTE), 
                            LATE_MORT_RENT_PMTS NUMBER, 
                            LOC_LAT NUMBER, 
                            LOC_LONG NUMBER, 
                            MARITAL_STATUS VARCHAR2(8 BYTE), 
                            MORTGAGE_AMT NUMBER, 
                            NUM_CARS NUMBER, 
                            NUM_MORTGAGES NUMBER, 
                            PET VARCHAR2(40 BYTE), 
                            POSTAL_CODE VARCHAR2(10 BYTE), 
                            PROMOTION_RESPONSE NUMBER, 
                            RENT_OWN VARCHAR2(40 BYTE), 
                            STATE_PROVINCE VARCHAR2(100 BYTE), 
                            STREET_ADDRESS VARCHAR2(400 BYTE), 
                            WORK_EXPERIENCE NUMBER, 
                            YRS_CURRENT_EMPLOYER NUMBER, 
                            YRS_CUSTOMER NUMBER, 
                            YRS_RESIDENCE NUMBER, 
                            APP_CHROME NUMBER, 
                            APP_EDGE NUMBER, 
                            APP_FIREFOX NUMBER, 
                            APP_MOBILE NUMBER, 
                            APP_SAFARI NUMBER, 
                            DEVICE_GALAXY NUMBER, 
                            DEVICE_IPAD NUMBER, 
                            DEVICE_IPHONE NUMBER, 
                            DEVICE_LENOVO NUMBER, 
                            DEVICE_MAC NUMBER, 
                            DEVICE_ONEPLUS NUMBER, 
                            DEVICE_PC NUMBER, 
                            DEVICE_PIXEL NUMBER, 
                            GENRE_ACTION NUMBER, 
                            GENRE_ADVENTURE NUMBER, 
                            GENRE_ANIMATION NUMBER, 
                            GENRE_BIOGRAPHY NUMBER, 
                            GENRE_COMEDY NUMBER, 
                            GENRE_CRIME NUMBER, 
                            GENRE_DOCUMENTARY NUMBER, 
                            GENRE_DRAMA NUMBER, 
                            GENRE_FAMILY NUMBER, 
                            GENRE_FANTASY NUMBER, 
                            GENRE_FILM_NOIR NUMBER, 
                            GENRE_HISTORY NUMBER, 
                            GENRE_HORROR NUMBER, 
                            GENRE_LIFESTYLE NUMBER, 
                            GENRE_MUSICAL NUMBER, 
                            GENRE_MYSTERY NUMBER, 
                            GENRE_NEWS NUMBER, 
                            GENRE_REALITY_TV NUMBER, 
                            GENRE_ROMANCE NUMBER, 
                            GENRE_SCI_FI NUMBER, 
                            GENRE_SPORT NUMBER, 
                            GENRE_THRILLER NUMBER, 
                            GENRE_UNKNOWN NUMBER, 
                            GENRE_WAR NUMBER, 
                            GENRE_WESTERN NUMBER, 
                            MV_ALADDIN NUMBER, 
                            MV_AQUAMAN NUMBER, 
                            MV_AVATAR NUMBER, 
                            MV_AVENGERS_ENDGAME NUMBER, 
                            MV_AVENGERS_INFINITY_WAR NUMBER, 
                            MV_BLACK_PANTHER NUMBER, 
                            MV_BOHEMIAN_RHAPSODY NUMBER, 
                            MV_CAPTAIN_MARVEL NUMBER, 
                            MV_FANTASTIC_BEASTS_TCO_GRINDELWALD NUMBER, 
                            MV_FROZEN_II NUMBER, 
                            MV_INCEPTION NUMBER, 
                            MV_INTERSTELLAR NUMBER, 
                            MV_JUMANJI_THE_NEXT_LEVEL NUMBER, 
                            MV_SPIDER_MAN_FAR_FROM_HOME NUMBER, 
                            MV_SPIDER_MAN_HOMECOMING NUMBER, 
                            MV_STARWARS_EPISODE_IX NUMBER, 
                            MV_STARWARS_EPISODE_VIII NUMBER, 
                            MV_THE_AVENGERS NUMBER, 
                            MV_THE_DARK_KNIGHT NUMBER, 
                            MV_THE_GODFATHER NUMBER, 
                            MV_THE_LION_KING NUMBER, 
                            MV_THE_MATRIX NUMBER, 
                            MV_TITANIC NUMBER, 
                            MV_TOY_STORY_4 NUMBER, 
                            MV_VENOM NUMBER, 
                            OS_ANDROID NUMBER, 
                            OS_IOS NUMBER, 
                            OS_MACOS NUMBER, 
                            OS_WINDOWS NUMBER, 
                            PAYMENT_AMEX NUMBER, 
                            PAYMENT_DISCOVER NUMBER, 
                            PAYMENT_MASTERCARD NUMBER, 
                            PAYMENT_NONE NUMBER, 
                            PAYMENT_VISA NUMBER, 
                            AGG_NTRANS_M10 NUMBER, 
                            AGG_NTRANS_M11 NUMBER, 
                            AGG_NTRANS_M12 NUMBER, 
                            AGG_NTRANS_M13 NUMBER, 
                            AGG_NTRANS_M14 NUMBER, 
                            AGG_NTRANS_M3 NUMBER, 
                            AGG_NTRANS_M4 NUMBER, 
                            AGG_NTRANS_M5 NUMBER, 
                            AGG_NTRANS_M6 NUMBER, 
                            AGG_NTRANS_M7 NUMBER, 
                            AGG_NTRANS_M8 NUMBER, 
                            AGG_NTRANS_M9 NUMBER, 
                            AGG_SALES_M10 NUMBER, 
                            AGG_SALES_M11 NUMBER, 
                            AGG_SALES_M12 NUMBER, 
                            AGG_SALES_M13 NUMBER, 
                            AGG_SALES_M14 NUMBER, 
                            AGG_SALES_M3 NUMBER, 
                            AGG_SALES_M4 NUMBER, 
                            AGG_SALES_M5 NUMBER, 
                            AGG_SALES_M6 NUMBER, 
                            AGG_SALES_M7 NUMBER, 
                            AGG_SALES_M8 NUMBER, 
                            AGG_SALES_M9 NUMBER, 
                            AVG_DISC_M10 NUMBER, 
                            AVG_DISC_M11 NUMBER, 
                            AVG_DISC_M12 NUMBER, 
                            AVG_DISC_M12_14 NUMBER, 
                            AVG_DISC_M13 NUMBER, 
                            AVG_DISC_M14 NUMBER, 
                            AVG_DISC_M3 NUMBER, 
                            AVG_DISC_M3_11 NUMBER, 
                            AVG_DISC_M3_14 NUMBER, 
                            AVG_DISC_M3_5 NUMBER, 
                            AVG_DISC_M3_8 NUMBER, 
                            AVG_DISC_M4 NUMBER, 
                            AVG_DISC_M5 NUMBER, 
                            AVG_DISC_M6 NUMBER, 
                            AVG_DISC_M6_8 NUMBER, 
                            AVG_DISC_M7 NUMBER, 
                            AVG_DISC_M8 NUMBER, 
                            AVG_DISC_M9 NUMBER, 
                            AVG_DISC_M9_11 NUMBER, 
                            AVG_NTRANS_M12_14 NUMBER, 
                            AVG_NTRANS_M3_11 NUMBER, 
                            AVG_NTRANS_M3_14 NUMBER, 
                            AVG_NTRANS_M3_5 NUMBER, 
                            AVG_NTRANS_M3_8 NUMBER, 
                            AVG_NTRANS_M6_8 NUMBER, 
                            AVG_NTRANS_M9_11 NUMBER, 
                            AVG_SALES_M12_14 NUMBER, 
                            AVG_SALES_M3_11 NUMBER, 
                            AVG_SALES_M3_14 NUMBER, 
                            AVG_SALES_M3_5 NUMBER, 
                            AVG_SALES_M3_8 NUMBER, 
                            AVG_SALES_M6_8 NUMBER, 
                            AVG_SALES_M9_11 NUMBER, 
                            DISC_PCT_DIF_M3_5_M6_11 NUMBER, 
                            DISC_PCT_DIF_M3_5_M6_14 NUMBER, 
                            DISC_PCT_DIF_M3_5_M6_8 NUMBER, 
                            SALES_PCT_DIF_M3_5_M6_11 NUMBER, 
                            SALES_PCT_DIF_M3_5_M6_14 NUMBER, 
                            SALES_PCT_DIF_M3_5_M6_8 NUMBER, 
                            TRANS_PCT_DIF_M3_5_M6_11 NUMBER, 
                            TRANS_PCT_DIF_M3_5_M6_14 NUMBER, 
                            TRANS_PCT_DIF_M3_5_M6_8 NUMBER, 
                            TARGET NUMBER'
            );        

        moviestream_write('** external tables created. **') ;


        --  Create tables from external tables

        moviestream_write('** create tables from external tables and drop external tables **');
        moviestream_write(' - create pizza_locations');
        moviestream_exec ( 'create table pizza_location as select * from ext_pizza_location');
        moviestream_exec ( 'drop table ext_pizza_location');

        moviestream_write(' - create genre');
        moviestream_exec ( 'create table genre as select * from ext_genre' );
        moviestream_exec ( 'drop table ext_genre' );

        moviestream_write(' - create customer_segment');
        moviestream_exec ( 'create table customer_segment as select * from ext_customer_segment' );
        moviestream_exec ( 'drop table ext_customer_segment' );

        moviestream_write(' - create customer_contact');
        moviestream_exec ( 'create table customer_contact as select * from ext_customer_contact' );
        moviestream_exec ( 'drop table ext_customer_contact' );

        moviestream_write(' - create customer_extension');
        moviestream_exec ( 'create table customer_extension as select * from ext_customer_extension' );
        moviestream_exec ( 'drop table ext_customer_extension' );

        moviestream_write(' - create movie');
        moviestream_exec ( 'create table movie as
            select
                cast(m.doc.movie_id as number) as movie_id,
                cast(m.doc.title as varchar2(200 byte)) as title,   
                cast(m.doc.budget as number) as budget,
                cast(m.doc.gross as number) gross,
                cast(m.doc.list_price as number) as list_price,
                cast(m.doc.genre as varchar2(4000)) as genres,
                cast(m.doc.sku as varchar2(30 byte)) as sku,   
                cast(m.doc.year as number) as year,
                to_date(m.doc.opening_date, ''YYYY-MM-DD'') as opening_date,
                cast(m.doc.views as number) as views,
                cast(m.doc.cast as varchar2(4000 byte)) as cast,
                cast(m.doc.crew as varchar2(4000 byte)) as crew,
                cast(m.doc.studio as varchar2(4000 byte)) as studio,
                cast(m.doc.main_subject as varchar2(4000 byte)) as main_subject,
                cast(m.doc.awards as varchar2(4000 byte)) as awards,
                cast(m.doc.nominations as varchar2(4000 byte)) as nominations,
                cast(m.doc.runtime as number) as runtime,
                substr(cast(m.doc.summary as varchar2(4000 byte)),1, 4000) as summary
            from ext_movie m' );
        moviestream_exec ( 'drop table ext_movie' );     

        moviestream_write(' - create custsales');
        moviestream_exec ( 'create table custsales as select * from ext_custsales' );
        moviestream_exec ( 'drop table ext_custsales' );

        moviestream_write(' - create moviestream_churn');
        moviestream_exec ( 'create table moviestream_churn as select * from ext_moviestream_churn' );
        moviestream_exec ( 'drop table ext_moviestream_churn' );


        -- Table combining the two independent ones
        moviestream_write(' - create combined customer');
        moviestream_exec ( 'create table CUSTOMER
                as
                select  cc.CUST_ID,                
                        cc.LAST_NAME,              
                        cc.FIRST_NAME,             
                        cc.EMAIL,                  
                        cc.STREET_ADDRESS,         
                        cc.POSTAL_CODE,            
                        cc.CITY,                   
                        cc.STATE_PROVINCE,         
                        cc.COUNTRY,                
                        cc.COUNTRY_CODE,           
                        cc.CONTINENT,              
                        cc.YRS_CUSTOMER,           
                        cc.PROMOTION_RESPONSE,     
                        cc.LOC_LAT,                
                        cc.LOC_LONG,               
                        ce.AGE,                    
                        ce.COMMUTE_DISTANCE,       
                        ce.CREDIT_BALANCE,         
                        ce.EDUCATION,              
                        ce.FULL_TIME,              
                        ce.GENDER,                 
                        ce.HOUSEHOLD_SIZE,         
                        ce.INCOME,                 
                        ce.INCOME_LEVEL,           
                        ce.INSUFF_FUNDS_INCIDENTS, 
                        ce.JOB_TYPE,               
                        ce.LATE_MORT_RENT_PMTS,    
                        ce.MARITAL_STATUS,         
                        ce.MORTGAGE_AMT,           
                        ce.NUM_CARS,               
                        ce.NUM_MORTGAGES,          
                        ce.PET,                    
                        ce.RENT_OWN,    
                        ce.SEGMENT_ID,           
                        ce.WORK_EXPERIENCE,        
                        ce.YRS_CURRENT_EMPLOYER,   
                        ce.YRS_RESIDENCE
                from CUSTOMER_CONTACT cc, CUSTOMER_EXTENSION ce
                where cc.cust_id = ce.cust_id' );

        moviestream_write(' - create customer_promotions');
        moviestream_exec ( 'create table customer_promotions as select * from ext_customer_promotions' );
        moviestream_exec ( 'drop table ext_customer_promotions' );   

        moviestream_write(' - create custsales_promotions');
        moviestream_exec ( '
           create table custsales_promotions as
           select *
           from custsales c
           where c.cust_id in (select p.cust_id from customer_promotions p)' );

        -- View combining data
        moviestream_write('** done creating tables from external tables **');
        moviestream_write(' - create view v_custsales');
        moviestream_exec ( 'CREATE OR REPLACE VIEW v_custsales AS
                SELECT
                    cs.day_id,
                    c.cust_id,
                    c.last_name,
                    c.first_name,
                    c.city,
                    c.state_province,
                    c.country,
                    c.continent,
                    c.age,
                    c.commute_distance,
                    c.credit_balance,
                    c.education,
                    c.full_time,
                    c.gender,
                    c.household_size,
                    c.income,
                    c.income_level,
                    c.insuff_funds_incidents,
                    c.job_type,
                    c.late_mort_rent_pmts,
                    c.marital_status,
                    c.mortgage_amt,
                    c.num_cars,
                    c.num_mortgages,
                    c.pet,
                    c.promotion_response,
                    c.rent_own,
                    c.work_experience,
                    c.yrs_current_employer,
                    c.yrs_customer,
                    c.yrs_residence,
                    c.loc_lat,
                    c.loc_long,   
                    cs.app,
                    cs.device,
                    cs.os,
                    cs.payment_method,
                    cs.list_price,
                    cs.discount_type,
                    cs.discount_percent,
                    cs.actual_price,
                    1 as transactions,
                    s.short_name as segment,
                    g.name as genre,
                    m.title,
                    m.budget,
                    m.gross,
                    m.genres,
                    m.sku,
                    m.year,
                    m.opening_date,
                    m.cast,
                    m.crew,
                    m.studio,
                    m.main_subject,
                    nvl(json_value(m.awards,''$.size()''),0) awards,
                    nvl(json_value(m.nominations,''$.size()''),0) nominations,
                    m.runtime
                FROM
                    genre g, customer c, custsales cs, customer_segment s, movie m
                WHERE
                    cs.movie_id = m.movie_id
                AND  cs.genre_id = g.genre_id
                AND  cs.cust_id = c.cust_id
                AND  c.segment_id = s.segment_id' );

        -- Add constraints and indexes
        moviestream_write('** creating constraints and indexes **');

        moviestream_exec ( 'alter table genre add constraint pk_genre_id primary key("GENRE_ID")' );

        moviestream_exec ( 'alter table customer add constraint pk_customer_cust_id primary key("CUST_ID")' );
        moviestream_exec ( 'alter table customer_extension add constraint pk_custextension_cust_id primary key("CUST_ID")' );
        moviestream_exec ( 'alter table customer_contact add constraint pk_custcontact_cust_id primary key("CUST_ID")' );
        moviestream_exec ( 'alter table customer_segment add constraint pk_custsegment_id primary key("SEGMENT_ID")' );

        moviestream_exec ( 'alter table movie add constraint pk_movie_id primary key("MOVIE_ID")' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_cast_json CHECK (cast IS JSON)' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_genre_json CHECK (genres IS JSON)' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_crew_json CHECK (crew IS JSON)' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_studio_json CHECK (studio IS JSON)' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_awards_json CHECK (awards IS JSON)' );
        moviestream_exec ( 'alter table movie add CONSTRAINT movie_nominations_json CHECK (nominations IS JSON)' );

        moviestream_exec ( 'alter table pizza_location add constraint pk_pizza_loc_id primary key("PIZZA_LOC_ID")' );

        moviestream_exec ( 'alter table time add constraint pk_day primary key("DAY_ID")' );

        moviestream_exec ( 'alter table customer_promotions add constraint customer_promotions_pk primary key(cust_id)' );
        moviestream_exec ( 'alter table custsales_promotions add primary key (cust_id, movie_id, day_id)' );

        -- foreign keys
        moviestream_exec ( 'alter table custsales add constraint fk_custsales_movie_id foreign key("MOVIE_ID") references movie("MOVIE_ID")' );
        moviestream_exec ( 'alter table custsales add constraint fk_custsales_cust_id foreign key("CUST_ID") references customer("CUST_ID")' );
        moviestream_exec ( 'alter table custsales add constraint fk_custsales_day_id foreign key("DAY_ID") references time("DAY_ID")' );
        moviestream_exec ( 'alter table custsales add constraint fk_custsales_genre_id foreign key("GENRE_ID") references genre("GENRE_ID")' );
        moviestream_exec ( 'alter table custsales_promotions add constraint fk_custsales_promotions_cust_id foreign key(cust_id) references customer_promotions(cust_id)' );
        moviestream_exec ( 'alter table custsales_promotions add constraint fk_custsales_promotions_movie_id foreign key(movie_id) references movie(movie_id)' );

        moviestream_write('- finished creating constraints and indexes.');
     end;

     -- ADD SQL-LAB REQUIREMENTS
     begin
        moviestream_write('** adding SQL Lab requirements **');
        moviestream_write('- create view vw_movie_sales_fact');
        moviestream_exec ( 'CREATE OR REPLACE VIEW vw_movie_sales_fact AS
                            SELECT
                            m.day_id,
                            t.day_name,
                            t.day_dow,
                            t.day_dom,
                            t.day_doy,
                            t.week_wom,
                            t.week_woy,
                            t.month_moy,
                            t.month_name,
                            t.month_aname,  
                            t.quarter_name,  
                            t.year_name,  
                            c.cust_id as customer_id,
                            c.state_province,
                            c.country,
                            c.continent,
                            g.name as genre,
                            m.app,
                            m.device,
                            m.os,
                            m.payment_method,
                            m.list_price,
                            m.discount_type,
                            m.discount_percent,
                            m.actual_price,
                            m.genre_id,
                            m.movie_id
                            FROM custsales m
                            INNER JOIN time t ON m.day_id = t.day_id
                            INNER JOIN customer c ON m.cust_id = c.cust_id
                            INNER JOIN genre g ON m.genre_id = g.genre_id' );

        moviestream_write('- create json table');                                            
        dbms_cloud.create_external_table (
            table_name => 'json_movie_data_ext',
            file_uri_list => 'https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/moviestream_gold/o/movie/*.json',
            column_list => 'doc varchar2(32000)',
            field_list => 'doc char(30000)',
            format => json_format
            );            

     end;

     -- ADD OML REQUIREMENTS
     begin
        moviestream_write('** adding OML Lab requirements **');
        moviestream_write('- create view sales_summary');
        moviestream_exec ( '
        CREATE OR REPLACE VIEW SALES_SUMMARY AS
        SELECT CUST_ID,
               MAX(CASE MDIFF_JAN2021 WHEN 1 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M1,
               MAX(CASE MDIFF_JAN2021 WHEN 2 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M2,
               MAX(CASE MDIFF_JAN2021 WHEN 3 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M3,
               MAX(CASE MDIFF_JAN2021 WHEN 4 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M4,
               MAX(CASE MDIFF_JAN2021 WHEN 5 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M5,
               MAX(CASE MDIFF_JAN2021 WHEN 6 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M6,
               MAX(CASE MDIFF_JAN2021 WHEN 7 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M7,
               MAX(CASE MDIFF_JAN2021 WHEN 8 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M8,
               MAX(CASE MDIFF_JAN2021 WHEN 9 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M9,
               MAX(CASE MDIFF_JAN2021 WHEN 10 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M10,
               MAX(CASE MDIFF_JAN2021 WHEN 11 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M11,
               MAX(CASE MDIFF_JAN2021 WHEN 12 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M12,
               MAX(CASE MDIFF_JAN2021 WHEN 13 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M13,
               MAX(CASE MDIFF_JAN2021 WHEN 14 THEN AGG_NUM_TRANS ELSE 0 END) AS AGG_NTRANS_M14,

               MAX(CASE MDIFF_JAN2021 WHEN 1 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M1,
               MAX(CASE MDIFF_JAN2021 WHEN 2 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M2,
               MAX(CASE MDIFF_JAN2021 WHEN 3 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M3,
               MAX(CASE MDIFF_JAN2021 WHEN 4 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M4,
               MAX(CASE MDIFF_JAN2021 WHEN 5 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M5,
               MAX(CASE MDIFF_JAN2021 WHEN 6 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M6,
               MAX(CASE MDIFF_JAN2021 WHEN 7 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M7,
               MAX(CASE MDIFF_JAN2021 WHEN 8 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M8,
               MAX(CASE MDIFF_JAN2021 WHEN 9 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M9,
               MAX(CASE MDIFF_JAN2021 WHEN 10 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M10,
               MAX(CASE MDIFF_JAN2021 WHEN 11 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M11,
               MAX(CASE MDIFF_JAN2021 WHEN 12 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M12,
               MAX(CASE MDIFF_JAN2021 WHEN 13 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M13,
               MAX(CASE MDIFF_JAN2021 WHEN 14 THEN AGG_ACTUAL_PR ELSE 0 END) AS AGG_SALES_M14,

               MAX(CASE MDIFF_JAN2021 WHEN 1 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M1,
               MAX(CASE MDIFF_JAN2021 WHEN 2 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M2,
               MAX(CASE MDIFF_JAN2021 WHEN 3 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M3,
               MAX(CASE MDIFF_JAN2021 WHEN 4 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M4,
               MAX(CASE MDIFF_JAN2021 WHEN 5 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M5,
               MAX(CASE MDIFF_JAN2021 WHEN 6 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M6,
               MAX(CASE MDIFF_JAN2021 WHEN 7 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M7,
               MAX(CASE MDIFF_JAN2021 WHEN 8 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M8,
               MAX(CASE MDIFF_JAN2021 WHEN 9 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M9,
               MAX(CASE MDIFF_JAN2021 WHEN 10 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M10,
               MAX(CASE MDIFF_JAN2021 WHEN 11 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M11,
               MAX(CASE MDIFF_JAN2021 WHEN 12 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M12,
               MAX(CASE MDIFF_JAN2021 WHEN 13 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M13,
               MAX(CASE MDIFF_JAN2021 WHEN 14 THEN AVG_DISC_PCT ELSE 0 END) AS AVG_DISC_M14

               FROM
               (SELECT  CUST_ID,
                        MDIFF_JAN2021,
                        COUNT(1) AGG_NUM_TRANS,
                        ROUND(SUM(ACTUAL_PRICE),2) AGG_ACTUAL_PR,
                        ROUND(AVG(DISCOUNT_PERCENT),2) AVG_DISC_PCT                
                        FROM   
                        (SELECT CUST_ID,
                                ACTUAL_PRICE,
                                DISCOUNT_PERCENT,
                                TRUNC(MONTHS_BETWEEN(TO_DATE(''31-01-2021'',''DD-MM-YYYY''), DAY_ID)) MDIFF_JAN2021
                                FROM CUSTSALES )
                        GROUP BY CUST_ID, MDIFF_JAN2021
                        ORDER BY CUST_ID)
                GROUP BY CUST_ID
                ' );

        moviestream_write('- create view TRENDS_SALES_TRANS');                    
        moviestream_exec ( '
        CREATE OR REPLACE VIEW TRENDS_SALES_TRANS AS
        SELECT S.*,
               -- SALES SECTION --

               -- SALES QUARTERLY AVERAGES
               ROUND((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5)/3,2) AVG_SALES_M3_5,
               ROUND((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8)/3,2) AVG_SALES_M6_8,
               ROUND((AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11)/3,2) AVG_SALES_M9_11,
               ROUND((AGG_SALES_M12+AGG_SALES_M13+AGG_SALES_M14)/3,2) AVG_SALES_M12_14,
               -- SALES AVERAGE 6 MONTHS
               ROUND((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5+
                      AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8)/6,2) AVG_SALES_M3_8,
               -- SALES AVERAGE 9 MONTHS
               ROUND((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5+
                      AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+
                      AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11)/9,2) AVG_SALES_M3_11,              
               -- SALES AVERAGE 12 MONTHS 
               ROUND((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5+
                      AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+
                      AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11+
                      AGG_SALES_M12+AGG_SALES_M13+AGG_SALES_M14)/12,2) AVG_SALES_M3_14,

               -- RATIOS - NEED TO GUARANTEE THAT THE DENOMINATOR IS NOT ZERO BY USING CASE

               -- AVERAGE SALES TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 3 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more sales,
               -- while ''-10'' means 10% less sales
               CASE WHEN ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5)/3) - 
                                ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8)/3 )) * 
                                1/((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8)/3)),
                                4))*100
               END SALES_PCT_DIF_M3_5_M6_8,

               -- AVERAGE SALES TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 6 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more sales,
               -- while ''-10'' means 10% less sales
               CASE WHEN ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5)/3) - 
                                ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11)/6 )) * 
                                1/((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11)/6)),
                                4))*100
               END SALES_PCT_DIF_M3_5_M6_11,

               -- AVERAGE SALES TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 9 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more sales,
               -- while ''-10'' means 10% less sales
               CASE WHEN ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11+AGG_SALES_M12+AGG_SALES_M13+AGG_SALES_M14) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_SALES_M3+AGG_SALES_M4+AGG_SALES_M5)/3) - 
                                ((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11+AGG_SALES_M12+AGG_SALES_M13+AGG_SALES_M14)/9 )) * 
                                1/((AGG_SALES_M6+AGG_SALES_M7+AGG_SALES_M8+AGG_SALES_M9+AGG_SALES_M10+AGG_SALES_M11+AGG_SALES_M12+AGG_SALES_M13+AGG_SALES_M14)/9)),
                                4))*100
               END SALES_PCT_DIF_M3_5_M6_14,

               -- TRANSACTIONS SECTION --

               -- TRANSACTIONS QUARTERLY AVERAGES
               ROUND((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5)/3,2) AVG_NTRANS_M3_5,
               ROUND((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8)/3,2) AVG_NTRANS_M6_8,
               ROUND((AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11)/3,2) AVG_NTRANS_M9_11,
               ROUND((AGG_NTRANS_M12+AGG_NTRANS_M13+AGG_NTRANS_M14)/3,2) AVG_NTRANS_M12_14,
               -- TRANSACTIONS AVERAGE 6 MONTHS
               ROUND((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5+
                      AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8)/6,2) AVG_NTRANS_M3_8,
               -- TRANSACTIONS AVERAGE 9 MONTHS 
               ROUND((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5+
                      AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+
                      AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11)/9,2) AVG_NTRANS_M3_11,              
               -- TRANSACTIONS AVERAGE 12 MONTHS 
               ROUND((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5+
                      AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+
                      AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11+
                      AGG_NTRANS_M12+AGG_NTRANS_M13+AGG_NTRANS_M14)/12,2) AVG_NTRANS_M3_14,

               -- RATIOS - NEED TO GUARANTEE THAT THE DENOMINATOR IS NOT ZERO BY USING CASE

               -- AVERAGE TRANSACTIONS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 3 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more transactions,
               -- while ''-10'' means 10% less transactions
               CASE WHEN ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5)/3) - 
                                ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8)/3 )) * 
                                1/((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8)/3)),
                                4))*100
               END TRANS_PCT_DIF_M3_5_M6_8,

               -- AVERAGE TRANSACTIONS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 6 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more TRANSACTIONS,
               -- while ''-10'' means 10% less TRANSACTIONS
               CASE WHEN ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5)/3) - 
                                ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11)/6 )) * 
                                1/((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11)/6)),
                                4))*100
               END TRANS_PCT_DIF_M3_5_M6_11,

               -- AVERAGE TRANSACTIONS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 9 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more TRANSACTIONS,
               -- while ''-10'' means 10% less TRANSACTIONS
               CASE WHEN ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11+AGG_NTRANS_M12+AGG_NTRANS_M13+AGG_NTRANS_M14) = 0) THEN 0.01
                    ELSE (ROUND(((((AGG_NTRANS_M3+AGG_NTRANS_M4+AGG_NTRANS_M5)/3) - 
                                ((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11+AGG_NTRANS_M12+AGG_NTRANS_M13+AGG_NTRANS_M14)/9 )) * 
                                1/((AGG_NTRANS_M6+AGG_NTRANS_M7+AGG_NTRANS_M8+AGG_NTRANS_M9+AGG_NTRANS_M10+AGG_NTRANS_M11+AGG_NTRANS_M12+AGG_NTRANS_M13+AGG_NTRANS_M14)/9)),
                                4))*100
               END TRANS_PCT_DIF_M3_5_M6_14,

               -- DISCOUNTS SECTION --

               -- DISCOUNTS QUARTERLY AVERAGES
               ROUND((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5)/3,2) AVG_DISC_M3_5,
               ROUND((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8)/3,2) AVG_DISC_M6_8,
               ROUND((AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11)/3,2) AVG_DISC_M9_11,
               ROUND((AVG_DISC_M12+AVG_DISC_M13+AVG_DISC_M14)/3,2) AVG_DISC_M12_14,
               -- DISCOUNTS AVERAGE 6 MONTHS
               ROUND((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5+
                      AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8)/6,2) AVG_DISC_M3_8,
               -- DISCOUNTS AVERAGE 9 MONTHS 
               ROUND((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5+
                      AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+
                      AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11)/9,2) AVG_DISC_M3_11,
               -- DISCOUNTS AVERAGE 12 MONTHS 
               ROUND((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5+
                      AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+
                      AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11+
                      AVG_DISC_M12+AVG_DISC_M13+AVG_DISC_M14)/12,2) AVG_DISC_M3_14,

               -- RATIOS - NEED TO GUARANTEE THAT THE DENOMINATOR IS NOT ZERO BY USING CASE

               -- AVERAGE DISCOUNTS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 3 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more discounts,
               -- while ''-10'' means 10% less discounts
               CASE WHEN ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8) = 0) THEN 0.01
                    ELSE (ROUND(((((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5)/3) - 
                                ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8)/3 )) * 
                                1/((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8)/3)),
                                4))*100
               END DISC_PCT_DIF_M3_5_M6_8,

               -- AVERAGE DISCOUNTS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 6 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more DISCOUNTS,
               -- while ''-10'' means 10% less DISCOUNTS
               CASE WHEN ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11) = 0) THEN 0.01
                    ELSE (ROUND(((((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5)/3) - 
                                ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11)/6 )) * 
                                1/((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11)/6)),
                                4))*100
               END DISC_PCT_DIF_M3_5_M6_11,

               -- AVERAGE DISCOUNTS TREND OF LAST 3 MONHTS COMPARED TO PREVIOUS 9 MONTHS
               -- in Percentage points.  ''0'' means no change, ''10'' means 10% more DISCOUNTS,
               -- while ''-10'' means 10% less DISCOUNTS
               CASE WHEN ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11+AVG_DISC_M12+AVG_DISC_M13+AVG_DISC_M14) = 0) THEN 0.01
                    ELSE (ROUND(((((AVG_DISC_M3+AVG_DISC_M4+AVG_DISC_M5)/3) - 
                                ((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11+AVG_DISC_M12+AVG_DISC_M13+AVG_DISC_M14)/9 )) * 
                                1/((AVG_DISC_M6+AVG_DISC_M7+AVG_DISC_M8+AVG_DISC_M9+AVG_DISC_M10+AVG_DISC_M11+AVG_DISC_M12+AVG_DISC_M13+AVG_DISC_M14)/9)),
                                4))*100
               END DISC_PCT_DIF_M3_5_M6_14      

               FROM SALES_SUMMARY S
               ' );


        -- RECODE COLUMNS AS COUNTS OF DIFFERENT CATEGORIES OF
        -- DEVICES, OS, APP, GENRE, PAYMENT AND SEASONS
        -- The code is counting transactions from months M3 and before
        moviestream_write('- create view CUSTOMER_CATEGORIES');                    
        moviestream_exec ( '
            CREATE OR REPLACE VIEW CUSTOMER_CATEGORIES AS
            SELECT CUST_ID,
                   COUNT(CASE WHEN DEVICE = ''pc'' THEN 1 END) DEVICE_PC,
                   COUNT(CASE WHEN DEVICE = ''mac'' THEN 1 END) DEVICE_MAC,
                   COUNT(CASE WHEN DEVICE = ''lenovo'' THEN 1 END) DEVICE_LENOVO,
                   COUNT(CASE WHEN DEVICE = ''iphone'' THEN 1 END) DEVICE_IPHONE,
                   COUNT(CASE WHEN DEVICE = ''pixel'' THEN 1 END) DEVICE_PIXEL,
                   COUNT(CASE WHEN DEVICE = ''ipad'' THEN 1 END) DEVICE_IPAD,
                   COUNT(CASE WHEN DEVICE = ''galaxy'' THEN 1 END) DEVICE_GALAXY,
                   COUNT(CASE WHEN DEVICE = ''oneplus'' THEN 1 END) DEVICE_ONEPLUS,

                   COUNT(CASE WHEN APP = ''edge'' THEN 1 END) APP_EDGE,
                   COUNT(CASE WHEN APP = ''chrome'' THEN 1 END) APP_CHROME,
                   COUNT(CASE WHEN APP = ''mobile-app'' THEN 1 END) APP_MOBILE,
                   COUNT(CASE WHEN APP = ''safari'' THEN 1 END) APP_SAFARI,
                   COUNT(CASE WHEN APP = ''firefox'' THEN 1 END) APP_FIREFOX,

                   COUNT(CASE WHEN OS = ''android'' THEN 1 END) OS_ANDROID,
                   COUNT(CASE WHEN OS = ''ios'' THEN 1 END) OS_IOS,
                   COUNT(CASE WHEN OS = ''macos'' THEN 1 END) OS_MACOS,
                   COUNT(CASE WHEN OS = ''windows'' THEN 1 END) OS_WINDOWS,

                   COUNT(CASE WHEN PAYMENT_METHOD = ''mastercard'' THEN 1 END) PAYMENT_MASTERCARD,
                   COUNT(CASE WHEN PAYMENT_METHOD = ''amex'' THEN 1 END) PAYMENT_AMEX,
                   COUNT(CASE WHEN PAYMENT_METHOD = ''discover'' THEN 1 END) PAYMENT_DISCOVER,
                   COUNT(CASE WHEN PAYMENT_METHOD = ''none'' THEN 1 END) PAYMENT_NONE,
                   COUNT(CASE WHEN PAYMENT_METHOD = ''visa'' THEN 1 END) PAYMENT_VISA,

                   COUNT(CASE WHEN GENRE_ID = 1 THEN 1 END) GENRE_ACTION,
                   COUNT(CASE WHEN GENRE_ID = 2 THEN 1 END) GENRE_ADVENTURE,
                   COUNT(CASE WHEN GENRE_ID = 3 THEN 1 END) GENRE_ANIMATION,
                   COUNT(CASE WHEN GENRE_ID = 4 THEN 1 END) GENRE_BIOGRAPHY,
                   COUNT(CASE WHEN GENRE_ID = 5 THEN 1 END) GENRE_COMEDY,
                   COUNT(CASE WHEN GENRE_ID = 6 THEN 1 END) GENRE_CRIME,
                   COUNT(CASE WHEN GENRE_ID = 7 THEN 1 END) GENRE_DOCUMENTARY,
                   COUNT(CASE WHEN GENRE_ID = 8 THEN 1 END) GENRE_DRAMA,
                   COUNT(CASE WHEN GENRE_ID = 9 THEN 1 END) GENRE_FAMILY,
                   COUNT(CASE WHEN GENRE_ID = 10 THEN 1 END) GENRE_FANTASY,
                   COUNT(CASE WHEN GENRE_ID = 11 THEN 1 END) GENRE_FILM_NOIR,
                   COUNT(CASE WHEN GENRE_ID = 12 THEN 1 END) GENRE_HISTORY,
                   COUNT(CASE WHEN GENRE_ID = 13 THEN 1 END) GENRE_HORROR,
                   COUNT(CASE WHEN GENRE_ID = 14 THEN 1 END) GENRE_LIFESTYLE,
                   COUNT(CASE WHEN GENRE_ID = 15 THEN 1 END) GENRE_MUSICAL,
                   COUNT(CASE WHEN GENRE_ID = 16 THEN 1 END) GENRE_MYSTERY,
                   COUNT(CASE WHEN GENRE_ID = 17 THEN 1 END) GENRE_NEWS,
                   COUNT(CASE WHEN GENRE_ID = 18 THEN 1 END) GENRE_REALITY_TV,
                   COUNT(CASE WHEN GENRE_ID = 19 THEN 1 END) GENRE_ROMANCE,
                   COUNT(CASE WHEN GENRE_ID = 20 THEN 1 END) GENRE_SCI_FI,
                   COUNT(CASE WHEN GENRE_ID = 21 THEN 1 END) GENRE_SPORT,
                   COUNT(CASE WHEN GENRE_ID = 22 THEN 1 END) GENRE_THRILLER,
                   COUNT(CASE WHEN GENRE_ID = 23 THEN 1 END) GENRE_WAR,
                   COUNT(CASE WHEN GENRE_ID = 24 THEN 1 END) GENRE_WESTERN,
                   COUNT(CASE WHEN GENRE_ID = 25 THEN 1 END) GENRE_UNKNOWN,

                   COUNT(CASE WHEN MOVIE_ID = 376 THEN 1 END) MV_AVENGERS_ENDGAME,
                   COUNT(CASE WHEN MOVIE_ID = 2834 THEN 1 END) MV_STARWARS_EPISODE_IX,
                   COUNT(CASE WHEN MOVIE_ID = 661 THEN 1 END) MV_CAPTAIN_MARVEL,
                   COUNT(CASE WHEN MOVIE_ID = 2802 THEN 1 END) MV_SPIDER_MAN_FAR_FROM_HOME,
                   COUNT(CASE WHEN MOVIE_ID = 3372 THEN 1 END) MV_THE_LION_KING,
                   COUNT(CASE WHEN MOVIE_ID = 190 THEN 1 END) MV_ALADDIN,
                   COUNT(CASE WHEN MOVIE_ID = 322 THEN 1 END) MV_AQUAMAN,
                   COUNT(CASE WHEN MOVIE_ID = 3705 THEN 1 END) MV_TOY_STORY_4,
                   COUNT(CASE WHEN MOVIE_ID = 377 THEN 1 END) MV_AVENGERS_INFINITY_WAR,
                   COUNT(CASE WHEN MOVIE_ID = 557 THEN 1 END) MV_BOHEMIAN_RHAPSODY,
                   COUNT(CASE WHEN MOVIE_ID = 515 THEN 1 END) MV_BLACK_PANTHER,
                   COUNT(CASE WHEN MOVIE_ID = 374 THEN 1 END) MV_AVATAR,
                   COUNT(CASE WHEN MOVIE_ID = 1707 THEN 1 END) MV_JUMANJI_THE_NEXT_LEVEL,
                   COUNT(CASE WHEN MOVIE_ID = 1636 THEN 1 END) MV_INTERSTELLAR,
                   COUNT(CASE WHEN MOVIE_ID = 3667 THEN 1 END) MV_TITANIC,
                   COUNT(CASE WHEN MOVIE_ID = 3039 THEN 1 END) MV_THE_AVENGERS,
                   COUNT(CASE WHEN MOVIE_ID = 1260 THEN 1 END) MV_FROZEN_II,
                   COUNT(CASE WHEN MOVIE_ID = 3244 THEN 1 END) MV_THE_GODFATHER,
                   COUNT(CASE WHEN MOVIE_ID = 1149 THEN 1 END) MV_FANTASTIC_BEASTS_TCO_GRINDELWALD,
                   COUNT(CASE WHEN MOVIE_ID = 3800 THEN 1 END) MV_VENOM,
                   COUNT(CASE WHEN MOVIE_ID = 1614 THEN 1 END) MV_INCEPTION,
                   COUNT(CASE WHEN MOVIE_ID = 3407 THEN 1 END) MV_THE_MATRIX,
                   COUNT(CASE WHEN MOVIE_ID = 2833 THEN 1 END) MV_STARWARS_EPISODE_VIII,
                   COUNT(CASE WHEN MOVIE_ID = 2803 THEN 1 END) MV_SPIDER_MAN_HOMECOMING,
                   COUNT(CASE WHEN MOVIE_ID = 3153 THEN 1 END) MV_THE_DARK_KNIGHT

               FROM ( SELECT 
                        CUST_ID,
                        APP,
                        OS,
                        MOVIE_ID,
                        GENRE_ID,
                        DEVICE,
                        PAYMENT_METHOD
                        FROM CUSTSALES)
               GROUP BY CUST_ID
        ' );  
/*
        moviestream_write('- create table moviestream_churn');                    
        moviestream_exec ( '
               CREATE TABLE MOVIESTREAM_CHURN AS
                    SELECT 

                    -- Customer
                        CUS.CUST_ID, CUS.AGE, CUS.CITY, CUS.COMMUTE_DISTANCE, CUS.CONTINENT, CUS.COUNTRY, CUS.COUNTRY_CODE, CUS.CREDIT_BALANCE, CUS.EDUCATION, CUS.EMAIL, CUS.FIRST_NAME, CUS.FULL_TIME, CUS.GENDER, CUS.HOUSEHOLD_SIZE, CUS.INCOME, CUS.INCOME_LEVEL, CUS.INSUFF_FUNDS_INCIDENTS, CUS.JOB_TYPE, CUS.LAST_NAME, CUS.LATE_MORT_RENT_PMTS, CUS.LOC_LAT, CUS.LOC_LONG, CUS.MARITAL_STATUS, CUS.MORTGAGE_AMT, CUS.NUM_CARS, CUS.NUM_MORTGAGES, CUS.PET, CUS.POSTAL_CODE, CUS.PROMOTION_RESPONSE, CUS.RENT_OWN, CUS.STATE_PROVINCE, CUS.STREET_ADDRESS, CUS.WORK_EXPERIENCE, CUS.YRS_CURRENT_EMPLOYER, CUS.YRS_CUSTOMER, CUS.YRS_RESIDENCE,
                    -- Categories
                       CAT.APP_CHROME, CAT.APP_EDGE, CAT.APP_FIREFOX, CAT.APP_MOBILE, CAT.APP_SAFARI, CAT.DEVICE_GALAXY, CAT.DEVICE_IPAD, CAT.DEVICE_IPHONE, CAT.DEVICE_LENOVO, CAT.DEVICE_MAC, CAT.DEVICE_ONEPLUS, CAT.DEVICE_PC, CAT.DEVICE_PIXEL, CAT.GENRE_ACTION, CAT.GENRE_ADVENTURE, CAT.GENRE_ANIMATION, CAT.GENRE_BIOGRAPHY, CAT.GENRE_COMEDY, CAT.GENRE_CRIME, CAT.GENRE_DOCUMENTARY, CAT.GENRE_DRAMA, CAT.GENRE_FAMILY, CAT.GENRE_FANTASY, CAT.GENRE_FILM_NOIR, CAT.GENRE_HISTORY, CAT.GENRE_HORROR, CAT.GENRE_LIFESTYLE, CAT.GENRE_MUSICAL, CAT.GENRE_MYSTERY, CAT.GENRE_NEWS, CAT.GENRE_REALITY_TV, CAT.GENRE_ROMANCE, CAT.GENRE_SCI_FI, CAT.GENRE_SPORT, CAT.GENRE_THRILLER, CAT.GENRE_UNKNOWN, CAT.GENRE_WAR, CAT.GENRE_WESTERN, CAT.MV_ALADDIN, CAT.MV_AQUAMAN, CAT.MV_AVATAR, CAT.MV_AVENGERS_ENDGAME, CAT.MV_AVENGERS_INFINITY_WAR, CAT.MV_BLACK_PANTHER, CAT.MV_BOHEMIAN_RHAPSODY, CAT.MV_CAPTAIN_MARVEL, CAT.MV_FANTASTIC_BEASTS_TCO_GRINDELWALD, CAT.MV_FROZEN_II, CAT.MV_INCEPTION, CAT.MV_INTERSTELLAR, CAT.MV_JUMANJI_THE_NEXT_LEVEL, CAT.MV_SPIDER_MAN_FAR_FROM_HOME, CAT.MV_SPIDER_MAN_HOMECOMING, CAT.MV_STARWARS_EPISODE_IX, CAT.MV_STARWARS_EPISODE_VIII, CAT.MV_THE_AVENGERS, CAT.MV_THE_DARK_KNIGHT, CAT.MV_THE_GODFATHER, CAT.MV_THE_LION_KING, CAT.MV_THE_MATRIX, CAT.MV_TITANIC, CAT.MV_TOY_STORY_4, CAT.MV_VENOM, CAT.OS_ANDROID, CAT.OS_IOS, CAT.OS_MACOS, CAT.OS_WINDOWS, CAT.PAYMENT_AMEX, CAT.PAYMENT_DISCOVER, CAT.PAYMENT_MASTERCARD, CAT.PAYMENT_NONE, CAT.PAYMENT_VISA,
                    -- Trends
                       TRE.AGG_NTRANS_M10, TRE.AGG_NTRANS_M11, TRE.AGG_NTRANS_M12, TRE.AGG_NTRANS_M13, TRE.AGG_NTRANS_M14, TRE.AGG_NTRANS_M3, TRE.AGG_NTRANS_M4, TRE.AGG_NTRANS_M5, TRE.AGG_NTRANS_M6, TRE.AGG_NTRANS_M7, TRE.AGG_NTRANS_M8, TRE.AGG_NTRANS_M9, TRE.AGG_SALES_M10, TRE.AGG_SALES_M11, TRE.AGG_SALES_M12, TRE.AGG_SALES_M13, TRE.AGG_SALES_M14, TRE.AGG_SALES_M3, TRE.AGG_SALES_M4, TRE.AGG_SALES_M5, TRE.AGG_SALES_M6, TRE.AGG_SALES_M7, TRE.AGG_SALES_M8, TRE.AGG_SALES_M9, TRE.AVG_DISC_M10, TRE.AVG_DISC_M11, TRE.AVG_DISC_M12, TRE.AVG_DISC_M12_14, TRE.AVG_DISC_M13, TRE.AVG_DISC_M14, TRE.AVG_DISC_M3, TRE.AVG_DISC_M3_11, TRE.AVG_DISC_M3_14, TRE.AVG_DISC_M3_5, TRE.AVG_DISC_M3_8, TRE.AVG_DISC_M4, TRE.AVG_DISC_M5, TRE.AVG_DISC_M6, TRE.AVG_DISC_M6_8, TRE.AVG_DISC_M7, TRE.AVG_DISC_M8, TRE.AVG_DISC_M9, TRE.AVG_DISC_M9_11, TRE.AVG_NTRANS_M12_14, TRE.AVG_NTRANS_M3_11, TRE.AVG_NTRANS_M3_14, TRE.AVG_NTRANS_M3_5, TRE.AVG_NTRANS_M3_8, TRE.AVG_NTRANS_M6_8, TRE.AVG_NTRANS_M9_11, TRE.AVG_SALES_M12_14, TRE.AVG_SALES_M3_11, TRE.AVG_SALES_M3_14, TRE.AVG_SALES_M3_5, TRE.AVG_SALES_M3_8, TRE.AVG_SALES_M6_8, TRE.AVG_SALES_M9_11, TRE.DISC_PCT_DIF_M3_5_M6_11, TRE.DISC_PCT_DIF_M3_5_M6_14, TRE.DISC_PCT_DIF_M3_5_M6_8, TRE.SALES_PCT_DIF_M3_5_M6_11, TRE.SALES_PCT_DIF_M3_5_M6_14, TRE.SALES_PCT_DIF_M3_5_M6_8, TRE.TRANS_PCT_DIF_M3_5_M6_11, TRE.TRANS_PCT_DIF_M3_5_M6_14, TRE.TRANS_PCT_DIF_M3_5_M6_8,
                    -- Churn Definition
                       CASE WHEN (TRE.AGG_NTRANS_M1 = 0 AND TRE.AGG_NTRANS_M3 >0 AND TRE.AGG_NTRANS_M4 >0 AND TRE.AGG_NTRANS_M5 >0 AND TRE.AGG_NTRANS_M6 >0 AND TRE.AGG_NTRANS_M7 >0 AND TRE.AGG_NTRANS_M8 >0 AND 
                                 TRE.AGG_NTRANS_M9 >0 AND TRE.AGG_NTRANS_M10 >0 AND TRE.AGG_NTRANS_M11 >0 AND TRE.AGG_NTRANS_M12 >0 AND TRE.AGG_NTRANS_M13 >0 AND TRE.AGG_NTRANS_M14 >0) 
                                 THEN 1
                                 ELSE 0
                                 END TARGET
                    -- Join CUSTOMER TABLE to CUSTOMER_CATEGORIES VIEW and TRENDS_SALES_TRANS VIEW              
                     FROM CUSTOMER CUS
                           INNER JOIN CUSTOMER_CATEGORIES CAT 
                              ON CUS.CUST_ID = CAT.CUST_ID
                           INNER JOIN TRENDS_SALES_TRANS TRE 
                              ON CUS.CUST_ID = TRE.CUST_ID         

                    -- Filter only customers with proper 12 months of active history             
                    WHERE TRE.AGG_NTRANS_M3 >0 AND TRE.AGG_NTRANS_M4 >0 AND TRE.AGG_NTRANS_M5 >0 AND TRE.AGG_NTRANS_M6 >0 AND TRE.AGG_NTRANS_M7 >0 AND TRE.AGG_NTRANS_M8 >0 AND 
                          TRE.AGG_NTRANS_M9 >0 AND TRE.AGG_NTRANS_M10 >0 AND TRE.AGG_NTRANS_M11 >0 AND TRE.AGG_NTRANS_M12 >0 AND TRE.AGG_NTRANS_M13 >0 AND TRE.AGG_NTRANS_M14 >0
                ' );
*/
     end;

     -- SPATIAL UPDATES.  DEPENDENT PIZZA_LOCATION AND CUSTOMER_CONTACT TABLES
     -- DEFINED PREVIOUSLY
     begin

        -- function
        moviestream_write('** adding spatial requirements **');
        moviestream_write('- create function latlon_to_geometry');
        moviestream_exec ( '
            CREATE OR REPLACE FUNCTION latlon_to_geometry (
               latitude   IN  NUMBER,
               longitude  IN  NUMBER
            ) RETURN sdo_geometry
               DETERMINISTIC
               IS
               BEGIN
               --first ensure valid lat/lon input
               IF latitude IS NULL OR longitude IS NULL
               OR latitude NOT BETWEEN -90 AND 90
               OR longitude NOT BETWEEN -180 AND 180 THEN
                 RETURN NULL;
               ELSE
               --return point geometry
                RETURN sdo_geometry(
                        2001, --identifier for a point geometry
                        4326, --identifier for lat/lon coordinate system
                        sdo_point_type(
                         longitude, latitude, NULL),
                        NULL, NULL);
               END IF;
               END;
        ' );

        begin
            -- METADATA UPDATES
            moviestream_write('- add spatial metadata');

            insert into user_sdo_geom_metadata values (
             'CUSTOMER_CONTACT',
             user||'.LATLON_TO_GEOMETRY(loc_lat,loc_long)',
              sdo_dim_array(
                  sdo_dim_element('X', -180, 180, 0.05), --longitude bounds and tolerance in meters
                  sdo_dim_element('Y', -90, 90, 0.05)),  --latitude bounds and tolerance in meters
              4326 --identifier for lat/lon coordinate system
                );
             commit;
        exception
            when others then
                moviestream_write(' - unable to update spatial metadata for customer_contact');             
                moviestream_write(' - .... ' || sqlerrm);                 
        end;

        begin        
            insert into user_sdo_geom_metadata values (
             'PIZZA_LOCATION',
             user||'.LATLON_TO_GEOMETRY(lat,lon)',
              sdo_dim_array(
                  sdo_dim_element('X', -180, 180, 0.05),
                  sdo_dim_element('Y', -90, 90, 0.05)),
              4326
               );
               
            commit;
        exception
            when others then
                moviestream_write(' - unable to update spatial metadata for pizza_location');             
                moviestream_write(' - .... ' || sqlerrm);                 
        end;

        -- Add spatial indexes
        begin
            moviestream_write('- create spatial indexes');
            moviestream_exec ( 'CREATE INDEX customer_sidx ON customer_contact (latlon_to_geometry(loc_lat,loc_long)) INDEXTYPE IS mdsys.spatial_index_v2 PARAMETERS (''layer_gtype=POINT'')' );            
        exception
            when others then
                moviestream_write(' - .... unable to create spatial index on customer_contact');             
                moviestream_write(' - .... ' || sqlerrm);                 
        end;    

        begin
            moviestream_write('- create spatial indexes');
            moviestream_exec ( 'CREATE INDEX pizza_location_sidx ON pizza_location (latlon_to_geometry(lat,lon)) INDEXTYPE IS mdsys.spatial_index_v2 PARAMETERS (''layer_gtype=POINT'')' );     
        exception
            when others then
                moviestream_write(' - .... unable to create spatial index on pizza_location');             
                moviestream_write(' - .... ' || sqlerrm);                 
        end;    

     end;
     
     moviestream_write('done.');
     
 
end add_datasets;