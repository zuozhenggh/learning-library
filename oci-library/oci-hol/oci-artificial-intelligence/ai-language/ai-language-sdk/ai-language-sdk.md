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

ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file())

 
#Detect Entities
detect_language_entities_details = oci.ai_language.models.DetectLanguageEntitiesDetails(text=text)
output = ai_client.detect_language_entities(detect_language_entities_details)
print(output.data)
 
#Detect Language
detect_dominant_language_details = oci.ai_language.models.DetectDominantLanguageDetails(text=text)
output = ai_client.detect_dominant_language(detect_dominant_language_details)
print(output.data)
 
#Detect KeyPhrases
detect_language_key_phrases_details = oci.ai_language.models.DetectLanguageKeyPhrasesDetails(text=text)
output = ai_client.detect_language_key_phrases(detect_language_key_phrases_details)
print(output.data)
 
#Detect Sentiment
detect_language_sentiments_details = oci.ai_language.models.DetectLanguageSentimentsDetails(text=text)
output = ai_client.detect_language_sentiments(detect_language_sentiments_details)
print(output.data)
 
#Detect Text Classification
detect_language_text_classification_details = oci.ai_language.models.DetectLanguageTextClassificationDetails(text=text)
output = ai_client.detect_language_text_classification(detect_language_text_classification_details)
print(output.data)

```
To Know More Visit [Python OCI-Language](https://docs.oracle.com/en-us/iaas/tools/python/2.43.1/api/ai_language/client/oci.ai_language.AIServiceLanguageClient.html)

#### Java Code Sample
Below is an example of how to use detectDominantLanguage API.
```
package com.oracle.pic.ocas.ailanguage;
 
import com.oracle.bmc.ailanguage.model.DetectedLanguage;
import com.oracle.bmc.auth.ConfigFileAuthenticationDetailsProvider;
import com.oracle.bmc.ailanguage.AIServiceLanguageClient;
import com.oracle.bmc.ailanguage.model.DetectDominantLanguageDetails;
import com.oracle.bmc.ailanguage.model.DetectDominantLanguageResult;
import com.oracle.bmc.ailanguage.requests.DetectDominantLanguageRequest;
import com.oracle.bmc.ailanguage.responses.DetectDominantLanguageResponse;
 
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
        DetectDominantLanguageResult dominantLanguageResult = aiServiceLanguageExample.getDominantLanguage(text);
 
        aiServiceLanguageExample.printLanguageType(dominantLanguageResult);
        client.close();
    }
 
    private DetectDominantLanguageResult getDominantLanguage(String text) {
        DetectDominantLanguageDetails languageDetails = DetectDominantLanguageDetails.builder().text(text).build();
        DetectDominantLanguageRequest request = DetectDominantLanguageRequest.builder().detectDominantLanguageDetails(languageDetails).build();
        DetectDominantLanguageResponse response = client.detectDominantLanguage(request);
        return response.getDetectDominantLanguageResult();
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
}
```
To Know More Visit [Java OCI-Language](https://docs.oracle.com/en-us/iaas/tools/java/2.3.1/)

#### Go
Below is an example of how to use detectLanguageKeyPhrases API.
```
// This is an automatically generated code sample.
// To make this code sample work in your Oracle Cloud tenancy,
// please replace the values for any parameters whose current values do not fit
// your use case (such as resource IDs, strings containing ‘EXAMPLE’ or ‘unique_id’, and
// boolean, number, and enum parameters with values not fitting your use case).

package main

import (
	"context"
	"fmt"

	"github.com/oracle/oci-go-sdk/v45/ailanguage"
	"github.com/oracle/oci-go-sdk/v45/common"
	"github.com/oracle/oci-go-sdk/v45/example/helpers"
)

func ExampleDetectLanguageKeyPhrases() {
	// Create a default authentication provider that uses the DEFAULT
	// profile in the configuration file.
	// Refer to <see href="https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File>the public documentation</see> on how to prepare a configuration file.
	client, err := ailanguage.NewAIServiceLanguageClientWithConfigurationProvider(common.DefaultConfigProvider())
	helpers.FatalIfError(err)

	// Create a request and dependent object(s).

	req := ailanguage.DetectLanguageKeyPhrasesRequest{DetectLanguageKeyPhrasesDetails: ailanguage.DetectLanguageKeyPhrasesDetails{Text: common.String("EXAMPLE-text-Value")},
		OpcRequestId: common.String("LWFJLBWE22RUPXOANJRC<unique_ID>")}

	// Send the request using the service client
	resp, err := client.DetectLanguageKeyPhrases(context.Background(), req)
	helpers.FatalIfError(err)

	// Retrieve value from the response.
	fmt.Println(resp)
}

```
To Know More Visit [Go OCI-Language](https://docs.oracle.com/en-us/iaas/tools/go/45.1.0/ailanguage/index.html)

#### Ruby
Below is an example of how to use detectLanguageTextClassification API.

```
# This is an automatically generated code sample.
# To make this code sample work in your Oracle Cloud tenancy,
# please replace the values for any parameters whose current values do not fit
# your use case (such as resource IDs, strings containing ‘EXAMPLE’ or ‘unique_id’, and
# boolean, number, and enum parameters with values not fitting your use case).

require 'oci'

# Create a default config using DEFAULT profile in default location
# Refer to https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File for more info
config = OCI::ConfigFileLoader.load_config

# Initialize service client with default config file
ai_language_client =
  OCI::AiLanguage::AIServiceLanguageClient.new(config: config)

# Send the request to service, some parameters are not required, see API doc for more info
detect_language_text_classification_response =
  ai_language_client.detect_language_text_classification(
    OCI::AiLanguage::Models::DetectLanguageTextClassificationDetails.new(
      text: 'EXAMPLE-text-Value'
    )
  )

# Get the data from response
puts "#{detect_language_text_classification_response.data}"
```
To Know More Visit [Ruby OCI-Language](https://docs.oracle.com/en-us/iaas/tools/ruby/2.14.0/OCI/AiLanguage.html)
#### Java Script
Below is an example of how to use detectLanguageSentiment API.
```
// This is an automatically generated code sample.
// To make this code sample work in your Oracle Cloud tenancy,
// please replace the values for any parameters whose current values do not fit
// your use case (such as resource IDs, strings containing ‘EXAMPLE’ or ‘unique_id’, and
// boolean, number, and enum parameters with values not fitting your use case).

import * as ailanguage from "oci-ailanguage";
import common = require("oci-common");

// Create a default authentication provider that uses the DEFAULT
// profile in the configuration file.
// Refer to <see href="https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File>the public documentation</see> on how to prepare a configuration file.

const provider: common.ConfigFileAuthenticationDetailsProvider = new common.ConfigFileAuthenticationDetailsProvider();

(async () => {
  try {
    // Create a service client
    const client = new ailanguage.AIServiceLanguageClient({
      authenticationDetailsProvider: provider
    });

    // Create a request and dependent object(s).
    const detectLanguageSentimentsDetails = {
      text: "EXAMPLE-text-Value"
    };

    const detectLanguageSentimentsRequest: ailanguage.requests.DetectLanguageSentimentsRequest = {
      detectLanguageSentimentsDetails: detectLanguageSentimentsDetails,
      opcRequestId: "88YBJIFGR20TWOSVKQSI<unique_ID>"
    };

    // Send request to the Client.
    const detectLanguageSentimentsResponse = await client.detectLanguageSentiments(
      detectLanguageSentimentsRequest
    );
  } catch (error) {
    console.log("detectLanguageSentiments Failed with error  " + error);
  }
})();
```
To Know More Visit [Java Script OCI-Language](https://docs.oracle.com/en-us/iaas/tools/typescript/2.0.1/modules/_ailanguage_index_.html)

#### DOT NET
Below is an example of how to use detectLanguageEntities API.
```
// This is an automatically generated code sample. 
// To make this code sample work in your Oracle Cloud tenancy, 
// please replace the values for any parameters whose current values do not fit
// your use case (such as resource IDs, strings containing ‘EXAMPLE’ or ‘unique_id’, and 
// boolean, number, and enum parameters with values not fitting your use case).

using System;
using System.Threading.Tasks;
using Oci.AilanguageService;
using Oci.Common;
using Oci.Common.Auth;

namespace Oci.Sdk.DotNet.Example.Ailanguage
{
    public class DetectLanguageEntitiesExample
    {
        public static async Task Main()
        {
            // Create a request and dependent object(s).
			var detectLanguageEntitiesDetails = new Oci.AilanguageService.Models.DetectLanguageEntitiesDetails
			{
				Text = "EXAMPLE-text-Value"
			};
			var detectLanguageEntitiesRequest = new Oci.AilanguageService.Requests.DetectLanguageEntitiesRequest
			{
				DetectLanguageEntitiesDetails = detectLanguageEntitiesDetails,
				OpcRequestId = "QT93ZSFEMJAN75ZIQSEX<unique_ID>",
				ModelVersion = Oci.AilanguageService.Models.NerModelVersion.V11,
				IsPii = true
			};

            // Create a default authentication provider that uses the DEFAULT
            // profile in the configuration file.
            // Refer to <see href="https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File>the public documentation</see> on how to prepare a configuration file. 
            var provider = new ConfigFileAuthenticationDetailsProvider("DEFAULT");
            try
            {
                // Create a service client and send the request.
				using (var client = new AIServiceLanguageClient(provider, new ClientConfiguration()))
				{
					var response = await client.DetectLanguageEntities(detectLanguageEntitiesRequest);
					// Retrieve value from the response.
					var entitiesValue = response.DetectLanguageEntitiesResult.Entities;
				}
            }
            catch (Exception e)
            {
                Console.WriteLine($"DetectLanguageEntities Failed with {e.Message}");
                throw e;
            }
        }

    }
}
```
To Know More Visit [DOT NET OCI-Langauge](https://docs.oracle.com/en-us/iaas/tools/dotnet/23.1.0/api/Oci.AilanguageService.html)

Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Rajat Chawla  - Oracle AI Services
    * Ankit Tyagi -  Oracle AI Services
* **Last Updated By/Date**
    * Rajat Chawla  - Oracle AI Services, July 2021
