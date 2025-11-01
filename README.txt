Función: int es_bisiesto(int year)
Entrada: year (entero)
Salida: 1 si el año es bisiesto, 0 si no lo es
Compilación del asm:
    nasm -f elf64 bisiesto.asm -o bisiesto.o
Ejecutar:
    g++ main.cpp bisiesto.o -o main
    ./main


