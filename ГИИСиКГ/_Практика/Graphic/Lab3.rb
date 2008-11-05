require 'Lab2'
require 'Array2.rb'

class GraphWindow

	slots 'DrawBezieSpline()', 'DrawErmitSpline()', 'DrawBSpline()', 'justDrawSpline()', 'justDrawBSpline()'

	alias :old3_connectActions :connectActions
private
=begin
	������� create_matrixs_ermit ��������� ������� ������ � ������� ���������� ������� ����� ��������� ������� ������
	������� ��������� ������ ����� m �������� ����� P1, P4 � ������� R1, R4
	�������� ��������� �����������
=end
	def create_matrixs_ermit(m)
		@@m = Array2.new
		@@m[1,1],@@m[1,2],@@m[1,3],@@m[1,4]=  2 , -2 ,  1 ,  1 
		@@m[2,1],@@m[2,2],@@m[2,3],@@m[2,4]= -3 ,  3 , -2 , -1 
		@@m[3,1],@@m[3,2],@@m[3,3],@@m[3,4]=  0 ,  0 ,  1 ,  0
		@@m[4,1],@@m[4,2],@@m[4,3],@@m[4,4]=  1 ,  0 ,  0 ,  0
		
		r1x, r1y = 3*(m[1][0] - m[0][0]), 3*(m[1][1] - m[0][1])
		r4x, r4y = 3*(m[3][0] - m[2][0]), 3*(m[3][1] - m[2][1])
		
		@@c = Array2.new
		@@c[1,1], @@c[1,2] = m[0][0] , m[0][1]
		@@c[2,1], @@c[2,2] = m[3][0] , m[3][1]
		@@c[3,1], @@c[3,2] = r1x     , r1y
		@@c[4,1], @@c[4,2] = r4x     , r4y
	end
=begin
	������� create_matrixs_bezie ��������� ������� ����� � ������� ���������� ������� ����� ��������� ������� �����
	������� ��������� ������ ����� m �������� ����� P1, P2, P3, P4
	�������� ��������� �����������
=end
	def create_matrixs_bezie(m)
		@@m = Array2.new
		@@m[1,1],@@m[1,2],@@m[1,3],@@m[1,4]= -1 ,  3 , -3 , 1 
		@@m[2,1],@@m[2,2],@@m[2,3],@@m[2,4]=  3 , -6 ,  3 , 0 
		@@m[3,1],@@m[3,2],@@m[3,3],@@m[3,4]= -3 ,  3 ,  0 , 0
		@@m[4,1],@@m[4,2],@@m[4,3],@@m[4,4]=  1 ,  0 ,  0 , 0
		@@c = Array2.new
		@@c[1,1], @@c[1,2] = m[0][0],m[0][1]
		@@c[2,1], @@c[2,2] = m[1][0],m[1][1]
		@@c[3,1], @@c[3,2] = m[2][0],m[2][1]
		@@c[4,1], @@c[4,2] = m[3][0],m[3][1]
	end
=begin
	������� create_matrixs_bspline ��������� ������� B�������
	������� ��������� �����������
	�������� ��������� �����������
=end
	def create_matrix_bspline()
		@@m = Array2.new
		@@m[1,1],@@m[1,2],@@m[1,3],@@m[1,4]= -1 ,  3 , -3 , 1 
		@@m[2,1],@@m[2,2],@@m[2,3],@@m[2,4]=  3 , -6 ,  3 , 0 
		@@m[3,1],@@m[3,2],@@m[3,3],@@m[3,4]= -3 ,  0 ,  3 , 0
		@@m[4,1],@@m[4,2],@@m[4,3],@@m[4,4]=  1 ,  4 ,  1 , 0
		@@m*(1.0/6);
	end
public
=begin
	������� justDrawSpline ������������ ������ �� ������� �������� ��������
	������� ��������� ������ ������� �����
	�������� ��������� �����������
=end
	def justDrawSpline(m)
		create_matrixs_bezie(m) if @spline_type == :bezie	# � ����������� �� ��������� ���� ������� ��������� ������� 
															     # ������������ ����������
		create_matrixs_ermit(m) if @spline_type == :ermit
		shag = 0.001										# ������ ���� ��� ��������� �������
		puts "==============================================" if $log
		for t_cur in 0..(1 / shag)							# ������ t �� 0-�� �� 1-�� �� ��������� ����
			t = t_cur / (1/shag)
			tm = Array2.new
			tm[1,1],tm[1,2],tm[1,3],tm[1,4] = t**3, t**2, t**1, t**0
			res = tm*(@@m*@@c)								# ������ ��������� ��������� ����� ��������� �������
			xd, yd = res[1,1], res[1,2]
			DrawDot( xd, yd )								# ��������� ��������� �����
			puts " x = #{x.round}, y = #{y.round} " if $log
		end
		puts "==============================================" if $log
	end
=begin
	������� getSplineArray ������������ ������ �� ������� �������� ������� Bspline 
	������� ��������� ������ ������� �����
	�������� ��������� �����������
=end
	def getSplineArray(m)
		answer = Hash.new
		c = Array2.new										# ���������� ������� ����������� ������� ����� ������� �������
		c[1,1], c[1,2] = m[0][0],m[0][1]
		c[2,1], c[2,2] = m[1][0],m[1][1]
		c[3,1], c[3,2] = m[2][0],m[2][1]
		c[4,1], c[4,2] = m[3][0],m[3][1]
		shag = 0.005										# ������ ���� ��� ��������� �������
		puts "==============================================" if $log
		for t_cur in (0..(1 / shag))						# ������ t �� 0-�� �� 1-�� �� ��������� ����
			t = t_cur / (1/shag)
			tm = Array2.new
			tm[1,1],tm[1,2],tm[1,3],tm[1,4] = t**3, t**2, t**1, t**0
			res = tm*(@@m*c)								# ������ ��������� ��������� ����� ��������� �������
			xd, yd = res[1,1], res[1,2]
			DrawDot( xd, yd )								# ��������� ��������� �����
			puts " x = #{x.round}, y = #{y.round} " if $log
		end
		puts "==============================================" if $log
		answer
	end
=begin
	������� justDrawBSpline ������������ B������ �� ������� ������� �����
	������� ��������� ������ ������� �����
	�������� ��������� �����������
=end

	def justDrawBSpline(m)
		return if m.size < 4
		create_matrix_bspline
		answer = Hash.new
		size = m.size
		m.insert(0,m[m.size-1].clone)					# ����������� ��������� ����� � "����������"
		m[size] =   m[0].clone
		m[size+1] = m[1].clone
		m[size+2] = m[2].clone							# ����������� ��� ������ ����� � ����� ������� ��� �������� ����������� Bspline
		for i in (0..m.size-4)
			cm = Array.new
			(0..3).each { |u| cm[u] = Array.new;cm[u][0],cm[u][1] = m[i+u][0],m[i+u][1] }
														# ��������� ������� ����� ������� B �������
			getSplineArray(cm)							# ��������� ������� B �������
		end
	end

	def DrawBezieSpline()
		@spline_type = :bezie
		StartWorkAction :DrawSpline
	end
	def DrawBSpline()
		StartWorkAction :DrawBSpline
	end
	def DrawErmitSpline()
		@spline_type = :ermit
		StartWorkAction :DrawSpline
	end

	def connectActions
		old3_connectActions
		
		@commands[:DrawSpline] = 	[
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:justDrawSpline
								];
		@commands[:DrawErmitSpline] = 	[
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:saveMouse,
			:justDrawSpline
								];
		@commands[:DrawBSpline] = 	[
			:saveWhileMouse,
			:justDrawBSpline
								];

		connect( @f.actionPaint_spline, SIGNAL('triggered()') , self , SLOT('DrawBezieSpline()') )
		connect( @f.actionErmit , SIGNAL('triggered()') , self , SLOT('DrawErmitSpline()') )
		connect( @f.actionBspline , SIGNAL('triggered()') , self , SLOT('DrawBSpline()') )
		
	end
end