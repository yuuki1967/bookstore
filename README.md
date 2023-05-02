# Azure Bookstore

This is a simple Maven project that builds a WAR that contains a simple bookstore application. The application is able 
to be built into a container and then available to be deployed as an Azure Web App.

The Workflow files in this repository provide the following features:

* Pull Requests code is built and tested using Maven and a Docker container published
* Code QL scanning performed on each push
* Ability to deploy a `review` environment to Azure using labels:
    - `Deploy to test`
    - `Deploy to qa`
    - `Deploy to staging`
* Azure review environments are destoryed once PR is closed
* Any commit to master will result in the `prod` Azure web application deployed to the latest code

For a step-by-step guide see: [Bookstore Demo](https://github.com/github/solutions-engineering/blob/master/guides/demo/end-to-end-demos/bookstore-demo.md)

## Running the Web Application locally

You can run the web application locally using Maven for development purposes, which can be done either directly if you 
have Maven and a JDK installed, or inside a container that has Maven and JDK installed.


### Running locally:
The following command will build the WAR package and then run up a Jetty process to serve the WAR file on http://localhost:8080

```bash
$ mvn package jetty:run
```


### Running in a Docker container:

The following assumes you have a docker volume of `maven-repo` that you are using to cache the Maven repository plugins 
and dependencies, but this is optional.

The container also binds to port 8080 so that you can use http://localhost:8080 to open the application.

If you want to build the project and then run it:
```bash
$ docker run -it -v maven-repo:/root/.m2 -v `pwd`:/maven -w /maven -p 8080:8080 maven:3.6.3-openjdk-15 mvn -P\!build-container package jetty:run
```

If you just want to run it as you have already compiled the code:
```bash
$ docker run -it -v maven-repo:/root/.m2 -v `pwd`:/maven -w /maven -p 8080:8080 maven:3.6.3-openjdk-15 mvn jetty:run
```

### Yuki's memo
$ docker run -it -v maven-repo:/root/.m2 -v `pwd`:/maven -w /maven -p 8080:8080 maven:3.6.3-openjdk-15 mvn -P\!build-container package jetty:run

```
[INFO] Scanning elapsed time=237ms
[INFO] DefaultSessionIdManager workerName=node0
[INFO] No SessionScavenger set, using defaults
[INFO] node0 Scavenging every 660000ms
[INFO] Started o.e.j.m.p.JettyWebAppContext@8f09a02{/,file:///maven/src/main/webapp/,AVAILABLE}{file:///maven/src/main/webapp/}
[INFO] Started ServerConnector@b5d7233{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
[INFO] Started @27500ms
[INFO] Started Jetty Server
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
^C[INFO] Stopped ServerConnector@b5d7233{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
[INFO] node0 Stopped scavenging
[INFO] Stopped o.e.j.m.p.JettyWebAppContext@8f09a02{/,file:///maven/src/main/webapp/,UNAVAILABLE}{file:///maven/src/main/webapp/}
[INFO] Jetty server exiting.
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  24:50 min
[INFO] Finished at: 2023-05-02T03:24:03Z
[INFO] ------------------------------------------------------------------------
```
