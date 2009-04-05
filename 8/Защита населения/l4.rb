S1 = 0.5
Sn = 295.0
Sdop = 85.0
Hvp = 2.9
M = Sn / S1
N = 699
puts " M = #{M} "
So = Sn + Sdop

V1 = So * Hvp / M
puts " V1 = #{V1}"
H = M / 5.0
puts " H = #{H}"

Kvm = M / N
puts " Kvm = #{Kvm}"
puts " Таким образом, #{Kvm*100} персонала помещается в убежище. "

Rr = 5.2
Rotk = 1.8
Rx = Rr - Rotk
puts " Rx = #{Rx}"

DRfmaks = 0.4
puts " дельта Rf maks = #{DRfmaks}"

Vsv = 50
tvip = 1
tn = Rx / Vsv + tvip
puts "tn = #{tn}"

tk = tn + 96
puts "tk = #{tk}"

R1max = 17000.0

Drz_max = R1max*(tn**(-0.2)-tk**(-0.2))
Dpr = Drz_max + 5.0
puts "D проник = #{Drz_max}"

Ddop = 50.0
Kosl_rz_treb = Dpr / Ddop
puts "К осл. рз. треб = #{Kosl_rz_treb}"

puts " Проникающая радиация = #{Dpr}"

h1 = 50.0
h2 = 35.0
d1 = 10.0
d2 = 14.4
Kp = 8.0

Kosl_zash = Kp * (2 ** (h1 / d1)) * (2 ** (h2 / d2))
puts " K осл. защ. = #{ Kosl_zash }"

puts " дельта Р ф. защ > дельта ф. макс и К осл. защ > K осл треб "

Kzt = M / N
puts " Kzt = #{Kzt}"

