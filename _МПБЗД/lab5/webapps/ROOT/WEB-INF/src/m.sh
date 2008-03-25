#set JAVA_HOME=c:\Program Files\Java\jdk1.6.0_02
#set path=%path%;c:\Program Files\Java\jdk1.6.0_02\bin
#set CATALINA_HOME=/home/rilley_elf/_AiPOS/Laba4/
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar Laba4Servlet.java
javac -cp ../../../../common/lib/servlet-api.jar:../lib/axis.jar:../lib/saaj.jar:../lib/jaxrpc.jar LoginServlet.java
cp Laba4Servlet.class ../classes/
cp LoginServlet.class ../classes/
