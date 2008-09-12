=begin
** Form generated from reading ui file 'machine_widget.ui'
**
** Created: Пт 12. сен 16:02:23 2008
**      by: Qt User Interface Compiler version 4.3.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_MachineWidget
    attr_reader :lineEdit_s
    attr_reader :label
    attr_reader :label_2
    attr_reader :lineEdit_a
    attr_reader :label_3
    attr_reader :lineEdit_b
    attr_reader :label_5
    attr_reader :lineEdit_c
    attr_reader :lineEdit_4
    attr_reader :label_4

    def setupUi(machineWidget)
    machineWidget.setObjectName("machineWidget")
    @lineEdit_s = Qt::LineEdit.new(machineWidget)
    @lineEdit_s.setObjectName("lineEdit_s")
    @lineEdit_s.setGeometry(Qt::Rect.new(40, 30, 113, 20))
    @label = Qt::Label.new(machineWidget)
    @label.setObjectName("label")
    @label.setGeometry(Qt::Rect.new(20, 30, 16, 16))
    @label_2 = Qt::Label.new(machineWidget)
    @label_2.setObjectName("label_2")
    @label_2.setGeometry(Qt::Rect.new(130, 0, 16, 16))
    @lineEdit_a = Qt::LineEdit.new(machineWidget)
    @lineEdit_a.setObjectName("lineEdit_a")
    @lineEdit_a.setGeometry(Qt::Rect.new(150, 0, 71, 20))
    @label_3 = Qt::Label.new(machineWidget)
    @label_3.setObjectName("label_3")
    @label_3.setGeometry(Qt::Rect.new(230, 0, 16, 16))
    @lineEdit_b = Qt::LineEdit.new(machineWidget)
    @lineEdit_b.setObjectName("lineEdit_b")
    @lineEdit_b.setGeometry(Qt::Rect.new(250, 0, 81, 20))
    @label_5 = Qt::Label.new(machineWidget)
    @label_5.setObjectName("label_5")
    @label_5.setGeometry(Qt::Rect.new(160, 30, 16, 16))
    @lineEdit_c = Qt::LineEdit.new(machineWidget)
    @lineEdit_c.setObjectName("lineEdit_c")
    @lineEdit_c.setGeometry(Qt::Rect.new(170, 30, 113, 20))
    @lineEdit_4 = Qt::LineEdit.new(machineWidget)
    @lineEdit_4.setObjectName("lineEdit_4")
    @lineEdit_4.setGeometry(Qt::Rect.new(30, 0, 25, 20))
    @label_4 = Qt::Label.new(machineWidget)
    @label_4.setObjectName("label_4")
    @label_4.setGeometry(Qt::Rect.new(10, 0, 16, 16))

    retranslateUi(machineWidget)

    size = Qt::Size.new(332, 55)
    size = size.expandedTo(machineWidget.minimumSizeHint())
    machineWidget.resize(size)


    Qt::MetaObject.connectSlotsByName(machineWidget)
    end # setupUi

    def setup_ui(machineWidget)
        setupUi(machineWidget)
    end

    def retranslateUi(machineWidget)
    machineWidget.setWindowTitle(Qt::Application.translate("MachineWidget", "Form", nil, Qt::Application::UnicodeUTF8))
    @label.setText(Qt::Application.translate("MachineWidget", "s=", nil, Qt::Application::UnicodeUTF8))
    @label_2.setText(Qt::Application.translate("MachineWidget", "a=", nil, Qt::Application::UnicodeUTF8))
    @label_3.setText(Qt::Application.translate("MachineWidget", "b=", nil, Qt::Application::UnicodeUTF8))
    @label_5.setText(Qt::Application.translate("MachineWidget", "*", nil, Qt::Application::UnicodeUTF8))
    @label_4.setText(Qt::Application.translate("MachineWidget", "n=", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(machineWidget)
        retranslateUi(machineWidget)
    end

end

module Ui
    class MachineWidget < Ui_MachineWidget
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_MachineWidget.new
    w = Qt::Widget.new
    u.setupUi(w)
    w.show
    a.exec
end
