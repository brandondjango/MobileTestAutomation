# Mobile Automation using Appium

# Note: this project is out of date with APPIUM 2!! fixes on the way

## Introduction

This project is pulled in as a dependency by a test project - there is no need for you to download and install it separately. However, the setup for projects that use it would be the same, so we discuss that in this README.

We will set up iOS and Android to work with Appium. Once you have completed this setup, your workflow is to download the specific mobile test project. Then you would connect your mobile device, start Appium from the command line in a shell, and then run the tests in a different shell using the Ruby ```build execute``` command.

The setup is different for iOS and Android, and will take some effort.

## Requirements

At minimum:
* Node - 10.16.0 or greater
* Node Package Manager(NPM)
* Appium - 1.13.0(supports up to iOS 12.3) or greater installed globally
* Carthage - 0.33.0 install with brew

For Android:
* Android SDK
* Android Studio

For iOS:
* MacBook Pro
* Xcode and an Apple Developer Account

For real devices:
* iOS device with USB cable
* Android device with USB cable

---

## Environment Setup

### Appium installation

There are two options to install Appium: via NPM or through Desktop.  This guide will show you how to with NPM. Visit http://appium.io/ to install the Desktop version.

1. To start NPM installation:

```npm install -g appium```

You can specify a version number by appending one to the end of "appium" with "@*INSERT_VERSION_NUMBER"

For example:

```npm install -g appium@1.13.0```

2. Something important to note is what release version you choose can impact your setup.  For instance, some of the iOS setup can be different depending on your version number.
At the time this guide is being written, it is suggested version 1.13.0 is used while iOS 12.4/13.0 versions are being sorted out.

3. That's it! Now Android and/or iOS environement and device setup needs to be done.


### Android Setup

#### Install Android Studio

1. Install Android Studio from the [Official Website](https://developer.android.com/studio).

2. Run Android Studio and install Android SDK and Tools

    * Create a new Android project - it doesn't matter what.
    * Go to the menu item ```Tools -> SDK Manager```
    * Install the following (under the ```SDK Platforms``` tab)
        * Android 9.0 (Pie)
    * Install the following (under the ```SDK Tools``` tab)
        * Android SDK Build-Tools (29.0.2)
        * Android Emulator (20.0.11)
        * Android SDK Tools (26.1.1)
        * Intel x86 Emulator Accelerator (HAXM installer)
        * Android Support Repository (47.0.0)
        * Google Repository (58)
        
3. Find the Android SDK directory. "platform-tools" and "tools" folders should be in the folder. 

4. Add those folders to your path.  They need to be in your path so Appium has access to them.(note, latest versions of mac have changed .bash_profile to .zprofile)
   ``` 
   export ANDROID_HOME=/Users/*INSERT_USER_DIRECTORY*/Library/Android/sdk/
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/platform-tools       
   ```   
5. After this your machine should be configured to run Android automation provided Appium is also installed.
   Next you will have to setup an emulated device or a real device.

#### Creating an emulated Android Virtual Device 
(to find detailed instructions, look here: https://developer.android.com/studio/run/managing-avds)
1. Open Android studio

2. Select ***Tools > AVD Manager***.

3. From here you will see a window that would contain your available Virtual Devices. To create one, click ***Create Virtual Device***.

4. Once you have created a device to your desired specifications, it should be set. The "Name" of the device is important for later, so keep note of the device you want to use for testing.
   
          
#### Configure your Android Device to permit USB debugging

The exact procedure may vary from device to device, but this is typical. You may have to google around for your particular device.

1. On the device, go to ```Settings -> About```
2. Tap the Build number seven times to make ```Settings -> Developer options``` available.
3. Enable the ```USB Debugging``` option.
4. Optional - set the device to stay awake so it never sleeps when plugged into the USB port.

#### Check your Setup by Finding Your Android Device

Plug in your Android device to the Mac's USB port (or via a dongle).

```adb devices```

If you can see your device, you are done with Android setup.

---

### iOS Setup

The iOS setup involves getting a developer account from Apple, installing Xcode, installing dependencies needed for testing and signing the test framework so that it will run on iOS devices.

#### Install Xcode

1. Get an apple developer account.
2. Install Xcode and the Xcode command line Dev tools.

#### Install carthage

```brew install carthage```

Check the version.

```carthage version```

0.33.0 is later works.

#### Sign the Appium Webdriver and Build the Test Project

1. Get the node version you are running. You'll need it for the path in the next step.

    ```node --version```

2. Find the web driver agent and open it in Xcode.
    ```
    cd ~/.nvm/versions/node/*INSERT_NODE_VERSION*/lib/node_modules/appium/node_modules/appium-webdriveragent
    
   open -a Xcode WebDriverAgent.xcodeproj
    ```
    
    ***NOTE:*** Depending on your version of Appium, this directory might be in another folder:
    
    ```~/.nvm/versions/node/*INSERT_NODE_VERSION*/lib/node_modules/appium/node_modules/appium-xcuitest-driver```
    
    As of Appium v1.16, the driver is here:
    '''/Users/lockridb/.nvm/versions/node/v11.1.0/lib/node_modules/appium/node_modules/appium-xcuitest-driver/node_modules/appium-webdriveragent'''
    
    Appium 1.18.2, installed globally:
    '''/usr/local/lib/node_modules/appium/node_modules/appium-webdriveragent'''

3.  After Xcode opens, click on "WebDriverAgent project" at the top of the left pane. In the center pain, all of the components will be selectable next to the yellow toolbox. 

    Sign each component by selecting "Automatically manage signing" and selecting your team, which is probably "OCLC".
    
    You will need to repeat this process for each component.
    
    * WebDriverAgentLib
    * WebDriverAgentLib_tvOS (error does not seem to matter, 8/2019 George)
    * WebDriverAgentRunner
    * WebDriverAgentRunner_tvOS (error does not seem to matter, 8/2019 George)
    * UnitTests
    * UnitTests_tvOS
    * IntegrationTests_1
    * IntegrationTests_2
    * IntegrationTests_3
    * IntegrationApp
    
4. Build the project.

    Select WebDriverAgent and then pull down on the ```Product``` menu and choose ```Build for... -> Testing```.
 
#### iOS Setup References

* https://github.com/appium/appium-xcuitest-driver/blob/master/docs/real-device-config.md
* https://github.com/facebook/WebDriverAgent/issues/1017

---

## Building Projects that Use This Dependency

If you are reading this because you want to run the Digby Mobile Automation tests, and you have completed the iOS and Android configuration above, then you should stop here and go to the [Digby Mobile Automation README](http://git.ent.oclc.org/projects/AUTOMATION/repos/digbymobileautomation/browse) to continue.

If you are starting a new project and need to pull in this dependency, then this information will be helpful.

### Setup for controlling browser/hybrid apps with iOS

https://github.com/facebook/WebDriverAgent/issues/1017

be sure to Sign and install the dependencies by: 

A) brew install carthage

and B) in the Webdriver folder install the scripts with: bash Scripts/bootstrap.sh -d

You can also stop the "messaging unqualified id error" by changing the way that error is treated in the build settings. Search for "treat" and you'll see that.

If you run into an error regarding a Resources/Webdriver.bundle, simply make it in the webdriver directory with mkdir -p Resources/Webdriver.bundle 



### Setup with Appium

Before we get started looking at the code, we need to install Appium. We can do this by visiting here:

http://appium.io/

Once we have Appium installed, we can start an instance of the Appium server by opening Appium and starting the server with the default settings.

Starting Appium will show the server version, location, and port:

>[Appium] Welcome to Appium v1.13.0
>[Appium] Appium REST http interface listener started on 0.0.0.0:4723 

At this point, we have made the external setup needed to start automating.


#### Starting an Appium Driver

The Appium driver is the class that drives the phone automation on a device.  It needs to connect to a server connected to the device we want to automate, as well as know what kind of phone it is automating, the name of the phone, the opertating system, etc.

To tell the driver this information, we do so by setting its capabilities. For example, in a yml file:

```
> caps:
   platformName: 'Android'
   deviceName: 'SampleName'
   automationName: 'Appium'
   app: 'https://dl.dropboxusercontent.com/s/xxxxxxxxxxxx/SampleApp.apk'
   newCommandTimeout: 1800
   clearSystemFiles: 'true'
  appium_lib:
   server_url: 'http://0.0.0.0:4723/wd/hub/'
```   
For iOS:

```
> caps:
    platformName: 'iOS'
    platformVersion: '11.2'
    deviceName: 'iPhoneX1'
    automationName: 'XCUITest'
    xcodeOrgID: 'Sample ID'
    xcodeSigningId: 'iPhone Developer'
    app: '/Users/lockridb/Downloads/SampleApp.ipa'
    newCommandTimeout: 1800
    clearSystemFiles: 'true'
    udid: '1f910e7cfghgfhfghgfhjgfhfghfbabedd182e2aea1f74'
    showXcodeLog: 'true'
    useCarthageSsl: 'true'
    updatedWDABundleId: '-N85WEFMZV.WebDriverAgentRunner'
    webkitResponseTimeout: 10000
    startIWDP: true
  appium_lib:
    server_url: 'http://0.0.0.0:4723/wd/hub/'
```   
From here, you can start your driver like so:

>capabilities = YAML.load(File.read("sample_driver.yml")) #to load yml file into hash
>@driver = Appium::Driver.new(capabilities, true)
>@driver.start_driver 


### Capability Samples:

Appium can perform a variety of tasks for you based on capabilites of the driver you start with it.

For example, it can start an emulator for you if you pass it certain values:

#### Android emulator:

```
caps:
  platformName: 'Android'
  deviceName: 'Random Name'
  avd: "Nexus_5X_API_28"
  automationName: 'Appium'
  app: 'https://dl.dropboxusercontent.com/s/xxxxxxxxxxx/SampleApp.apk'


appium_lib:
  server_url: 'http://0.0.0.0:4723/wd/hub/'
``` 

The "avd" capability corresponds to the name of an Android Virtual Device. If, when you start a driver with the above capabilities,
the emulator is not already started, Appium will start it for you!

#### iOS simulator

The same can be done for iOS. Run the following command to get an output of iOS devices available:

```xcrun simctl list```

If you pass one of these names into "deviceName" capability, even without the "udid" capability, Appium will start a simulator for you!

Example capabilities:

```
caps:
  platformName: 'iOS'
  platformVersion: '12.3'
  deviceName: 'iPhone 8'
  automationName: 'XCUITest'
  xcodeOrgID: 'Sample ID'
  xcodeSigningId: 'iPhone Developer'
  showXcodeLog: 'true'
  updatedWDABundleId: 'Sample.WebDriverAgentRunner'

appium_lib:
  server_url: 'http://0.0.0.0:4723/wd/hub/'
```

In this case, a simulator of an iPhone 8 with iOS 12.3 would appear.

### Real Devices

To connect to physical devices connected to your machine, you'll have to pass different information:

#### Android Real Device

For Android, you will need your phones name to match the "deviceName" capability:

```
caps:
  platformName: 'Android'
  deviceName: 'Sample Phone Name'
  automationName: 'uiautomator2'
  app: 'app/SampleApp.apk'
  newCommandTimeout: 1800
  clearSystemFiles: 'true'

appium_lib:
  server_url: 'http://0.0.0.0:4723/wd/hub/'

```

If my phone is connected to my machine, I should see it in the list of available devices produced by this command:

```adb devices```

When you start your driver on the real device, you should see activity in the appium logs and on the phone.

#### iOS real device

For iOS devices, the important identifier capability is udid:

```
caps:
  platformName: 'iOS'
  platformVersion: '12.3'
  deviceName: 'Sample Name'
  automationName: 'XCUITest'
  xcodeOrgID: 'Sample ID'
  xcodeSigningId: 'iPhone Developer'
  app: 'app/SampleApp.ipa'
  udid: 'fghgfhfghfghfghfghfgh6fghfghfghf87'
  showXcodeLog: 'true'
  updatedWDABundleId: 'Sample.WebDriverAgentRunner'

appium_lib:
  server_url: 'http://0.0.0.0:4723/wd/hub/'
```

If a iOS Phone with that udid is connected to your appium machine, you will see it connect, provided you have enabled automation on that iPhone.
 

## Using page-object within Mobile

This gem comes with a BasePage class that acts as a starter for controlling your phone in a page-object like manner.

It includes click with error handling, element present methods, setting fields/element values. 

You can initialize it by passing the Appium driver to the page object. for example:

```
page_object = SamplePageObject.new @driver
page_object.click_element(page_object.page_element)
```

## contexts

For an Android/Hybrid app setup, you may get an error saying you do not have a chromedriver to run the webview context you wan. To resolve this more easily, you can allow appium to install the appropriate chromedrivers by starting appium with the following parameters:

>appium --allow-insecure chromedriver_autodownload

Try these commands:

>@driver.available_contexts

>@driver.current_context

>@driver.set_context(context_name)


## Location spoofing:

First: https://github.com/JonGabilondoAngulo/idevicelocation

@driver.driver.set_location(latitude, longitude, altitude)
@driver.set_location({:latitude => 18, :longitude => 33,:altitude => 0})






