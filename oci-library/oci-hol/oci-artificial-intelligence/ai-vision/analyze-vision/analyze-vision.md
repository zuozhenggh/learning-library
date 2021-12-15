# Lab 1: Use Vision Service through the OCI Console

## Introduction
In this session, we will walk through the OCI Console to familiarize ourselves with the Vision Service. We'll discuss the data requirements and formats, and provide some sample datasets as examples. We will also show you how to upload to Oracle object storage for later to train a custom model.


### Objectives

In this lab, you will:
- Understand the data requirements and data formats for analyzing images.
- Be able to download prepared sample datasets and upload the downloaded dataset into OCI (Oracle Cloud Infrastructure) object storage.
- Get familiar with the OCI console and be able to demo key vision features with it.

### Prerequisites:
- A Free tier or paid tenancy account in OCI (Oracle Cloud Infrastructure)
- Familiar with OCI object storage to upload data.

## **Policy Setup**

Before you start using OCI Vision, your tenancy administrator should set up the following policies by following below steps:

### 1. Navigate to Policies
Log into OCI Cloud Console. Using the Burger Menu on the top left corner, navigate to Identity & Security and click it, and then select Policies item under Identity.
  ![](./images/policy1.png " ")


### 2. Create Policy
Click Create Policy
  ![](./images/policy2.png " ")


### 3. Create a new policy with the following statements:

If you want to allow all the users in your tenancy to use vision service, create a new policy with the below statement:
  ```
  <copy>allow any-user to use ai-service-vision-family in tenancy</copy>
  ```
  ![](./images/policy3.png " ")


If you want to limit access to a user group, create a new policy with the below statement:
  ```
  <copy>allow group <group-name> to use ai-service-vision-family in tenancy</copy>
  ```
  ![](./images/policy4.png " ")

## **TASK 1:** Understand Data Requirements

The vision service works with multiple formats of image data in order to detect objects, assign labels to images, extract text, and more. The service accepts data through Object Storage and locally stored images (if using via OCI console).

The service offers sync and async APIs to analyze images, with data requirements for each detailed below:
<table>
  <tbody>
    <tr>
      <th>API</th>
      <th>Description</th>
      <th>Supported Input Format</th>
    </tr>
    <tr>
      <td>sync API (analyzeImage, analyzeDocument)</td>
      <td>Analyzes individual images</td>
      <td>
      <ul>
        <li>JPG, PNG, (PDF and Tiff for analyzeDocument)</li>
        <li>Up to 8 MB</li>
        <li>Single image input</li>
      </ul>
      </td>
    </tr>
    <tr>
      <td>async API<br>/jobs/startImageAnalysisjob<br>/jobs/start</td>
      <td>Analyze multiple images or multi-page PDFs</td>
      <td>
      <ul>
        <li>JPG, PNG (PDF and Tiff for analyzeDocument)</li>
        <li>Up to 2000 images input</li>
        <li>Supports multi-page PDF </li>
      </ul>
      </td>
    </tr>
  </tbody>
</table>

## **TASK 2:** Upload Data to Object Storage

This is an optional set of steps if you want to test OCI Vision with your own sample images.

**Task 2a:** Create an Object Storage Bucket (This step is optional in case the bucket is already created)

First, From the OCI Services menu, click Object Storage.
![](./images/cloudstoragebucket.png " ")

Then, Select Compartment from the left dropdown menu. Choose the compartment matching your name or company name.
![](./images/createCompartment.png " ")

Next click Create Bucket.
![](./images/createbucketbutton.png " ")

Next, fill out the dialog box:
* Bucket Name: Provide a name <br/>
* Storage Tier: STANDARD

Then click Create
![](./images/pressbucketbutton.png " ")

**Task 2b:** Upload image files into Storage Bucket

Switch to OCI window and click the Bucket Name.

Bucket detail window should be visible. Click Upload
![](./images/bucketdetail.png " ")

Click on Upload and then browse to file which you desire to upload.
![](./images/upload-sample-file.png " ")


More details on Object storage can be found on this page. [Object Storage Upload Page](https://oracle.github.io/learning-library/oci-library/oci-hol/object-storage/workshops/freetier/index.html?lab=object-storage) to see how to upload.

## **TASK 3:** Demo Vision Service using the OCI Console

**Task 3a:** Navigate to the Vision Page of OCI Console 

![](./images/navigate-to-ai-vision-menu.png " ")

**Task 3b:** Use Document AI features

On the Vision page, select “Document AI” on the left navigation menu and provide a document or image from local storage or OCI object storage. This invokes analyzeDocument API after the image is provided. Raw text extracted by our pre-trained multi-tenant model is displayed on the right. 

![](./images/document_ai_features.png " ")

Features you can test out: 
<table>
  <tbody>
    <tr>
      <th>Feature</th>
      <th>Description</th>
      <th>Details on Console</th>
    </tr>
    <tr>
      <td>OCR (Optical Character Recognition)</td>
      <td>Locates and digitizes text information from images</td>
      <td>
        Text will appear under the "raw text" header of the results pane of the console
        <a href="./images/ocr.png">[Reference]</a>
      </td>
    </tr>
    <tr>
      <td>Document Image Classification</td>
      <td>Classifies documents into different types based on their visual appearance, high-level features, and extracted keywords</td>
      <td>
      Classification along with confidence score appears directly under "Results" pane
      <a href="./images/dic.png">[Reference]</a>
      </td>
    </tr>
    <tr>
      <td>Language Classification</td>
      <td>Classifies the language of document based on visual features</td>
      <td>
      Classification along with confidence score appears under document classification in Results pane
      <a href="./images/language-classification.png">[Reference]</a>
      </td>
    </tr>
    <tr>
      <td>Table extraction</td>
      <td>Extracts content in tabular format, maintaining row/column relationships of cells </td>
      <td>
      Toggle to the Table tab to get table information
      <a href="./images/table-extraction.png">[Reference]</a>
      </td>
    </tr>
    <tr>
      <td>Searchable PDF output</td>
      <td>Embeds a transparent layer on top of document image in PDF format to make it searchable by keywords</td>
      <td>
      You need to test on a PDF document to use this feature. When you've selected a PDF, the searchable PDF button will be clickable. Clicking on it will download an OCR PDF to your computer.
      <a href="./images/searchable-pdf-output.png">[Reference]</a>
      </td>
    </tr>
  </tbody>
</table>

**Task 3c:** Use Image Analysis Features 

On the Vision page, select “Image Classification” or "Object Detection" on the left navigation menu and provide an image from local storage or OCI object storage. This invokes analyzeImage API after the image is provided. 

![](./images/image-features.png " ")

Features you can test out: 

<table>
  <tbody>
    <tr>
      <th>Feature</th>
      <th>Description</th>
      <th>Details on Console</th>
    </tr>
    <tr>
      <td>Image classification</td>
      <td>Categorizes object(s) within an image</td>
      <td>
        Select "Image Classification." Labels and confidence scores will appear under the Results pane.
        <a href="./images/image-classification.png">[Reference]</a>
      </td>
    </tr>
    <tr>
      <td>Object detection</td>
      <td>Locates and identifies objects within an image</td>
      <td>
      Select "Object Detection." Objects, confidence score, and highlighted bounding box will all appear under the Results pane. Clicking on one of the labels on the results pane will also highlight where on the image that object was detected.
      <a href="./images/object-detection.png">[Reference]</a>
      </td>
    </tr>
  </tbody>
</table>

Congratulations on completing this lab!

[Proceed to the next section](#next).

### Acknowledgements:
* **Authors**
    * Kate D'Orazio - Oracle OCI Vision Services
    * Vaishnavi Kotturu - Oracle OCI Vision Services

* **Last Updated By/Date**
    * Vaishnavi Kotturu - Oracle OCI Vision Services, November 2021