.data

prompt: .asciiz "Please enter a string (50 characters max): "
fail: .asciiz " Fail!\n"
success: .asciiz " Success! Location: "
buffer: .space 50

.text

.globl main
main:

la $a0, prompt		# ask for input
li $v0, 4
syscall

li $v0, 8		# get input string
la $a0, buffer
li $a1, 50
syscall

move $s0, $a0		# store string in $s0

ReadChar:

li $v0, 12		# get a char
syscall


subi $t0, $zero, 1	# one position before the starting index of the stored string

LOOP:
addi, $t0, $t0, 1	# starting from the first character and go on
add $t1, $s0, $t0	# move to the n-th character of the string
lb $t2, ($t1)		# load character at the n-th position

bge $t0, 50, FAIL	# if the index is 50 (the 51th character), didn't find char

blt $v0, $t2, LOOP	# if the n-th char is not equal to the input char, loop
bgt $v0, $t2, LOOP	

la $a0, success		# print success message
li $v0, 4
syscall

addi, $t0, $t0, 1	# get base-1 index
move $a0, $t0
li $v0, 1		# print index
syscall
j EXIT			# terminate

FAIL:
la $a0, fail		# print fail message
li $v0, 4
syscall
j ReadChar		# read a new char

EXIT: