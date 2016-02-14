Main:	addi $a0, $zero, 6  # set arg to something
	jal Fib	
	nop # for delay slot
	add $a0 $zero, $v0 # save the result of Fib to $a0.
	addi $v0, $zero, 10
	syscall # when $v0=10, exit.

	
Fib: 	bne  $a0, 0, Elseif	# if n==0
	nop # for delay slot
	addi $v0, $zero, 0
	jr $ra
	nop
	
Elseif:	bne $a0, 1, Else # if n==1
	nop #delay slot
	addi $v0, $zero, 1
	jr $ra
	nop
	
Else:	addi $a0, $a0, -1 # a==a-1
	
	# store stuff in the stack, store return address in the stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	addi $sp, $sp, -4
	sw $a0, 0($sp)
	#
	
	jal Fib
	nop	
	#after Fib(n-1)
	
	# get a0 from the stack
	lw $a0, 0($sp)
	addi $sp, $sp, 4
	
	# store $v0 on the stack
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	
	addi $a0, $a0, -1 # a-1 -1 == 2
	jal Fib
	nop
	
	# get the result of Fib(n-1) from the stack
	lw $t2 0($sp)
	addi $sp, $sp, 4
	
	# get ra from the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	#after Fib(n-2)
	add $t3, $zero, $v0
	
	add $v0, $t2, $t3 # return value = fib(-1) + fib(n-2)

	jr $ra
	nop
