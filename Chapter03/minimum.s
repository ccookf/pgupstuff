#Purpose:	This program finds the minimum number in a data set
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

	.long 67, 255, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 255

	#The wordsize of a long is 4 bytes. 
	#Alternatively there are .byte (1 byte), .int (2 bytes), and .ascii (1byte/char with a "\0" terminated string)

.section .text

.globl _start

_start:

    movl $0, %edi			        #move 0 to the index register
    movl data_items(,%edi,4), %eax	#load the first byte of data
				                    #list(,index,wordsize)
    movl %eax, %ebx			        #load the first number as the current smallest
    #jmp loop_exit      #reads 3

start_loop:
    
    incl %edi			            #increment the index by one
    movl data_items(,%edi, 4), %eax #load the next piece of data using the index
    cmpl %ebx, %eax                 #see if the item is smaller

    #These two lines do the termination comparison by index rather than value or address
    #movl $13, %ecx
    #cmpl %ecx, %edi
    
    je loop_exit			        #je - jump if equal, the results of cmpl are stored in the %eflags register
    
    cmpl %ebx, %eax			        #compare items
    jge start_loop			        #jump to the start of the loop if is bigger or equal
    movl %eax, %ebx			        #mark if it's smaller
    jmp start_loop			        #jump to loop beginning

loop_exit:
    
    #%ebx is used for the status code for the system exit call
    #and it was already used to store the largest number

    #movl $69, %ebx     #test case to verify %ebx status code is valid

    movl $1, %eax
    int $0x80

#	Other jump operators on comparisons:
#	jg	jump if second operator is greater
#	jge	jump if second operator is greater than or equal
#	jl	jump if second operator is less than first
#	jle jump if second operator is less than or equal to first
#	jmp	jump at any time (no comparison necessary)



