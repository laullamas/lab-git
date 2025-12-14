#!/bin/bash
#
# Script para cortar archivos fastq según el número de usuario
# Automatizado para cualquier alumnoXX
#

# Verificar argumentos
if [ $# -ne 1 ]; then
    echo "Uso: $0 archivo.fastq"
    exit 1
fi

input_file=$1

# Verificar que el archivo existe
if [ ! -f "$input_file" ]; then
    echo "ERROR: Archivo $input_file no encontrado"
    exit 1
fi

# Extraer número de usuario (de 'alumno09' extrae '09')
user_number=$(echo $USER | sed 's/alumno//')

# Determinar el divisor según la lógica del laboratorio
if [ "$user_number" == "01" ]; then
    divisor=10
else
    # Eliminar ceros a la izquierda (09 -> 9)
    divisor=$(echo $user_number | sed 's/^0*//')
fi

# Contar líneas totales
total_lines=$(wc -l < "$input_file")

# Calcular líneas a mantener
lines_to_keep=$((total_lines / divisor))

echo "Usuario: $USER (divisor: $divisor)"
echo "Archivo: $input_file"
echo "Total líneas: $total_lines"
echo "Líneas a mantener (1/$divisor): $lines_to_keep"

# Cortar usando archivo temporal por seguridad
head -n $lines_to_keep "$input_file" > "${input_file}.tmp"

# Sobreescribir el archivo original
mv "${input_file}.tmp" "$input_file"

echo "Archivo procesado correctamente"
