#
# Copyright (c) 1993-1997, Silicon Graphics, Inc.
# ALL RIGHTS RESERVED 
# Permission to use, copy, modify, and distribute this software for 
# any purpose and without fee is hereby granted, provided that the above
# copyright notice appear in all copies and that both the copyright notice
# and this permission notice appear in supporting documentation, and that 
# the name of Silicon Graphics, Inc. not be used in advertising
# or publicity pertaining to distribution of the software without specific,
# written prior permission. 
#
# THE MATERIAL EMBODIED ON THIS SOFTWARE IS PROVIDED TO YOU "AS-IS"
# AND WITHOUT WARRANTY OF ANY KIND, EXPRESS, IMPLIED OR OTHERWISE,
# INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF MERCHANTABILITY OR
# FITNESS FOR A PARTICULAR PURPOSE.  IN NO EVENT SHALL SILICON
# GRAPHICS, INC.  BE LIABLE TO YOU OR ANYONE ELSE FOR ANY DIRECT,
# SPECIAL, INCIDENTAL, INDIRECT OR CONSEQUENTIAL DAMAGES OF ANY
# KIND, OR ANY DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION,
# LOSS OF PROFIT, LOSS OF USE, SAVINGS OR REVENUE, OR THE CLAIMS OF
# THIRD PARTIES, WHETHER OR NOT SILICON GRAPHICS, INC.  HAS BEEN
# ADVISED OF THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, ARISING OUT OF OR IN CONNECTION WITH THE
# POSSESSION, USE OR PERFORMANCE OF THIS SOFTWARE.
# 
# US Government Users Restricted Rights 
# Use, duplication, or disclosure by the Government is subject to
# restrictions set forth in FAR 52.227.19(c)(2) or subparagraph
# (c)(1)(ii) of the Rights in Technical Data and Computer Software
# clause at DFARS 252.227-7013 and/or in similar or successor
# clauses in the FAR or the DOD or NASA FAR Supplement.
# Unpublished-- rights reserved under the copyright laws of the
# United States.  Contractor/manufacturer is Silicon Graphics,
# Inc., 2011 N.  Shoreline Blvd., Mountain View, CA 94039-7311.
#
# OpenGL(R) is a registered trademark of Silicon Graphics, Inc.
#
# alpha.c
# This program draws several overlapping filled polygons
# to demonstrate the effect order has on alpha blending results.
# Use the 't' key to toggle the order of drawing polygons.
require 'opengl'
require 'mathn'
include Gl,Glu,Glut

$leftFirst = GL_TRUE

# Initialize alpha blending function.
def init
	glEnable(GL_BLEND)
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	glShadeModel(GL_FLAT)
	glClearColor(0.0, 0.0, 0.0, 0.0)
end

def drawLeftTriangle
	# draw yellow triangle on LHS of screen
	
	glBegin(GL_TRIANGLES)
	glColor(1.0, 1.0, 0.0, 0.75)
	glVertex(0.1, 0.9, 0.0) 
	glVertex(0.1, 0.1, 0.0) 
	glVertex(0.7, 0.5, 0.0) 
	glEnd()
end

def drawRightTriangle
	# draw cyan triangle on RHS of screen
	
	glBegin(GL_TRIANGLES)
	glColor(0.0, 1.0, 1.0, 0.75)
	glVertex(0.9, 0.9, 0.0) 
	glVertex(0.3, 0.5, 0.0) 
	glVertex(0.9, 0.1, 0.0) 
	glEnd()
end

display = Proc.new do
	glClear(GL_COLOR_BUFFER_BIT)
	
	if ($leftFirst)
		drawLeftTriangle()
		drawRightTriangle()
	else
		drawRightTriangle()
		drawLeftTriangle()
	end
	glutSwapBuffers()
end

reshape = Proc.new do |w, h|
	glViewport(0, 0,  w, h)
	glMatrixMode(GL_PROJECTION)
	glLoadIdentity()
	if (w <= h) 
		gluOrtho2D(0.0, 1.0, 0.0, 1.0*h/w)
	else 
		gluOrtho2D(0.0, 1.0*w/h, 0.0, 1.0)
	end
end

keyboard = Proc.new do|key, x, y|
	case (key)
		when 't'[0],'T'[0]
			$leftFirst = !$leftFirst
			glutPostRedisplay()	
		when 27  # Escape key
			exit(0)
	end
end

# Main Loop
# Open window with initial window size, title bar, 
# RGBA display mode, and handle input events.
glutInit
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB)
glutInitWindowSize(500, 500)
glutInitWindowPosition(100, 100)
glutCreateWindow($0)
init()
glutReshapeFunc(reshape)
glutKeyboardFunc(keyboard)
glutDisplayFunc(display)
glutMainLoop()
