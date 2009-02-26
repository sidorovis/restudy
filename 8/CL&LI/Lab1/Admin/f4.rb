=begin
** Form generated from reading ui file 'f4.ui'
**
** Created: Вт февр. 17 17:35:54 2009
**      by: Qt User Interface Compiler version 4.4.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_F4
    attr_reader :label
    attr_reader :pushButton

    def setupUi(f4)
    if f4.objectName.nil?
        f4.objectName = "f4"
    end
    f4.resize(352, 121)
    @label = Qt::Label.new(f4)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(80, 10, 191, 61)
    @pushButton = Qt::PushButton.new(f4)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(120, 80, 113, 32)

    retranslateUi(f4)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), f4, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(f4)
    end # setupUi

    def setup_ui(f4)
        setupUi(f4)
    end

    def retranslateUi(f4)
    f4.windowTitle = Qt::Application.translate("f4", "Well Done", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("f4", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n" \
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n" \
"p, li { white-space: pre-wrap; }\n" \
"</style></head><body style=\" font-family:'Lucida Grande'; font-size:13pt; font-weight:400; font-style:normal;\">\n" \
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:28pt;\">Level Finished!</span></p></body></html>", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("f4", "Next Level!", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(f4)
        retranslateUi(f4)
    end

end

module Ui
    class F4 < Ui_F4
    end
end  # module Ui

