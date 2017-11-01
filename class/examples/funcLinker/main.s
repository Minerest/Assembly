//Compile instructions: g++ getIntegerTestAsmMain.s getInteger.s -o getIntegerTestAsm
.global main
.section .rodata

output: .asciz "Entered value = %d\n\n"

.section .text

main:
	push {lr}

	mov r0, #1
	mov r1, #10
	bl getIntInRng
	mov r1, r0
	ldr r0, =output
	bl printf

	pop {pc}
