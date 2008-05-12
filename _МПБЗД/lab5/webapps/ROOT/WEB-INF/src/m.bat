set JAVA_HOME=d:\Programs\Java\jdk1.6.0_03
set path=%path%;d:\Programs\Java\jdk1.6.0_03\bin
set CATALINA_HOME=../../../../

del *.class

javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint DepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint AddDepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint DelDepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint PreUpdDepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint UpdDepServlet.java

javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint SkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint AddSkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint DelSkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint PreUpdSkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint UpdSkiServlet.java

javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint ProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint AddProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint DelProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint PreUpdProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar;../lib/axis.jar;../lib/saaj.jar;../lib/jaxrpc.jar -Xlint UpdProServlet.java

copy DepServlet.class ..\classes
copy AddDepServlet.class ..\classes
copy DelDepServlet.class ..\classes
copy PreUpdDepServlet.class ..\classes
copy UpdDepServlet.class ..\classes

copy SkiServlet.class ..\classes
copy AddSkiServlet.class ..\classes
copy DelSkiServlet.class ..\classes
copy PreUpdSkiServlet.class ..\classes
copy UpdSkiServlet.class ..\classes

copy ProServlet.class ..\classes
copy AddProServlet.class ..\classes
copy DelProServlet.class ..\classes
copy PreUpdProServlet.class ..\classes
copy UpdProServlet.class ..\classes
