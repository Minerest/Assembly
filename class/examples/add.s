.global add_asm
.global add_asm2
.global add_arr
.global main
.section .data


dbg: .asciz "... Inside function: add_asm...\n"
.section .text
main:
add_asm:	// r0, and r1 are both parameters. r0 is the number to be returned from the function
	push {r0, r1, lr}
	ldr r0, =dbg
	bl printf
	pop {r0, r1, lr}
	add r0, r0, r1
	mov pc, lr //Return back to our calling code.

add_asm2:
	add r0, r0, r1
	add r0, r0, r2
	mov pc, lr

add_arr:
	push {r4}	//preserve r4 since we use it in our...
	mov r4, r0	// copy ptr to array (in r0) to...
	mov r0, #0	// r0 = sum, initialized to 0
	mov r2, r0	//r2 = counter, initialized to 0
._w:	cmp r2, r1	//test: compare r2 and r1 (r1 = #...
	beq ._w_end	// branch if equal to ._w_end (end o...)
	ldr r3, [r4, +r2, lsl #2]// r3 = *(r4 + r2*4)
	add r0, r0, r3	//r0 = r0 + r3
	add r2, #1	//r2++
	b ._w //branch back to ._w this is a while loop
._w_end:
	pop {r4}
	mov pc, lr
