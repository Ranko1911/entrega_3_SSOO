#include <iostream>
#include <chrono>
#include <thread>

int main() {
    std::cout << "Esperando 30 segundos..." << std::endl;
    
    // Espera 30 segundos
    std::this_thread::sleep_for(std::chrono::seconds(30));
    
    std::cout << "Espera completada." << std::endl;
    
    return 0;
}