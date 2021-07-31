# Lab 2: Access AI Language Service with REST API

## Introduction

Our language services also support to use SDK.

In this lab session, we will show several code snippets to access our service with SDK.

You do not need to execute those codes, but review them to understand what information and steps are needed to implement your own integration.

*Estimated Lab Time*: 10 minutes

### Objectives:

* Learn how to use REST API to communicate with our language service endpoints.

### Prerequisites:
* Familiar with Python programming is required
* Have a Python environment ready in local
* Familiar with local editing tools, vi and nano
* Installed with Python libraries: `oci` and `requests`

## SDK Setup

Oracle Cloud Infrastructure provides a number of Software Development Kits (SDKs) to facilitate development of custom solutions.Software Development Kits (SDKs) Build and deploy apps that integrate with Oracle Cloud Infrastructure services.



### **TASK 1:** SDK Guides

Each SDK provides the tools you need to develop an app, including code samples and documentation to create, test, and troubleshoot. In addition, if you want to contribute to the development of the SDKs, they are all open source and available on GitHub.

#### 1. [SDK for Java](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdk.htm#SDK_for_Java)
#### 2. [SDK for Python](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/pythonsdk.htm#SDK_for_Python)
#### 3. [SDK for TypeScript and JavaScript](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/typescriptsdk.htm#SDK_for_TypeScript_and_JavaScript)
#### 4. [SDK for .NET](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/dotnetsdk.htm#SDK_for_NET)
#### 5. [SDK for Go](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/gosdk.htm#SDK_for_Go)
#### 6. [SDK for Ruby](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/rubysdk.htm#SDK_for_Ruby)



### **TASK 2:** AI Language Service SDK Code Sample

The following are a few examples of accessing those API endpoints.

#### Python Code Sample
Below is the Python sample code to access API endpoints.
```Python
import oci
 
text = "Zoom interface is really simple and easy to use. The learning curve is very short thanks to the interface. It is very easy to share the Zoom link to join the video conference. Screen sharing quality is just ok. Zoom now claims to have 300 million meeting participants per day. It chose Oracle Corporation co-founded by Larry Ellison and headquartered in Redwood Shores , for its cloud infrastructure deployments over the likes of Amazon, Microsoft, Google, and even IBM to build an enterprise grade experience for its product. The security feature is significantly lacking as it allows people to zoom bomb"
 
#Create Language service client with user config default values. Please follow below link to setup ~/.oci directory and user config
#https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm
#https://oracle-cloud-infrastructure-python-sdk.readthedocs.io/en/latest/configuration.html

ai_client = oci.ocas.AIServiceLanguageClient(oci.config.from_file())

 
#Detect Entities
detect_language_entities_details = oci.ocas.models.DetectLanguageEntitiesDetails(text=text)
output = ai_client.detect_language_entities(detect_language_entities_details)
print(output.data)
 
#Detect Language
detect_dominant_language_details = oci.ocas.models.DetectDominantLanguageDetails(text=text)
output = ai_client.detect_dominant_language(detect_dominant_language_details)
print(output.data)
 
#Detect KeyPhrases
detect_language_key_phrases_details = oci.ocas.models.DetectLanguageKeyPhrasesDetails(text=text)
output = ai_client.detect_language_key_phrases(detect_language_key_phrases_details)
print(output.data)
 
#Detect Sentiment
detect_language_sentiments_details = oci.ocas.models.DetectLanguageSentimentsDetails(text=text)
output = ai_client.detect_language_sentiments(detect_language_sentiments_details)
print(output.data)
 
#Detect Text Classification
detect_language_text_classification_details = oci.ocas.models.DetectLanguageTextClassificationDetails(text=text)
output = ai_client.detect_language_text_classification(detect_language_text_classification_details)
print(output.data)

```

#### Java Code Sample
Below is the Java sample code to access API endpoints.
```
package com.oracle.pic.ocas.ailanguage;
 
import com.oracle.bmc.ailanguage.model.DetectedLanguage;
import com.oracle.bmc.ailanguage.model.KeyPhrase;
import com.oracle.bmc.ailanguage.model.TextClassification;
import com.oracle.bmc.ailanguage.requests.DetectLanguageTextClassificationRequest;
import com.oracle.bmc.ailanguage.responses.DetectLanguageTextClassificationResponse;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.ailanguage.AIServiceLanguageClient;
import com.oracle.bmc.ailanguage.model.DetectDominantLanguageDetails;
import com.oracle.bmc.ailanguage.model.DetectDominantLanguageResult;
import com.oracle.bmc.ailanguage.model.DetectLanguageEntitiesDetails;
import com.oracle.bmc.ailanguage.model.DetectLanguageEntitiesResult;
import com.oracle.bmc.ailanguage.model.DetectLanguageKeyPhrasesDetails;
import com.oracle.bmc.ailanguage.model.DetectLanguageKeyPhrasesResult;
import com.oracle.bmc.ailanguage.model.DetectLanguageSentimentsDetails;
import com.oracle.bmc.ailanguage.model.DetectLanguageSentimentsResult;
import com.oracle.bmc.ailanguage.model.DetectLanguageTextClassificationDetails;
import com.oracle.bmc.ailanguage.model.DetectLanguageTextClassificationResult;
import com.oracle.bmc.ailanguage.model.Entity;
import com.oracle.bmc.ailanguage.model.SentimentAspect;
import com.oracle.bmc.ailanguage.requests.DetectDominantLanguageRequest;
import com.oracle.bmc.ailanguage.requests.DetectLanguageEntitiesRequest;
import com.oracle.bmc.ailanguage.requests.DetectLanguageKeyPhrasesRequest;
import com.oracle.bmc.ailanguage.requests.DetectLanguageSentimentsRequest;
import com.oracle.bmc.ailanguage.responses.DetectDominantLanguageResponse;
import com.oracle.bmc.ailanguage.responses.DetectLanguageEntitiesResponse;
import com.oracle.bmc.ailanguage.responses.DetectLanguageKeyPhrasesResponse;
import com.oracle.bmc.ailanguage.responses.DetectLanguageSentimentsResponse;
 
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
 
public class AIServiceLanguageExample {
 
    private static AIServiceLanguageClient client;
 
    public AIServiceLanguageExample() throws IOException {
        ConfigFileAuthenticationDetailsProvider provider = new ConfigFileAuthenticationDetailsProvider("DEFAULT");
        client = new AIServiceLanguageClient(provider);
    }
    public static void main(String[] args) throws IOException {
 
        String text = "Zoom interface is really simple and easy to use. The learning curve is very short thanks to the interface. It is very easy to share the Zoom link to join the video conference. Screen sharing quality is just ok. Zoom now claims to have 300 million meeting participants per day. It chose Oracle Corporation co-founded by Larry Ellison and headquartered in Redwood Shores , for its cloud infrastructure deployments over the likes of Amazon, Microsoft, Google, and even IBM to build an enterprise grade experience for its product. The security feature is significantly lacking as it allows people to zoom bomb";
 
        AIServiceLanguageExample aiServiceLanguageExample = new AIServiceLanguageExample();
        DetectLanguageSentimentsResult sentimentsResult = aiServiceLanguageExample.getLanguageSentiments(text);
        DetectLanguageEntitiesResult entitiesResult = aiServiceLanguageExample.getLanguageEntities(text);
        DetectDominantLanguageResult dominantLanguageResult = aiServiceLanguageExample.getDominantLanguage(text);
        DetectLanguageKeyPhrasesResult keyPhrasesResult = aiServiceLanguageExample.getLanguageKeyPhrases(text);
        DetectLanguageTextClassificationResult textClassificationResult = aiServiceLanguageExample.getLanguageTextClassification(text);
 
        aiServiceLanguageExample.printSentiments(sentimentsResult);
        aiServiceLanguageExample.printEntities(entitiesResult);
        aiServiceLanguageExample.printLanguageType(dominantLanguageResult);
        aiServiceLanguageExample.printKeyPhrases(keyPhrasesResult);
        aiServiceLanguageExample.printTextClassification(textClassificationResult);
        client.close();
    }
 
    private DetectLanguageSentimentsResult getLanguageSentiments(String text) {
        DetectLanguageSentimentsDetails sentimentsDetails = DetectLanguageSentimentsDetails.builder().text(text).build();
        DetectLanguageSentimentsRequest request = DetectLanguageSentimentsRequest.builder().detectLanguageSentimentsDetails(sentimentsDetails).build();
        DetectLanguageSentimentsResponse response = client.detectLanguageSentiments(request);
        return response.getDetectLanguageSentimentsResult();
    }
 
    private DetectLanguageEntitiesResult getLanguageEntities(String text) {
        DetectLanguageEntitiesDetails entitiesDetails = DetectLanguageEntitiesDetails.builder().text(text).build();
        DetectLanguageEntitiesRequest request = DetectLanguageEntitiesRequest.builder().detectLanguageEntitiesDetails(entitiesDetails).build();
        DetectLanguageEntitiesResponse response = client.detectLanguageEntities(request);
        return response.getDetectLanguageEntitiesResult();
    }
 
    private DetectDominantLanguageResult getDominantLanguage(String text) {
        DetectDominantLanguageDetails languageDetails = DetectDominantLanguageDetails.builder().text(text).build();
        DetectDominantLanguageRequest request = DetectDominantLanguageRequest.builder().detectDominantLanguageDetails(languageDetails).build();
        DetectDominantLanguageResponse response = client.detectDominantLanguage(request);
        return response.getDetectDominantLanguageResult();
    }
 
    private DetectLanguageKeyPhrasesResult getLanguageKeyPhrases(String text) {
        DetectLanguageKeyPhrasesDetails keyPhrasesDetails = DetectLanguageKeyPhrasesDetails.builder().text(text).build();
        DetectLanguageKeyPhrasesRequest request = DetectLanguageKeyPhrasesRequest.builder().detectLanguageKeyPhrasesDetails(keyPhrasesDetails).build();
        DetectLanguageKeyPhrasesResponse response = client.detectLanguageKeyPhrases(request);
        return response.getDetectLanguageKeyPhrasesResult();
    }
 
    private DetectLanguageTextClassificationResult getLanguageTextClassification(String text) {
        DetectLanguageTextClassificationDetails textClassificationDetails = DetectLanguageTextClassificationDetails.builder().text(text).build();
        DetectLanguageTextClassificationRequest request = DetectLanguageTextClassificationRequest.builder().detectLanguageTextClassificationDetails(textClassificationDetails).build();
        DetectLanguageTextClassificationResponse response = client.detectLanguageTextClassification(request);
        return response.getDetectLanguageTextClassificationResult();
    }
 
    private void printSentiments(DetectLanguageSentimentsResult result) {
        List<SentimentAspect> aspects = result.getAspects();
        String printFormat = "%s [%s - %s]";
 
        System.out.println();
        System.out.println("========= Language Aspect Based Sentiment ========");
        aspects.forEach(aspect -> System.out.println(String.format(printFormat, aspect.getText(), aspect.getSentiment(), aspect.getScores())));
        System.out.println("========= End ========");
        System.out.println();
    }
 
    private void printEntities(DetectLanguageEntitiesResult result) {
        List<Entity> entities = result.getEntities();
        String printFormat = "%s [%s]";
        System.out.println("========= Entities ========");
        entities.forEach(entity -> System.out.println(String.format(printFormat, entity.getText(), entity.getType())));
        System.out.println("========= End ========");
        System.out.println();
    }
 
    private void printLanguageType(DetectDominantLanguageResult result) {
        String printFormat = "%s [%s]";
        System.out.println("========= Dominant Language ========");
        List<DetectedLanguage> languages = result.getLanguages();
        List<String> languagesStr = languages.stream().map(language -> language.getName()+ " ("+language.getScore()+")").collect(Collectors.toList());
        System.out.println(String.join(",", languagesStr));
        System.out.println("========= End ========");
        System.out.println();
    }
 
    private void printKeyPhrases(DetectLanguageKeyPhrasesResult result) {
        List<KeyPhrase> keyPhrases = result.getKeyPhrases();
        System.out.println("========= Language Key Phrases ========");
        List<String> keyPhrasesStr = keyPhrases.stream().map(keyPhrase -> keyPhrase.getText()+ " ("+keyPhrase.getScore()+")").collect(Collectors.toList());
        System.out.println(String.join(",", keyPhrasesStr));
        System.out.println("========= End ========");
        System.out.println();
    }
 
    private void printTextClassification(DetectLanguageTextClassificationResult result) {
        List<TextClassification> textClassifications = result.getTextClassification();
        String printFormat = "%s (%s)";
        System.out.println("========= Language Topic Labels & Related Words ========");
        System.out.println("========= Language Topic Labels ========");
        textClassifications.forEach(textClassification -> System.out.println(String.format(printFormat, textClassification.getLabel(), textClassification.getScore())));
        System.out.println("========= End ========");
    }
}
```



Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Rajat Chawla  - Oracle AI Services
    * Ankit Tyagi -  Oracle AI Services
* **Last Updated By/Date**
    * Rajat Chawla  - Oracle AI Services, July 2021
