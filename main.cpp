// ======================================
// Archivo: main.cpp
// Descripción: Interfaz gráfica en C++ (GTKmm)
//              que utiliza la función NASM es_bisiesto()
// ======================================

#include <gtkmm.h>
#include <string>
#include <cctype>
#include <cstdlib>

extern "C" int es_bisiesto(int year);

class VentanaPrincipal : public Gtk::Window {
public:
    VentanaPrincipal() {
        set_title("Calculadora de Año Bisiesto");
        set_default_size(400, 150);
        set_border_width(15);

        etiqueta.set_text("Ingresa un año y presiona 'Verificar':");
        caja_principal.pack_start(etiqueta, Gtk::PACK_SHRINK, 10);

        caja_horizontal.set_spacing(10);
        caja_principal.pack_start(caja_horizontal, Gtk::PACK_SHRINK);

        entrada.set_placeholder_text("Ejemplo: 2024");
        caja_horizontal.pack_start(entrada, Gtk::PACK_EXPAND_WIDGET);

        boton.set_label("Verificar");
        caja_horizontal.pack_start(boton, Gtk::PACK_SHRINK);

        // Conectar señales
        boton.signal_clicked().connect(sigc::mem_fun(*this, &VentanaPrincipal::on_boton_clicked));
        entrada.signal_activate().connect(sigc::mem_fun(*this, &VentanaPrincipal::on_boton_clicked));

        add(caja_principal);
        show_all_children();
    }

protected:
    Gtk::Box caja_principal{Gtk::ORIENTATION_VERTICAL, 10};
    Gtk::Box caja_horizontal{Gtk::ORIENTATION_HORIZONTAL, 10};
    Gtk::Label etiqueta;
    Gtk::Entry entrada;
    Gtk::Button boton;

    void on_boton_clicked() {
        std::string texto = entrada.get_text();

        if (!esNumero(texto)) {
            Gtk::MessageDialog dialog(*this,
                "Por favor ingresa un número entero válido.",
                false,
                Gtk::MESSAGE_WARNING,
                Gtk::BUTTONS_OK);
            dialog.set_title("Entrada inválida");
            dialog.run();
            return;
        }

        int anio = std::stoi(texto);
        int resultado = es_bisiesto(anio);

        std::string mensaje = (resultado)
            ? "El año " + std::to_string(anio) + " es bisiesto."
            : "El año " + std::to_string(anio) + " no es bisiesto.";

        Gtk::MessageDialog dialog(*this, mensaje, false, Gtk::MESSAGE_INFO, Gtk::BUTTONS_OK);
        dialog.set_title("Resultado");
        dialog.run();
    }

    bool esNumero(const std::string &s) {
        if (s.empty()) return false;
        size_t start = (s[0] == '-' || s[0] == '+') ? 1 : 0;
        if (start == s.size()) return false;
        for (size_t i = start; i < s.size(); ++i)
            if (!std::isdigit(static_cast<unsigned char>(s[i])))
                return false;
        return true;
    }
};

int main(int argc, char *argv[]) {
    auto app = Gtk::Application::create(argc, argv, "ucr.tarea2.bisiesto");
    VentanaPrincipal ventana;
    return app->run(ventana);
}
