#Purpose:	Simple program that exits and returns
#		a status code to the Linux kernel
#

#Input:		none

#Output:	status code
#		view by typing echo $?

#Variables:
#	
#	%eax	holds the system call number
#	%ebx	holds the return status
.section .data

.section .text

.globl _start
_start:
movl $1, %eax	#this is the linux kernel command number
		#(system call) for exiting a program
		
movl $0x11, %ebx	#this is the status number to return
		#to the operating system
		#in this case I switched $69 for a hex number $0x11 which the console represents with 17
		
int $0x80	#this wakes up the kernel to run the exit command