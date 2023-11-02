    ;NIP: 780336
	;Alvaro Fraidias Monteagudo
	;r0 = Inicio del vector
	;r1 =  Numero de elementos del vector
	;r2 =  i
	;r3 =  j
	;r4 = Datos vector i
	;r5 = Datos del vector j
	;r6 = Lo uso para desplazarme por la pila y poder obtener los datos de r0 y r1 
	;r7 = Inicio del vector en la subrutina
	;r8 =  Numero de elementos del vector en la subrutina
		
	AREA datos, DATA, READWRITE
vectorDesordenado	DCD 1, 5, 4, 2, 3
PILA	SPACE 64	  
basePILA			  

    AREA prog, CODE, READONLY
    ENTRY
	ldr sp, =basePILA
	ldr r0, =vectorDesordenado
	mov r1, #5	
	push {r0, r1}
	bl BURBUJA
fin2 b fin2

BURBUJA 
	push {r2, r3, r4, r5, r6, r7, r8, lr} ;Salvamos los registros que se van a modificar  (no haría falta guardar lr porque no se llama a otra subrutina)
	add r6, sp, #32		  ;nos saltamos todos los registros guardados en la pila
	ldmfd r6, {r7,r8} 
	eor r2, r2, r2
	eor r4, r4, r4	  ;Borra lo que hay en r2, r4, r5
	eor r5, r5, r5
 																				  
forgrande CMP r2, r8																		  
	bge fin																					  
		 mov r3, #0;j
forpequenio CMP r3, r2
         bge finforpequenio
	     ldr r4,[r7,r2, LSL #2]
         ldr r5,[r7,r3, LSL #2]
	     cmp r4,r5
	     bgt NOCumple
         	str r5, [r7,r2, LSL #2]
		 	str r4, [r7,r3, LSL #2]	  		  
NOCumple
    		add r3, r3, #1
   			 b forpequenio							  

finforpequenio
    	add r2, r2, #1
    	b forgrande 
fin
        pop{r2, r3, r4, r5, r6, r7, r8, pc};Volvemos a poner los valores originales a los registros
END
