#set JAVA_HOME=c:\Program Files\Java\jdk1.6.0_02
#set path=%path%;c:\Program Files\Java\jdk1.6.0_02\bin
#set CATALINA_HOME=/home/rilley_elf/_AiPOS/Laba4/
#rm DepServlet.class
#rm AddDepServlet.class
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint DepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint AddDepServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint DelDepServlet.java

javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint SkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint AddSkiServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint DelSkiServlet.java

javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint ProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint AddProServlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar -Xlint DelProServlet.java

cp DepServlet.class ../classes/
cp AddDepServlet.class ../classes/
cp DelDepServlet.class ../classes/

cp SkiServlet.class ../classes/
cp AddSkiServlet.class ../classes/
cp DelSkiServlet.class ../classes/

cp ProServlet.class ../classes/
cp AddProServlet.class ../classes/
cp DelProServlet.class ../classes/
