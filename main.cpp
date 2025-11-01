#include <iostream>
using namespace std;

extern "C" int es_bisiesto(int year);

int main() {
    int años[] = {1900, 2000, 2024, 2025};
    for (int año : años) {
        int res = es_bisiesto(año);
        cout << año << " -> " << (res ? "Bisiesto" : "No bisiesto") << endl;
    }
    return 0;
}
