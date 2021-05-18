# Miscellaneous Markdown Development Features [Work in Progress]

## Introduction

***WORK IN PROGRESS***

We'll go over how to implement certain markdown features and tips.

### Objectives

* 


### What Do You Need?
* An IDE, such as Atom or Visual Studio Code.
* A local web server such as **atom-live-server** for Atom or **Live Server** for VSC.

## **STEP 1:** Linking to Absolute Path Images (on github)
Rather than pointing to images within your lab folder or workshop directory with a relative path, you can just as easily point your images to URLs. This comes in handy if you reuse an image a lot, the code you write to display it in markdown will always be the same no matter where the image is in relation to markdown. Using absolute image paths is also handy if you need to keep an image updated, as changing the destination file image will affect every instance where you pointed an image to it. This is the same concept and implementation as using absolute paths for common labs in your manifest.json files.

*For screen shots of OCI menu navigation, use the images with absolute links in **Lab 1: Provision an Instance** markdown from the sample-workshop. A preview of the images can be found **[here](https://oracle.github.io/learning-library/sample-livelabs-templates/sample-workshop/workshops/freetier/index.html?lab=provision)** under STEP 0.*

1. Here is an example of what the image code block looks like for pointing to a local image using relative pathing.

  ![](./images/local-image.png " ")

2. To use an image with an absolute path, just replace the path with an URL. In this case, I still point to an image located in this lab's image folder.

  ![](https://raw.githubusercontent.com/oracle/learning-library/master/sample-livelabs-templates/create-labs/labs/3a-labs-misc-develop-content-features/images/absolute-image.png " ")

3. If the image link breaks, the image will break. For this reason, it's recommended that you use the raw github link rather than a random image hosting site.  To get this link on github just navigate to the file, right click on the image, and copy the image location for your use.

  ![](./images/touch-cloud.png " ")


## **STEP 2:** Using Conditional Formatting
If your workshop supports multiple instance types, but the bulk of the content stays the same, then conditional formatting can save you a lot of work. Most commonly, if you have differences between the "Free Tier" and "LiveLabs" (Green button) versions such as provisioning a database instance in Free Tier and just checking that it's created properly for LiveLabs, then conditional formatting will allow your workshop to use a singular markdown for both. This will save you immense effort and prevent accidental oversights if you need to update your workshop in the future, since you won't have to maintain a duplicate markdown.

  1. Conditional formatting is using the "if" conditional to choose what to display in your markdown, based on an additional attribute "type" you attach to a lab element in your manifest.json file. Take a look at this example to understand the components involved in making conditional formatting work. 

  ![](./images/conditional-vsc.png " ")

  On line 71, you can see the conditional is **if type="freetier"** and the closing **/if** on line 92. That means line 71-92 is only rendered if the type is freetier, and lines 93-98 is only rendered if the type is livelabs. 

  ![](./images/freetier.png " ")
  
  On line 21 and 27, you can see that we added the attribute "type" to the lab element. In this instance, this manifest.json is for the free tier version of the workshop so when a customer launches the workshop through a free tier button on the workshop's landing page, lab 2 and lab 3 will always have the **"freetier"** type attached to it.

  ![](./images/livelabs.png " ")

  On line 12, 17, and 23, you can see the same thing except that the type is "livelabs" for this file. The actual word doesn't matter, as long as the "type" in the manifest.json and the "type" in the markdown matches, the contents of the markdown conditional will be displayed.

2. You may have noticed that the numbering of the substeps within a step that uses conditional formatting may get out of line. Don't worry, as long as you use a number greater than 0, markdown will automatically number them sequentially when it gets rendered on a webpage. Also note that conditional formatting can be using in-line if needed, you don't **HAVE TO** envelope content in a neat code block... though it's recommended to keep things organized and easy to read. 

  ![](./images/conditional-note.png " ")

## **STEP 3:** Linking within a Workshop (Hotlinks)
Sometime you may want to link to something within your lab or workshop.  Most commonly, this is used in pages to link from the introduction or objectives to a specific section in the lab. This section in particular is hot linked from the introduction to drive home that point. We'll take a look at the "Need Help?" lab to demonstrate how to incorporate this in your workshop.

1. First, take a look at the format of the hotlink. It's the same as when you construct a regular hyperlink, except that you preface the URL section with a **#** and then you use a seemingly condensed version of the section name you want to link to.

  ![](./images/hotlink-vsc.png " ")

2. The condensed version of the section name is derived from the title of section, without any spaces and most punctuations. This is actually the **name** attribute of the section (**division** in this case, and in most cases). To view this and ensure your hotlink is correct... right click on the element you want to link to and select **Inspect Element** and find the **"Name"** attribute.

  ![](./images/hotlink-element.png " ")


## **STEP 4:** Adding Videos
Adding videos is very similar to adding images. We most commonly see videos added in the introductions for labs to familiarize the audience with the product before they dive into the workshop. 

1. Take a look at this example of a video linked in the introduction of a workshop. 

  ![](./images/youtube-vsc.png " ")

  Markdown does the work of embedding the video for you, all you need to provide it is video hosting site (YouTube highly recommended) and the video link address.

2. The video link address are the characters you'll find at the end of the url for the video you want to link.

  ![](./images/youtube-url.png " ")

## **STEP 5:** Scaling an Image


## **STEP 6:** Using the LintChecker


You may now [proceed to the next lab](#next).

## Want to Learn More?


## Acknowledgements

* **Author** - Didi Han, Database Product Management
* **Contributors** -  Kay Malcolm & Tom McGinn, Database Product Management 
* **Last Updated By/Date** - Didi Han, May 2021


