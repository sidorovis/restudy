# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def change_if_exist(string,from,to)
		if string.match(from)
			string[from] = to
		end
		string
	end
	def solve_errors( f )
		err = f.error_messages
		err = russificate( err )
		err
	end
	def russificate( err )
		change_if_exist(err,"There were problems with the following fields","Просмотрите выделенное внимательно")
		change_if_exist(err,/errors prohibited this (\w+( )?\w*) from being saved/," ошибки требуют исправления")
		change_if_exist(err,/error prohibited this (\w+( )?\w*) from being saved/," ошибка требует исправления")
		change_if_exist(err,(/Password is too short (minimum is \d+ characters)/)," Пароль слишком короткий требуется 4 символа")
		change_if_exist(err,"Password doesn't match confirmation","Пароли не совпадают")
		change_if_exist(err,"Title can't be blank","Введите название")
		change_if_exist(err,"Project can't be blank","Поле проект не может быть пустым")
		change_if_exist(err,"Password confirmation can't be blank","Поле подтверждение пароля не может быть пустым")
		change_if_exist(err,"Login can't be blank","Поле логин не может быть пустым")
		change_if_exist(err,"Password can't be blank","Поле пароль не может быть пустым")
		change_if_exist(err,"Email can't be blank","Поле адрес электронной почты не может быть пустым")
		change_if_exist(err,"Task status can't be blank","Поле статус задачи не может быть пустым")
		change_if_exist(err,"Description can't be blank","Введите описание")
		change_if_exist(err,"Email should look like an email address","Введите верный адрес электронной почты")
		change_if_exist(err,"Password is too short (minimum is 6 characters)","Пароль слишком короткий требуется 6 символов")
		err
	end
end
