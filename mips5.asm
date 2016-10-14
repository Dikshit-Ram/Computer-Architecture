.data
size : .word 10
array : .word 0:9
print : .asciiz "\nEnter 10 integers : "
printarray : .asciiz "\nThe elements in the array are :"
space: .asciiz "  "
min : .asciiz "\nMinimum is "
max: .asciiz "\nMaximum is "
.text
	la $s5, size		# load address  into $s5
	lw $s5, 0($s5)		# store array in stack
	la $s0, array		# load address of  array into $s0
	
	la $a0, print		# load the print 
	li $v0, 4		#systemcall
	syscall		
		
Loop1 : beq, $s5,$0,Loop2	# if s5 == 0, jump to L2
	li $v0,5		
	syscall			
	sw $v0, 0($s0)		# store word in register $v0 into RAM at address contained in $s0
	addi $s0,$s0, 4		# increment s0 by 4
	addi $s5, $s5, -1	# decrement s5 by 1
	j Loop1			# unconditional jump to L1
	
Loop2 : la $a0, printarray		# load address of string originalorder into $a0
	li $v0, 4			
	syscall	
			
	la $s0,array	
	la $s4, size		# load address of string array into $s0	
	lw $s4, 0($s4)			# store array in stack
	
	
	
Loop3 : slti $t0, $s4, 1	# if t4 < 1, then t0 = 1
	bne $t0, $0, Loop4		# if t0 != 0, jump to loop L4
 	
	lw $a0, 0($s0)		# store array in stack
	li $v0, 1		
	syscall	
	 la   $a0, space  	 # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall		
		
	addi $s0, $s0, 4	# increment s0 by 4
	addi $s4, $s4, -1	# decrement t4 by 1
	
	beq $t4, $0, Loop3		# if t4 == 0, jump to L3
	la $a0, space		# load space
	li $v0, 4		
	syscall			
	j Loop3			# unconditional jump to L3

 Loop4 :la $t5, size		# load address of string to $t5
	lw $t5, 0($t5)		# store array in stack
	la $s1, array		# load address of array into $s1
	la $s2, array		# load address of array into $s2
	lw $t1, 0($s1)		# store array in stack
	addi $s2, $s2, 4	# increment s2 by 4
	
		
Loop5 :	slti $t0, $t5, 2	# if t5 < 2, then t0 = 1
	bne $t0, $0, Loop10	# if t0 != 0, jump to loop10
	lw $t2, 0($s2)		# restore array in stack
	slt $t3, $t1, $t2	# if t1 < t2, t3 =1			
	bne $t3, $0, Loop6		# if t3 != 0, jump to loop Loop6
	addi $t1, $t2, 0	# t1 = t2
	addi $s2, $s2, 4	# increment s2 by 4
	addi $t5, $t5, -1	# decrement t5 by 1
	j Loop5			# jump to loop5	
		
Loop6 :	addi $s2, $s2, 4	# increment s2 by 4
	addi $t5, $t5, -1	# decrement t5 by 1
	j Loop5			# jump to loop5	


Loop7 :	la $t6, size			# load address of string size into $t6
	lw $t6, 0($t6)			# restore the array in stack

	la $s3, array			# load address of string array into $s3
	la $s4, array			# load address of string array into $s4
	addi $s4, $s4, 4		# increment s4 by 4
	lw $t4, 0($s3)			

		
Loop8 :	slti $t0, $t6, 2		# if t6 < 2, t0 = 1	
	bne $t0, $0, Loop11		# if t0 != 0, jump to loop3
	lw $t2, 0($s4)			

	slt $t3, $t4, $t2		# if t4 < t2, t3 = 1		
	bne $t3, $0, Loop9			# if t3 != 0, jump to Loop9

	addi $s4, $s4, 4		# increment s4 by 4
	addi $t6, $t6, -1		# decrement s6 by 1
	j Loop8				# jump to Loop8
		
Loop9 :		
	addi $t4, $t2, 0		# t4 = t2
	addi $s4, $s4, 4		# increment s4 by 4
	addi $t6, $t6, -1		# decrement s6 by 1
	j Loop8				# jump to Loop8
Loop10 :	
	la $a0, min			# load address of string minimum into $a0
	li $v0, 4			
	syscall				
	
	addi $a0,$t1,0			# a0 = t1
	li $v0, 1			
	syscall	
	 la   $a0, space  			    # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall			
	j Loop7				# jump to Loop7

 Loop11 :la $a0, max			# load address of string maximum into $a0
	li $v0, 4				
	syscall				
	 la   $a0, space  			    # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall
		
	addi $a0,$t4,0			# a0 = t4
	li $v0, 1		
	syscall	
	 la   $a0, space  			    # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall		
					
Exit :	 li   $v0, 10        		  # system call for exit
     	 syscall 
