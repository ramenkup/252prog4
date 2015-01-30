# Your code goes below this line
.data
	counter: 
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
         
newLine: .asciiz "\n"

spacer: .asciiz":   "
 

.text	
main:

addiu	$sp,	$sp,	-24		# allocate stack space -- default of 24 here
sw	$fp,	0($sp)     		# save caller's frame pointer
sw    	$ra, 	4($sp)     		# save return address
addiu 	$fp, 	$sp,	20  		# setup main's frame pointer
        

la 	$t0, 	mainNumPhrases
lw	$s0,	0($t0)			# value of main numPhrases loaded to $s0

la 	$s5, 	counter 		# $S5 is EQUAL TO COUNTER ADRESS

la	$s1, 	mainPhrases		# $s1 reference to first mainPhrase
		
addi 	$s2, 	$zero,	0		# int phraseCounter=0

					# while(phraseCounter < Phrases.length){
phraseLoopStart:
slt	$t1,	$s2,	$s0		# check phraseCounter($s2) < numPhrases
beq	$t1,	$zero,	phraseLoopEnd	# if phraseCounter !< numPhrases, jump to phraseLoopEnd
sll	$t3,	$s2,	2		# shift (*4) the phrase counter
add 	$t3, 	$t3, 	$s1				
lw	$s4, 	0($t3)			#s4= current string base adress
addi $t1,$zero, 0 			#t1=n
			
					#char c= Phrases[phraseCounter].charAt(n);
add $t2, $t1, $s4
lb	$t2, 0($t2) 			#$t2=c
			
					#while(c != 0){
cLoopStart:
beq	$t2,	$zero,	cLoopEnd	#if(!(c < 65)
addi 	$t6,	$zero,	65 		#TEMP load into $t6, not needed past next line
slt  	$t5,	$t2,	$t6		#$t5 set to 1 0 zero also TEMP value
bne  	$t5,	$zero, 	elseJumper					
addi 	$t6,	$zero, 	91		#TEMP-if(c < 91)
slt  	$t5,	$t2,	$t6		#TEMP
bne  	$t5, 	$zero, 	counterPlusOne
j 	countJumper			#counter[c-65]+=1;
					
counterPlusOne:
addi	$t6,	$zero,	65 		#set $t6 to 65
sub  	$t5, 	$t2, 	$t6		# t5 TEMP
sll  	$t5, 	$t5, 	2
add 	$t6,  	$s5, 	$t5 
lw  	$t5, 	0($t6)
addi	$t5,	$t5,	1
sw	$t5,	0($t6)			#save 

countJumper:
			
elseJumper:				
addi	$t6, 	$zero,	97 		#TEMP load into $t6, not needed past next line
slt  	$t5, 	$t2, 	$t6		# $t5 set to 1 0 zero also TEMP value
bne  	$t5, 	$zero, 	innerElseJumper	#if(c < 122)
addi 	$t6, 	$zero, 	123		#TEMP
slt  	$t5, 	$t2,  	$t6		#TEMP
bne  	$t5, 	$zero, 	innerCounterPlusOne
j 	innerCountJumper		#counter[c-65]+=1;
					
innerCounterPlusOne:
addi 	$t6, 	$zero, 	97 		#set $t6 to 65
sub  	$t5, 	$t2, 	$t6		# t5 TEMP
sll  	$t5, 	$t5, 	2
add 	$t6,  	$s5, 	$t5 
lw  	$t5, 	0($t6)
addi 	$t5, 	$t5, 	1
sw  	$t5, 	0($t6) 			#save

innerCountJumper:
#else{ if(c >= 97 && c <= 122)

innerElseJumper:
addi	$t1,	$t1,	1		#c= Phrases[phraseCounter].charAt(n);
add	$t2,	$t1,	$s4
lb	$t2, 	0($t2) 			#$t2=c
j cLoopStart				#}

cLoopEnd:				#System.out.println(Phrases[phraseCounter]);
add 	$a0, 	$zero, 	$s4
addi 	$v0, 	$zero, 	4		#try 4 if not 1
syscall
la	$a0, 	newLine
addi 	$v0, 	$zero, 	4 		#plus 4 because of asciiz
syscall					#int z=0;
addi 	$t7, 	$zero, 	0 		#z= $t7
zWhile:
addi	$t6,	$zero,	26 		#TEMP $t6=26/while(z<26){
slt  	$t5, 	$t7, 	$t6
beq 	$t5, 	$zero, 	zWhileEnd	#int a=  z+97;
addi 	$t8, 	$t7, 	97 		#$t8=a=z+97
add 	$a0, 	$zero, 	$t8		#System.out.print( (char)a + ":" +"\t"+ counter[z]+""+"\n");
addi 	$v0, 	$zero, 	11
syscall
la 	$a0, 	spacer
addi 	$v0, 	$zero,	4
syscall
sll 	$t6, 	$t7, 	2		#TEMP
add 	$t6, 	$t6, 	$s5
lw	$t6,	0($t6)
add 	$a0, 	$zero, 	$t6
addi 	$v0, 	$zero, 	1
syscall
la	$a0,	newLine
addi	$v0,	$zero,	4 		#plus 4 because of ascizze
syscall					#z++;
addi	$t7,	$t7,	1		#}
				
j zWhile

zWhileEnd:				#phraseCounter++;
addi $s2, $s2, 1			#}
j phraseLoopStart

phraseLoopEnd:
#epilouge
lw	$ra, 	4($sp)  		# get return address from stack
lw    	$fp, 	0($sp)     		# restore the caller's frame pointer
addiu 	$sp,	$sp,	24 		# restore the caller's stack pointer
jr    	$ra            			# return to caller's code

