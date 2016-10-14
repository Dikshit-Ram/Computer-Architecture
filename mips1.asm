.data
size: .word 8				#Size of array 
array: .word 1,2,3,4,5,6,7,8		 #Array
space: .asciiz " "
Newline: .asciiz "\n"
before: .asciiz "The array before reversing is"
after: .asciiz "The array after reversing is"
.text
	la   $s0, array       		 # load address of array
	la   $s5, size       		 # load address of size variable
	lw   $s5, 0($s5)		#load arrray size
	
	la $a0,before			#load the address of before
	li $v0, 4			# load appropriate system call code into register $v0 to print a message
	syscall				# call operating system to perform print operation
	
	 la   $a0, space  			    # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall
	
	loop: slti $t1, $s5, 1     	 # check if reach the bound 
     	 bne $t1, $zero, rev		#if t1 not equal to zeo goto rev
      	lw  $a0, ($s0)       		 # load the value at $s0
      	li $v0, 1            		 # specify Print integer service 
      	syscall  
      
      	la   $a0, space     		 # load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall
        
     	 addi $s0, $s0, 4  		  # next word     
     	 addi $s5, $s5, -1 		  # decrease size
       
     	 j loop             		 # jump to loop
      
      
      rev:
      	la   $s0, array       		 # load address of array
	la   $s5, size       		 # load address of size variable
	lw   $s5, 0($s5)		#load arrray size
	
	la $a0,Newline			#load address of Newline
	li $v0, 4			# load appropriate system call code into register $v0 to print a message
	syscall				# call operating system to perform print operation
	
	la $a0,after			#load address of after
	li $v0, 4
	syscall
	
	 la   $a0, space      		# load  the  space  
     	 li   $v0, 4 	  		 # specify Print string service
     	 syscall
	
      loop1: slti $t1, $s5, 1     	 # check if reach the bound 
      bne $t1, $zero, exit   
      lw  $a0, 28($s0)			# load the value at $s0
      li $v0, 1             		# specify Print integer service 
      syscall  
      
      la   $a0, space      		# load  the  space  
      li   $v0, 4 	   		# specify Print string service
      syscall
        
      addi $s0, $s0, -4   		 # next word     
      addi $s5, $s5, -1  		 # decrease size
       
      j loop1             		 # jump to loop
      
      exit: li   $v0, 10          # system call for exit
      syscall 
