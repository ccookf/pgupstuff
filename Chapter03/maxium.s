#Purpose:	This program finds the maxiumn number in a data set
#
#Variables:
#	
#	%edi - Holds the index of the data being examined
#	%ebx - Holds the largest item found
#	%eax - Current data item
#	
#	data_items - Holds the list of items, a zero terminates the list

.section .data

data_items:

	.long 3, 67, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 0

	#The wordsize of a long is 4 bytes. 
	#Alternatively there are .byte (1 byte), .int (2 bytes), and .ascii (1byte/char with a "\0" terminated string)

.section .text

.globl _start

_start:

movl $0, %edi			#move 0 to the index register
movl data_items(,%edi,4), %eax	#load the first byte of data
				#list(,index,wordsize)
movl %eax, %ebx			#since this is the first item it's the biggest

start_loop:

cmpl $0, %eax			#check if we've hit the end
je loop_exit			# je - jump if equal, the results of cmpl are stored in the %eflags register
incl %edi			#load the next item by incrementing by one
movl data_items(,%edi, 4), %eax
cmpl %ebx, %eax			#compare items
jle start_loop			#jump to the start of the loop if it isn't bigger
movl %eax, %ebx			#mark if it's bigger
jmp start_loop			#jump to loop beginning

loop_exit:
#%ebx is used for the status code for the system exit call
#and it was already used to store the largest number
movl $1, %eax
int $0x80

#	Other jump operators on comparisons:
#	jg	jump if second operator is greater
#	jge	jump if second operator is greater than or equal
#	jl	jump if second operator is less than first
#	jle 	jump if second operator is less than or equal to first
#	jmp	jump at any time (no comparison necessary)



