#Program:	Replicates the factorial.s program without recursion via a loop
#			where total = total*(n-1) from n = argument to n = 1
#
#Variables:
#	%eax	represents (n)
#	%ebx	represents the total result so far

.section .data

argument:
	.long 4

.section .text
.globl _start

_start:
	movl argument, %eax			#copy value to eax
	movl argument, %ebx			#copy value to ebx

factorial_loop:
	cmpl $1, %eax				#if %eax is 1 we are done
	je loop_end
	decl %eax					#multiply ebx by eax minus one
	imull %eax, %ebx
	jmp factorial_loop

loop_end:
	movl $1, %eax
	int $0x80
