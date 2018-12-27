.data

default: .asciiz " *\n"

NumMsg:	.asciiz " zero\n", " First\n", " Second\n", " Third\n", " Fourth\n", " Fifth\n", " Sixth\n", " Seventh\n", " Eighth\n", " Ninth\n"

CapMsg: .asciiz " Alpha\n", " Bravo\n", " China\n", " Delta\n", " Echo\n", " Foxtrot\n", " Golf\n", " Hotel\n", " India\n", " Juliet\n", " Kilo\n", " Lima\n", " Mary\n",
 " November\n", " Oscar\n", " Paper\n", " Quebec\n", " Research\n", " Sierra\n", " Tango\n", " Uniform\n", " Victor\n", " Whisky\n", " X-ray\n", " Yankee\n", " Zulu\n"

LowMsg: .asciiz " alpha\n", " bravo\n", " china\n", " delta\n", " echo\n", " foxtrot\n", " golf\n", " hotel\n", " india\n", " juliet\n", " kilo\n", " lima\n", " mary\n",
" november\n", " oscar\n", " paper\n", " quebec\n", " research\n", " sierra\n", " tango\n", " uniform\n", " victor\n", " whisky\n", " x-ray\n", " yankee\n", " zulu\n"

# Positions for each letter conversion
LetterPos: .word 0, 8, 16, 24, 32, 39, 49, 56, 64, 72, 81, 88, 95, 102, 113, 121, 129, 138, 149, 158, 166, 176, 185, 194, 202, 211

# Positions for each number conversion
NumPos: .word 0, 7, 15, 24, 32, 41, 49, 57, 67, 76


.text

.globl main

main:

start:

li $v0, 12		# read character
syscall


li $s0, '?'		# if input is equal to '?', then exit
beq $v0, $s0, EXIT


blt $v0, '0', OTHER	# if v1 < '0', goto other
ble $v0, '9', NUMBER	# input <= '9', goto number


blt $v0, 'A', OTHER	# input < 'A', goto other
ble $v0, 'Z', CAP	# input <= 'Z', goto cap


blt $v0, 'a', OTHER	# input < 'a', goto other
ble $v0, 'z', LOW	# input <= 'z', goto low



# If the input is not an integer from 0-9 or an English letter
OTHER:
li $v0, 4

la $a0, default		# print default message

syscall

j start			# Restart



# If the input is an integer from 0-9
NUMBER:

subi $v0, $v0, 48	# get the position (n-th) of the number

la $t0, NumPos		
mul $v0, $v0, 4
add $t0, $t0, $v0
lw $v0, 0($t0)		# get the position of the n-th number

la $a0, NumMsg		# load the address of NumMsg

add $a0, $a0, $v0	# Go to the position of the n-th number in NumMsg

li $v0, 4

syscall

j start			# Restart

CAP:

subi $v0, $v0, 65	# get the position (n) of the capital letter

la $t0, LetterPos

mul $v0, $v0, 4
add $t0, $t0, $v0
lw $v0, 0($t0)		# get the position of the n-th capital letter

la $a0, CapMsg		# load the address of CapMsg

add $a0, $a0, $v0	# Go to the position of the n-th capital letter in CapMsg

li $v0, 4

syscall

j start			# Restart

LOW:

subi $v0, $v0, 97	# get the position (n) of the lowercase letter

la $t0, LetterPos

mul $v0, $v0, 4
add $t0, $t0, $v0
lw $v0, 0($t0)		# get the position of the n-th lowercase letter

la $a0, LowMsg		# load the address of LowMsg

add $a0, $a0, $v0	# Go to the position of the n-th lowercase letter in LowMsg

li $v0,4

syscall

j start			# Restart

EXIT:
