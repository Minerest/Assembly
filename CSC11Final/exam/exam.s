.fpu neon
.data 
arr: .byte 1,2,3,4,5,6,7,8

.text
.global main
main:
	push {lr}
	ldr r0, =arr
	
ldr r0, =arr

mov r1, #0

mov r2, #0

lp: cmp r1, #8

     beq _done

     ldrb r3, [r0, +r1]

     add r2, r3

     add r1, #1

     bal lp

_done:


	pop {pc}

