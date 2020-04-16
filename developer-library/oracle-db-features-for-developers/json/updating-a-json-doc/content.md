# Oracle Database 19c JSON Documents

## Updating a JSON Document

You can now update a JSON document declaratively using the new SQL function **JSON_MERGEPATCH**. You can apply one or more changes to multiple documents by using a single statement. This feature improves the flexibility of JSON update operations.

## Updating Selected JSON Documents On The Fly

You can use ***JSON_MERGEPATCH*** in a SELECT list, to modify the selected documents. The modified documents can be returned or processed further.

### Retrieve A Specific Value From JSON Document

For example we can retrieve the entire JSON document containing the country description for Spain.

````
> <copy>select DOC from MYJSON j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](../images/updateJsonDoc_1.png)

JSON Merge Patch acts a bit like a UNIX patch utility — you give it:
1. a source document to patch and
2. a patch document that specifies the changes to make, and it returns a copy of the source document updated (patched).

Here is a very simple example, changing one attribute in a two attributes JSON document.

````
> <copy>SELECT json_mergepatch('{"CountryName":"Spain", "Capital":"Madrid"}', '{"Capital":"Toledo"}' RETURNING CLOB PRETTY) Medieval FROM dual;</copy>
````
![](../images/updateJsonDoc_2.png)

However, you cannot use it to add, remove, or change array elements (except by explicitly replacing the whole array). For example, our documents received from GeoNames are all arrays.

The Country description for Spain has one field geonames that has an array value. This array has one element (geonames[0]), which is an object with 17 fields
- continent
- capital
- languages
- geonameId
- south
- isoAlpha3
- north
- fipsCode
- population
- east
- isoNumeric
- areaInSqKm
- countryCode
- west
- countryName
- continentName
- currencyCode

````
> <copy>SELECT j.doc.geonames[0] FROM MYJSON j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](../images/updateJsonDoc_3.png)

Take a note of the capital attribute in that document — ***"capital":"Madrid"***. There is always a solution.

### Update A Specific Value From JSON Document

Change that attribute on the fly — ***"capital":"Toledo"***. We can print the same result in a pretty format, just to highlight it more.

````
> <copy>SELECT json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo"}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````

![](../images/updateJsonDoc_4.png)

Change two attributes in that JSON document. Remember, the return value for a dot-notation query is always a string, and we can work with strings. For example we can add the first part of it, before element geonames[0], and the last part, to convert this single element back into an array, and print the resulted array in a pretty format.

````
> <copy>SELECT json_mergepatch(j.doc, '{"geonames": [' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````
![](../images/updateJsonDoc_5.png)

Further, we can add the altered element with the updated values, as an additional JSON document, to the first element with the original value. For example, we can keep our original array elements, and add new ones with new values.

````
> <copy>SELECT json_mergepatch(j.doc, '{"geonames": [' || j.doc.geonames[0] || ',' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````
![](../images/updateJsonDoc_6.png)

In the end, everything is possible, there are no restrictions.

### Update JSON Document Using Selected Current Value

In the same way, we can use the altered array with ***JSON_MERGEPATCH*** function to insert, or update, a JSON document stored inside the database.

````
> <copy>INSERT INTO MYJSON (doc) SELECT json_mergepatch(j.doc, '{"geonames": [' || j.doc.geonames[0] || ',' || json_mergepatch(j.doc.geonames[0], '{"capital":"Toledo", "countryName" : "Medieval Spain"}') || ']}' RETURNING CLOB PRETTY) Medieval
  FROM myjson j where j.doc.geonames.geonameId = '2510769';</copy>
````

In this case, we insert a new document.

## Updating A JSON Column Using JSON Merge Patch

You can use ***JSON_MERGEPATCH*** in an UPDATE statement, to update the documents in a JSON column. We will use the very first JSON document in our table, the one about that Oracle Workshop.

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](../images/updateJsonDoc_7.png)

This is a simple JSON document, with three fields. The third field is also a collection with three fields.

### Update Specific Element In A JSON Document

We can update the second field, using the plain UPDATE statement and ***JSON_MERGEPATCH*** function. When running the same SELECT statement, we notice that the document is not pretty-printed any more.

````
> <copy>update MYJSON set DOC = json_mergepatch(DOC, '{"audienceType": "Developers and DBAs"}') where ID = 1;</copy>
````

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](../images/updateJsonDoc_8.png)

So we can add the ***PRETTY*** clause to the UPDATE statement, and have more clarity when returning the document from our table.

````
> <copy>update MYJSON set DOC = json_mergepatch(DOC, '{"audienceType": "Developers and DBAs"}' RETURNING CLOB PRETTY) where ID = 1;</copy>
````

````
> <copy>select DOC from MYJSON where ID = 1;</copy>
````
![](../images/updateJsonDoc_9.png)

This one looks much nicer. Remember to commit changes if you want to keep them in the database.

````
<copy>commit;</copy>
````

Updating JSON documents inside the Oracle Database is that simple.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Troy Anthony, April 2020

See an issue?  Please open up a request [here](https://github.com/oracle/learning-library/issues).
---
