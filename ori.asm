.data

.text
main:
	addi $2, $0, 5
	ori $3, $2, 12  # $3 = 13
	sw $3, 84($0)