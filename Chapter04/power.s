#Purpose:   Demonstrate functions with a program that calculates 2^3 + 5^2
#
#Assembly instructions:
#
#   As this is probably going to be run on x86_64 this won't assemble correctly on its own
#   Target 32 bit environment and link appropriately. Ex:
#
#       as --32 power.s -o power.o
#       ld -m elf_i386 power.o -o power

.section .data

.section .text

.globl _start

_start:

    pushl $3                #puts the word on the stack and subtracts 4 from esp
    pushl $2                #pushing these values as parameters to the function
    call power
    addl $8, %esp           #pushes the stack pointer back 2 words
    pushl %eax              #save the results from 2^3
    pushl $2
    pushl $5
    call power
    addl $8, %esp
    popl %ebx               #pops the value from the stack into register and adds 4 onto esp
                            #alternatively we could peek at the value with indirect addressing mode 
                            #eg. (%esp)
    addl %eax, %ebx
    movl $1, %eax
    int $0x80

.type power, @function

power:
                            #at this point the return address was pushed onto the stack (as %esp)?
    
    pushl %ebp              #Save the base point register
    movl %esp, %ebp         #Copies the stack pointer onto the base pointer
    subl $4, %esp           #reserves room for a word by shifting the stack pointer
                            #remember the stack actually grows downwards
                            #this can be accessed indirectly via the base pointer, 4(%ebp)z
    movl 8(%ebp), %ebx      #This refers to the $2 pushed onto the stack in the first call
                            #at this time the stack reads: 
                            #       3                   12(%ebp)
                            #       2                   8(%ebp)
                            #       original ebp        4(%ebp)
                            #       old stack pointer   (%ebp)
                            #       reserved word       -4(%ebp)
    movl 12(%ebp), %ecx
    movl %ebx, -4(%ebp)     #Now we're storing the 2 from earlier into the reserved word (local variable)

power_loop_start:
    cmpl $1, %ecx           #The power loop x^y-- where y == 1 yields termination of the loop
    je end_power
    movl -4(%ebp), %eax     #Moving the 2 from the reserved stack into eax
    imull %ebx, %eax        #Multiply the 2 against itself and save into eax as 4
    movl %eax, -4(%ebp)     #Move the 4 into the reserved space on the stack
    decl %ecx               #y--
    jmp power_loop_start

end_power:
    movl -4(%ebp), %eax     #Take the total stored in the reserved word and move to eax
    movl %ebp, %esp         #copies the original stack pointer back into %esp from %ebp
    popl %ebp               #copies the original ebp back into ebp so ret can reset the stack frame
    ret

    