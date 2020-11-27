# Using Bitwise Aggregate Functions

## Introduction
This lab shows how to use the new `BIT_AND_AGG`, `BIT_OR_AGG` and `BIT_XOR_AGG` bitwise aggregate functions at the bit level of records within a group. `BIT_AND_AGG`, `BIT_OR_AGG` and `BIT_XOR_AGG` return the result of bitwise AND, OR and XOR operations respectively. These aggregates can be performed on a single numeric column or an expression. The return type of a bitwise aggregate operation is always a number.

### About Product/Technology
Until Oracle Database 21c, only the set operator UNION could be combined with ALL. Oracle Database 21c introduces two set operators, MINUS ALL (same as EXCEPT ALL) and INTERSECT ALL.

 ![Set Operators](images/set-operators.png "Set Operators")

- The 1st and 2nd statements use the EXCEPT operator to return only unique rows returned by the 1st query but not the 2nd.  
- The 3rd and 4th statements combine results from two queries using EXCEPT ALL reteruning only rows returned by the 1st query but not the 2nd even if not unique.
- The 5th and 6th statement combines results from 2 queries using INTERSECT ALL returning only unique rows returned by both queries.


Estimated Lab Time: XX minutes

### Objectives
In this lab, you will:
* Setup the environment
* Test the set operator with the EXCEPT clause
* Test the set operator with the EXCEPT ALL clause
* Test the set operator with the INTERSECT clause
* Test the set operator with the INTERSECT ALL clause

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account
* Lab: SSH Keys
* Lab: Create a VCN
* Lab: Create an OCI VM Database
* Lab: 21c Setup


## **STEP 1:** Test the bitwise AND function

- Connect to `PDB21` as `SYSTEM` to query values with numbers and bitwise aggregate functions.

  
  ```
  
  $ <copy>sqlplus system@PDB21</copy>
  
  Copyright (c) 1982, 2019, Oracle.  All rights reserved.
  
  Enter password: <b><i>password</i></b>
  
  Connected to:
  
  SQL>
  
  ```

- A bitwise AND is a binary operation that takes two equal-length binary representations and performs the logical AND operation on each pair of the corresponding bits. If both bits in the compared position are 1, the bit in the resulting binary representation is 1, otherwise, the result is 0. Apply the `BIT_AND_AGG` function on two numbers. The bit pattern for the values used in the examples below are 01 for 1, 10 for 2, and 11 for 3.

  
  ```
  
  SQL> <copy>WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual) 
  
                SELECT BIT_AND_AGG(c1) FROM x;</copy>
  
  BIT_AND_AGG(C1)
  
  ---------------
  
                2
  
  SQL>
  
  ```

## **STEP 2:** Test the bitwise OR function

A bitwise OR is a binary operation that takes two bit patterns of equal length and performs the logical inclusive OR operation on each pair of corresponding bits. The result in each position is 0 if both bits are 0, otherwise the result is 1.

- Apply the `BIT_OR_AGG` function on two numbers.

```

SQL> <copy>WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual) 
              SELECT BIT_OR_AGG(c1) FROM x;</copy>

BIT_OR_AGG(C1)
--------------
             3

SQL>

```

## **STEP 3:** Test the bitwise XOR function

A bitwise XOR is a binary operation that takes two bit patterns of equal length and performs the logical exclusive OR operation on each pair of corresponding bits. The result in each position is 1 if only the first bit is 1 or only the second bit is 1, but will be 0 if both are 0 or both are 1. Therefore, the comparison of two bits results in 1 if the two bits are different, and 0 if they are equal. 

- Apply the `BIT_XOR_AGG` function on two numbers.

```

SQL> <copy>WITH x AS (SELECT 2 c1 FROM dual UNION ALL SELECT 3 FROM dual) 
              SELECT BIT_XOR_AGG(c1) FROM x;</copy>

BIT_XOR_AGG(C1)
---------------
              1

SQL> <copy>EXIT</copy>
$

```


You may now [proceed to the next lab](#next).

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Dominique Jeunot, Database UA Team
* **Contributors** -  Kay Malcolm, Database Product Management
* **Last Updated By/Date** -  Kay Malcolm, Database Product Management

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
