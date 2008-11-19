=begin
** Form generated from reading ui file 'main.ui'
**
** Created: Ср 19. ноя 11:29:29 2008
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
    attr_reader :actionDraw2Pow
    attr_reader :actionPaint_spline
    attr_reader :actionErmit
    attr_reader :actionBspline
    attr_reader :actionCreateConvex
    attr_reader :actionSimpleFill
    attr_reader :actionStackFill
    attr_reader :actionFill
    attr_reader :actionProecirovanie_mode
    attr_reader :actionNormal_mode
    attr_reader :actionFrameMode
    attr_reader :actionNoFrameMode
    attr_reader :centralwidget
    attr_reader :menubar
    attr_reader :menuLines
    attr_reader :menuMain_Commands
    attr_reader :menu2_dimension_lines
    attr_reader :menuSplines
    attr_reader :menuFill
    attr_reader :menuProecirovanie
    attr_reader :menuFrame
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
    @actionDraw2Pow = Qt::Action.new(mainWindow)
    @actionDraw2Pow.setObjectName("actionDraw2Pow")
    @actionPaint_spline = Qt::Action.new(mainWindow)
    @actionPaint_spline.setObjectName("actionPaint_spline")
    @actionErmit = Qt::Action.new(mainWindow)
    @actionErmit.setObjectName("actionErmit")
    @actionBspline = Qt::Action.new(mainWindow)
    @actionBspline.setObjectName("actionBspline")
    @actionCreateConvex = Qt::Action.new(mainWindow)
    @actionCreateConvex.setObjectName("actionCreateConvex")
    @actionSimpleFill = Qt::Action.new(mainWindow)
    @actionSimpleFill.setObjectName("actionSimpleFill")
    @actionStackFill = Qt::Action.new(mainWindow)
    @actionStackFill.setObjectName("actionStackFill")
    @actionFill = Qt::Action.new(mainWindow)
    @actionFill.setObjectName("actionFill")
    @actionProecirovanie_mode = Qt::Action.new(mainWindow)
    @actionProecirovanie_mode.setObjectName("actionProecirovanie_mode")
    @actionNormal_mode = Qt::Action.new(mainWindow)
    @actionNormal_mode.setObjectName("actionNormal_mode")
    @actionFrameMode = Qt::Action.new(mainWindow)
    @actionFrameMode.setObjectName("actionFrameMode")
    @actionNoFrameMode = Qt::Action.new(mainWindow)
    @actionNoFrameMode.setObjectName("actionNoFrameMode")
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
    @menuSplines = Qt::Menu.new(@menubar)
    @menuSplines.setObjectName("menuSplines")
    @menuFill = Qt::Menu.new(@menubar)
    @menuFill.setObjectName("menuFill")
    @menuProecirovanie = Qt::Menu.new(@menubar)
    @menuProecirovanie.setObjectName("menuProecirovanie")
    @menuFrame = Qt::Menu.new(@menubar)
    @menuFrame.setObjectName("menuFrame")
    mainWindow.setMenuBar(@menubar)
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.setObjectName("statusbar")
    mainWindow.setStatusBar(@statusbar)

    @menubar.addAction(@menuMain_Commands.menuAction())
    @menubar.addAction(@menuLines.menuAction())
    @menubar.addAction(@menu2_dimension_lines.menuAction())
    @menubar.addAction(@menuSplines.menuAction())
    @menubar.addAction(@menuFill.menuAction())
    @menubar.addAction(@menuProecirovanie.menuAction())
    @menubar.addAction(@menuFrame.menuAction())
    @menuLines.addAction(@actionADC)
    @menuLines.addAction(@actionBrezenhem)
    @menuMain_Commands.addAction(@actionClear_Field)
    @menu2_dimension_lines.addAction(@actionEllipse)
    @menu2_dimension_lines.addAction(@actionDraw2Pow)
    @menuSplines.addAction(@actionErmit)
    @menuSplines.addAction(@actionPaint_spline)
    @menuSplines.addAction(@actionBspline)
    @menuFill.addAction(@actionCreateConvex)
    @menuFill.addAction(@actionFill)
    @menuProecirovanie.addAction(@actionProecirovanie_mode)
    @menuProecirovanie.addAction(@actionNormal_mode)
    @menuFrame.addAction(@actionFrameMode)
    @menuFrame.addAction(@actionNoFrameMode)

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
    @actionDraw2Pow.setText(Qt::Application.translate("MainWindow", "Draw2Pow", nil, Qt::Application::UnicodeUTF8))
    @actionPaint_spline.setText(Qt::Application.translate("MainWindow", "B&ezie", nil, Qt::Application::UnicodeUTF8))
    @actionErmit.setText(Qt::Application.translate("MainWindow", "&Ermit", nil, Qt::Application::UnicodeUTF8))
    @actionBspline.setText(Qt::Application.translate("MainWindow", "&Bspline", nil, Qt::Application::UnicodeUTF8))
    @actionCreateConvex.setText(Qt::Application.translate("MainWindow", "CreateConvex", nil, Qt::Application::UnicodeUTF8))
    @actionSimpleFill.setText(Qt::Application.translate("MainWindow", "SimpleFill", nil, Qt::Application::UnicodeUTF8))
    @actionStackFill.setText(Qt::Application.translate("MainWindow", "StackFill", nil, Qt::Application::UnicodeUTF8))
    @actionFill.setText(Qt::Application.translate("MainWindow", "Fill", nil, Qt::Application::UnicodeUTF8))
    @actionProecirovanie_mode.setText(Qt::Application.translate("MainWindow", "Proecirovanie mode", nil, Qt::Application::UnicodeUTF8))
    @actionNormal_mode.setText(Qt::Application.translate("MainWindow", "Normal mode", nil, Qt::Application::UnicodeUTF8))
    @actionFrameMode.setText(Qt::Application.translate("MainWindow", "FrameMode", nil, Qt::Application::UnicodeUTF8))
    @actionNoFrameMode.setText(Qt::Application.translate("MainWindow", "NoFrameMode", nil, Qt::Application::UnicodeUTF8))
    @menuLines.setTitle(Qt::Application.translate("MainWindow", "&Lines", nil, Qt::Application::UnicodeUTF8))
    @menuMain_Commands.setTitle(Qt::Application.translate("MainWindow", "&Main Commands", nil, Qt::Application::UnicodeUTF8))
    @menu2_dimension_lines.setTitle(Qt::Application.translate("MainWindow", "2 &Dimension lines", nil, Qt::Application::UnicodeUTF8))
    @menuSplines.setTitle(Qt::Application.translate("MainWindow", "&Splines", nil, Qt::Application::UnicodeUTF8))
    @menuFill.setTitle(Qt::Application.translate("MainWindow", "Fill", nil, Qt::Application::UnicodeUTF8))
    @menuProecirovanie.setTitle(Qt::Application.translate("MainWindow", "Proecirovanie", nil, Qt::Application::UnicodeUTF8))
    @menuFrame.setTitle(Qt::Application.translate("MainWindow", "Frame", nil, Qt::Application::UnicodeUTF8))
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
