.data

.text
main:
	addi $s0, $0, 0
	# The status port start position is 0x80, with a length of two bits. The 0th bit represents the LED status, and the 1st bit represents the switch status.
	sw $s0, 0x80($0)
checkSwitch:
	lw $s1, 0x80($0)
	andi $s2, $s1, 0x2  # check whether switch status is 1, swtich status stored in $s2
	beq $s2, $0, checkSwitch
	lw $s3, 0x88($0)
	lw $s4, 0x8c($0)
	add $s5, $s4, $s3
checkLED:
	lw $s1, 0x80($0)
	andi $s2, $s1, 0x1  # check whether led status is 1
	beq $s2, $0, checkLED
	sw $s5, 0x84($0)
	j checkSwitch
	
	