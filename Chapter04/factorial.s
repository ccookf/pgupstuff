#Purpose:	Calculate the factorial of a number 3! = 6, 4! = 24, ect... using recursion

.section .data

.section .text

.globl _start
.globl factorial			#"This is unneeded unless we want to share the function with other programs

_start:
	pushl $5				#The number we are going to find a factorial of
	call factorial
	addl $4, %esp			#Bye bye to the number stored on the stack before the function
	movl %eax, %ebx			#move the return value of the function for exit status
	movl $1, %eax			#setup the system call
	int $0x80

.type factorial, @function

factorial:
	pushl %ebp				#backup ebp for later
	movl %esp, %ebp			#save the stack pointer on ebp
	movl 8(%ebp), %eax		#copy the parameter onto eax
	cmpl $1, %eax			
	je factorial_end		#end if parameter is one
	decl %eax				#else reduce parameter by one
	pushl %eax				#make this the parameter for the next factorial call
							#I left this line out by mistake and it just floods the stack with
							#factorial calls.  Oddly enough I got a segmentation fault from this?
							#Does stack overflow not exist in asm or something?
	call factorial
	movl 8(%ebp), %ebx		#ebp was cleared by the function
	imull %ebx, %eax		#multiply the result of the factorial call with the parameter
							#and store in eax as the return value of the function

factorial_end:
	movl %ebp, %esp			#restore the stack pointer and return address
	popl %ebp
	ret
