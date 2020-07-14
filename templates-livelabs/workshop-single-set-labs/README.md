# Workshop with a single set of labs

## Instructions

1. Open the workshop-single-set-labs template in Atom or Visual Studio Code using workshop-single-set-labs
2. Start atom-live-server (Atom) or live-server (Visual Studio Code)
3. Look at workshop-single-set-labs/product-area/product-type/workshops/product-workshop-name/freetier

## Folder Structure

In this example, the goal is to create several "children" workshops from one longer "parent" workshop. The children are made up of parts from the parent.

workshop-single-set-labs/
  product-area/
    product-type/

        -- individual labs

        provision-lab/
        setup-lab/
        dataload-lab/
        query-lab/
        analyze-lab/
        visualize-lab

    workshops/
      product-workshop-name/    -- contains one of the prerequisites and all 6 individual labs
        introduction/
          introduction.md       -- description of the everything workshop
       freetier/                -- freetier version of the workshop
        index.html
        manifest.json
       livelabs/                -- livelabs version of the workshop
        index.html
        manifest.json


### FreeTier vs LiveLabs

* "FreeTier" - includes Free Trials, Paid Accounts and for some workshops, Always Free accounts.
* "LiveLabs" - these are workshops that use Oracle provided tenancies

### The product-workshop-name

The workshop includes all 6 of the individual labs in a single sequence.

The folder structure includes a Introduction "lab" that describes the workshop as a complete set of 6 labs. Note: you may not need to have a different introduction for each of the parent and child versions of the workshops, this is illustrative only.

Look at the product-name-workshop/freetier folder and look at the manifest.json file to see the structure.

The Prerequisite "lab" is the first lab in a common folder three levels up:

  ```
  "filename": "../../../common/prerequisite-freetier-lab/prerequisite-freetier-lab.md"
  ```

The labs are also located three levels up, for example:

  ```
  "filename": "../../../provision-lab/provision-lab.md"
  ```

### More information

* [Creating the Structure of Markdown Labs](https://confluence.oraclecorp.com/confluence/display/DCS/Creating+the+Structure+of+Markdown+Labs)
* [See an working example on GitHub](https://github.com/oracle/learning-library/tree/master/data-management-library/autonomous-database/shared)
