; Archivo: bisiesto.asm
; Descripción: Función en ensamblador NASM x86
;              que determina si un año es bisiesto.
;---------------------------------------------------------------------

section .text
    global es_bisiesto        ; Exporta la función para usarla en C++

; int es_bisiesto(int year)
; Entrada: edi = año
; Salida: eax = 1 si es bisiesto, 0 si no

es_bisiesto:
    push rbp
    mov rbp, rsp

    ; --- Verificar si divisible entre 400 ---
    mov eax, edi        ; eax = year
    cdq
    mov ecx, 400
    idiv ecx
    cmp edx, 0
    je .bisiesto        ; Si divisible entre 400 → bisiesto

    ; --- Verificar si divisible entre 4 ---
    mov eax, edi
    cdq
    mov ecx, 4
    idiv ecx
    cmp edx, 0
    jne .no_bisiesto    ; Si no es divisible entre 4 → no bisiesto

    ; --- Verificar que NO sea divisible entre 100 ---
    mov eax, edi
    cdq
    mov ecx, 100
    idiv ecx
    cmp edx, 0
    je .no_bisiesto     ; Si es divisible entre 100 → no bisiesto

.bisiesto:
    mov eax, 1
    jmp .fin

.no_bisiesto:
    mov eax, 0

.fin:
    mov rsp, rbp
    pop rbp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
