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
    addl $8, %esp
    pushl %eax
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
    pushl %ebp              #Save the base point register
    movl %esp, %ebp         #Save
    subl $4, %esp
    movl 8(%ebp), %ebx
    movl 12(%ebp), %ecx
    movl %ebx, -4(%ebp)

power_loop_start:
    cmpl $1, %ecx
    je end_power
    movl -4(%ebp), %eax
    imull %ebx, %eax
    movl %eax, -4(%ebp)
    decl %ecx
    jmp power_loop_start

end_power:
    movl -4(%ebp), %eax
    movl %ebp, %esp
    popl %ebp
    ret

    