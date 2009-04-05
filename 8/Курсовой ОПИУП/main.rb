class Array
  def summ
    sum = 0
    each { |i| sum += i }
    sum
  end
end
# количество смен
n_smen = 2.0
# время на смену в часах
t_smen = 8.0
# число рабочих дней
k_smen = 20.0
# потери времени в процентах
t_remont = 3.61
       
# нормы времени
normi_vremeni = [ 4.8, 9.2, 9.0, 4.4, 6.0, 5.6, 7.0, 8.0 ]

# такт 
takt = normi_vremeni.summ / normi_vremeni.size
puts " Такт = #{takt}"

# программа в месяц
Nmes = (k_smen * t_smen * 60 * n_smen * ( 100 - t_remont ))/takt
puts " Программа в месяц = #{Nmes}"
