
# Use Autonomous Database Tools

## Introduction
This lab introduces the suite of data tools built into the Oracle Autonomous Data Warehouse.

Estimated Time: 50 minutes

### Objectives
In this lab, you will:
- Familiarize with the suite of built-in database tools of the Oracle Autonomous Data Warehouse
- Load data
- Learn how to use the Data Transforms tool to correct data errors
- Create a business model
- Generate data insights
- Use the Catalog tool

### Prerequisites

To complete this lab, you need to have the following:

- All previous labs successfully completed


## Task 1: Use Data Transforms

### MovieStream Critics Corner: Data Transforms

*Just as the good folks at MovieStream are very proud of the SciFi lineup, we in the Autonomous Database team are very proud of our Data Transforms tool. There’s an eponymous movie series in the SciFi genre and fans of that will truly appreciate the value of a tool that can transform, perhaps a third normal form application schema into a star schema suitable for analysis. Even if it’s only a quick clean up of source data, you’ll be glad to have the Data Transforms tool at your fingertips.*

### Overview

In this section of the lab, you'll correct the data errors identified in the previous section of the lab. In a future version of this lab, we’ll show you how to do this using drag-and-drop techniques via the Data Transforms Tool.

#### Video Preview

Watch a video demonstration of the Data Transforms tool of Autonomous Database:

[] (youtube:Xg5VK_R4-IM)
> **Note:** Interfaces in this video may look different from the interfaces you will see.

That’s something to look forward to, but is not currently covered in this lab.

### Use SQL 

As an alternative to using the Data Transforms Tool, you can perform the necessary fixes to the data set using SQL. This is covered here. 

1. From the Autonomous Database **Tools** home page, access a SQL worksheet by clicking the **SQL** card on the **Database Actions** page. Copy and paste the following SQL statement into the Worksheet.

    ````
    <copy>
    create table MOVIE_SALES_2020Q2 as
    select COUNTRY
    , initcap(DAY) as DAY -- Use title case for days
    , MONTH
    , GENRE
    , CUSTOMER_SEGMENT
    , DEVICE
    , SALES
    , PURCHASES
    FROM MOVIE_SALES_2020
    where month in ('April','May','June'); -- only want data from Q2
    exec dbms_stats.gather_table_stats(user, 'MOVIE_SALES_2020Q2');
    </copy>
    ````

2. Select the entire text in the Worksheet and press the **green** button to run these two statements. You should see that both statements have executed successfully. Having completed this step you now have a table MOVIE\_SALES\_2020Q2, with data for just April, May, and June. The days have all been changed to title case. Refresh to see the new table created.
![ALT text is not available for this image](images/data-transforms.png)

## Task 2: Create a Business Model

### MovieStream Critics Corner: Business Model

*You know that frustrating feeling of joining your friends and family who are half way through watching a movie? Having missed out on the introduction, much of what you see makes no sense to you. Often that’s what it’s like looking at a bunch of data that does not have a good semantic model. That’s where Autonomous Database’s Business Model tool comes in. Hierarchies, dimensions, and measures are automatically detected to give you a head start. The business model is built in to the database itself, so that it is accessible to all users of the database, regardless of which tool they use to access the data.*

### Overview

You can only go so far looking at raw data. Before long you want a semantic model on top of it. That's where our Business Model tool comes in. We've made it simple to build sophisticated models on your data, by identifying dimensions, hierarchies, and measures - with a nice clean way of saying how to aggregate - sum, average, or whatever. But wait, there's more. We make it fast, too! Simple SQL written against the business model is re-written to ensure optimal data access, and because we know about the hierarchical structure of the data, we can pre-aggregate the totals and sub-totals you want, before you've even told us you want them! 

#### Video Preview

Watch a video demonstration of the Business Model tool of Autonomous Database:

[] (youtube:i2na8dmE_Xc)
> **Note:** Interfaces in this video may look different from the interfaces you will see.

In this section of the workshop, you'll create a Business Model over table MOVIE\_SALES\_2020Q2.

1. Start by clicking the **Business Models** card in the ADB **Database Actions** page. The page on which you'll land has some text explaining the Business Model utility in some detail, but let's dive straight in.
2. Press one of the **Create Model** buttons. If **MOVIE\_SALES\_2020Q2** is not already identified as the *Fact Table*, select it from the pick list. (Be sure to select table MOVIE\_SALES\_2020**Q2**, which has just the data for April, May, June, and not table MOVIE\_SALES\_2020, which has data for the full year!)
  ![ALT text is not available for this image](images/business-model.png)

### Generate A New Business Model

3. Now, press **Next** to start the Auto-Business Model utility. This will take several seconds to complete, after which you'll see a dialog such as this.
  ![ALT text is not available for this image](images/2879071220.png)

### Expand Data Sources

4. Press **Close** and select **Data Sources** from the panel at the left of the screen. You'll see that a star schema has been identified, based on the tables that you loaded in previous steps of this lab. All columns of the Fact Table, MOVIE\_SALES\_2020Q2, are  already shown.

5. Press the **three dots** to the right of table DAYS and select **Expand**. Repeat this for the other three dimension tables. You should see the star schema laid out as follows:
  ![ALT text is not available for this image](images/2879071210.png)

### Refine Your Hierarchies

6. Select **Hierarchies** from the list on the left of the screen and click the three dots to the right of the row for hierarchy **CONTINENT**. Click **Edit**.
  ![ALT text is not available for this image](images/hierarchy-continent.png)

7. Notice that the business model tool has detected a hierarchy of Countries within Continents, based on the structure and contents of the tables in the Autonomous Data Warehouse. 
  ![ALT text is not available for this image](images/continent-country.png)

8. This is a great head start, but a better term to use for this hierarchy would be geography. Override the default *Hierarchy Name* with **GEOGRAPHY**. Override *Caption* and *Description* with **Geography** as shown below. Then click **Save**. 
  ![ALT text is not available for this image](images/geography.png)

9. Clean up hierarchy DAYS:

    - Click the three dots to the right of that hierarchy and select **Edit**. 
    - Change *Hierarchy Name* to **DAY**.
    - Change *Caption* and *Description* to **Day**.
  ![ALT text is not available for this image](images/day-hierarchy.png)

10. This is simply a day-of-week hierarchy, but now you'll see the value of the table that the sales analyst had set up in a previous analysis. Sorting days alphabetically is not particularly helpful. What's preferable is to sort by the day number of week. Conventions for day numbers vary across the world and the DAYS table supports both the European and the North American conventions. You'll use the North American convention for this exercise. Change the *Sort By* to **DAY\_NUM\_USA**. Then click **Save**. 
  ![ALT text is not available for this image](images/sort-day.png)

11. Similarly, change the MONTHS dimension as follows:
  ![ALT text is not available for this image](images/month.png)

### Work With Measures

12. Now select **Measures**, the last item on the list on the left of the screen. Notice that Auto-Business Model has identified SALES and PURCHASES as candidate Measures from the Fact Table (because these are numeric columns).

    a. Measure SALES is a dollar amount.

    b. Measure PURCHASES is a tally of the number of purchases made.

13. The default aggregation expression for the measures is SUM. Other expressions could be selected, but for the purposes of this workshop, SUM is the appropriate value to select in both cases.
  ![ALT text is not available for this image](images/sum.png)

14. Press **Create** and then **Yes** in the confirmation dialog. After a few seconds, the Business Model is successfully created, and represented by a card at the bottom of the screen.

15. Press the three dots on the top right of the card and select **Show DDL** from the list that appears. 
  ![ALT text is not available for this image](images/show-ddl.png)

16. Experienced users of Oracle Database will note that the Business Model is implemented in the database as an Analytic View. Experienced or not, it's nice to know that you didn't have to type any of that DDL! Click **Close** to return to the Business Model screen, click the **three dots** on the Business Model's card again and this time select **Analyze** from the list that appears. 

17. You should see a data summary similar to this.
    ![ALT text is not available for this image](images/data-summary.png)

    Then click **Layout**.

18. Notice that there are two tabs across the top of the Layout screen.

    In the Hierarchies tab:

    a. Change the layout of hierarchy *GEOGRAPHY* to **All** by selecting that value from the pick list.

    b. Change the layout of hierarchy *CUSTOMER_SEGMENT* to **Column**.

    c. Change the layout of hierarchy *DEVICES* to **Row**.

    ![ALT text is not available for this image](images/hierarchies-tab.png)

19. In the Measures tab:

    a. Deselect measure **SALES**.

    b. Select measure **PURCHASES**.

    Click **Close**.

20. You should see a data summary similar to this.
  ![ALT text is not available for this image](images/data-summary-good.png)

21. Having completed this step, you now have a Business Model over table MOVIE\_SALES\_2020Q2. This features hierarchies, measures (including aggregation expressions), and provides a preview pane in which to view the data and do some rudimentary analysis. Press **Close** to return to the Business Model page. Shortly you'll return to the Autonomous Database Home Page, but first let's explore some of the various navigation techniques available throughout the tool suite. 


22. There are 3 options to navigate to Data Insights and Catalog.

    Option 1: From the three-dot menu of the Business Model card, there are options to navigate directly to Insights and Catalog for this Business Model. (You'll use these tools in subsequent sections of this workshop.)

    Option 2: From the **hamburger menu** on the top left of the screen, you can navigate directly to any of the Built-In tools.

    Option 3: Alternatively, from the hamburger menu, you can return to the **Database Actions** menu, also known as the home page of the Built-In Tool Suite.
      ![ALT text is not available for this image](images/navigate-insights.png)

    Here you'll take Option 3: Select **Database Actions**. 

## Task 3: Generate Data Insights 

### MovieStream Critics Corner: Data Insights

*If Sherlock Holmes is your hero, MovieStream has hundreds of movies in the detective genre for you to enjoy. You’ll enjoy the Data Insights tool of Autonomous Database, too. Just as Dr. Watson marvels at Holmes’s perspicacity, you’ll marvel as Data Insights scours thoroughly through the data to find all the essential clues, as if to say, “It’s elementary, my dear Watson.”*

### Overview

If the sales analyst's job can be likened to looking for a needle in a haystack, the Data Insights tool can be thought of as an electromagnet. Swing it over the haystack and turn on the power. Anything made of ferrous metals will be pulled on to the electromagnet. There may be all sorts of junk here -  rusty old nails and screws and nuts and bolts - but there are going to be a few needles as well. It's far easier to pick the needles out of these few bits of metal than go rummaging around in all that hay - especially if you have hay fever! That's more or less how our Insights tool works, as you shall see in this section of the workshop.

#### Video Preview

Watch a video demonstration of the Data Insights tool of Autonomous Database:

[] (youtube:pLaZnCQk3Vs)
> **Note:** Interfaces in this video may look different from the interfaces you will see.

### Generate New Insights

1. From the Autonomous Database **Tools** home page, click the **Data Insights** card. If this is the first time you've accessed this tool (or any other in the Built-In Tool Suite), you'll see a series of tool tips to show you how to use it.
  
2. If the tool tips do not appear, they can be accessed by clicking the binoculars icon on the upper-right of the screen (under your username). Click **Next** repeatedly to browse through the tool tips for the Data Insights module. (To exit at any time, press X in the upper right of the tool tip.)
  ![ALT text is not available for this image](images/insights.png)

3. In this exercise, you're going to follow a procedure exactly as laid out in these tool tips, thus:

    a. Under *Analytic View/Table*, select Analytic View **MOVIE\_SALES\_2020Q2\_MODEL\_AV** (which is the basis for the Business Model you created in Task 2). 

    b. Under *Column*, select **PURCHASES**.

    c. Press **Search**.

    The Data Insights tool is now scouring through the data in your business model, looking for hidden patterns, anomalies, and outliers in the data set. You may be interested to know that these queries employ many of the built-in analytical capabilities of Oracle Database. A typical example is **Regression Slope**. Note that this process can take several minutes to complete, since a very large number of queries are being executed. This might be a good time to stretch, get a refreshment, and let Autonomous Database do the hard work for you! You can monitor the progress bar towards the upper left of the screen. While it is processing, the screen will refresh automatically as various insights appear on the screen. At any point, it is possible to disable auto-refresh to freeze a particular set of "gauges on the dashboard". This technique allows you to drill into a specific insight, while processing continues. You'll notice that it's possible to toggle between these two modes of *Enable Auto Refresh* and *Disable Auto Refresh*. When the search has completed, you'll see a dashboard with a bar chart (gauge) for each of the top twenty insights, as defined by the data patterns found to be most anomalous in the data set.
  ![ALT text is not available for this image](images/insight.png)

  > **Note:** Searching for Data Insights is CPU-intensive, and the time to complete the process is dependent in part on the CPU count of your Autonomous Database. If you use the always-free tier, which is limited to a single OCPU, the search may take 10 minutes or more. The time to complete the search for Data Insights can be dramatically reduced if you run with a higher CPU count, preferably with auto-scale enabled.

4. Scroll down if necessary, click on one of these, such as the bar chart for "GENRE in June" (fifth item on the third row in the above screenshot). This drills down into a detailed view of this Insight, similar to this:
  ![ALT text is not available for this image](images/june.png)
  This chart shows actual purchases (blue bars) vs expected purchases (green lines) of various movie genres in the month of June. Three segments have bold black borders. These indicate the most anomalous values, showing that the consumption of:

    a. Comedies and Romances is higher than expected, and

    b. Sci-Fi is lower than expected.

5. The actual and expected values are shown for the highlighted bar (Romance in this screenshot). The way to read this is, "compared to the other months in the quarter – April and May – in June there was a lower than expected consumption of Sci-Fi movies, and a higher than expected consumption of Comedies and Romances." Perhaps what the data is showing you is that as we enter the summer months, people are feeling more light-hearted and romantic, and need correspondingly less escapism in their movie choices. **This is indeed quite an actionable insight, and it's far from an obvious one**. Based on this anomalous pattern, which Data Insights found in the data without the need for any painstaking slicing and dicing, the sales analyst may now be able to propose a marketing campaign for next Q2, making movie recommendations to customers based on a seasonal shift in taste for genres. 

6. Click the **Back** button on the top left of the screen to return to the **Insights** dashboard. You may wish to browse through some of the other Insights shown. Several of these represent other valuable information for your sales analyst. Others may be less interesting – at least for the current purposes of your sales analyst. Returning to the analogy of the needle in the haystack, these might be considered the rusty nails pulled out by the electromagnet. 

### Retrieve Insights

In this exercise, you have run the Data Insights tool for what may be the first time. Over time it's likely that Data Insights will be run repeatedly over various data sets. You've also seen that, because of the vast number of queries that are involved in running the Data Insights tool, it can take some time to complete searching for Insights on a new data set. For these reasons, it can be very useful to be able to retrieve insights that have already been run. You'll walk through this process now in the following steps:

7. Return to the home page, by clicking **Database Actions**.
8. Click the **Data Insights** card to return to the Data Insights screen.
9. The most recent search will show up.
10. If it does not show up, or if you want to retrieve other recent searches, you can click the three-bar menu to the upper right to open the list of **Recent Searches**. 
11. Select the appropriate search from the list that appears. (There's only one in this example.) The data for this search will be retrieved. 
  ![ALT text is not available for this image](images/recent-search.png)

### Run Insights against Tables

It's also worth noting that Data Insights can be run directly against a table, and it is certainly not wrong to do so. In many cases, this can be a useful technique to use for data profiling. It can often identify data anomalies that represent data items that need to be addressed with further data preparation. (Typical examples include unwanted sub-totals, or perhaps multiple values for a single logical category - which suggest the need for filtering and data cleansing. The built-in Transforms tool is ideal for addressing these requirements.)

### RECAP

Historically, data analysts would pore over data sets, slicing and dicing, looking for hidden patterns or outliers in the data. With Autonomous Database, the data analyst is now armed with the automatic Data Insights tool, which performs the same operations unattended. This gives the analyst a significant head start in understanding what's really important about their data set.

## Task 4: Use Autonomous Database Catalog

### MovieStream Critics Corner: Catalog

*True fans of period dramas on MovieStream study [Burke’s Peerage](https://www.burkespeerage.com/) in their spare time. They know that impeccable lineage is a non-negotiable quality in a suitable love-match for an aristocrat. They are just as keenly aware that a clear line of succession is an essential consideration. The untimely demise of a principal character could have profound implications for the continuity of a great family’s line. These people will have an instinctive appreciation for Autonomous Database’s Catalog tool, which shows both Lineage and Impact Analysis clearly for any entity in the system, be it a table, view, business model, or whatever.*

#### Video Preview

Watch a video demonstration of the Catalog tool of Autonomous Database:

[] (youtube:qi7HxiVyfOc)
> **Note:** Interfaces in this video may look different from the interfaces you will see.

Data is capital and the built-in Catalog tool allows you to maximize its value. Data Lineage and Impact Analysis are now at your fingertips in this integrated tool, which you explore in this part of the workshop.

1. From the **Database Actions** page, select the **Catalog** card. You'll land on a page looking like this. 
  ![ALT text is not available for this image](images/catalog.png)
2. To understand this screen, glance at the upper left to notice that for the current schema, entities of type **TABLE** are currently shown, with a card for each. On the upper right, you'll notice that the third icon from the right (card view) is selected. Click the button to its right to show the information in grid view:
  ![ALT text is not available for this image](images/grid-view.png)
3. Click the icon on the far right for list view:
  ![ALT text is not available for this image](images/list-view.png)
4. Personal preference and different use cases may dictate which viewing option is preferable. For the purposes of this section of the workshop, click the **Card View** icon to return to that layout.

### Search The Catalog

5. The catalog has a browser-like search capability. In the search bar across the top, enter **movie sales** and click **Enter**.
6. Only entities matching these criteria will be displayed.
  ![ALT text is not available for this image](images/movie-sales.png)

### Change the Filter

7. On the upper left of the screen, just above the cards, is the **filter** icon. If it is not highlighted, click it.
8. Under Entity Type, click **More...** and check the boxes for Analytic View and Business Model. Then click **Apply**.
  ![ALT text is not available for this image](images/filter.png)
9. You now see that the Entity Type list at the top has been expanded correspondingly, and that four cards are displayed. Besides the two tables you saw initially, there are now cards for the Business Model and the Analytic View on which it's based. 
  ![ALT text is not available for this image](images/three-entities.png)
10. Clear the search by clicking **x** on the right end of the search bar. Now you see eight cards: six tables, a business model, and an analytic view.
  ![ALT text is not available for this image](images/2879071198.png)

### Understand Data Lineage

An important consideration in understanding the reliability of data is its source, or lineage. This capability is built into the Catalog.

11. Click the three dots on the upper right of the card for table **DEVICES**, and select **View Details**. On the left of the panel that appears, you'll see tabs for *Preview, Lineage, Impact, Statistics* and *Data Definition*. Here you'll notice the consistency of the widgets used between the various tools that you've explored in this lab. Preview is the default selection. You've seen Statistics and Data Definition elsewhere in this workshop.
12. For this exercise, click **Lineage**. Various different levels of information are accessible by expanding the various cards as required. To do this, click the three dots to the right of the card and select **Expand***.* Even more information is visible by hovering the mouse pointer over specific areas of the screen. An example is shown below. 
  ![ALT text is not available for this image](images/lineage.png)
13. Click **Close** in the lower right of the screen (or click the **Esc** button on your keyboard) to return to the main catalog view. 

### Impact Analysis

You may think of impact analysis as the inverse of lineage. It shows which other entities are dependent on a specific entity. In this exercise, you'll look at the Impact Analysis for table **MOVIE\_SALES\_2020Q2**.

14. Click the three dots for that card, select **View Details** and then select the **Impact** tab on the left of the screen that appears. You should spend some time exploring the Impact Analysis for this table. Depending on how you drill down (Expand), you may see a screen like this.
  ![ALT text is not available for this image](images/impact.png)It's worth pausing here to reflect on quite how extensive the impact analysis is for this simple exercise. Here you have a single table, on which you built a business model. This is implemented as an analytic view, including a number of Attribute Dimensions. Against this, you ran an Data Insights job, which resulted in a large number of Insights queries.
15. If you **Expand** on **REQUEST\_INSIGHT_1** (on the right of the screen), you'll see some of the many queries that were executed as part of the Data Insights job, perhaps while you were sipping your coffee! Tip: You can return to a lower-resolution of data by selecting *Collapse* for an entity that had previously been *Expand*ed. 
16. **RECAP** - This concludes the brief guided tour of the **Catalog** tool. In this section, you have seen:

    a. How to view data in card view, grid view, and list view

    b. How to use the browser-like search capability

    c. How to change the filter

    d. How to view Lineage

    e. How to view Impact Analysis

17. Feel free to explore more of its capabilities, or else click **Close** and return to the Autonomous Database Actions Home Page from the hamburger menu at the top left of your screen.

## Want To Learn More

See the documentation on [Database Actions](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/about-sdw.html#GUID-AF7601F9-7713-4ECC-8EC9-FB0296002C69).

## Acknowledgements

- Created By/Date - Patrick Wheeler, Product Management, Autonomous Database, March 2021
- Contributors - Keith Laker, Rick Green, Nilay Panchal, Hermann Baer
- Last Updated By - Arabella Yao, August 2021
