%% ������������ ������� �1 �� ���� "���������� ����������������"
%%
%% "������� �������"
%% 
%% ������� 1:
%% ��� �������, ��� ���������� ��������� parent, ����� ����� ���� ������� �� ����������� ���� �������?
%% �) ?-  parent( jim,   X).
%% �) ?-  parent( X, ann).
%% �) ?-  parent( pam,   X),   parent ( X,   pat).
%% r) ?-  parent( pam,   X),   parent ( X,   Y),   parent(Y,   jim).
%%
%% ������� 2:
%% ������������� �� ����� Prolog ������������� ���� ������� �� ��������� parent.
%% �)	��� �������� ��������� ���?
%% �)	����� �� ��� �������?
%% �)	��� �������� �������� ��� �������� ���?
%% 
%% ������� 3:
%% ������������ ����������� ���� ����������� � ������� Prolog.
%% �)	������,  ��� ����� �������, ��������  (������� ��������� happy �  ����� ����������).
%% �)	��� ���� X, ���� X ����� �������, �������� ������ ��� �����, �� X ����� ����� ����� (������� ����� ��������� hastwochildren).
%% 
%% ������� 4:
%% ���������� ��������� grandchild � �������������� ��������� parent. 
%%
%% ������� 5:
%% ���������� ��������� aunt ( X, Y) � �������� ��������� parent � sister. 

grandparent(X,Z) :-
        parent(X, Y),
        parent(Y, Z).

grandchild(X,Z) :-
		parent(Z, Y),
		parent(Y, X).

happy( X ) :-
		parent(X,Y).

different(X,Y) :-
		not(X=Y).

sister(X,Y) :-
		parent(Z,X),
		parent(Z,Y),
		female(X),
		different(X,Y).

aunt(X,Y) :-
		parent(Z,Y),
		sister(X,Z),
		not(parent(X,Y)).

hastwochildren( X ) :-
		parent(X,Y),parent(X,Z),different(Y,Z).

parent(pam, bob).
parent(tom, bob). 
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

male(pam).
male(bob). 
female(liz).
female(ann).
female(pat).
male(jim).

