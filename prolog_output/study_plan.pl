%%%%% Study Plan %%%%%
 :- discontiguous course/1.
 :- discontiguous course/8.
 :- discontiguous course_req/2.
 %%%%%%%%%%%%%%%%%%%%%%

 path(X,Y):- course_req(X,Y).
 path(X,Y):- course_req(X,Z), path(Z,Y).

 get_all_requirements(C, L):- get_all_reqs(C,L), nl, forall( member(R, L), format('~q ~q ~q ~n',R)), nl.

 reqs(C, R):- findall(X, path(C, X), L), sort(L, L2), member(R, L2).
 get_all_reqs(C, L):-
 	findall(
 	[R, D, T],
 	(reqs(C,R), course(R,_,_,_,_,A,P, D),atomic_list_concat([A, P],"_",T)),
 L).

 get_all_leaves(L):- all_leaves(L), nl, forall( member(H,L), format('~q ~q ~n',H)), nl.

 leave(X):- \+ course_req(_,X).
 all_leaves(L):- 
 findall(
 	[X,D],
 	(course(X), leave(X), course(X,_,_,_,_,_,_, D)),
 L).

 %%%%%%%%%%%%%%%%%%%%%%
% --- 'EIF200' ---
course('EIF200').
course('EIF200', 1, regular, dipl, 3, 'I', 'I', 'Fundamentos de Informática' ).
course_req('EIF200', 'Admission').
% --- 'MAY230' ---
course('MAY230').
course('MAY230', 2, regular, dipl, 4, 'I', 'I', 'Matemática para Informática I' ).
course_req('MAY230', 'Admission').
% --- 'EstudiosGeneralesI' ---
course('EstudiosGeneralesI').
course('EstudiosGeneralesI', 3, regular, dipl, 3, 'I', 'I', 'Estudios Generales I' ).
course_req('EstudiosGeneralesI', 'Admission').
% --- 'EstudiosGeneralesII' ---
course('EstudiosGeneralesII').
course('EstudiosGeneralesII', 4, regular, dipl, 3, 'I', 'I', 'Estudios Generales II' ).
course_req('EstudiosGeneralesII', 'Admission').
% --- 'LIX410' ---
course('LIX410').
course('LIX410', 5, regular, dipl, 4, 'I', 'I', 'Inglés Integrado I' ).
course_req('LIX410', 'Admission').
% --- 'EIF201' ---
course('EIF201').
course('EIF201', 6, regular, dipl, 4, 'I', 'II', 'Programación I' ).
course_req('EIF201', 'EIF200').
course_req('EIF201', 'MAY230').
% --- 'MAY231' ---
course('MAY231').
course('MAY231', 7, regular, dipl, 4, 'I', 'II', 'Matemática para Informática II' ).
course_req('MAY231', 'MAY230').
% --- 'EstudiosGeneralesIII' ---
course('EstudiosGeneralesIII').
course('EstudiosGeneralesIII', 8, regular, dipl, 3, 'I', 'II', 'Estudios Generales III' ).
course_req('EstudiosGeneralesIII', 'Admission').
% --- 'EstudiosGeneralesIV' ---
course('EstudiosGeneralesIV').
course('EstudiosGeneralesIV', 9, regular, dipl, 3, 'I', 'II', 'Estudios Generales IV' ).
course_req('EstudiosGeneralesIV', 'Admission').
% --- 'LIX411' ---
course('LIX411').
course('LIX411', 10, regular, dipl, 4, 'I', 'II', 'Inglés Integrado II' ).
course_req('LIX411', 'LIX410').
% --- 'EIF204' ---
course('EIF204').
course('EIF204', 11, regular, dipl, 4, 'II', 'I', 'Programación II' ).
course_req('EIF204', 'EIF201').
% --- 'MAY232' ---
course('MAY232').
course('MAY232', 12, regular, dipl, 4, 'II', 'I', 'Matemática para Informática III' ).
course_req('MAY232', 'MAY231').
% --- 'EIF202' ---
course('EIF202').
course('EIF202', 13, regular, dipl, 3, 'II', 'I', 'Soporte Técnico' ).
course_req('EIF202', 'EIF200').
% --- 'EIF203' ---
course('EIF203').
course('EIF203', 14, regular, dipl, 3, 'II', 'I', 'Estructuras Discretas para Informática' ).
course_req('EIF203', 'EIF200').
course_req('EIF203', 'MAY230').
% --- 'LIX412' ---
course('LIX412').
course('LIX412', 15, regular, dipl, 4, 'II', 'I', 'Inglés Integrado III' ).
course_req('LIX412', 'LIX411').
% --- 'EIF206' ---
course('EIF206').
course('EIF206', 16, regular, dipl, 4, 'II', 'II', 'Programación III' ).
course_req('EIF206', 'EIF204').
course_req('EIF206', 'MAY231').
% --- 'EIF207' ---
course('EIF207').
course('EIF207', 17, regular, dipl, 4, 'II', 'II', 'Estructuras de Datos' ).
course_req('EIF207', 'EIF203').
course_req('EIF207', 'EIF204').
% --- 'EIF205' ---
course('EIF205').
course('EIF205', 18, regular, dipl, 3, 'II', 'II', 'Arquitectura de Computadoras' ).
course_req('EIF205', 'EIF201').
course_req('EIF205', 'EIF202').
% --- 'EIF404' ---
course('EIF404').
course('EIF404', 19, regular, dipl, 3, 'II', 'II', 'La Organización y su Entorno' ).
course_req('EIF404', 'EIF201').
% --- 'MAY223' ---
course('MAY223').
course('MAY223', 20, regular, dipl, 3, 'II', 'II', 'Probabilidad y Estadística para Informática' ).
course_req('MAY223', 'MAY231').
course_req('MAY223', 'EIF203').
% --- 'EIF209' ---
course('EIF209').
course('EIF209', 21, regular, dipl, 4, 'III', 'I', 'Programación IV' ).
course_req('EIF209', 'EIF206').
% --- 'EIF210' ---
course('EIF210').
course('EIF210', 22, regular, dipl, 4, 'III', 'I', 'Ingeniería de Sistemas  I' ).
course_req('EIF210', 'EIF206').
% --- 'EIF211' ---
course('EIF211').
course('EIF211', 23, regular, dipl, 4, 'III', 'I', 'Diseño e Implementación de Bases de Datos' ).
course_req('EIF211', 'EIF206').
course_req('EIF211', 'EIF207').
% --- 'EIF212' ---
course('EIF212').
course('EIF212', 24, regular, dipl, 3, 'III', 'I', 'Sistemas Operativos' ).
course_req('EIF212', 'EIF204').
course_req('EIF212', 'EIF205').
% --- 'EIF208' ---
course('EIF208').
course('EIF208', 25, regular, dipl, 3, 'III', 'I', 'Comunicaciones y Redes de Computadores' ).
course_req('EIF208', 'EIF205').
% --- 'EIF400' ---
course('EIF400').
course('EIF400', 26, regular, bsc, 4, 'III', 'II', 'Paradigmas de Programación' ).
course_req('EIF400', 'EIF206').
% --- 'EIF401' ---
course('EIF401').
course('EIF401', 27, regular, bsc, 4, 'III', 'II', 'Ingeniería de Sistemas II' ).
course_req('EIF401', 'EIF210').
% --- 'EIF402' ---
course('EIF402').
course('EIF402', 28, regular, bsc, 4, 'III', 'II', 'Administración de Bases de Datos' ).
course_req('EIF402', 'EIF212').
course_req('EIF402', 'EIF211').
% --- 'EIF405' ---
course('EIF405').
course('EIF405', 29, regular, bsc, 3, 'III', 'II', 'Investigación de Operaciones y sus Aplicaciones' ).
course_req('EIF405', 'MAY232').
course_req('EIF405', 'MAY223').
% --- 'EIF407' ---
course('EIF407').
course('EIF407', 30, regular, bsc, 3, 'III', 'II', 'Liderazgo y Organización ' ).
course_req('EIF407', 'EIF404').
% --- 'EIFXXX' ---
course('EIFXXX').
course('EIFXXX', 31, regular, bsc, 4, 'IV', 'I', 'Diseño y programación de plataformas Móviles' ).
course_req('EIFXXX', 'EIF209').
course_req('EIFXXX', 'EIF428O').
% --- 'EIF406' ---
course('EIF406').
course('EIF406', 32, regular, bsc, 4, 'IV', 'I', 'Ingeniería de Sistemas III' ).
course_req('EIF406', 'EIF401').
% --- 'OptativaI' ---
course('OptativaI').
course('OptativaI', 33, generic, bsc, 3, 'IV', 'I', 'Optativa ' ).
course_req('OptativaI', 'Admission').
% --- 'OptativaII' ---
course('OptativaII').
course('OptativaII', 34, generic, bsc, 3, 'IV', 'I', 'Optativa ' ).
course_req('OptativaII', 'Admission').
% --- 'EIF403' ---
course('EIF403').
course('EIF403', 35, regular, bsc, 3, 'IV', 'I', 'Métodos de Investigación Científica en Informática' ).
course_req('EIF403', 'MAY223').
% --- 'EIF408' ---
course('EIF408').
course('EIF408', 36, regular, bsc, 5, 'IV', 'II', 'Proyectos y su Aplicación en la Organización (PPS)' ).
course_req('EIF408', 'EIF209').
course_req('EIF408', 'EIF401').
course_req('EIF408', 'EIF402').
% --- 'EIF409' ---
course('EIF409').
course('EIF409', 37, regular, bsc, 4, 'IV', 'II', 'Aplicaciones Informáticas Globales' ).
course_req('EIF409', 'EIF209').
course_req('EIF409', 'EIF401').
course_req('EIF409', 'EIF402').
% --- 'OptativaIII' ---
course('OptativaIII').
course('OptativaIII', 38, generic, bsc, 3, 'IV', 'II', 'Optativa ' ).
course_req('OptativaIII', 'Admission').
% --- 'OptativaIV' ---
course('OptativaIV').
course('OptativaIV', 39, generic, bsc, 3, 'IV', 'II', 'Optativa ' ).
course_req('OptativaIV', 'Admission').
% --- 'EIF410' ---
course('EIF410').
course('EIF410', 40, regular, bsc, 2, 'IV', 'II', 'Informática y Sociedad' ).
course_req('EIF410', 'EIF401').
% --- 'EIF100O' ---
course('EIF100O').
course('EIF100O', 41, optional, bsc, 3, '_', '_', 'Dispositivos para comunicaciones de Datos' ).
course_req('EIF100O', 'EIF208').
% --- 'EIF420O' ---
course('EIF420O').
course('EIF420O', 42, optional, bsc, 3, '_', '_', 'Inteligencia Artificial' ).
course_req('EIF420O', 'EIF207').
% --- 'EIF421O' ---
course('EIF421O').
course('EIF421O', 43, optional, bsc, 3, '_', '_', 'Análisis de Algoritmos' ).
course_req('EIF421O', 'EIF207').
course_req('EIF421O', 'MAY231').
% --- 'EIF422O' ---
course('EIF422O').
course('EIF422O', 44, optional, bsc, 3, '_', '_', 'Diseño de Interfaces de usuario' ).
course_req('EIF422O', 'EIF206').
% --- 'EIF424O' ---
course('EIF424O').
course('EIF424O', 45, optional, bsc, 3, '_', '_', 'Desarrollo de Aplicaciones Educativas' ).
course_req('EIF424O', 'EIF204').
course_req('EIF424O', 'EIF206').
% --- 'EIF425O' ---
course('EIF425O').
course('EIF425O', 46, optional, bsc, 3, '_', '_', 'Diseño de Ambientes Multimediales' ).
course_req('EIF425O', 'Admission').
% --- 'EIF426O' ---
course('EIF426O').
course('EIF426O', 47, optional, bsc, 3, '_', '_', 'Diseño de Ambientes de Aprendizaje' ).
course_req('EIF426O', 'Admission').
% --- 'EIF427O' ---
course('EIF427O').
course('EIF427O', 48, optional, bsc, 3, '_', '_', 'Robótica' ).
course_req('EIF427O', 'EIF204').
% --- 'EIF428O' ---
course('EIF428O').
course('EIF428O', 49, optional, bsc, 3, '_', '_', 'Fundamentos de Programación Web' ).
course_req('EIF428O', 'EIF206').
course_req('EIF428O', 'EIF211').
% --- 'EIF431O' ---
course('EIF431O').
course('EIF431O', 50, optional, bsc, 3, '_', '_', 'Administración de servidores basados en software libre' ).
course_req('EIF431O', 'EIF212').
course_req('EIF431O', 'EIF402').
% --- 'EIF433O' ---
course('EIF433O').
course('EIF433O', 51, optional, bsc, 3, '_', '_', 'Contexto, Desarrollo y Aplicación de Software Libre y de código abierto' ).
course_req('EIF433O', 'EIF212').
course_req('EIF433O', 'EIF211').
% --- 'EIF434O' ---
course('EIF434O').
course('EIF434O', 52, optional, bsc, 3, '_', '_', 'Minería de Datos I' ).
course_req('EIF434O', 'EIF402').
course_req('EIF434O', 'MAY223').
% --- 'EIF435O' ---
course('EIF435O').
course('EIF435O', 53, optional, bsc, 3, '_', '_', 'Minería de Datos II' ).
course_req('EIF435O', 'EIF434O').
% --- 'EIG416O' ---
course('EIG416O').
course('EIG416O', 54, optional, bsc, 3, '_', '_', 'Gestión de Tecnología Educativa' ).
course_req('EIG416O', 'EIF425O').
% --- 'EIF429O' ---
course('EIF429O').
course('EIF429O', 55, optional, bsc, 3, '_', '_', 'Introducción a la creación de Empresas' ).
course_req('EIF429O', 'Admission').
% --- 'EIF430O' ---
course('EIF430O').
course('EIF430O', 56, optional, bsc, 3, '_', '_', 'Las TIC’s en el Ámbito Jurídico de Costa Rica' ).
course_req('EIF430O', 'Admission').
% --- 'EIG417O' ---
course('EIG417O').
course('EIG417O', 57, optional, bsc, 3, '_', '_', 'Liderazgo y organizaciones' ).
course_req('EIG417O', 'Admission').
% --- 'EIG418O' ---
course('EIG418O').
course('EIG418O', 58, optional, bsc, 3, '_', '_', 'La organización y su entorno' ).
course_req('EIG418O', 'Admission').
