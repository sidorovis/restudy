=begin
** Form generated from reading ui file 'f2.ui'
**
** Created: Вт февр. 17 18:25:05 2009
**      by: Qt User Interface Compiler version 4.4.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_F2
    attr_reader :buttonBox
    attr_reader :label
    attr_reader :label_2
    attr_reader :lineEdit
    attr_reader :label_3

    def setupUi(f2)
    if f2.objectName.nil?
        f2.objectName = "f2"
    end
    f2.resize(368, 95)
    @buttonBox = Qt::DialogButtonBox.new(f2)
    @buttonBox.objectName = "buttonBox"
    @buttonBox.geometry = Qt::Rect.new(260, 10, 81, 41)
    @buttonBox.orientation = Qt::Vertical
    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok
    @label = Qt::Label.new(f2)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(0, 60, 151, 20)
    @label_2 = Qt::Label.new(f2)
    @label_2.objectName = "label_2"
    @label_2.geometry = Qt::Rect.new(10, 10, 231, 31)
    @lineEdit = Qt::LineEdit.new(f2)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(160, 60, 16, 22)
    @lineEdit.maxLength = 1
    @label_3 = Qt::Label.new(f2)
    @label_3.objectName = "label_3"
    @label_3.geometry = Qt::Rect.new(180, 60, 181, 17)

    retranslateUi(f2)
    Qt::Object.connect(@buttonBox, SIGNAL('accepted()'), f2, SLOT('accept()'))
    Qt::Object.connect(@buttonBox, SIGNAL('rejected()'), f2, SLOT('reject()'))

    Qt::MetaObject.connectSlotsByName(f2)
    end # setupUi

    def setup_ui(f2)
        setupUi(f2)
    end

    def retranslateUi(f2)
    f2.windowTitle = Qt::Application.translate("f2", "Level X, Round 0", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("f2", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n" \
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n" \
"p, li { white-space: pre-wrap; }\n" \
"</style></head><body style=\" font-family:'Lucida Grande'; font-size:13pt; font-weight:400; font-style:normal;\">\n" \
"<p align=\"right\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">qbegin</p></body></html>", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("f2", "Question:", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("f2", "wend", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(f2)
        retranslateUi(f2)
    end

end

module Ui
    class F2 < Ui_F2
    end
end  # module Ui

