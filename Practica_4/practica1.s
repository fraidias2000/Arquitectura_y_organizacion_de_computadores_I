    AREA datos, DATA, READWRITE
long    EQU 7*4   
serie   DCD 1, 2, 4, 6, 8, 7, 9
resul	DCB 0
    AREA prog, CODE, READONLY

    ENTRY

	mov r0, #0
	add r0 , r0, #0x01

    mov r0, #0
    eor r1, r1, r1  ;borra lo que hay en el registro
    
    ldr r2, =serie
buc	ldr r3, [r2, r0]
    add r1, r1, r3
    add r0, r0, #4
    cmp r0, #long
    bne buc
    
    ldr r2, =resul
    str r1, [r2]
       
fin	b fin

    END 