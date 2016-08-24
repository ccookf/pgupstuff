#Purpose:		Calculates the square of a supplied value
#
#Data:	
#
#	argument	contains the value that will be squared

.section .data
argument:
	.long 7

.section .text
.globl _start

_start:
	pushl argument
	call square
	movl %eax, %ebx			#move returned value to ebx as the exit status
	movl $1, %eax			#set up the system call for exit
	int $0x80				#exit

#Function - square
#Arguments:
#	8(%ebp) - value to be squared
#
#Returns:
#	8(%ebp) raised to the second power
.type square, @function
square:
	pushl %ebp				#Typical function stuff
	movl %esp, %ebp

	movl 8(%ebp), %eax		#get the argument from the stack
	imull %eax, %eax		#multiply by itself to get the square

	movl %ebp, %esp			#Reset the frame and return
	popl %ebp
	ret
