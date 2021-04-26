# Choose your Own JSON Adventure: Relational or Document Store: JSON Documents and SODA

## Overview of SODA

Simple Oracle Document Access (SODA) is a set of NoSQL-style APIs that let you create and store collections of documents (in particular JSON) in Oracle Database, retrieve them, and query them, without needing to know Structured Query Language (SQL) or how the documents are stored in the database. 

## Introduction

In this lab you will use the SQL Developer Web browser-based tool, connect to your Database and load JSON data into relational tables. You will then work with this data to understand how it is accessed and stored.

Estimated Lab Time: 30-45 minutes

### Objectives

- Load JSON data into relational tables
- Understand how Oracle stores JSON data in relations tables
- Work with the JSON data with SQL

### Prerequisites

- The following lab requires an <a href="https://www.oracle.com/cloud/free/" target="\_blank">Oracle Cloud account</a>. You may use your own cloud account, a cloud account that you obtained through a trial, or a training account whose details were given to you by an Oracle instructor.
- This lab assumes you have successfully provisioned Oracle Autonomous database an connected to ADB with SQL Developer web.
- You have completed the user setups steps.

### **STEP 1: Loading JSON Data in a Collection**

> curl -u "gary:WElcome11##11" -i -X PUT https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelays

curl -u "gary:WElcome11##11" -i -X PUT https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelayscollection


HTTP/1.1 201 Created
Date: Wed, 14 Apr 2021 17:09:04 GMT
Content-Length: 0
Connection: keep-alive
X-Frame-Options: SAMEORIGIN
Cache-Control: private,must-revalidate,max-age=0
Location: https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/planeDelays/


curl -i -X POST -u "gary:WElcome11##11" -d @airportDelays.json -H "Content-Type: application/json" "https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/planeDelays?action=insert"

curl -i -X POST -u "gary:WElcome11##11" -d @airportDelays.json -H "Content-Type: application/json" "https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelayscollection?action=insert"


HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Date: Wed, 14 Apr 2021 17:15:38 GMT
Content-Type: application/json
Content-Length: 736197
Connection: keep-alive
X-Frame-Options: SAMEORIGIN
Cache-Control: private,must-revalidate,max-age=0

### **STEP 2**: Working with JSON Data in a Document Store

Show diagram in UI


A filter specification is a pattern expressed in JSON. You use it to select, from a collection, the JSON documents whose content matches it, meaning that the condition expressed by the pattern evaluates to true for the content of (only) those documents.

A filter specification is also called a query-by-example (QBE), or simply a filter.

Because a QBE selects documents from a collection, you can use it to drive read and write operations on those documents. For example, you can use a QBE to remove all matching documents from a collection. 

{
    "AirportCode": "SFO"
}

{
    "AirportCode": "SFO",
    "Time": {
        "Month Name": "June",
        "Year": 2010
    }
}

{
    "AirportCode": "SFO",
    "Time": {
        "Label": "2010/06"
    }
}

SUM

[{"$uniqueCount" : "zebra.name"},
 {"$sum"         : {"path"  : "zebra.price",                                       "bucket : [{"$lt"  : 3000},                               {"$gte" : 3000}]}, {"$avg"         : "zebra.rating"}]


 {"id": 5}

The comparison operators are the following:

    $all — whether an array field value contains all of a set of values

    $between — whether a field value is between two string or number values (inclusive)

    $eq — whether a field value is equal to a given scalar

    $exists — whether a given field exists

    $gt — whether a field value is greater than a given scalar value

    $gte — whether a field value is greater than or equal to a given scalar

    $hasSubstring — whether a string field value has a given substring (same as $instr)

    $in — whether a field value is a member of a given set of scalar values

    $instr — whether a string field value has a given substring (same as $hasSubstring)

    $like — whether a field value matches a given SQL LIKE pattern

    $lt — whether a field value is less than a given scalar value

    $lte — whether a field value is less than or equal to a given scalar value

    $ne — whether a field valueis different from a given scalar value

    $nin — whether a field value is not a member of a given set of scalar values

    $regex — whether a string field value matches a given regular expression

    $startsWith — whether a string field value starts with a given substring


 {"AirportCode": "DCA",
"Statistics.Flights.Cancelled": {"$gt": 400}
}

{
  "Statistics.# of Delays.Weather": {
    "$gt": 15
  }
}

QBE Operator $not 

{"Statistics.Flights.Cancelled": {"$gt": 400},
"AirportCode":{"$not" : {"$eq" : "DCA"}}
}

QBE Logical Combining Operators 

{ "$and" : [{"Statistics.Flights.Cancelled": {"$gt": 400}}, {"Time.Year": 2010 }, {"AirportCode": "ORD"}]}

{"Statistics.Flights.Cancelled": {"$gt": 400},
"Time.Year": 2010,
"AirportCode":{"$not" : {"$eq" : "DCA"}},
"$or" : [{"Time.Month": {"$eq": 6}}, {"Time.Month": {"$eq": 7}}]
}


{ "$query"   : { "$and" : [{"Statistics.Flights.Cancelled": {"$gt": 400}}, {"Time.Year": 2010 }, {"Time.Month": }]},
  "$orderby" :  { "path" :      "AirportCode",
                   "datatype" :  "varchar2",
                   "order" :     "desc" },
                  }


create index using UI

{"Statistics.Carriers.Names": {"$contains": "United"}}

