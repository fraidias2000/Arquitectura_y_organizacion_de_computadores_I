;NIP: 780336
;Alvaro Fraidias Monteagudo   
;r0 = Vector a ordenar
;r1 = Tamaño del vector	 
;r2 = En la subrutina suma es el iterador, en la subrutina ORDENA es la parte de la izquierda del vector a ordenar y en la subrutina QSOR es i.
;r3 = En la subrutina suma es el dato del vector, en la subrutina ORDENA es la parte de la derecha del vector a ordenar y en la subrutina QSORT es j y la posicion derecha del vector 
;r4 = En la subrutina suma es la suma acumulada, en la subrutina QSORT es el dato del vector en la posicion T[i]
;r5 = En la subrutina QSORT es el dato del vector en la posicion T[j]
;r6 = En la subrutina QSORT es un registro auxiliar para hacer   aux = izquierda + derecha /2
;r7 = En la subrutina QSORT es x
;r8 = En la subrutina QSORT es w
;r9 = En la subrutina QSORT es la posicion izquierda del vector 
   
    AREA datos, DATA, READWRITE

resultadoSuma SPACE 4
pila	SPACE	100
top_pila


  AREA codigo, CODE   
  EXPORT ordena 

ordena

  ldr sp,=top_pila
  ldr r0,=T 
  ldr r1,=N
  
  sub sp,sp,#4 ;Dejo el primer hueco en la pila para el resultado de la suma

  push{r0-r1}
  bl SUMA
  pop{r0-r1}
  
  ldr r2, =resultadoSuma
  ldr r3, [sp, #0]
  str r3,[r2] 

  push {r0-r1}	
  bl ORDENA
  pop {r0-r1}
      
fin	b fin

SUMA   
  push{r0-r4,lr}
  ldr r0,[sp,#24] ;cargo el r0 de la pila en r0 
  ldr r1,[sp,#28] ;cargo el r1 de la pila en r1
  mov r2,#0
  mov r3,#0
  mov r4,#0

bucleSuma cmp r1,r2
	bge finbucleSuma	
	ldr r3,[r0,r2,LSL #2]
	add r4, r3, r4
	add r2,r2,#1
	b bucleSuma
finbucleSuma

  str r4,[sp,#32]
  pop{r0-r4,pc} ;final subrutina suma

ORDENA
   push{r1-r3,lr} 
   sub r1,r1,#1  ;qsort(0,n-1);
   mov r2, #0  ;izda
   mov r3, r1  ;dcha
   push{r2-r3}
   bl QSORT
   pop{r2-r3}
   pop{r1-r3,pc} ;final subrutina ordena

QSORT
   push{r2-r9,lr}
   mov r2,#0 ; i
   ldr r3, [sp,#44] ; cargar derecha (tambien es j)
   mov r4, #0 ; T[i]
   mov r5, #0 ; T[j]
   mov r6, #0 ; auxiliar
   mov r7, #0  ;x
   mov r8, #0 ; w
   ldr r9, [sp, #40] ; izquierda   
                                                       

   ldr r4,[r0,r2,LSL #2]
   ldr r5, [r0,r3,LSL #2]
    
   add r6,r3,r9; aux = izquierda + derecha
   mov r6,r6,LSR #1	; aux = izquierda + derecha /2
   ldr r7,[r0,r6,LSL #2]

doWhile

	b condicionPrimerWhile

primerWhile

	add r2, r2, #1
	ldr r4,[r0,r2,LSL #2]
						
condicionPrimerWhile

	 cmp r4, r7
	 ble primerWhile
	 b condicionSegundoWhile

segundoWhile	 

	 sub r3,r3,#1
	 ldr r5,[r0, r3, LSL #2]

condicionSegundoWhile 

	cmp r5, r7
    blt segundoWhile
			 
if1 
	cmp r2,r3
	movle r8,r4
	movle r4,r5
	movle r5,r8
	addle r2,r2,#1
	suble r3,r3,#1
finif1

conDoWhile 
	cmp r2,r3
	ble doWhile
	
if2
	 cmp r9, r3
	 bge finif2
	 push{r3, r9}
	 bl QSORT ;recursividad
	 pop{r1-r3}

finif2

if3  
	ldr r3, [sp,#44] ; cargar derecha
	cmp r2,r3
	bge finif3 
	push{r2,r3}
	bl QSORT ;recursividad
	pop{r2,r3}

finif3	    				     

   pop {r2-r9,pc}  ;Fin subrutina QSORT

    END 