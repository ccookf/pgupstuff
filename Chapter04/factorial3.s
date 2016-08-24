#Program:	Replicates the factorial.s program without recursion via a loop
#			where total = total*(n-1) from n = argument to n = 1
#
#Variables:
#	%eax	the total so far
#	%ebx	(n)

.section .data

argument:
	.long 5

.section .text
.globl _start

_start:
	
	pushl argument				#push the value onto the stack as an argument
	call factorial
	movl %eax, %ebx				#set up the system response code and call exit
	movl $1, %eax
	int $0x80

.type factorial, @function

factorial:
	pushl %ebp					#typical function setup
	movl %esp, %ebp
	movl 8(%ebp), %eax			#copy the argument to eax and ebx
	movl %eax, %ebx

factorial_loop:
	cmpl $1, %ebx				#if %ebx is 1 we are done
	je loop_end
	decl %ebx					#multiply ebx by eax minus one
	imull %ebx, %eax
	jmp factorial_loop

loop_end:
	movl %ebp, %esp				#reset the frame and return
	popl %ebp
	ret
