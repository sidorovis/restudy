require 'rubygems'
require 'sqlite3.rb'

=begin
  method get_quests
    return : array of quests from db
  this method connect to local sqlite3 database (filename data.db) where should be:
    create table quests
      (
        id INTEGER PRIMARY KEY,
        task VARCHAR(256) NOT NULL,
        description VARCHAR(256) NOT NULL,
        variants VARCHAR(256) NOT NULL,
        solve VARCHAR(256) NOT NULL,
        level INTEGER
      );
    collect and prepare data to tasks
=end
def get_quests()
  db = SQLite3::Database.open('data.db')
  $config = []
  db.execute('select * from quests') do |row|
    id = row[0]
    task = row[1]
    description = row[2]
    variants = row[3].split("|")
    solve = row[4]
    level = row[5]
    $config << [task,description,variants,solve,level]
  end
  db.close
  $config
end
def add_data(task,description,variants,solve,level)
  db = SQLite3::Database.open('data.db')
  db.execute("insert into quests(task,description,variants,solve,level) values('#{task}','#{description}','#{variants}','#{solve}',#{level});");# do |row|
#  end
  db.close
end
=begin
add_data('HEL_O','Enter letter to Hi word','','HELLO',1)
add_data('HE_LO','Enter letter to Hi word','','HELLO',1)
add_data('_ELLO','Enter letter to Hi word','','HELLO',1)
add_data('HELL_','Enter letter to Hi word','','HELLO',1)
add_data('H_LLO','Enter letter to Hi word','','HELLO',1)

add_data('PROGRA_MING','Enter letter','','PROGRAMMING',2)
add_data('PR_GRAMMING','Enter letter','','PROGRAMMING',2)
add_data('PROGR_MMING','Enter letter','','PROGRAMMING',2)
add_data('PROG_AMMING','Enter letter','','PROGRAMMING',2)
add_data('P_OGRAMMING','Enter letter','','PROGRAMMING',2)

add_data('IT IS N_T SO EASY','Enter letter into word hard work','','IT IS NOT SO EASY',3)
add_data('IT IS NOT SO EAS_','Enter letter into word hard work','','IT IS NOT SO EASY',3)
add_data('IT IS NOT SO _ASY','Enter letter into word hard work','','IT IS NOT SO EASY',3)
add_data('IT IS NOT SO E_SY','Enter letter into word hard work','','IT IS NOT SO EASY',3)
add_data('IT_IS NOT SO EASY','Enter letter into word hard work','','IT IS NOT SO EASY',3)

add_data('YOU NE_ER FINISH IT','Enter letter missed ','','YOU NEVER FINISH IT',4)
add_data('YOU NEVER FI_ISH IT','Enter letter missed ','','YOU NEVER FINISH IT',4)
add_data('YOU NEVER FINI_H IT','Enter letter missed ','','YOU NEVER FINISH IT',4)
add_data('YOU NEVER FINIS_ IT','Enter letter missed ','','YOU NEVER FINISH IT',4)
add_data('_OU NEVER FINISH IT','Enter letter missed ','','YOU NEVER FINISH IT',4)

add_data('BR_NG','Enter missed letter ','','BRING',5)
add_data('BRING D_DE','Enter missed letter ','','BRING DUDE',5)
add_data('BRING YOU_SELF DUDE','Enter missed letter ','','BRING YOURSELF DUDE',5)
add_data('BRING YOURSELF H_ME DUDE','Enter missed letter ','','BRING YOURSELF HOME DUDE',5)
add_data('BRING YOURSELF HOME ALI_E DUDE','Enter missed letter ','','BRING YOURSELF HOME ALIVE DUDE',5)

=end
