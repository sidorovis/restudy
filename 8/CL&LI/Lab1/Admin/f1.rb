=begin
** Form generated from reading ui file 'f1.ui'
**
** Created: Вт февр. 17 15:59:13 2009
**      by: Qt User Interface Compiler version 4.4.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_F1
    attr_reader :buttonBox
    attr_reader :label
    attr_reader :label_2
    attr_reader :label_3

    def setupUi(f1)
    if f1.objectName.nil?
        f1.objectName = "f1"
    end
    f1.resize(326, 97)
    @buttonBox = Qt::DialogButtonBox.new(f1)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(230, 10, 81, 41)
    @buttonBox.orientation = Qt::Vertical
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @label = Qt::Label.new(f1)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(20, 10, 171, 17)
    @label_2 = Qt::Label.new(f1)
    @label_2.objectName = "label_2"
    @label_2.geometry = Qt::Rect.new(20, 30, 201, 17)
    @label_3 = Qt::Label.new(f1)
    @label_3.objectName = "label_3"
    @label_3.geometry = Qt::Rect.new(20, 60, 291, 20)

    retranslateUi(f1)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), f1, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), f1, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(f1)
    end # setupUi

    def setup_ui(f1)
        setupUi(f1)
    end

    def retranslateUi(f1)
    f1.windowTitle = Qt::Application.translate("f1", "Welcome", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("f1", "Welcome to the Lang Game!", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("f1", "Press Ok To Start Game", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("f1", "Developer team wish you Good Luck!!!", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(f1)
        retranslateUi(f1)
    end

end

module Ui
    class F1 < Ui_F1
    end
end  # module Ui

