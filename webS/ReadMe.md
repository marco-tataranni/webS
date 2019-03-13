# web-jsp-example

JSP Sample Application to access MSSQL Databases

# Developer Workspace
[![Contribute](http://beta.codenvy.com/factory/resources/codenvy-contribute.svg)](http://beta.codenvy.com/f?id=r8et9w6vohmqvro8)

# Stack to use

FROM [codenvy/java]

# How to run

| #       | Description           | Command  |
| :------------- |:-------------| :-----|
| 1      | Da inserire in un command (copia il codice nella cartella ROOT di Tomcat e manda in esecuzione il server web) | `cp -r /projects/webDB/* $TOMCAT_HOME/webapps/ROOT && $TOMCAT_HOME/bin/catalina.sh run 2>&1` |
| 2      | per l'uso su codenvy.io, aggiungere nella "Preview URL" | `${server.8080}` |