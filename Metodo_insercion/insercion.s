;780336
;Alvaro Fraidias Monteagudo
;r0 = Inicio vector
;r1 =  Tamaño vector
;r2 = I
;r3 = J
;r4 = Registro auxiliar
;r5 Vector j
;r6 = Lo uso para desplazarme en la pila y poder obtener los datos de r0 y r1 dentro de la subrutina
;r7 = Inicio del vector en la subrutina 
;r8 =  Numero de elementos del vector en la subrutina
  AREA datos, DATA, READWRITE
vectorDesordenado	DCD	5,6,3,7,2,1,4
PILA	SPACE 64	  
basePILA

    AREA prog, CODE, READONLY

    ENTRY
	ldr sp, =basePILA
	ldr r0, =vectorDesordenado
	mov r1, #7
	push{r0,r1} ;Pasamos los parametros por pila
	bl INSERCION
fin b fin

INSERCION
	push {r2, r3, r4, r5, r6,r7, r8, lr} ;salvamos los registros que se van a modificar (Igual que en la burbuja, no haría falta guardar lr porque no llamamos a otras subrutinas dentro de esta subrutina)
	add r6, sp, #32 ; 
	ldmfd r6, {r7,r8} 
	eor r2, r2, r2
	eor r3, r3, r3
	eor r4, r4, r4	  ;Borra lo que hay en r2, r3, r4, r5
	eor r5, r5, r5

for cmp r2, r8
	bge fin2

	ldr r4, [r7,r2, LSL #2]  
	sub r3, r2, #1		
	b comp

while 
   	add r6, r3, #1
	str	r5, [r7, r6, LSL #2]
	sub r3, r3, #1
		
comp
	cmp r3, #0
	blt finwhile
	ldr r5,[r7, r3, LSL #2]
	cmp r5,r4
	bgt while

finwhile
	add r6, r3, #1
	str r4, [r0,r6, LSL #2]  
		
	add r2, r2, #1
	b for
fin2
	pop {r2, r3, r4, r5, r6,r7, r8, pc} ;Volvemos a poner los valores originales a los registros

    END 