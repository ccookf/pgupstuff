#Purpose:	This program finds the minimum number in a data set
#           The data set is navigated using what is essentially pointer math
#
#Variables:
#	
#	%eax - address of the current item in memory
#   %ebx - current minimum value item in list
#   %ecx - value of current item in memory
#   %edx - address of end of list
#	
#	data_items - Holds the list of items, a zero terminates the list

.section .data

data_items:

	.long 67, 255, 34, 222, 45, 75, 54, 34, 44, 33, 22, 11, 66, 255

	#The wordsize of a long is 4 bytes. 
	#Alternatively there are .byte (1 byte), .int (2 bytes), and .ascii (1byte/char with a "\0" terminated string)

data_end:

    #.long 0

    #if I understand this correctly the section for data is a continous chunk of memory,
    #thus data_end is right after data_items
    #see lists.nongnu.org/archive/html/pgubook-readers/2004-02/msg00008.html

.section .text

.globl _start

_start:

    movl $data_items, %eax          #load the address of the list into eax
    movl $data_end, %edx            #load the address of the end into edx

    movl data_items, %ebx           #load the value of the first list item into ebx
    #jmp loop_exit                  #test line, will produce output of 67 for the return code

start_loop:
    
    cmpl %eax, %edx
    je loop_exit
    
    addl $4, %eax                   #incrementing the pointer by one word
    movl (%eax), %ecx
    cmpl %ebx, %ecx
    jge start_loop
    movl %ecx, %ebx
    jmp start_loop

loop_exit:
    
    #%ebx is used for the status code for the system exit call
    #and it was already used to store the smallest number

    #movl $69, %ebx     #test case to verify %ebx status code is valid

    movl $1, %eax
    int $0x80
