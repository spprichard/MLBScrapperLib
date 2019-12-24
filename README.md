# MLB Scrapper Library
This package is a Pure-Swift Library for interacting with the MLB LookupService. This library will be used by an application which pulls from the MLB Lookup Service (within the bounds of the terms of use found (here)[http://gdx.mlb.com/components/copyright.txt]), and aggregates it in a way that allows for a more informed Fantasy Baseball Team Owner. 

In the workspace you will find playgrounds, and an Xcode Project used to experiment, develop, and publish this library. The `CMD` directory is mean to be a "sandbox". Meaning, when developing new features, maintain existing features of this libabry the developer can mess around without having to push the code to a remote branch, and update the dependency in the Service itself. 

## TODOs:
- Hydration of data (teams, players, etc) should be done using K8's Jobs. Figure out how to make that work. JobDispatcher?
- Create WebUI, start with SwiftWebUI 


