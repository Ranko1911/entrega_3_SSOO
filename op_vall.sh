#!/bin/bash

directorio="scdebug/sleep"
for archivo in "$directorio"/*; do
  if [ -f "$archivo" ]; then
    echo "Contenido de $archivo:"
    cat "$archivo"
  fi
done
