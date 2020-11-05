# EasyMQTT App

Flutter App for remote control of an EasyMQTT system. The app makes requests to the flask web server running the REST API for monitoring and control of the system 

## Acknowledgements
* [Cupertino Icons](https://pub.dev/packages/cupertino_icons)
* [Splash Screen](https://pub.dev/packages/splashscreen)
* [Responsive Grid](https://pub.dev/packages/responsive_grid)
* [Mongo Dart](https://pub.dev/packages/mongo_dart)
* [Flutter Toast](https://pub.dev/packages/fluttertoast)
* [Toggle Switch](https://pub.dev/packages/toggle_switch)

# Demonstrator Setup Readme

## Pre Requisites
Follow the API readme instructions and connect your broker and setup 2 devices. If you intend to run the demonstrator remotely remember to follow all the steps in the [easyMQTT repo](https://github.com/JetNoLi/easymqtt) and ensure your brokers are connected to the same database.

## Configure Your ESP
The simplest way to do this is through the testDevicePub.py. You can send any messages to your ESP's locally using MQTT topics and messages. Ensure to follow the correct packet structure as indicated in the readme. testDevicePub.py can be found in the tests folder on the easymqtt github. Just remember to change line 3 to your broker IP and port number. 

Currently listenCB will print button pressed to the screen, you can alter this to trigger any interrupt. You can find listenCB in the main and edit it to publish an MQTT message to your required device, remembering to follow the psuedo packet structure as listed in the deviceReadMe.  

## Once you have built your circuit as indicated
Run testDevicePub.py and enter the following for topic:  
deviceName_listen  
enter the following for message:  
13_1_listenCB

Now when you open the door the listenCB will trigger publish the switch message to the device to which the buzzer is attached and the alarm will go off.
