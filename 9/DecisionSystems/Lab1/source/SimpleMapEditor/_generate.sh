qmake -project
echo 'INCLUDEPATH += /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/include' >> SimpleMapEditor.pro
echo 'INCLUDEPATH += /opt/local/libexec/qt4-mac/include/QtXml/' >> SimpleMapEditor.pro
echo 'QMAKE_LFLAGS += -F/opt/local/libexec/qt4-mac/lib/' >> SimpleMapEditor.pro
echo 'LIBS += -framework QtXml' >> SimpleMapEditor.pro
echo 'QMAKE_LFLAGS += -L/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib' >> SimpleMapEditor.pro
echo 'LIBS += -lqgis_analysis -lqgis_core -lqgis_gui -lqgispython' >> SimpleMapEditor.pro
qmake -spec macx-xcode SimpleMapEditor.pro
