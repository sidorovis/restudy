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
k_smen = 22.0
# потери времени в процентах
t_remont = 3
puts " 100 - #{t_remont} = #{100-t_remont} "       
# нормы времени
normi_vremeni = [ 4.8, 9.2, 9.0, 4.4, 6.0, 5.6, 7.0, 8.0 ]
k_normi_vremeni = [ 1.0, 1.2, 1.0, 1.0, 1.1, 1.0, 1.0, 1.0 ]

# такт 
takt = normi_vremeni.summ / normi_vremeni.size
ss = 0
(0..normi_vremeni.size-1).each { |i| ss += normi_vremeni[i] * ( 2 - k_normi_vremeni[i] ) }
puts " Сумма норм времени = #{normi_vremeni.summ}"
puts " Сумма норм времени2 = #{ss}"
puts " Такт = #{takt}"

Km = ss / ( takt * normi_vremeni.size )
puts " Коэфициент массовости = #{Km}"

# программа в месяц
Nmes_ = (k_smen * t_smen * n_smen * ( 100 - t_remont )/100)
puts " Программа количество часов = #{Nmes_}"

Nmes = (60 * k_smen * t_smen * n_smen * ( 100 - t_remont )/100) /takt
puts " Программа в месяц = #{Nmes}"

kol_detal = Nmes / ( n_smen * k_smen )
puts " Количество деталей = #{ kol_detal } "

