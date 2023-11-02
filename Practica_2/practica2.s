    AREA datos, DATA, READWRITE
long    EQU 1024
vector SPACE 2048
    AREA prog, CODE, READONLY

    ENTRY
    mov r0, #0
    mov r3, #0
    
    ldr r2, =vector
buc	strh r0, [r2, r3]
    add r0, r0, #1
    add r3, r3, #2
    cmp r0, #long
    bne buc

fin	b fin

    END 