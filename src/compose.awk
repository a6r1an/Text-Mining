#
# Composes records from the (slightly edited) study plan text version
# input/study_plan.txt --> compose_output/composed_plan.txt
#
# Expected output record format generated by compose
# nn::code::description::credits[2345](::req)*::(bsc|dipl)::(nivel|_)::(ciclo|_)
# req ~ EI(F|G)...O? | LIX...
#
# To run
# awk -f compose.awk input/study_plan.txt > compose_output/composed_plan.txt

# 1) Nombre: ANDRES GUTIERREZ ARCIA ID:402310453 correo: andres.gutierrez.arcia@gmail.com HORARIO: 01 pm
# 2) Nombre: ADRIAN PRENDAS ARAYA ID:604140420 correo: a6r2an@gmail.com HORARIO: 01 pm
# 3) Nombre: CARLOS MURILLO BADILLA ID:402360192 correo: cmb2897@gmail.com HORARIO: 01 pm
# 4) Nombre: JOAQUÍN ALEJANDRO SÁNCHEZ BARBOZA ID:114160575 correo: j.alejandro.1290@gmail.com HORARIO: 01 pm
#


BEGIN { 
	RS = "\r\n\r\n"  # Record separator
	FS = "\r\n"      # Field separator
	OFS = "::" 		 # Output field separator
	nn = 1
	grado = "dipl"
	nivel = ""
	ciclo = ""
}

/Nivel/{
	split($0, arr, " ") 	# [1]="I"  [2]="Ciclo || Nivel"
	nivel = arr[1]  	
	opt[i++] = arr[1]   # Uso ese array con {I,II,III,IV} para las optativas
}

/Ciclo/{
	split($0, arr, " ") 	# [1]="I"  [2]="Ciclo/Nivel"
	ciclo = arr[1]
}

/^DIPLOMADO/{ # after dipl -> bsc
	grado = "bsc" 
}

/^BACHILLERATO/{
	ciclo = nivel = "_"
}

/^(EIF|EIG|MAY|LIX|Optativa|Estudios)/{

	if($0 ~ /Estudios/ || /Optativa/){	# No cuenta con NRC, hay que invertir valores.
		$4 = "Admission"
		$3 = $2
		$2 = $1
		
			if($0 ~ /Optativa/){
				$1 = $1opt[cont++] # Guardo los niveles y luego los reutilizo como numerax para Optativa
			}
	}
	 
	 gsub(" ", "", $1);
	 
	if($1 == "EIFXXX"){	# Caso especial EIFXXX.
		gsub(" ", "", $5);
	}
	 
	if($1 ~ /EI(F|G)[0-9][0-9][0-9]O/){	#Optativas Generales y Optativas Disciplinarias.
	
		if(NF == 2){	# Optativa no tiene Requisitos.
			$4 = "Admission"
		}
		
		else if(NF >= 3){ # Optativa tiene 1 o más requisitos

			requisito1 = $3 # $3 será los créditos, por el momento es un requisito.
			
			gsub(" ", "", requisito1) #Se juntan todas las palabras del primer requisito.
			
			if(NF == 4){	# Optativa cuenta con 2 requisitos
				requisito2 = $4
				gsub(" ", "", requisito2)
				$5 = substr(requisito2, 1, 6)
				
			}
			
			if($1 == "EIG416O"){ # Caso especial
				$4 = substr(requisito1, 9, 7)
			}
			
			else if(requisito1 ~ /EIF\s*[0-9]{3}/){		# Caso especial
				$4 = substr(requisito1, 1 , ($1 == "EIF435O")? 7 : 6);
			}
			
		}
		
		$3 = 3 # Se asignan 3 créditos a las Optativas.
		
	}
	 
	 gsub("-", "", $0)	# Elimina los "-" de cursos de inglés.
	 
	 gsub("\r\n", "::", $0)	# Cambia la separación de los cambios de línea "\n" a "::"
	 
	 gsub("Ingreso a Carrera", "Admission", $0)

	print nn++, $0, grado, nivel, ciclo			
}
