=begin
** Form generated from reading ui file 'main.ui'
**
** Created: Ср 1. окт 16:00:59 2008
**      by: Qt User Interface Compiler version 4.3.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_MainWindow
    attr_reader :actionADC
    attr_reader :actionBrezenhem
    attr_reader :action
    attr_reader :actionClear_Field
    attr_reader :actionDelete_last_draw_action
    attr_reader :actionEllipse
    attr_reader :centralwidget
    attr_reader :menubar
    attr_reader :menuLines
    attr_reader :menuMain_Commands
    attr_reader :menu2_dimension_lines
    attr_reader :statusbar

    def setupUi(mainWindow)
    mainWindow.setObjectName("mainWindow")
    @actionADC = Qt::Action.new(mainWindow)
    @actionADC.setObjectName("actionADC")
    @actionBrezenhem = Qt::Action.new(mainWindow)
    @actionBrezenhem.setObjectName("actionBrezenhem")
    @action = Qt::Action.new(mainWindow)
    @action.setObjectName("action")
    @actionClear_Field = Qt::Action.new(mainWindow)
    @actionClear_Field.setObjectName("actionClear_Field")
    @actionDelete_last_draw_action = Qt::Action.new(mainWindow)
    @actionDelete_last_draw_action.setObjectName("actionDelete_last_draw_action")
    @actionEllipse = Qt::Action.new(mainWindow)
    @actionEllipse.setObjectName("actionEllipse")
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.setObjectName("centralwidget")
    mainWindow.setCentralWidget(@centralwidget)
    @menubar = Qt::MenuBar.new(mainWindow)
    @menubar.setObjectName("menubar")
    @menubar.setGeometry(Qt::Rect.new(0, 0, 800, 19))
    @menuLines = Qt::Menu.new(@menubar)
    @menuLines.setObjectName("menuLines")
    @menuMain_Commands = Qt::Menu.new(@menubar)
    @menuMain_Commands.setObjectName("menuMain_Commands")
    @menu2_dimension_lines = Qt::Menu.new(@menubar)
    @menu2_dimension_lines.setObjectName("menu2_dimension_lines")
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.setObjectName("statusbar")
    mainWindow.setStatusBar(@statusbar)

    @menubar.addAction(@menuMain_Commands.menuAction())
    @menubar.addAction(@menuLines.menuAction())
    @menubar.addAction(@menu2_dimension_lines.menuAction())
    @menuLines.addAction(@actionADC)
    @menuLines.addAction(@actionBrezenhem)
    @menuMain_Commands.addAction(@actionClear_Field)
    @menuMain_Commands.addAction(@actionDelete_last_draw_action)
    @menu2_dimension_lines.addAction(@actionEllipse)

    retranslateUi(mainWindow)

    size = Qt::Size.new(800, 600)
    size = size.expandedTo(mainWindow.minimumSizeHint())
    mainWindow.resize(size)


    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.setWindowTitle(Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8))
    @actionADC.setText(Qt::Application.translate("MainWindow", "&ADC", nil, Qt::Application::UnicodeUTF8))
    @actionBrezenhem.setText(Qt::Application.translate("MainWindow", "&Brezenhem", nil, Qt::Application::UnicodeUTF8))
    @action.setText(Qt::Application.translate("MainWindow", "Delete Last Action", nil, Qt::Application::UnicodeUTF8))
    @actionClear_Field.setText(Qt::Application.translate("MainWindow", "&Clear Field", nil, Qt::Application::UnicodeUTF8))
    @actionDelete_last_draw_action.setText(Qt::Application.translate("MainWindow", "&Delete last draw action", nil, Qt::Application::UnicodeUTF8))
    @actionEllipse.setText(Qt::Application.translate("MainWindow", "&Ellipse", nil, Qt::Application::UnicodeUTF8))
    @menuLines.setTitle(Qt::Application.translate("MainWindow", "&Lines", nil, Qt::Application::UnicodeUTF8))
    @menuMain_Commands.setTitle(Qt::Application.translate("MainWindow", "&Main Commands", nil, Qt::Application::UnicodeUTF8))
    @menu2_dimension_lines.setTitle(Qt::Application.translate("MainWindow", "2 &Dimension lines", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_MainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    w.show
    a.exec
end
