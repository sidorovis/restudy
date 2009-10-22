#include "MainWindow.h"

MainWindow::MainWindow(QWidget* parent)
: QMainWindow(parent)
{
	setMinimumSize(minimalSizeX, minimalSizeY);
	
	QString myPluginsDir = "/Applications/MacPorts/qgis1.3.0.app/Contents/MacOS/lib/qgis";
	QgsProviderRegistry::instance(myPluginsDir);
	QString mDataSourceOsm;
	QString mDataSourceOgr;
	const QStringList list = QgsProviderRegistry::instance()->providerList();
	for (int i = 0 ; i < list.size(); i++)
		qDebug() << list.at(i);
	QgsDataProvider* provider_osm = QgsProviderRegistry::instance()->getProvider( "osm", mDataSourceOsm );
	QgsDataProvider* provider_ogr = QgsProviderRegistry::instance()->getProvider( "ogr", mDataSourceOgr );
	
	qDebug() << mDataSourceOsm ;
	qDebug() << provider_osm ;
	qDebug() << mDataSourceOgr ;
	qDebug() << provider_ogr ;
	
#define OSMTEST 1

#ifdef MYRASTERTEST	
//	QFileInfo myRasterFileInfo("/Users/rilley_elf/Downloads/Abarema_jupunba_projection.tif");
//	QgsRasterLayer * mypLayer = new QgsRasterLayer(myRasterFileInfo.filePath(), 
//	myRasterFileInfo.completeBaseName());
#endif
#ifdef VECTORTEST
//	QString myProviderName = "ogr";
//	QFileInfo fileInfo("/Users/rilley_elf/maps/MIF-MID/roads.mif");
//	QgsVectorLayer* vectLay = new QgsVectorLayer(fileInfo.filePath(), fileInfo.completeBaseName(),myProviderName);
#endif
#ifdef OSMTEST
	QString myProviderName = "osm";
	QFileInfo fileInfo("/Users/rilley_elf/maps/map.osm.xml");
	QgsVectorLayer* vectLay = new QgsVectorLayer(fileInfo.filePath(), fileInfo.completeBaseName(),myProviderName);
#endif
	if (vectLay->isValid())
	{

		mpMapCanvas= new QgsMapCanvas(0, 0);
		mpMapCanvas->enableAntiAliasing(true);
		mpMapCanvas->setCanvasColor( QColor(255, 255, 255) );
		setCentralWidget(mpMapCanvas);
	
		qDebug("Layer is valid");
		QList<QgsMapCanvasLayer> mySet;
		QgsMapLayerRegistry::instance()->addMapLayer(vectLay, TRUE);
		mySet.push_back(vectLay);
		mpMapCanvas->setExtent(vectLay->extent());
		mpMapCanvas->setLayerSet(mySet);
		mpMapCanvas->freeze(false);
		mpMapCanvas->setVisible(true);
	}
	else
	{
		qDebug("Layer is NOT valid");
	}
	show();
}

