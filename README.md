javaserver-cookbook
===================

This is a demo cookbook.

this cookbook will install and do a basic configuration of a tomcat server with an nginx reverse proxy front

the default recipe will
  - installs java (default version is 1.7.0_79/)
  - installs tomcat (default version is 7.0.67)
  - installs nginx (default is 1.6.2)
  - creates self-signed certificate - used for nginx ssl configuration
  - install the self-signed certificate in the java keystore
  - configures nginx to be a reverse proxy in front of tomcat - redirects http trafic to https


You need the ChefDK to run the tests plus vagrant and virtualbox (the usual setup)
To run the tests execute these commands
```bash
$ rubocop
$ foodcritic .
$ rspec
$ kitchen verify
```
* TODO: create a Thorfile for running the test and packaging the cookbook
* TODO: Need more attributes for more flexable configuration
* TODO: More tests

running the demo
----------------

You can just do...
```bash
$ vagrant up
```
when vagrant finished you can point your browser to https://192.168.33.10

NOTE: there is no real webapp, just a welcome page

