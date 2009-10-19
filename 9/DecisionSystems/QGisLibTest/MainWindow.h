#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#define minimalSizeX 640
#define minimalSizeY 480

#define CORE_EXPORT
#define GUI_EXPORT

#define QGISDEBUG true
#define QGIS_DEBUG 1

#include <QMainWindow>
#include <QString>
#include <qgsproviderregistry.h>
#include <qgsrasterlayer.h>
#include <qgsvectorlayer.h>
#include <qgsmapcanvas.h>
#include <QVBoxLayout>
#include <qgsmaplayerregistry.h>
#include <QDebug>
#include <qgslogger.h>

class MainWindow : public QMainWindow
{	
	Q_OBJECT
public:	
	MainWindow(QWidget* parent = 0);
	
	QgsMapCanvas * mpMapCanvas;
	QVBoxLayout  * mpLayout;
	
};

#endif // MAIN_WINDOW_H
