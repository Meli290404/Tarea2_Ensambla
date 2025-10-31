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
    formato_entrada db "%d", 0        

section .bss 
    anio resd 1   ; variable que guarda el año ingresado 
    res  resd 1   ; variable para guardar resultado (1 o 0)

section .text
    global main               ; punto de entrada
    extern printf, scanf       ; funciones externas (de libc)

; ----------------------------------------------------------
; es_bisiesto:
;   Entrada: año en la pila (primer parámetro)
;   Salida: rax = 1 si es bisiesto, rax = 0 si no lo es
;
;   
; ----------------------------------------------------------

es_bisiesto:
push rbp
mov rbp, rsp

sub rsp, 16            ; reservar espacio local
mov dword [rbp-4], edi ; guardar el parámetro (year) en memoria local

mov eax, [rbp-4]       ; eax = year
cdq                    ; extiende signo de eax -> edx
mov ecx, 400
idiv ecx               ; edx = year % 400
cmp edx, 0
jne .divisible4y100
mov eax, 1
jmp .fin

.divisible4y100:
; ver si es divisible entre 4
mov eax, [rbp-4]
cdq
mov ecx, 4
idiv ecx
cmp edx, 0
jne .no_bisiesto
;si es divisible entre cuatro, ver que no es divisible entre 100
mov eax, [rbp-4]
cdq
mov ecx, 100
idiv ecx
cmp edx, 0
je .no_bisiesto
;divisible entre 4 y no entre 100
mov eax, 1
jmp .fin

.no_bisiesto:
mov eax, 0

.fin:
add rsp, 16
mov rsp, rbp
pop rbp
ret
   
; ----------------------------------------------------------
; main:
;   Muestra mensaje, lee año, llama a la función es_bisiesto,
;   e imprime el resultado.
; ----------------------------------------------------------

main:
    push rbp
    mov rbp, rsp          ; preparar stack frame

    ; Mostrar mensaje de entrada
    lea rdi, [rel mensaje_entrada]
    xor eax, eax
    call printf

    ; Leer año desde teclado
    lea rdi, [rel formato_entrada]  ; formato "%d"
    lea rsi, [rel anio]             ; dirección donde guardar el valor leído
    xor eax, eax
    call scanf

    ; Cargar el valor del año leído
    mov eax, dword [rel anio]   ; mover el año leído a eax
    mov edi, eax                ; pasar como argumento a la función
    call es_bisiesto            ; llamada a la función lógica

    ; rax contiene el resultado (1 = bisiesto, 0 = no bisiesto)
    cmp eax, 1
    je imprimir_bisiesto

imprimir_no_bisiesto:
    lea rdi, [rel mensaje_noBis]
    xor eax, eax
    call printf
    jmp fin

imprimir_bisiesto:
    lea rdi, [rel mensaje_bis]
    xor eax, eax
    call printf

fin:
    mov eax, 0
    mov rsp, rbp
    pop rbp
    ret
section .note.GNU-stack noalloc noexec nowrite progbits
