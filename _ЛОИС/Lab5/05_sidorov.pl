%% Практическое занятие №1 по теме "Логическое программирование"
%%
%% "Семейка Адамсов"
%% 
%% Задание 1:
%% При условии, что определено отношение parent, какой ответ дает система на приведенные ниже вопросы?
%% а) ?-  parent( jim,   X).
%% б) ?-  parent( X, ann).
%% в) ?-  parent( pam,   X),   parent ( X,   pat).
%% r) ?-  parent( pam,   X),   parent ( X,   Y),   parent(Y,   jim).
%%
%% Задание 2:
%% Сформулируйте на языке Prolog перечисленные ниже вопросы об отношении parent.
%% а)	Кто является родителем Пэт?
%% б)	Имеет ли Лиз ребенка?
%% в)	Кто является дедушкой или бабушкой Пэт?
%% 
%% Задание 3:
%% Преобразуйте приведенные ниже утверждения в правила Prolog.
%% а)	Каждый,  кто имеет ребенка, счастлив  (введите отношение happy с  одним параметром).
%% б)	Для всех X, если X имеет ребенка, имеющего сестру или брата, то X имеет двоих детей (введите новое отношение hastwochildren).
%% 
%% Задание 4:
%% Определите отношение grandchild с использованием отношения parent. 
%%
%% Задание 5:
%% Определите отношение aunt ( X, Y) в терминах отношений parent и sister. 

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

