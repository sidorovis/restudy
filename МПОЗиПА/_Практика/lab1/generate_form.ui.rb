=begin
** Form generated from reading ui file 'generate_form.ui'
**
** Created: Пт 12. сен 16:02:24 2008
**      by: Qt User Interface Compiler version 4.3.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_GenerateForm
    attr_reader :m_Edit
    attr_reader :label
    attr_reader :generateButton
    attr_reader :a_b_arrays
    attr_reader :okButton
    attr_reader :label_2
    attr_reader :n_Edit

    def setupUi(generateForm)
    generateForm.setObjectName("generateForm")
    generateForm.setWindowModality(Qt::WindowModal)
    @m_Edit = Qt::LineEdit.new(generateForm)
    @m_Edit.setObjectName("m_Edit")
    @m_Edit.setGeometry(Qt::Rect.new(50, 10, 81, 20))
    @label = Qt::Label.new(generateForm)
    @label.setObjectName("label")
    @label.setGeometry(Qt::Rect.new(30, 10, 21, 16))
    @generateButton = Qt::PushButton.new(generateForm)
    @generateButton.setObjectName("generateButton")
    @generateButton.setGeometry(Qt::Rect.new(140, 10, 75, 24))
    @a_b_arrays = Qt::TableWidget.new(generateForm)
    @a_b_arrays.setObjectName("a_b_arrays")
    @a_b_arrays.setGeometry(Qt::Rect.new(10, 40, 231, 301))
    @a_b_arrays.setTabKeyNavigation(false)
    @okButton = Qt::PushButton.new(generateForm)
    @okButton.setObjectName("okButton")
    @okButton.setGeometry(Qt::Rect.new(90, 380, 75, 24))
    @label_2 = Qt::Label.new(generateForm)
    @label_2.setObjectName("label_2")
    @label_2.setGeometry(Qt::Rect.new(20, 350, 16, 16))
    @n_Edit = Qt::LineEdit.new(generateForm)
    @n_Edit.setObjectName("n_Edit")
    @n_Edit.setGeometry(Qt::Rect.new(40, 350, 113, 20))
    Qt::Widget::setTabOrder(@m_Edit, @generateButton)
    Qt::Widget::setTabOrder(@generateButton, @n_Edit)
    Qt::Widget::setTabOrder(@n_Edit, @okButton)
    Qt::Widget::setTabOrder(@okButton, @a_b_arrays)

    retranslateUi(generateForm)

    size = Qt::Size.new(248, 412)
    size = size.expandedTo(generateForm.minimumSizeHint())
    generateForm.resize(size)


    Qt::MetaObject.connectSlotsByName(generateForm)
    end # setupUi

    def setup_ui(generateForm)
        setupUi(generateForm)
    end

    def retranslateUi(generateForm)
    generateForm.setWindowTitle(Qt::Application.translate("GenerateForm", "Enter datas", nil, Qt::Application::UnicodeUTF8))
    @m_Edit.setInputMask('')
    @label.setText(Qt::Application.translate("GenerateForm", "m=", nil, Qt::Application::UnicodeUTF8))
    @generateButton.setText(Qt::Application.translate("GenerateForm", "Generate", nil, Qt::Application::UnicodeUTF8))
    if @a_b_arrays.columnCount() < 2
        @a_b_arrays.setColumnCount(2)
    end

    __colItem = Qt::TableWidgetItem.new
    __colItem.setText(Qt::Application.translate("GenerateForm", "1", nil, Qt::Application::UnicodeUTF8))
    @a_b_arrays.setHorizontalHeaderItem(0, __colItem)

    __colItem1 = Qt::TableWidgetItem.new
    __colItem1.setText(Qt::Application.translate("GenerateForm", "2", nil, Qt::Application::UnicodeUTF8))
    @a_b_arrays.setHorizontalHeaderItem(1, __colItem1)
    @a_b_arrays.setAccessibleName('')
    @okButton.setText(Qt::Application.translate("GenerateForm", "Ok", nil, Qt::Application::UnicodeUTF8))
    @label_2.setText(Qt::Application.translate("GenerateForm", "n=", nil, Qt::Application::UnicodeUTF8))
    end # retranslateUi

    def retranslate_ui(generateForm)
        retranslateUi(generateForm)
    end

end

module Ui
    class GenerateForm < Ui_GenerateForm
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_GenerateForm.new
    w = Qt::Widget.new
    u.setupUi(w)
    w.show
    a.exec
end
