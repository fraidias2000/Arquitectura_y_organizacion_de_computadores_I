    AREA datos, DATA, READWRITE

Dato_a	DCD	7
Dato_b	DCD	14
Res_c	SPACE	4
PILA	SPACE 64	   ; Defino una Pila de 64 Bytes
basePILA			   ; Le etiqueta guarda la @ de inicio de la Pila. La Pila será Full Descending

    AREA prog, CODE, READONLY

ENTRY

    ldr sp, =basePILA 	; Inicializa puntero a pila
    
    ldr r0, =Dato_a
    ldr r1, [r0],#4	 	; Cargar Dato_a en r1 y hacer que r0 apunte a Dato_b
    ldr r2, [r0],#4
    
	sub sp,  sp, #4		; Reservo el espacio en la Pila para Retornar resultado
	stmdb sp!, {r1,r2}	; Guardar los datos a sumar en la Pila    
	bl suma				; Llamar a la subrutina suma
    add sp, sp, #8		; Desprecio los parámetros de la Pila
	ldr r1, [sp]		; Leer el resultado de la Pila
	add sp, sp, #4		; Dejo sp a su valor Inicial
	
	str r1, [r0]		; Guardar el resultado en la Memoria

fin	B fin

suma	; Suma a y b, que lee de la Pila y devuelve el resultado c en la Pila
    stmdb sp!, {r4, r5}	; Salvar los registros que utiliza la subrutina suma en la Pila
						; No es necesario guardar lr porque al NO llamar a otra subrutina su valor se mantiene
    
	ldr r4, [sp, #8]    ; Cargar a de la Pila
	ldr r5, [sp, #12]	; Cargar b de la Pila

    add r4, r4, r5
   	str r4, [sp, #16]   ; Guardo resultado en la Pila
	 
	ldmia sp!, {r4, r5}	; Restaurar los registros que ha utilizado la subrutina
	mov pc, lr			; Retornar

	 END
