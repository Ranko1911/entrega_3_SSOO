#!/bin/bash
TEXT_BOLD=$(tput bold) # tput bold hace que el texto sea negrita
TEXT_GREEN=$(tput setaf 2) # tput setaf 2 hace que el texto sea verde
TEXT_RED=$(tput setaf 1) # tput setaf 1 hace que el texto sea rojo
TEXT_RESET=$(tput sgr0) # tput sgr0 hace que el texto sea normal
TEXT_ULINE=$(tput sgr 0 1) # tput sgr 0 1 hace que el texto sea subrayado

#!/bin/bash

# Obtener la lista de procesos del usuario (reemplaza 'tu_usuario' con tu nombre de usuario)
ps_output=$(ps -U $USER -o pid,comm --no-header)

# Recorrer la lista de procesos y verificar el atributo TracerPid
while read -r line; do
  pid=$(echo "$line" | awk '{print $1}')
  process_name=$(echo "$line" | awk '{print $2}')

  # Verificar si el proceso está siendo trazado
  if [ -f "/proc/$pid/status" ]; then
    tracer_pid=$(awk -F'\t' '/TracerPid/{print $2}' "/proc/$pid/status")
      if [ "$tracer_pid" -ne 0 ]; then
        tracer_name=$(awk -F'\t' '/Name/{print $2}' "/proc/$tracer_pid/status")
        echo "${TEXT_GREEN} Proceso bajo trazado (PID, Nombre):$pid, $process_name ---- Proceso trazador (PID, Nombre): $tracer_pid, $tracer_name ${TEXT_RESET}"
        #echo "Proceso trazador (PID, Nombre): $tracer_pid, $tracer_name"
        echo "-------------------------"
      else 
        echo "${TEXT_RED} Proceso bajo trazado (PID, Nombre): $pid, $process_name ---- Proceso trazador (PID, Nombre): 0, Ninguno${TEXT_RESET}"
        #echo "Proceso trazador (PID, Nombre): 0, Ninguno"
        echo "-------------------------"
      fi
  fi
done <<< "$ps_output"