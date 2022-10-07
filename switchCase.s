.section .data
input1:       .asciz "@[`{The dog^ ZATE %my Homeworkaz!" # -> 22
input2:       .asciz ""	# -> 0
input3:       .asciz "#!$"	# -> 0

.section .text
# ---------------------------------
# "Inverts" the case of a string: lowercase is changed to uppercase, uppercase to
# lowercase, and everything else stays the same. The conversion is in-place.
# It returns the number of characters that were inverted
# Example: "The Dog" -> "tHE dOG" returns 6
# Example: "" -> "" returns 0
# Example: "#!$" -> "#!$" returns 0
# ---------------------------------

.globl _start
_start:

    mov $0, %rdx                # sum of swtiched letters
    mov $0, %eax                # index for string iteration
string_loop:

    mov input1(, %eax, 1), %bl  # read character from string array
    cmp $0, %bl                 # check if it's the end of the string
    je exit

    cmp $65, %bl                # if character < 65
    jl continue
    cmp $90, %bl                # if character <= 90
    jle switch_to_lower

    cmp $97, %bl                # if character < 97, range between 65-90 is already checked
    jl continue
    cmp $122, %bl               # if character > 122
    jg continue

switch_to_upper:
    sub $32, %bl                # switch letter
    mov %bl, input1(, %eax, 1)  # update string array in memory
    inc %rdx                    # count switching
    jmp continue

switch_to_lower:
    add $32, %bl                # switch letter
    mov %bl, input1(, %eax, 1)  # update string array in memory
    inc %rdx

continue:
    inc %eax                    # increase index for string iteration
    jmp string_loop

exit:
	mov $60, %rax               # system call 60 is exit
    mov %rdx, %rdi              # return sum of swtiched letters
    syscall
