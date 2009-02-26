class String
 ##
 # method ruupcase!
 # upcase russian letters into self string object
 #
  def ruupcase!
    small = "ёйцукенгшщзхъфывапролджэячсмитьбю"
    big =   "ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
    for i in 0..small.size/2-1
      self[small[i*2..i*2+1]] = big[i*2..i*2+1] while self.include?(small[i*2..i*2+1])
    end
    self
  end
end
=begin
  class Quest
    save quests objects by it's data
=end
class Quest
##
# default constructor
#
  def initialize(description, task, variants, solve, level)
    @desc, @task, @variants, @solve, @level = description, task, variants, solve, level
  end
##
# method: to_s
# test method to simple quest data show, using only for testing 
  def to_s
    result = "Задача: #{@desc}. #{@task} "
    result += " варианты выбора: #{@variants.join(", ")}. " if @variants
    result += "\n Правильный ответ: #{@solve}, уровень сложности вопроса: #{@level} "
  end
##
# method ask
# used to ask questions
# automaticaly ask self question 
# return does user give right answer 1: right, 0: wrong answer
#
  def ask
	d1 = Ui_F2.new()
	d1.setupUi(d11 = Qt::Dialog.new())
	d1.label_2.text = @desc
	tt = @task.split("_")
	d11.setWindowTitle "Level #{$level}, Question #{$t} / #{$quest_per_level}"
	d1.label.text = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n" \
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n" \
"p, li { white-space: pre-wrap; }\n" \
"</style></head><body style=\" font-family:'Lucida Grande'; font-size:13pt; font-weight:400; font-style:normal;\">\n" \
"<p align=\"right\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">#{tt[0].to_s}</p></body></html>"
	d1.label_3.text = tt[1]
	if (d11.exec == Qt::Dialog::Accepted)
		try = @task.clone
		try["_"] = d1.lineEdit.text
		if try.ruupcase!.upcase == @solve.ruupcase!.upcase
			puts "Right!"
			return 1			
		end
		puts "Wrong!"
		return 0
	else
		return -1
	end
end 
end
##
# method find_questions
# create question array, from data array that was read from db
# use global variable $quests
# return quests array
#
def find_questions()
  result = []
  $quests = get_quests();
  $quests.each { |quest| result << Quest.new(quest[1],quest[0],quest[2],quest[3],quest[4]) if quest[4].to_i == $level }
  #$quests.each { |quest| result << Quest.new( quest[1][:description.to_s], quest[1][:task.to_s], quest[1][:variants.to_s], quest[1][:solve.to_s], quest[1][:level.to_s] ) if quest[1][:level.to_s] && (quest[1][:level.to_s]) <= $level }
  result
end
##
# method ask_questions
# ask series of questions (from one level)
# return count of right answers
#
def ask_questions( quests )
  labels = Array.new(quests.size, false )
  counter = 0
  for i in 1..$quest_per_level
	$t = i
    curr_i = rand(quests.size)
    while labels[ curr_i ]
      curr_i = rand(quests.size) 
    end
    labels[ curr_i ] = true
	res = quests[ curr_i ].ask
	return -1 if res == -1
    counter += res
  end
  counter
end
##
# method start_level
# create questions array
# and return number of right answers
#
def start_level()
  quests = find_questions
  
  if quests.size < $quest_per_level
    puts "Недостаточная база для #{$level} уровня. Загрузите другую базу для продолжения игры."
    exit(1)
  end 
  ask_questions quests
end