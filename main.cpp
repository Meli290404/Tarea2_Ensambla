// Archivo: main.cpp
// Descripción: Interfaz gráfica en C++ (GTKmm)
//              que utiliza la función NASM es_bisiesto()

// Se importan las librerías necesarias
#include <gtkmm.h>
#include <string>
#include <cctype>
#include <cstdlib>

//Se declara la función ensamblador
extern "C" int es_bisiesto(int year);

class VentanaPrincipal : public Gtk::Window {
public:
    // Constructor donde se inicializan todos los elementos de la GUI
    VentanaPrincipal() {
        set_title("Calculadora de Año Bisiesto");  // Título de la ventana
        set_default_size(400, 150);  // Tamaño de la ventana
        set_border_width(15);  // Borde de la ventana

        // Etiqueta que le indica al usuario la instrucción
        etiqueta.set_text("Ingresa un año y presiona 'Verificar':");
        caja_principal.pack_start(etiqueta, Gtk::PACK_SHRINK, 10);

        // Caja horizontal para entrada y botón
        caja_horizontal.set_spacing(10);
        caja_principal.pack_start(caja_horizontal, Gtk::PACK_SHRINK);

        // Entrada de texto para el año
        caja_horizontal.pack_start(entrada, Gtk::PACK_EXPAND_WIDGET);

        boton.set_label("Verificar");
        caja_horizontal.pack_start(boton, Gtk::PACK_SHRINK);

        // Se conecta la señal que se genera cuando se presiona el botón y se llama a la función on_boton_clicked.
        boton.signal_clicked().connect(sigc::mem_fun(*this, &VentanaPrincipal::on_boton_clicked));
        entrada.signal_activate().connect(sigc::mem_fun(*this, &VentanaPrincipal::on_boton_clicked));

        // Se agregan los elementos a la ventana y se muestran.
        add(caja_principal);
        show_all_children();
    }

protected:
    // Componentes principales de la interfaz
    Gtk::Box caja_principal{Gtk::ORIENTATION_VERTICAL, 10};
    Gtk::Box caja_horizontal{Gtk::ORIENTATION_HORIZONTAL, 10};
    Gtk::Label etiqueta;
    Gtk::Entry entrada;
    Gtk::Button boton;

    // Función que se ejecuta al presionar el botón.
    void on_boton_clicked() {
        // Se obtiene el texto ingresado por el usuario.
        std::string texto = entrada.get_text();

        // Validar que la entrada sea un número entero.
        if (!esNumero(texto)) {
            Gtk::MessageDialog dialog(*this,
                "Por favor ingresa un número entero positivo válido.",
                false,
                Gtk::MESSAGE_WARNING,
                Gtk::BUTTONS_OK);
            dialog.set_title("Entrada inválida");
            dialog.run();
            return;
        }

        int anio = std::stoi(texto);
        int resultado = es_bisiesto(anio);

        // Dependiendo del resultado, se muestra un mensaje diferente.
        std::string mensaje = (resultado)
            ? "El año " + std::to_string(anio) + " es bisiesto."
            : "El año " + std::to_string(anio) + " no es bisiesto.";

        // Mostrar el resultado en un cuadro de diálogo.
        Gtk::MessageDialog dialog(*this, mensaje, false, Gtk::MESSAGE_INFO, Gtk::BUTTONS_OK);
        dialog.set_title("Resultado");
        dialog.run();
    }

    // Función que verifica si el texto ingresado es un número entero positivo válido
    bool esNumero(const std::string &s) {
        if (s.empty()) return false;

        // Si el primer carácter es un signo negativo, se considera inválido
        if (s[0] == '-') return false;

        // Si el primer carácter es un signo positivo, lo ignoramos
        size_t start = (s[0] == '+') ? 1 : 0;

        // Si después del signo no hay más caracteres, no es un número
        if (start == s.size()) return false;

        // Se recorre cada carácter y verifica que todos sean dígitos
        for (size_t i = start; i < s.size(); ++i) {
            if (!std::isdigit(static_cast<unsigned char>(s[i])))
                return false;
        }

        return true;
    }

};

int main(int argc, char *argv[]) {
    auto app = Gtk::Application::create(argc, argv, "tarea2.bisiesto");
    VentanaPrincipal ventana;
    return app->run(ventana);
}
