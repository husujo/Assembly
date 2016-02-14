Main:	addi $a0, $zero, 4  # set arg to something
	jal Fact
	
	nop # for delay slot

	add $a0 $zero, $v0
	addi $v0, $zero, 10
	syscall

	# addi $ra Done
Fact: 	beq  $a0, 0, Else
	nop # for delay slot
	
	# store n in the stack, store return address in the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	addi $sp, $sp, -4
	sw $a0, 0($sp)

	# recurse on n-1. jal puts $ra = the next instruction after jal.
	addi $a0, $a0, -1
	jal Fact
	
	nop # for delay slot
	
	#get shit out of the stack
	lw $t1, 0($sp) # get a
	addi $sp, $sp, 4
	lw $t2, 0($sp) # get ra
	addi $sp, $sp, 4
	add $ra, $zero, $t2
	
	# result * n:
	mult $v0, $t1
	mflo $v0
	# need to jump over else:
	jr $ra
	
	nop # for delay slot
	
# if a0 == 0, return 1:	
Else:	addi $v0, $zero, 1
	# return? need to set return address?
	jr $ra
	
	nop # for delay slot





