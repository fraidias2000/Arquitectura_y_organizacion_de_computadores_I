	AREA datos, DATA, READWRITE
vector SPACE 40
suma DCB 0

	AREA prog, CODE, READONLY
ENTRY
	mov r1, #9
	ldr r3,=vector+36
bL6
	str r1, [r3], #-4
	subs r1, r1, #1
	bpl bL6

	ldr r0, =suma
	ldr r3, [r0, #0]
	mov r1, #0
	ldr r4, =vector
bL11
	ldr r2, [r4], #4
	add r3, r3, r2
	add r1, r1, #1
	cmp r1, #9
	ble bL11

	str r3, [r0, #0]

fin b fin
END
