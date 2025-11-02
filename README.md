# Tarea Programada 2 Calculadora de años bisiestos

# Integrantes
- Stephanie Monge C35035
- Melissa Garita C23186
- Andrés Ramírez C36467
- Jimena Bejarano C31074

# Descripción del programa
Esta calculadora de años bisiestos funciona con base a divisiones para determinar si el año introducido por el usuario corresponde a un año bisiesto, o no. La estructura del código se encuentra dividida entre la función que realiza los cálculos para determinar lo anterior, la cual se encuentra codificada en lenguaje ensamblador. Asimismo, el código que maneja la interfaz se realizó utilizando C++ junto con la librería GTK3.

# Instrucciones para compilar el programa
Primeramente se debe verificar si se tiene instalado los paquetes necesarios para compilar la biblioteca GTK3 en C++, si no se tiene instalada, se debe ejecutar en la terminal el siguiente comando:
- sudo apt install build-essential nasm pkg-config libgtkmm-3.0-dev

Seguidamente se generó un archivo makefile para facilitar la compilación de los archivos .asm y .cpp. Para compilar el programa se debe ejecutar en la terminal el comando "make" y para correr el programa se debe utilizar el comando "make run"

Finalmente, se abre una ventana en donde se le pide el año al usuario y se debe presionar el botón de verificar para obtener la respuesta. Para cerrar correctamente el programa se debe presionar la "X" en la esquina superior derecha.