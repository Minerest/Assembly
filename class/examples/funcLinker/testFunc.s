.global clr_kb
.global getInt
.global getIntInRng
.global main

.section .data

output: .asciz "The value you entered was: %d\n\n"

.section .text

.align 4
/*
main:
	push {lr} //Save your exit!
	bl getInt //Call function
	mov r1, r0	//???
	ldr r0, =output //????
	bl printf
	pop {pc}

*/
getInt:
	push {lr}	//save the exit 
	sub sp, #4 //Save save for a 4 byte variable
	ldr r0, =prompt
	bl printf
	ldr r0, =pat
	mov r1, sp	//move the variable to the saved space on the stack
	bl scanf
	ldr r0, [sp]
	add sp, #4
	pop {pc}	//exit the function

prompt: .asciz "Enter an integer value: "
pat: .asciz "%d"

.align 4

getIntInRng:
	push {r4,r5,lr} //has to be in order
	mov r4, r0	//min
	mov r5, r1	//max
	sub sp, #4
gRange_do:	//beginning of loop
	ldr r0, =prompt2
	mov r1, r4
	mov r2, r5
	bl printf
	ldr r0, =pat
	mov r1, sp
	bl scanf
	ldr r0, [sp]
	cmp r0, r4	//r4 is minimum value accepted
	blt gRange_err	//if r0 < r4, branch to gRange_err
	cmp r0, r5	//r5 is max value accepted
	ble gRange_done
gRange_err:
	ldr r0, =err_msg
	bl printf
	bl clr_kb
	bal gRange_do
gRange_done:
	add sp, #4
	pop {r4,r5,pc}

prompt2: .asciz "Enter an int between %d and %d: "
err_msg: .asciz "Invalid Entry!\n"

.align 4

clr_kb:
	push {lr}
loop:
	bl getchar
	cmp r0, #10
	bne loop
	pop {pc}
