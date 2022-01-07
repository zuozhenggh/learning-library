# Create your first map


## Introduction

doc details link...

Estimated Lab Time: 30 minutes

### Objectives

*  ....

### Prerequisites

* ....


## Task 1: ....

Create.... 

1. drag Static Content region to left column.
![Image alt text](images/add-spatial-analysis-01.png)

2. Rename to **My Filters Region**
![Image alt text](images/add-spatial-analysis-02.png) 

3. Add Select List item
![Image alt text](images/add-spatial-analysis-03.png) 

4. Set query for Select List
![Image alt text](images/add-spatial-analysis-04.png) 

5. Scroll down and set default to Texas
![Image alt text](images/add-spatial-analysis-05.png) 

6. Add number field for distance, name ...,  label **Proximity (km)**
![Image alt text](images/add-spatial-analysis-06.png) 

7. Scroll down and set **Value Required**
![Image alt text](images/add-spatial-analysis-07.png) 

8. Scroll down and set default to 100
![Image alt text](images/add-spatial-analysis-08.png) 

9. Add Dynamic Action to Distance entry
![Image alt text](images/add-spatial-analysis-09.png) 
.
10. Set name to **Validate and Refresh**, Event to , Select type to Item(s), Items(s) to.... Set Client Side Condition to ....
![Image alt text](images/add-spatial-analysis-10.png)

11. Set True action to ....
![Image alt text](images/add-spatial-analysis-11.png)    

12. Create **False Action**
![Image alt text](images/add-spatial-analysis-12.png)    

13. Set false Action to **Alert**...
![Image alt text](images/add-spatial-analysis-13.png) 

14. Rename State layer to ... amnd set to menu selection...
![Image alt text](images/add-spatial-analysis-14.png) 

15. Set Airports to spatial query
![Image alt text](images/add-spatial-analysis-15.png) 

    ```
    <copy>
    select a.*
    from EBA_SAMPLE_MAP_AIRPORTS a, EBA_SAMPLE_MAP_SIMPLE_STATES b
    where b.state_code= :P3_STATE
    and a.land_area_covered > 1000
    and sdo_within_distance(a.geometry, b.geometry, 'distance='|| :P3_DISTANCE ||' unit=KM') = 'TRUE'
    </copy>
    ```

16. Save and Run. Select Alabama and 100
![Image alt text](images/add-spatial-analysis-16.png) 

17. Switch State
![Image alt text](images/add-spatial-analysis-17.png) 

18. change distance
![Image alt text](images/add-spatial-analysis-18.png) 




## Learn More
* 

## Acknowledgements
* **Author** - David Lapp, Database Product Management, Oracle
* **Last Updated By/Date**  - David Lapp, Database Product Management, xxx 2021

