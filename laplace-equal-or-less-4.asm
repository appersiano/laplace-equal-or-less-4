######_PROGETTO ARCHITETTURA DEGLI ELABORATORI II CALCOLO DEL DETERMINANTE DI UNA MATRICE DI ORDINE <=4 UTILIZZANDO IL TEOREMA DI LAPLACE_######
.data
intro: .asciiz "Calcolo della determinante di una matrice di ordine <= 4 con il teorema di Laplace"
arrivederci: .asciiz "\n\nUscita \nCreato da Alessandro Persiano"

ordine_matrice: .asciiz "\nInserisci l'ordine della matrice (max 4): "
riga_n: .asciiz "\nRiga numero "
acapo: .asciiz "\n"
infreccia: .asciiz "= "
init_m: .asciiz "m["
fine_m_zero: .asciiz "][0]"
sottomat: .asciiz "\n\nEstrazione sottomatrice rispetto l'elemento in posizione: "
caporiga: .asciiz "\nNumero caporiga: "
complemento_algebrico: .asciiz "\nComplemento algebrico: "
det: .asciiz "\n\nIl determinate della matrice e': "

.align 2
matrice: .space 64
sottomatrice: .space 36
.text
.globl main

main:
	li $v0,4			#Seleziono il print_string
	la $a0,intro			#$a0 contiene l'indirizzo di intro
	syscall				#lancio print_string 
	
	#POPOLAMENTO MATRICE
	jal popola_matrice		#jump and link alla procedura popola matrice
	move $s0, $v0			#sposto il contenuto di $v0,contenente l'ordine della matrice, in $s0 
	move $s1, $v1			#sposto il contenuto di $v1,contenente l'indirizzo della matrice, in $s1

	#CALCOLO DETERMINANTE DELLA MATRICE
	move $a0, $s0			#sposto il contenuto di $s0,contenente l'ordine della matrice, in $a0 
	move $a1, $s1			#sposto il contenuto di $s1,contenente l'ordine della matrice, in $a1 
	jal laplace			#jump and link alla procedura laplace
	move $t0,$v0			#sposto il contenuto di $v0,contenente il determinante della matrice, in $t0
					
	
	#STAMPA DEL DETERMINANTE DELLA MATRICE
	li $v0,4			#Seleziono il print_string
	la $a0,det			#$a0 contiene l'indirizzo di det
	syscall				#lancio print_string
	
	li $v0,1			#Seleziono il print_string
	move $a0,$t0			# $a0 = $t0
 	syscall				#lancio print_int
		
	#EXIT					
	li $v0,4			#Seleziono il print_string
	la $a0,arrivederci		#$a0 contiene l'indirizzo di arrivederci
	syscall

	li $v0,10			#Seleziono l' exit (termina esecuzione)
	syscall				#lancio exit (termina esecuzione)

		
### INIZIO PROCEDURA POPOLAMENTO MATRICE
popola_matrice:
	la $a1,matrice			#carico in $a1 l'indirizzo di memoria per salvare la matrice
	move $t1,$a1			#$t1 = $a1
	
	chiedi_ordine:
	li $v0,4			#Seleziono il print_string
	la $a0,ordine_matrice		#$a0 contiene l'indirizzo di ordine_matrice
	syscall

	li $v0,5			#5 read int chiedo l'ordine della matrice
	syscall				#lancio print_int
	
					#if ($v0 > 4 OR $v0 <= 4) ? goto(chiedi_ordine) : pc+4 
	bgt $v0,4,chiedi_ordine		#if ($v0 > 4)? goto(chiedi_ordine) : pc+4
	ble $v0,0,chiedi_ordine		#if ($v0 <= 4)? goto(chiedi_ordine) : pc+4
						
	move $t0,$v0			#sposto l'ordine della matrice nella registro $t0
	
	li $t3,0 			#inizializzo $t3 ; contatore first_for
	for_riga:
	beq $t3,$t0,end_for_riga	#Se counter = ordine matrice ? goto(end_first_for) : pc+4
		
	li $v0,4			#Seleziono il print_string
	la $a0,riga_n			#$a0 contiene l'indirizzo di riga_n
	syscall 			#lancio print_string
	
	li $v0,1			#Seleziono il print_int
	move $a0,$t3			#$a0 = $t3(contatore)
	syscall				#Lancio print_int
	
	li $v0,4			#Seleziono il print_string
	la $a0,acapo			#$a0 contiene l'indirizzo di acapo
	syscall 			#Lancio print_string
	
	li $t4,0 			#inizializzo $t4 ; (contatore for_colonna)
	for_colonna:
	beq $t4,$t0,end_for_colonna	#if ($t4 = $t0)? goto(end_for_colonna) : pc+4
	
	li $v0,4			#Seleziono il print_string
	la $a0,init_m			#$a0 contiene l'indirizzo di init_m
	syscall 			#lancio print_string
	
	li $v0,1			#Seleziono il print_int
	move $a0,$t3			#$a0 = $t3 
	syscall				#Lancio il print_int
	
	li $v0,11			#Seleziono il print_char
	li $a0,']'			#$a0 contiene il carattere ']'
	syscall 			#lancio print_char
	
	li $v0,11			#Seleziono il print_char
	li $a0,'['			#$a0 contiene il carattere '['
	syscall				#Lancio il print_char
		
	li $v0,1			#Seleziono il print_int
	move $a0,$t4			#$a0 = $t4 ; 
	syscall				#Lancio il print_int
	
	li $v0,11			#Seleziono il print_char
	li $a0,']'			#$a0 contiene il carattere ']'
	syscall				#Lancio il print_char
	
	li $v0,4			#Seleziono il print_string
	la $a0,infreccia		#$a0 contiene l'indirizzo di infreccia
	syscall				#Lancio il print_string
	 
	li $v0,5			#Selezione il read_int
	syscall				#Lancio il read_int
			
	sw $v0,0($t1)			#Salvo $vo in $t1 ; Aggiungo il numero acquisito al matrice 
	add $t1,$t1,4			#Aggiorno il puntatore della matrice spostandomi di +4 byte elemento [i]+1
	add $t4,$t4,1			#$t4++ ; Incremento il contatore di +1
	j for_colonna
	end_for_colonna:
	
	add $t3,$t3,1			#Incrementro contatore $t3++
	j for_riga
	end_for_riga:

end_popola_matrice:
	
	move $v0,$t0			#$v0 = ordine matrice
	move $v1,$a1			#$v1 = indirizzo matrice
	jr $ra				#Jump register return address
### FINE PROCEDURA POPOLAMENTO MATRICE


## INIZIO PROCEDURA LAPLACE
laplace:
	addi $sp,$sp,-4			#abbasso lo stack di una word
	sw $ra,0($sp)			#salvo il return address
		
	beq $a0,4,caso_quattro		#if ($a = 4)? goto(caso_quattro) : pc+4
	
	beq $a0,3,caso_base_tre		#if ($v0 = 3)? goto(caso_base_tre) : pc+4
	
	beq $a0,2,caso_base_due		#if ($v0 = 2)? goto(caso_base_due) : pc+4
	
caso_base_uno: 				#ordine matrice = 1	 	 		
	lw $t0,0($a1)			#Carico l'elemento m[0][0]
	move $v0,$t0			#$v0 = $t0 ; 
	j fine				#goto(fine)
	
caso_base_due: 				#ordine matrice = 2
					#determinante = m[0][0]*m[1][1]-m[0][1]*m[1][0];
  	lw $t0,0($a1)			#$t0 = m[0][0]	
 	lw $t1,4($a1)			#$t1 = m[0][1]
	lw $t2,8($a1)			#$t2 = m[1][0]	
 	lw $t3,12($a1)			#$t3 = m[1][1]
 	
 	mul $t4,$t0,$t3			# $t4 = $t0 * $t3 ; $t4 = m[0][0]*m[1][1]
 	mul $t5,$t1,$t2			# $t5 = $t0 * $t3 ; $t5 = m[0][1]*m[1][0]
 	sub $t0,$t4,$t5			# $t0 = $t4 - $t5
 				
	move $v0,$t0			#$v0 = $t0 ; $t0 = determinante calcolato
	j fine				#goto(fine)
		
caso_base_tre: 				#ordine matrice = 3 Utilizzo la regola di Sarrus!
	 				#determinante = m[0][0]*m[1][1]*m[2][2]+
				 	#		m[0][1]*m[1][2]*m[2][0]+
				 	#		m[0][2]*m[1][0]*m[2][1]-
				 	#		m[2][0]*m[1][1]*m[0][2]-
				 	#		m[2][1]*m[1][2]*m[0][0]-
				 	#		m[2][2]*m[1][0]*m[0][1]
 	
 	addi $sp,$sp,-60		#abbasso lo stack di 16 word
	sw $t0,0($sp)			#salvataggio registri nello stack pointer
	sw $t1,4($sp)
	sw $t2,8($sp)
	sw $t3,12($sp)
	sw $t4,16($sp)
	sw $t5,20($sp)
	sw $t6,24($sp)
	sw $t7,28($sp)
	sw $t8,32($sp)
	sw $s0,36($sp)
	sw $s1,40($sp)
	sw $s2,44($sp)
	sw $s3,48($sp)
	sw $s4,52($sp)
	sw $s5,56($sp)
				
	lw $t0,0($a1)			#$t0 = m[0][0]
	lw $t1,4($a1)			#$t1 = m[0][1]
	lw $t2,8($a1)			#$t2 = m[0][2]
	lw $t3,12($a1)			#$t3 = m[1][0]
	lw $t4,16($a1)			#$t4 = m[1][1]
	lw $t5,20($a1)			#$t5 = m[1][2]		
	lw $t6,24($a1)			#$t6 = m[2][0]
	lw $t7,28($a1)			#$t7 = m[2][1]
	lw $t8,32($a1)			#$t8 = m[2][2]
	 	
	mul $s0,$t0,$t4			#$s0 = m[0][0]*m[1][1]
	mul $s0,$s0,$t8 		#$s0 = $s0 * m[2][2]
		
	mul $s1,$t1,$t5			#$s1 = m[0][1]*m[1][2]
 	mul $s1,$s1,$t6 		#$s1 = $s1 * m[2][0]
	 	
 	mul $s2,$t2,$t3			#$s2 = m[0][2]*m[1][0]
 	mul $s2,$s2,$t7 		#$s2 = $s2 * m[2][1]
 	
 	mul $s3,$t6,$t4			#$s3 = m[2][0]*m[1][1]
 	mul $s3,$s3,$t2 		#$s3 = $s3 * m[0][2]
 	
 	mul $s4,$t7,$t5			#$s4 = m[2][1]*m[1][2]
 	mul $s4,$s4,$t0 		#$s4 = $s5 * m[0][0]
		
 	mul $s5,$t8,$t3			#$s5 = m[2][2]*m[1][0]
 	mul $s5,$s5,$t1 		#$s5 = $s5 * m[0][1]
		
 	add $s0,$s0,$s1			#$s0 = $s0 + $s1
 	add $s0,$s0,$s2 		#$s0 = $s0 + $s2
	 
 	add $s3,$s3,$s4			#$s3 = $s3 + $s4
 	add $s3,$s3,$s5			#$s3 = $s3 + $s5
		
 	sub $t0,$s0,$s3 		#$t0 = $s0 - $s3

	move $v0,$t0			#$v0 = $t0 ; metto in $v0 il determinante che si trovava in $t0
	
	#ripristino i registri	
	lw $t0,0($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	lw $t3,12($sp)
	lw $t4,16($sp)
	lw $t5,20($sp)
	lw $t6,24($sp)
	lw $t7,28($sp)
	lw $t8,32($sp)
	lw $s0,36($sp)
	lw $s1,40($sp)
	lw $s2,44($sp)
	lw $s3,48($sp)
	lw $s4,52($sp)
	lw $s5,56($sp)
	add $sp,$sp,60			#rialzo lo stack pointer di 64 byte
	j fine				#goto(fine)

caso_quattro: 				#cardinalità = 4
		  							
	mul $s0,$a0,$a0			#$s0 = $a0*$a0 ; ottieni il numero totale di elementi della matrice
	mul $s1,$s0,4			#$s1 = $s0*4 ; ottieni ultimo indirizzo
	move $s2,$a0			#$s2 = ordine matrice ; es. 3 (mat 3*3)
	mul $s3,$a0,4			#scarto riga ; es mat(3x3) ogni 12 byte abbiamo il primo elemento della riga
	move $s4,$a1	 		#indirizzo matrice principale
	la $s6,sottomatrice		#carico in $s6 l'indirizzo della sottomatrice																						###############################################################
		
	li $t0,0				# inizializzo il contatore $t0 ; ciclo for ($t0=0;$t0<ultimo_indirizzo_matrice;$t0++)	
	for_primo_el_colonna:
	beq $t0,$s1,end_for_primo_el_colonna	#if ($t0 = $s1) ? goto(end_for_primo_el_colonna) : pc+4
	
	move $s5,$s6			# $s5 = $s6 ; sposto l'indirizzo della sottomatrice in $s5
	
	li $v0,4			#Seleziono il print_string
	la $a0,sottomat			#$a0 contiene l'indirizzo di sottomatrice
	syscall 			#Lancio il print_string

	li $v0,4			#Seleziono il print_string
	la $a0,init_m			#$a0 contiene l'indirizzo di sottomatrice
	syscall 			#Lancio il print_string
	
	li $v0,1			#Seleziono il print_int
	div $a0,$t0,$s3			#$a0 = $t0
	syscall				#Lancio il print_it
	
	li $v0,4			#Seleziono il print_int
	la $a0,fine_m_zero		#$a0 = $t0
	syscall
	
	li $v0,4			#Seleziono il print_string
	la $a0,acapo			#$a0 contiene l'indirizzo di acapo
	syscall 			#Lancio il print_string
	
	#### scorro l'intera matrice per riga
	li $t1,0			#inizialiazzo il contatore $t1
	add $t3,$t0,$s3
	for_item:			#equivalente foreach scorro tutti gli elementi della matrice
	beq $t1,$s1,end_for_item	#se $t1 è uguale all'ultimo elemento vai alla fine
	
	##Calcolo range riga da evitare
	# abbiamo $t0 = indice primo el riga. ; $t1 = elemento; $t3 primo elemento successivo della riga
	
	# controllo se l'elemento è nella prima colonna della matrice m[?][0]
	div $t1,$s3  			#divido elemento per lo scarto riga, se il resto è uguale a 0 vuol dire che è un elemento della prima colonna
	mfhi $t6			#$t6 = reminder
	
	beq $t6,0,jfine			#if ($t6 = 0) ? goto(jfine) : pc + 4
	
	####  if($t1 < $t0 AND $t1 >= $t3)? aggiungi alla sottomatrice : salta
	li $t6,0			#inizializzo $t0
	
	blt $t1,$t0,avanti		#if ($t1 < $t0) ? goto(avanti) : pc+4
	j maggiore 
	avanti:
	li $t6,1			#Flag $t6=1
	j as
	
	maggiore:
	bge $t1,$t3,s_avanti		#if ($t1 >= $t0) ? goto(s_avanti) : pc+4
	j as
	s_avanti:
	li $t6,1			#Flag $t6=1
	as:
		
	bne $t6,1,jfine			#if ($t6 != 1) ? goto(jfine) : pc+4
	
	#carico in sottomatrice $t1=offset numero $s4 = indirizzo matrice principale
	
	add $s4,$t1,$s4			#$s4 = $s4 + $t1 ; indirizzo matrice principale + offset
	lw $t4,0($s4)			#$t4 = carico il contenuto della matrice all'indirizzo base + offset calcolato
	sub $s4,$s4,$t1			#ripristino $s4 all'inizio dell'indirizzo della matric
	
	sw $t4,0($s5)			#Salvo $t4 nella sottomatrice
	addi $s5,$s5,4			#e mi sposto di 4 byte 
	
	li $v0,1			#Seleziono il print_int
	move $a0,$t4			#$a0 = $t4
	syscall				#Lancio il print_int
		
	li $v0,11			#Seleziono il print_char
	li $a0,' '			#$a0 contiene il carattere ' ' (è uno spazio)
	syscall 			#Lancio il print_char
			
	#fine carico in sottomatrice
	
	jfine:
			
	#### fine calcolo range
							
	addi $t1,$t1,4			# $t1 = $t1 + 4
	j for_item			#goto (for_item)
	end_for_item:	
	# fine stampa array
			
	#organizziamoci e iniziamo la ricorsione		
	add $a0,$s2,-1			#Ordine sottomatrice = ordine_matrice-1
	move $a1,$s6			#$a1 = $s6
	jal laplace			#Chiamata ricorsiva Jump And Link Laplace
	move $t9,$v0			#$t9 = $v0 (al ritorno della chiamata ricorsiva $v0 contiene il determinante della sottomatrice calcolato)
	
	#procediamo al calcolo del complemento algebrico	
	add $t8,$s4,$t0			#$t8 = $s4 + $t0 / offset = indirizzo_matrice + $t0
	lw $t8,0($t8)			#$t8 = $t8 + offset
	
	#stampa numero caporiga
	li $v0,4			#Seleziono il print_string
	la $a0,caporiga			#$a0 contiene l'indirizzo di caporiga
	syscall 			#Lancio print string
	
	li $v0,1			#Seleziono print_int
	move $a0,$t8			#$a0 contiene $t8 (caporiga)	
	syscall				#Lancio print_int
	#
	
	mul $t9,$t9,$t8			#$t9 = $t9 * $t8 ; caporiga * determinante sottomatrice

	#se l'indice riga è pari allora moltiplica per 1 altrimenti -1
	div $t8,$t0,$s3 		#$t8 = $t0 / $s3 ; calcolo indice riga
	li $t6,2			#$t6 = 1
	div $t8,$t6			# $t8/$t6
	mfhi $t8			# $t8 = reminder
	bne $t8,0,menouno		# if ($t8 != 0) ? goto(menouno) : pc+4
	#mul $t9,$t9,1 			#inutile moltiplicare per uno! il risultato non cambia risparmio un istruzione
	j enduno			#goto(enduno)
	menouno:
	mul $t9,$t9,-1			#$t9 = $t9 * -1
	enduno:
			
	## Stampa complemento algebrico
	li $v0,4			#Seleziono il print_string
	la $a0,complemento_algebrico	#$a0 contiene l'indirizzo di complemento_algebrico
	syscall 			#Lancio il print_string
	
	li $v0,1			#Seleziono il print_int
	move $a0,$t9			#$a0 = $t9 ; $t9 contiene il complemento algebrico 
	syscall				#Lancio print_int
		
	add $s7,$s7,$t9			#$s7 accumulatore determinanti!	
	add $v0,$zero,$s7		#$v0 = $s7 ; imposto il parametro in uscita
		  
	add $t0,$t0,$s3			#$t0 = $t0 + $s3;																			
	j for_primo_el_colonna	#goto (for_primo_el_colonna)
	end_for_primo_el_colonna:																						
					
	fine:
		
	lw $ra,0($sp)			#Recupero il return address dallo stack pointer
	add $sp,$sp,4			#Alzo lo stack pointer di 4 byte
	jr $ra				#Jump register return adress
## FINE PROCEDURA LAPLACE
