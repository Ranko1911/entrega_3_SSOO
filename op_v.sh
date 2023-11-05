#!/bin/bash

directorio="scdebug/$1"


if [ -d "$directorio" ]; then
  archivo_mas_reciente=$(ls -t "$directorio" | head -1)
  
  if [ -n "$archivo_mas_reciente" ]; then
    echo "El archivo más reciente es $archivo_mas_reciente"
    echo "El directorio es $directorio"
    echo "La ruta es $directorio/$archivo_mas_reciente"
    cat "$directorio/$archivo_mas_reciente"
  else
    echo "El directorio está vacío o no contiene archivos."
  fi
else
  echo "El directorio $directorio no existe."
fi
