RizmN = 55
Rizm = 34
N = 16
Tp = 36

Rx = Rizm * 15
puts "z1: Px = #{Rx} "
X = Rx * Tp * N
puts "z1: X = #{X}"

#------------------------------------
puts
As = 3
M = "Co 60"

Tgod = 1

Bsy = 1.15 * 10 ** (-15)

Rn = As * Bsy
puts "z2: Rn = #{Rn}"

Rn1 = Rn * 3.7 * 10 ** (5)
puts "z2: Rn1 = #{Rn1}"

N2 = Rn1 * ( Tgod * 365 * 24 * 3600 )
puts "z2: N = #{N2}"

#------------------------------------
puts

Kosl = 4
Tch = 1.5
K2 = 1.63
Rizm3 = 65
Ddop = 20

R1 = Rizm3 * K2 
puts "z3: R1 = #{R1}"

a = R1 / ( Ddop * Kosl )
puts "z3: a = #{a}"
puts "z3: Tdop = #{4}"

#-----------------------------------
puts 

Nch4 = 11
Ddop4 = 30
R14 = 35
K24 = 1.63

Rn4 = R14 / K24
puts "z4: Rn = #{Rn4}"

tk = 1.5 + Nch4
puts "z4: Tk = #{tk}"

K2tk = (19.72 + 21.71) / 2
puts "z4: K2tk = #{K2tk}"

Rk4 = R14 / K2tk
puts "z4: Rk = #{Rk4}"

X4 = (5 * Rn4 * 1.5 - 5 * Rk4 * tk) / 1
puts "z4: X = #{X4}"

N4 = X4 / Ddop4
puts "z4: N = #{N4}"

