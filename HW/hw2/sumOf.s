.global main

.section .data
text: .asciz "Enter a positive number to get the sum and sum of the squares\n\n"
format: .asciz "%d"
badInText: .asciz "Bad input! "
goodText: .asciz "Good input!"
endText: .asciz "You entered %d, the sum of all numbers up to your input is %d, the sum of squares up the your input is %d \n\n"

test: .asciz "Count: %d, sum: %d, sumOf: %d\n"

.align 4

sum: .word 0
sumOfSquares: .word 0
usrIn: .word 0
count: .word 1


.section .text


main:
	push {lr}	//save  the exit point
textOut:
	.align 4
	ldr r0, =text	//print intro text
	bl printf
	ldr r0, =format//get the input format
	ldr r1, =usrIn //store the input in  =usrIn
	bl scanf
vCheck:			//check for validity
	.align 4
	mov r1, #0	//checking against the number 0 to check for negatives
	ldr r0, =usrIn  //store address of usrIn
	ldr r0, [r0]	//get the value of the user input
	cmp r0, r1	//compare 0 to the user input
	ble badInput	//branch to the badInput if userIn is lessthan or equal to 0
	bl goodInput	//else go to goodInput
badInput:
	.align 4
	ldr r0, =badInText
//	pop {r4}
	bl printf
	bl textOut
goodInput:
	ldr r0, =goodText
	bl printf
	//store the variables [sum, count, and usrIn] in various registers

	ldr r0, =sum
	ldr r0, [r0]  //store the sum value
	ldr r1, =count
	ldr r1, [r1]  //store the count value
	ldr r2, =usrIn
	ldr r2, [r2]  //store the usrInput
	ldr r3, =sumOfSquares
	ldr r3, [r3]  // store the sumOfSquares
sumLoop:
	add r0, r0 ,r1	//add the count to the sum
	mul r4, r1, r1	//get the square of the count
	add r3, r3, r4	//and add it to sumOfSquares
	add r1, r1, #1  //increment the counter
	cmp r1, r2     //if the count is smaller than the usrInput
	blt sumLoop    //loop again

	ldr r5, =sumOfSquares
	ldr r6, =sum
	str r3, [r5]
	str r0, [r6]
	bl endSumLoop
endSumLoop:
	ldr r0, =endText
	ldr r2, =sum
	ldr r2, [r2]
	ldr r1, =usrIn
	ldr r1, [r1]
	ldr r3, =sumOfSquares
	ldr r3, [r3]
	bl printf
	pop {pc}	//pc go home
