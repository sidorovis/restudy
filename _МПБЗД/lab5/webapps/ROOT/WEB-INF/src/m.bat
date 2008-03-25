set JAVA_HOME=d:\Programs\Java\jdk1.6.0_03
set path=%path%;d:\Programs\Java\jdk1.6.0_03\bin
set CATALINA_HOME=../../../../
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar Laba4Servlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar LoginServlet.java
copy Laba4Servlet.class ..\classes\
copy LoginServlet.class ..\classes\
