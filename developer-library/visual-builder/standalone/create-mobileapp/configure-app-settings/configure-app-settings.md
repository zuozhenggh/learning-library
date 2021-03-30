# Configure Application Settings

## Introduction

This tutorial shows how to configure a mobile application's settings and enable the app to run as a Progressive Web Application (PWA).

### Estimated Lab Time:  10 minutes

### Background

Now that you've created your mobile application, you'll want to review the app's settings and make sure the values are what you want your user to see. You also have the option of enabling the mobile application to be installed as a Progressive Web Application (PWA).

PWA support is powerful functionality for mobile apps. When you enable your mobile app as a PWA, it can be installed directly from the browser on an Android or iOS device. Much like a native mobile app, it won't have an address bar and will run pretty much like one. Also, as browser support becomes available, you can make  progressive enhancements to build the app's user experience. Most importantly for you as a developer, you won't have to publish your app to an app store.

## **STEP 2**: Configure Application Settings

These steps assume that you are already logged in to Oracle Visual Builder and are viewing the HR Application you created.

1.  In the Navigator, click the **Mobile Applications ![](images/vbcsia_mob_mob_icon.png)**  tab.
2.  Click the **hrmobileapp** node and click the **Settings** tab.
3.  In the General tab, review the Application Settings. Revise values that are displayed to the users (as suggested in the following examples):

    -   **App Name**: Accept the default value or specify an alternative value for the app name. This value specifies the name that is displayed when the app is installed on a mobile device.
    -   **URL Scheme:** Accept the default value. This value specifies the URL scheme for the app.
    -   **Package name / Bundle ID Default:** Accept the default value. This value specifies the package name for the app. To avoid naming conflicts, Android uses reverse package names, such as `com.company.application`. For more information, refer to the Android Developers website.
    -   **Lock Portrait Mode:** Accept the default value to render the application in Portrait mode on the mobile device. Deselecting the check box renders the mobile application in both Landscape and Portrait mode.

    ![](images/vbcsia_mob_gen_s3.png)

## **STEP 2**: Define a Build Configuration

A build configuration includes deployment configuration and specifies if the build is to be deployed for development or production. Ideally, you'll want to create separate builds: one for development  and another for production with different information for the two environments. For the purposes of this tutorial, however, we'll only use one build configuration for both.

1.  Click the **Build Configurations** tab and select **Android** in the + Configuration drop-down list.

    ![](images/vbcsia_mob_bp_s1.png)

2.  In the Android Build Configuration dialog box, enter:

    -   **Configuration Name:** Enter the configuration name, for example, `MyAndroidBuildConfiguration`.  

    -   **Build Type:** Set the build type to **Debug**. Options are **Debug** or **Release**.

    -   **Assigned in the following application profiles**: Accept the default application profile (**Base configuration**) that Visual Builder provides. You could also create your own application profile.
    -   **App ID:** Enter a unique ID for the application, for example, you could enter `default.android.hrmobileapp`. Each application deployed to an Android device has a unique ID, one that cannot start with a numeric value or contain spaces.  

    -   **Version Name:** Accept the default value for the application's release version number. This is the release version of the application code that is displayed to the user. For example, enter `2.0.0` if this is the second version of your application. The value you enter appears in application information dialogs when you deploy the application to a device.
    -   **Version Code:** Accept the default value for the version code. This is an integer value that represents the version of the application code, which is checked programmatically by other applications for upgrades or downgrades. The minimum and default value is 1. You can select any value and increment it by 1 for each successive release. 
    -   **Keystore:** Drag and drop (or browse to and select) the keystore file containing the private key used for signing the application for distribution. Use the provided sample keystore file, `vbcsdoc.keystore`.
    -   **Keystore Password:** Enter the password for the keystore. This password allows access to the physical file. If using the sample keystore file, enter `vbcsdoc_ks_pass`.
    -   **Key Alias:** Enter an alias for the key. This is the value set for the keytool's _-alias_ argument. Only the first eight characters of the alias are used. If using the sample keystore file, enter `vbcsdoc_ksalias`.
    -   **Key Password:** Enter the password for the key. This password allows access to the key (identified by the alias) within the keystore. If using the sample keystore file, enter `vbcsdoc_ks_pass`.

    ![](images/vbcsia_mob_bp_s2.png)

3.  Click **Save Configuration**. The new build configuration is displayed on the Build Configurations page.

    ![](images/vbcsia_mob_bp_result.png)

## Acknowledgements
**Author** - Sheryl Manoharan

**Last Updated** - February 2021
