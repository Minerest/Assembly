//To compile, g++ final.s -lwiringPi
//gpio18 [or wiringPi pin1] is for PWM
//GPIO23 is for button 1

.global main

.section .data

text: .asciz "button is pushed!\n"

nText: .asciz "No input\n"

b1: .asciz "button 1 is pressed!\n"

b2: .asciz "button 2 is pressed!\n"

b3: .asciz "button 3 is pressed!\n"

b4: .asciz "button 4 is pressed!\n"

intro: .asciz "this is a project that uses a pwm signal to power an Electronic Speed Controller [ESC] which in turn causes the motors to spin\n\n."

setPWM: .asciz "gpio mode 1 pwm"

setMS: .asciz "gpio pwm-ms"

//Setting the clock and rate to be at 50hz. According to Wikipedia, ESC's should operate at a 50hz frequency
// setting gpio pwm 1 @ 40  should equal 1.0 ms pulses which the ESC *SHOULD* consider the minimum value
// setting the  PWM signal at 80 should equal to 2.0ms pulses which the ESC *SHOULD* consider its maximum value. 

setClock: .asciz "gpio pwmc 480"

setRate: .asciz "gpio pwmr 800"

button1: .asciz "gpio pwm 1 40"

button2: .asciz "gpio pwm 1 60"

button3: .asciz "gpio pwm 1 80"

cleanup: .asciz "gpio mode 1 in"

end: .asciz "thats all folks\n"

val: .word 0
.section .text

main:
	push {lr}

	//The next dozen lines should setup the Raspberry pi for PWM output
	ldr r0, =intro
	bl printf
	bl wiringPiSetup

	ldr r0, =setPWM
	bl system

	ldr r0, =setMS
	bl system

	ldr r0, =setClock
	bl system

	ldr r0, =setRate
	bl system


	mov r0, #4 //Pin 4 should be what Im using for the button1
        mov r1, #0 //0 for input
        bl pinMode

	mov r0, #5 //Pin 5 should be what Im using for the button2
        mov r1, #0 //0 for input
        bl pinMode

	mov r0, #6 //Pin 6 should be what Im using for the button3
        mov r1, #0 //0 for input
        bl pinMode

	mov r0, #0 //Pin 4 should be what Im using for the button4 i.e. cleanup
        mov r1, #0 //0 for input
        bl pinMode

	ldr r0, =button3	//Setting the pwm signal at max "Throttle"
	bl system		//Needed to arm the ESC, part of BLHeli_S protocol
loop:
	mov r0, #4	//button 1
	bl digitalRead
	cmp r0, #1
	beq b1_

	mov r0, #5 	//button 2
	bl digitalRead
	cmp r0, #1
	beq b2_

	mov r0, #6 	//button 3
	bl digitalRead
	cmp r0, #1
	beq b3_

	mov r0, #0	// button 4
	bl digitalRead
	cmp r0, #1
	beq b4_

	cmp r0, #1
	bne noInput
b1_:			//label for clarity
	ldr r0, =b1
	bl printf

	ldr r0, =button1//Sets PWM at min Freq
	bl system
	bal cont

b2_:                    //label for clarity
        ldr r0, =b2	//sets PWM at medium Freq
        bl printf

	ldr r0, =button2
	bl system
        bal cont

b3_:                    //label for clarity
        ldr r0, =b3	//Setup PWM at Max Freq
        bl printf

	ldr r0, =button3
	bl system
        bal cont

b4_:                    //label for clarity
        ldr r0, =b4	//Cleans the GPIO pins, just like Pythons GPIO library
        bl printf

        bal exit

noInput:
	ldr r0, =nText
	bl printf
cont:
	mov r0, #50	//Short delay
	bl delay
	bal loop
exit:
	//Some tests to make sure the button commands work
/*	ldr r0, =button1
	bl system

	mov r0, #1000
	bl delay

	ldr r0, =button3
	bl system

	mov r0, #1000
	bl delay*/

	ldr r0, =end
	bl printf

	ldr r0, =cleanup
	bl system


	pop {pc}

	//who needs github?
	//this part is commented out because this code caused the computer to crash so hard, I had to unplug it.
	//The solution is to make some calls to the system to set everything up.
/*	ldr r0, =intro
	bl printf
	bl wiringPiSetup

	mov r0, #1      //1 is pwm-bal[default] and 0 is pwm-MS [traditional PW$
        bl pwmSetMode

	mov r0, #1024
        bl pwmSetClock

	mov r0, #1      //1 is the PWM pin for the raspberry pi
        mov r1, #2      //2 should by pwmMode on the wiring pi setup
        bl pinMode

/*	mov r0, #1024
	bl pwmSetRange

	mov r0, #1024
	bl pwmSetClock

/*	mov r0, #1
	mov r1, #500	//r1 can be a value between 0 and 1024
	bl pwmWrite

/*	ldr r0, =input
	ldr r1, =val
	bl scanf

	mov r0, #1
	mov r1, #0
	bl pwmWrite*/

//	pop {pc}

