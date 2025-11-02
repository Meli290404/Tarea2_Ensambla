# Compiladores y herramientas
CXX = g++
ASM = nasm
PKG = pkg-config
PKG_FLAGS = $(shell $(PKG) --cflags --libs gtkmm-3.0)

# Archivos del proyecto
SRC_CPP = main.cpp
SRC_ASM = bisiesto.asm
OBJ_ASM = $(SRC_ASM:.asm=.o)
TARGET = tarea2

# Flags
CXXFLAGS = -std=c++17 -Wall -no-pie
ASMFLAGS = -f elf64

# ============================================
# Reglas principales
# ============================================

all: $(TARGET)

$(TARGET): $(SRC_CPP) $(OBJ_ASM)
	@echo "🔧 Compilando proyecto..."
	$(CXX) $(SRC_CPP) $(OBJ_ASM) -o $(TARGET) $(CXXFLAGS) $(PKG_FLAGS) -Wl,-rpath,/usr/lib/x86_64-linux-gnu
	@echo "Compilación finalizada. Ejecuta 'make run' para probar."

$(OBJ_ASM): $(SRC_ASM)
	@echo "Ensamblando módulo NASM..."
	$(ASM) $(ASMFLAGS) $(SRC_ASM) -o $(OBJ_ASM)

# ============================================
# Ejecución en entorno limpio (sin Snap)
# ============================================

run: $(TARGET)
	@echo "Ejecutando aplicación en entorno limpio (autenticado)..."
	env -i \
	  DISPLAY=$(DISPLAY) \
	  XAUTHORITY=$(XAUTHORITY) \
	  DBUS_SESSION_BUS_ADDRESS=$(DBUS_SESSION_BUS_ADDRESS) \
	  HOME=$(HOME) \
	  PATH=/usr/bin:/bin \
	  LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu \
	  ./$(TARGET)


# ============================================
# Limpieza
# ============================================

clean:
	@echo "Limpiando archivos generados..."
	rm -f $(OBJ_ASM) $(TARGET)
	@echo "Limpieza completa."
