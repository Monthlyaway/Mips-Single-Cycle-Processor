.data

.text
main:
	addi $2, $0, 5
	andi $3, $2, 12  # $3 = 4
	sw $3, 84($0)