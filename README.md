Welcome to your Appcelerator Titanium Mobile Project
===========

This is a master detail view application, utilizing a native table view component and platform-specific UI and navigation. A starting point for a navigation-based application with hierarchical data, or a stack of windows. Requires Titanium Mobile SDK 1.8.0+.


### Before building the app in Titanium run:

* gem install ti

* ti compile all

----------------------------------
Watch CoffeeScript Files and compile them
----------------------------------

### Run from app directory: 

* cd app

### Then to watch for cuescore source file changes run:

* coffee -c -o ../Resources/js/cuescore --watch cuescore

### In another terminal window run to watch for spec file changes:

* coffee -c -o ../spec/javascripts/libs --watch spec

----------------------------------
Use Maven to run Jasmine tests and code coverage
----------------------------------

### from root project dir:

* mvn archetype:generate -DarchetypeRepository=http://searls-maven-repository.googlecode.com/svn/trunk/snapshots -DarchetypeGroupId=com.github.searls -DarchetypeArtifactId=jasmine-archetype -DarchetypeVersion=1.2.0.0-SNAPSHOT -DgroupId=com.acme -DartifactId=my-jasmine-project -Dversion=0.0.1-SNAPSHOT
mvn jasmine:bdd

> #### go to: http://localhost:8234 to see test results

### To generate code coverage run:

* mvn verify

> ####To make changes edit the pom.xml file in the root project dir.

### If you don't want to use maven then just run these commands from project root dir:

* gem install jasmine

* rake jasmine

> #### Go to: http://localhost:8888 to see test results