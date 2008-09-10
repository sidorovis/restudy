=begin
** Form generated from reading ui file 'konveer.ui'
**
** Created: Ср 10. сен 16:38:46 2008
**      by: Qt User Interface Compiler version 4.3.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt'

class Ui_Form
    attr_reader :comboBox
    attr_reader :pushButton
    attr_reader :label_2
    attr_reader :label_3
    attr_reader :comboBox_2

    def setupUi(form)
    form.setObjectName("form")
    form.setWindowModality(Qt::ApplicationModal)
    form.setMinimumSize(Qt::Size.new(252, 788))
    form.setMaximumSize(Qt::Size.new(252, 788))
    @comboBox = Qt::ComboBox.new(form)
    @comboBox.setObjectName("comboBox")
    @comboBox.setGeometry(Qt::Rect.new(10, 30, 71, 22))
    @pushButton = Qt::PushButton.new(form)
    @pushButton.setObjectName("pushButton")
    @pushButton.setGeometry(Qt::Rect.new(170, 30, 75, 24))
    @label_2 = Qt::Label.new(form)
    @label_2.setObjectName("label_2")
    @label_2.setGeometry(Qt::Rect.new(30, 10, 16, 16))
    @label_3 = Qt::Label.new(form)
    @label_3.setObjectName("label_3")
    @label_3.setGeometry(Qt::Rect.new(110, 10, 21, 16))
    @comboBox_2 = Qt::ComboBox.new(form)
    @comboBox_2.setObjectName("comboBox_2")
    @comboBox_2.setGeometry(Qt::Rect.new(90, 30, 69, 22))

    retranslateUi(form)

    size = Qt::Size.new(252, 788)
    size = size.expandedTo(form.minimumSizeHint())
    form.resize(size)


    Qt::MetaObject.connectSlotsByName(form)
    end # setupUi

    def setup_ui(form)
        setupUi(form)
    end

    def retranslateUi(form)
    form.setWindowTitle(Qt::Application.translate("Form", "Konveer", nil, Qt::Application::UnicodeUTF8))
    @pushButton.setText(Qt::Application.translate("Form", "Generate", nil, Qt::Application::UnicodeUTF8))
    @label_2.setText(Qt::Application.translate("Form", "a[i]", nil, Qt::Application::UnicodeUTF8))
    @label_3.setText(Qt::Application.translate("Form", "b[i]", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(form)
        retranslateUi(form)
    end

end

module Ui
    class Form < Ui_Form
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_Form.new
    w = Qt::Widget.new
    u.setupUi(w)
    w.show
    a.exec
end
