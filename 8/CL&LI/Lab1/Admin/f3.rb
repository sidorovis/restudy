=begin
** Form generated from reading ui file 'f3.ui'
**
** Created: Вт февр. 17 17:31:32 2009
**      by: Qt User Interface Compiler version 4.4.3
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_Form
    attr_reader :label
    attr_reader :pushButton

    def setupUi(form)
    if form.objectName.nil?
        form.objectName = "form"
    end
    form.resize(338, 130)
    @label = Qt::Label.new(form)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(70, 10, 181, 61)
    @pushButton = Qt::PushButton.new(form)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(110, 90, 113, 32)

    retranslateUi(form)
    Qt::Object.connect(@pushButton, SIGNAL('clicked()'), form, SLOT('close()'))

    Qt::MetaObject.connectSlotsByName(form)
    end # setupUi

    def setup_ui(form)
        setupUi(form)
    end

    def retranslateUi(form)
    form.windowTitle = Qt::Application.translate("Form", "Form", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("Form", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n" \
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n" \
"p, li { white-space: pre-wrap; }\n" \
"</style></head><body style=\" font-family:'Lucida Grande'; font-size:13pt; font-weight:400; font-style:normal;\">\n" \
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:28pt;\">Good Game!!!</span></p></body></html>", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("Form", "Bye-Bye", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(form)
        retranslateUi(form)
    end

end

module Ui
    class Form < Ui_Form
    end
end  # module Ui

