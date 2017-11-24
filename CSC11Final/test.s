.global main

.section .data


input: .asciz "%d"

text: .asciz "button is pushed!\n"
nText: .asciz "NO\n"
val: .word 0
.section .text

main:
        push {lr}
	bl wiringPiSetup

	mov r0, #4 //Pin 4 should be what Im using for the buttons
	mov r1, #0 //0 for input
	bl pinMode

/*	mov r0, #4
	mov r0, #2 //2 for pull up resistor?
	bl pullUpDnControl*/

	mov r5, #0 //set r5 to 0 for loop failsafe
loop:
	add r5, r5, #1
	mov r0, #4
	bl digitalRead
	cmp r0, #1
	bne notEquals
equals:
	ldr r0, =text
	bl printf
	bal cont
notEquals:
	ldr r0, =nText
	bl printf
cont:
	mov r0, #75
	bl delay
	cmp r5, #55
	blt loop

end:
	pop {pc}
