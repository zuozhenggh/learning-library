# Create a Function

## Introduction

This lab walks you through the process of creating a serverless function that will only run on demand. The function will conform to the schema required to be consumed by Oracle Data Integrate. The serverless function will call an AI service (OCI Language in this case).

Estimated Lab Time: 120 minutes


### Objectives

In this lab, you will:
* Background
* Create a Sentiment Function
* Deploy the Function
* Invoke the Function

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed


## Task 1: Background

Currently, OCI Language works on a single record at a time, as shown in the example below:
		**OCI Language sample input**
		{
   	"text": "I would like to buy a new XBox, because my Playstation
             uses a resistor ACM-3423 that is not sold anymore."
		}

		**OCI Language sample output**
		{
    "entities": [
        {
            "text": "XBox",
            "type": "PRODUCT",
            "score": 0.9795951843261719,
            "offset": 26,
            "length": 4,
            "isPii": false
        },
        {
            "text": "Playstation",
            "type": "PRODUCT",
            "score": 0.9898978471755981,
            "offset": 43,
            "length": 11,
            "isPii": false
        },
        {
            "text": "resistor ACM-3423",
            "type": "PRODUCT",
            "score": 0.8866055011749268,
            "offset": 62,
            "length": 17,
            "isPii": false
        }
    		]
			}

Oracle Data Integration today supports calling functions, where the data payload is a single base 64 encoded string that contains the records to process, and a set of parameters.

Sample Oracle Data Integration Function Input:
		{"data":"eyJpZCI6MSwiaW5mbyI6Ilpvb20gbm93IGNsYWltcyB0byBoYXZlIDMwMCBtaWxsaW9uIG1lZXRpbmcgcGFydGljaXBhbnRzIHBlciBkYXkuIEl0IGNob3NlIE9yYWNsZSBDb3Jwb3JhdGlvbiBjby1mb3VuZGVkIGJ5IExhcnJ5IEVsbGlzb24gYW5kIGhlYWRxdWFydGVyZWQgaW4gUmVkd29vZCBTaG9yZXMgLCBmb3IgaXRzIGNsb3VkIGluZnJhc3RydWN0dXJlIGRlcGxveW1lbnRzIG92ZXIgdGhlIGxpa2VzIG9mIEFtYXpvbiwgTWljcm9zb2Z0LCBHb29nbGUsIGFuZCBldmVuIElCTSB0byBidWlsZCBhbiBlbnRlcnByaXNlIGdyYWRlIGV4cGVyaWVuY2UgZm9yIGl0cyBwcm9kdWN0LiBUaGUgc2VjdXJpdHkgZmVhdHVyZSBpcyBzaWduaWZpY2FudGx5IGxhY2tpbmcgYXMgaXQgYWxsb3dzIHBlb3BsZSB3aXRoIGRpc3R1cmJpbmcgem9vbWJvbWIuIn0KeyJpZCI6MiwiaW5mbyI6Ikx1aXMgbGlrZXMgdG8gd29yayBhdCBPcmFjbGUgYW5kIGxlYXJuIGFib3V0IGRhdGEgaW50ZWdyYXRpb24ifQ==","parameters":{"column":"info"}
    }

Note that the encoded data is the base 64 encode version of a set of JSON Lines format (each line is a JSON for each record). Each record has an ID that will be used to associate the output.

   {"id":1,"info":"Zoom now claims to have 300 million meeting participants per day. It chose Oracle Corporation co-founded by Larry Ellison and headquartered in Redwood Shores , for its cloud infrastructure deployments over the likes of Amazon, Microsoft, Google, and even IBM to build an enterprise grade experience for its product. The security feature is significantly lacking as it allows people with disturbing zoombomb."
 	 }

{"id":2,"info":"Luis likes to work at Oracle and learn about data integration"}

The output of the Oracle Data Integration Function will be a list of results that has the shape of a table. Currently Oracle Data Integration does not support nesting of complex structures.

This what the sample output should look like. Notice that it does not have nested structures.

[
    {
        "id": 1,
        "is_pii": false,
        "length": 4,
        "offset": 0,
        "score": 0.9817479849,
        "text": "Zoom",
        "type": "ORG"
    },
    {
        "id": 1,
        "is_pii": false,
        "length": 11,
        "offset": 24,
        "score": 0.9844536185,
        "text": "300 million",
        "type": "CARDINAL"
    },
…
    {
        "id": 2,
        "is_pii": true,
        "length": 4,
        "offset": 0,
        "score": 0.9824903011,
        "text": "Luis",
        "type": "PERSON"
    },
    {
        "id": 2,
        "is_pii": false,
        "length": 6,
        "offset": 22,
        "score": 0.9826752543,
        "text": "Oracle",
        "type": "ORG"
    }
]

Since we need to integrate the OCI Language service through an Oracle Function, we can use the function to serve as the entity that will:
1.	Read the function input (decode the input)
2.	Call the AI service multiple times (once for each record)
3.	Aggregate the output of each call into a shape that Data Integrate can receive.
(optional) Step 1 opening paragraph.

1. Sub step 1

	![Image alt text](images/sample1.png)

2. Sub step 2

  ![Image alt text](images/sample1.png)

4. Example with inline navigation icon ![Image alt text](images/sample2.png) click **Navigation**.

5. Example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## Task 2: Concise Step Description

1. Sub step 1 - tables sample

  Use tables sparingly:

  | Column 1 | Column 2 | Column 3 |
  | --- | --- | --- |
  | 1 | Some text or a link | More text  |
  | 2 |Some text or a link | More text |
  | 3 | Some text or a link | More text |

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2

3. Code examples

    ```
    Adding code examples
  	Indentation is important for the code example to appear inside the step
    Multiple lines of code
  	<copy>Enclose the text you want to copy in <copy></copy>.</copy>
    ```

4. Code examples that include variables

	```
  <copy>ssh -i <ssh-key-file></copy>
  ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
