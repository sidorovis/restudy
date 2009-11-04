qmake -project
echo 'INCLUDEPATH += /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/include' >> SimpleMapEditor.pro
echo 'INCLUDEPATH += /opt/local/libexec/qt4-mac/include/QtXml/' >> SimpleMapEditor.pro
echo 'INCLUDEPATH += /opt/local/include/' >> SimpleMapEditor.pro
echo 'QMAKE_LFLAGS += -L/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib' >> SimpleMapEditor.pro
echo 'QMAKE_LFLAGS += -L/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/qgis' >> SimpleMapEditor.pro
echo 'LIBS += -lqgis_analysis -lqgis_core -lqgis_gui -lqgispython' >> SimpleMapEditor.pro
#echo 'LIBS += -losmplugin' >> SimpleMapEditor.pro
#echo 'LIBS +=  -lqgis_gui -lqgispython' >> SimpleMapEditor.pro
echo 'QT += xml' >> SimpleMapEditor.pro

echo 'MAPS.version = 1.0.0' >> SimpleMapEditor.pro
echo 'MAPS.files =  ./maps/city.mif' >> SimpleMapEditor.pro
echo 'MAPS.files += ./maps/city.mid' >> SimpleMapEditor.pro
echo 'MAPS.files += ./maps/regions.mif' >> SimpleMapEditor.pro
echo 'MAPS.files += ./maps/regions.mid' >> SimpleMapEditor.pro
echo 'MAPS.path = Contents/MacOS/maps' >> SimpleMapEditor.pro

echo 'QGIS_LIBS.version = 1.3.0' >> SimpleMapEditor.pro
echo 'QGIS_LIBS.files = /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/libqgis_analysis.1.3.0.dylib' >> SimpleMapEditor.pro
echo 'QGIS_LIBS.files += /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/libqgis_core.1.3.0.dylib' >> SimpleMapEditor.pro
echo 'QGIS_LIBS.files += /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/libqgis_gui.1.3.0.dylib' >> SimpleMapEditor.pro
echo 'QGIS_LIBS.files += /Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/libqgispython.1.3.0.dylib' >> SimpleMapEditor.pro
echo 'QGIS_LIBS.path = Contents/MacOS/lib' >> SimpleMapEditor.pro
echo 'QMAKE_BUNDLE_DATA += QGIS_LIBS MAPS' >> SimpleMapEditor.pro
echo 'SOURCES += _generate.sh' >> SimpleMapEditor.pro
echo 'SOURCES += _clean.sh' >> SimpleMapEditor.pro

qmake -spec macx-xcode SimpleMapEditor.pro
