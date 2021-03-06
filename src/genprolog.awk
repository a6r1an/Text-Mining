# @id: 604140420 																					#
# @author: Adrian Prendas Araya																		#
# @email: a6r2an@gmail.com 																			#
#####################################################################################################
# Generates prolog file from compose.awk output 													#
# compose_output/composed_plan.txt --> prolog_output/study_plan.pl 									#
# To run 																							#
# awk -f ./src/genprolog.awk ./compose_output/composed_plan.txt > prolog_output/study_plan_adr.pl 	#
# Expected input record format generated by compose 												#
# nn::code::description::credits[2345](::req)*::(bsc|dipl)::(level|_)::(cycle|_)					#
# req ~ EI(F|G)...O? | LIX...																		#
#####################################################################################################
BEGIN{
	print "%%%%% Study Plan %%%%%\n",
		  ":- discontiguous course/1.\n",
	 	  ":- discontiguous course/8.\n",
	 	  ":- discontiguous course_req/2.\n",
		  "%%%%%%%%%%%%%%%%%%%%%%\n\n",

		  "path(X,Y):- course_req(X,Y).\n",
		  "path(X,Y):- course_req(X,Z), path(Z,Y).\n\n",

		  "get_all_requirements(C, L):- get_all_reqs(C,L), nl, forall( member(R, L), format('~q ~q ~q ~n',R)), nl.\n\n",

		  "reqs(C, R):- findall(X, path(C, X), L), sort(L, L2), member(R, L2).\n",
		  "get_all_reqs(C, L):-\n",
				"\tfindall(\n",
				"\t[R, D, T],\n",
				"\t(reqs(C,R), course(R,_,_,_,_,A,P, D),atomic_list_concat([A, P],\"_\",T)),\n",
		  "L).\n\n",

		  "get_all_leaves(L):- all_leaves(L), nl, forall( member(H,L), format('~q ~q ~n',H)), nl.\n\n",

		  "leave(X):- \\+ course_req(_,X).\n",
		  "all_leaves(L):- \n",
 		  "findall(\n",
 				"\t[X,D],\n",
 				"\t(course(X), leave(X), course(X,_,_,_,_,_,_, D)),\n",
 		  "L).\n\n",

		  "%%%%%%%%%%%%%%%%%%%%%%" 

	FS = "::" # Field separator
	RS = "\n" # Record separator

}

function parse(type){
	switch(type){
		case /^(EIF|EIG)[0-9]{3}O/: return "optional"
		case /^Optativa/: return "generic"
		case /^(EIF|LIX|MAY|EstudiosGenerales)/: return "regular"

	}
}

{
	# nn::code::description::credits[2345](::req)*::(bsc|dipl)::(level|_)::(cycle|_)
	type = parse($2)	

	printf "%% --- '%s' ---\n", $2 
	printf "course('%s').\n", $2 
	printf "course('%s', %s, %s, %s, %s, '%s', '%s', '%s' ).\n", $2, $1, type, $(NF-2), $4, $(NF-1), $NF, $3 

	if(NF>8){
		end = NF - 2
		start = 5
		for(i = start; i < end; i++){
			printf "course_req('%s', '%s').\n", $2, $i 
		}
	}else{
			printf "course_req('%s', '%s').\n", $2, $5 
	}
}

END{
	# code
	# code, nn, regular, dipl, credi, ciclo, nivel, nombre
	# code, req
}
