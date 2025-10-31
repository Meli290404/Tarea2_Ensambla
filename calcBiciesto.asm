; ==========================================================
; Proyecto: Calculadora de Años Bisiestos 
; Lenguaje: Ensamblador NASM x86 (Linux)
; Descripción:
;   Esta parte recibe un año y devuelve un valor
;   indicando si el año es bisiesto (1) o no bisiesto (0).
; ==========================================================

section .data
    mensaje_bis db "Es bisiesto", 10, 0
    mensaje_noBis db "No es bisiesto", 10, 0
    mensaje_entrada db "Ingrese un año: ", 0
    formato_entrada db "%d", 0        ; formato para leer entero (no 'tipo_entrada')

section .bss 
    anio resd 1   ; variable que guarda el año ingresado 
    res  resd 1   ; variable para guardar resultado (1 o 0)

section .text
    global main               ; punto de entrada
    extern printf, scanf       ; funciones externas (de libc)

; ----------------------------------------------------------
; es_bisiesto:
;   Entrada: año en la pila (primer parámetro)
;   Salida: eax = 1 si es bisiesto, eax = 0 si no lo es
;
;   Consideraciones: 
;     - usar logica de division entre 400 y 4
; ----------------------------------------------------------

es_bisiesto:

no_bisiesto:

es_bisiesto_si:

fin_bisiesto:
   
; ----------------------------------------------------------
; main:
;   Muestra mensaje, lee año, llama a la función es_bisiesto,
;   e imprime el resultado.
; ----------------------------------------------------------

main:
    push ebp
    mov ebp, esp          ; preparar stack frame

    ; Mostrar mensaje de entrada
    push mensaje_entrada
    call printf
    add esp, 4            ; limpiar pila 

    ; Leer año desde teclado
    push anio             ; dirección donde guardar el valor leído
    push formato_entrada  ; formato "%d"
    call scanf
    add esp, 8            ; limpiar pila 

    ; Cargar el valor del año leído
    mov eax, [anio]       ; mover el año leído a eax
    push eax              ; pasar como argumento a la función
    call es_bisiesto      ; llamada a la función lógica
    add esp, 4            ; limpiar pila después de la llamada

    ; eax contiene el resultado (1 = bisiesto, 0 = no bisiesto)
    cmp eax, 1
    je imprimir_bisiesto

imprimir_no_bisiesto:
    push mensaje_noBis
    call printf
    add esp, 4
    jmp fin

imprimir_bisiesto:
    push mensaje_bis
    call printf
    add esp, 4

fin:
    mov esp, ebp
    pop ebp
    ret
