kill2(){ # funciona en maquina ajena, pero no en la local
  ps_output=$(ps -U $USER -o pid,comm --no-header)

  while read -r line; do
    pid=$(echo "$line" | awk '{print $1}')

    # Verificar si el proceso está siendo trazado
    if [ -f "/proc/$pid/status" ]; then
      tracer_pid=$(awk -F'\t' '/TracerPid/{print $2}' "/proc/$pid/status")
      if [ "$tracer_pid" -ne 0 ]; then
        echo "kill $tracer_pid"
        kill -s SIGKILL $tracer_pid &> /dev/null
        echo "kill -s SIGKILL $pid"
        kill -s SIGKILL $pid &> /dev/null
      fi
    fi
  done <<< "$ps_output"

}

kill2