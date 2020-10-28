# Design the Pizza Skill

## Introduction

In this lab, we will complete development of the Pizza Skill that has been started for us.

Estimated Lab Time: n minutes


### Objectives

In this lab, you will:
- Create a composite bag entity to consolidate existing entities which represent the different variable elements of the pizza (size, topping, delivery time etc) and make it easier to manage entities from the dialog flow.
- Add logic to the skill's dialog flow to manage the pizza ordering process.
- Train and test the skill.
- Publish the skill so that it can be used in a digital assistant.

## **STEP 1**: Explore and Test the Skill

The conversational AI use case you are working with is a skill for ordering pizza. To familiarize yourself with the designer and the skill itself, try it out by following these steps:

1. In ODA, click the main menu icon to open the side menu.
2. Click **Development** and select **Skills**.
3. Click the main menu icon again to collapse the side menu.
4. In the skills dashboard, select your copy of **PizzaSkill**.
5. In the left navigation for the designer, select the Intents icon.![](../images/left_nav_intents.png " ")
6. Click the **OrderPizza** intent and quickly scan the utterances.

7. In the left navigation for the designer, select the Entities icon.![](../images/left_nav_entities.png " ")
8. Select the **PizzaDough** entity and look at the way that it is configured.
9. Repeat the above step for **PizzaSize** and **PizzaTopping**.
10. Locate the **Train button**![](../images/train-button.png " ") on the right side of the page, click it, click **Submit**, and then wait a few seconds for the training to complete.

11. Find the Bot Tester icon ![](../images/test_button.png " ") on the top of the page and click it.
12. In the tester's **Message** field, type *I want to order pizza*, click **Send**, and note the skill's response.
  For now it's just a static response. It will become more dynamic once we add logic to the dialog flow.

13. Click the **Reset** button at the top of the tester window and then close the tester.

## **STEP 2:** Add a Composite Bag Entity

When a customer orders a pizza, details such as toppings, size, and crust need to be specified. In PizzaSkill, each of these variables is represented by an entity.

The challenge for any chatbot is that the user can include varying subsets of the required information in their initial input. For example, one person might specify the size and topping, but not the type of crust. And another person might specify only the crust. In each case, the skill should recognize any entities supplied in the original input, and prompt for those that are not.

In this step, we’ll create a composite bag entity, which is a special entity that automatically recognizes and prompts for the appropriate entities for a pizza order. In addition to our custom entities (PizzaSize, PizzaTopping, PizzaDough), we'll include a system entity for DeliveryTime.

**Create the Composite Bag Entity**:

1. Select the Entities icon and click the Add Entity button to create a new entity.
2. In the **Name** field, change the value to PizzaBag.
3. In the Configuration section, in the Type dropdown, select **Composite Bag**.
  ![](../images/select-composite-bag.png " ")

**Add Bag Items for the PizzaSize, PizzaTopping, PizzaDough, and DeliveryTime Entities**

1. Click Add Bag Item button. ![](./images/bag-item-button.png " ")
2. On the Add Bag Item page, fill in the following values:
    - **Name**: PizzaSize
    - **Type**: Entity
    - **Entity Name**: PizzaSize (If prompted in a popup, select **Overwrite**.)
    - **Maximum User Input Attempts**: 4
    - **Error Message**: Sorry, '${system.entityToResolve.value.userInput!'this'}' is not a valid size of pizza.

3. Click Add Prompt button. ![](./images/add-prompt.png " ")
4. For the value, enter *What size of pizza would you like?*
5. Again, click Add Prompt button. ![](./images/add-prompt.png " ")
6. For the value, enter *Please choose small, medium or large.*
7. Click **Close**.
8. Again, click Add Bag Item button. ![](./images/bag-item-button.png " ")

9. On the Add Bag Item page, fill in the following values:
    - **Name**: PizzaTopping
    - **Type**: Entity
    - **Entity Name**: PizzaTopping (If prompted in a popup, select **Overwrite**.)
    - **Error Message**: Sorry, we don't have that topping
    - **Prompt for Disambiguation**: switched ON
    - **Disambiguation Prompt**: Sorry you can only order one topping type

10. Click **Close**.
11. Again click Add Bag Item button. ![](./images/bag-item-button.png " ")
12. On the Add Bag Item page, fill in the following values:
    - **Name**: PizzaDough
    - **Type**: Entity
    - **Entity Name**: PizzaDough
    - **Prompt for Value**: false

13. Click **Close**.

14. For the fourth (and final) time, click Add Bag Item button. ![](./images/bag-item-button.png " ")

15. On the Add Bag Item page, fill in the following values:
    - **Name**: DeliveryTime
    - **Type**: Entity
    - **Entity Name**: TIME
    - **Maximum User Input Attempts**: 4

16. Scroll down to the Prompts section, replace the existing prompt with *When can we deliver that for you?*, and press Enter.
17. Click Add Validation Rule button. ![](./images/validation-rule-button.png " ")

18. In the **Expression** field, enter ${(pizza.value.DeliveryTime.hrs?number < 10)?then('true','false')}
19. In the **Error Message** field, enter *Sorry, we only deliver up to 9:30pm* and press the Enter key.
20. Click **Close**.

  Here is what the PizzaBag composite bag should look like in the designer:
  ![](./images/pizza-bag-entity.png " ")

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Group, Month Year>
* **Workshop (or Lab) Expiry Date** - <Month Year> -- optional, use this when you are using a Pre-Authorized Request (PAR) URL to an object in Oracle Object Store.

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.