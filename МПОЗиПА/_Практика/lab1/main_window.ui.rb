=begin
** Form generated from reading ui file 'main_window.ui'
**
** Created: Пт 12. сен 16:02:22 2008
**      by: Qt User Interface Compiler version 4.3.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_MainWindow
    attr_reader :centralwidget
    attr_reader :frame
    attr_reader :upButton
    attr_reader :downButton
    attr_reader :nextMove
    attr_reader :label
    attr_reader :moveCounter
    attr_reader :previousMove
    attr_reader :play
    attr_reader :stop
    attr_reader :speed
    attr_reader :label_2
    attr_reader :reset
    attr_reader :buildGraph

    def setupUi(mainWindow)
    mainWindow.setObjectName("mainWindow")
    mainWindow.setWindowModality(Qt::WindowModal)
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.setObjectName("centralwidget")
    @frame = Qt::Frame.new(@centralwidget)
    @frame.setObjectName("frame")
    @frame.setGeometry(Qt::Rect.new(10, 10, 441, 581))
    @frame.setFrameShape(Qt::Frame::StyledPanel)
    @frame.setFrameShadow(Qt::Frame::Raised)
    @upButton = Qt::PushButton.new(@centralwidget)
    @upButton.setObjectName("upButton")
    @upButton.setGeometry(Qt::Rect.new(470, 10, 75, 41))
    @downButton = Qt::PushButton.new(@centralwidget)
    @downButton.setObjectName("downButton")
    @downButton.setGeometry(Qt::Rect.new(470, 60, 75, 41))
    @nextMove = Qt::PushButton.new(@centralwidget)
    @nextMove.setObjectName("nextMove")
    @nextMove.setGeometry(Qt::Rect.new(470, 197, 75, 24))
    @label = Qt::Label.new(@centralwidget)
    @label.setObjectName("label")
    @label.setGeometry(Qt::Rect.new(480, 147, 63, 16))
    @moveCounter = Qt::LineEdit.new(@centralwidget)
    @moveCounter.setObjectName("moveCounter")
    @moveCounter.setGeometry(Qt::Rect.new(470, 167, 81, 20))
    @previousMove = Qt::PushButton.new(@centralwidget)
    @previousMove.setObjectName("previousMove")
    @previousMove.setGeometry(Qt::Rect.new(470, 117, 77, 24))
    @play = Qt::PushButton.new(@centralwidget)
    @play.setObjectName("play")
    @play.setGeometry(Qt::Rect.new(470, 377, 75, 24))
    @stop = Qt::PushButton.new(@centralwidget)
    @stop.setObjectName("stop")
    @stop.setGeometry(Qt::Rect.new(470, 407, 75, 24))
    @speed = Qt::LineEdit.new(@centralwidget)
    @speed.setObjectName("speed")
    @speed.setGeometry(Qt::Rect.new(470, 337, 71, 20))
    @label_2 = Qt::Label.new(@centralwidget)
    @label_2.setObjectName("label_2")
    @label_2.setGeometry(Qt::Rect.new(490, 317, 31, 16))
    @reset = Qt::PushButton.new(@centralwidget)
    @reset.setObjectName("reset")
    @reset.setGeometry(Qt::Rect.new(470, 470, 75, 41))
    @buildGraph = Qt::PushButton.new(@centralwidget)
    @buildGraph.setObjectName("buildGraph")
    @buildGraph.setGeometry(Qt::Rect.new(470, 560, 75, 24))
    mainWindow.setCentralWidget(@centralwidget)

    retranslateUi(mainWindow)

    size = Qt::Size.new(566, 606)
    size = size.expandedTo(mainWindow.minimumSizeHint())
    mainWindow.resize(size)


    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.setWindowTitle(Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8))
    @upButton.setText(Qt::Application.translate("MainWindow", "^", nil, Qt::Application::UnicodeUTF8))
    @downButton.setText(Qt::Application.translate("MainWindow", "v", nil, Qt::Application::UnicodeUTF8))
    @nextMove.setText(Qt::Application.translate("MainWindow", "nextMove", nil, Qt::Application::UnicodeUTF8))
    @label.setText(Qt::Application.translate("MainWindow", "moveNumber", nil, Qt::Application::UnicodeUTF8))
    @previousMove.setText(Qt::Application.translate("MainWindow", "PreviousMove", nil, Qt::Application::UnicodeUTF8))
    @play.setText(Qt::Application.translate("MainWindow", "PLay", nil, Qt::Application::UnicodeUTF8))
    @stop.setText(Qt::Application.translate("MainWindow", "Stop", nil, Qt::Application::UnicodeUTF8))
    @speed.setText(Qt::Application.translate("MainWindow", "1000", nil, Qt::Application::UnicodeUTF8))
    @label_2.setText(Qt::Application.translate("MainWindow", "speed", nil, Qt::Application::UnicodeUTF8))
    @reset.setText(Qt::Application.translate("MainWindow", "Reset", nil, Qt::Application::UnicodeUTF8))
    @buildGraph.setText(Qt::Application.translate("MainWindow", "BuildGraphics", nil, Qt::Application::UnicodeUTF8))
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
