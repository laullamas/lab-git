#!/bin/bash
#
# Script SLURM para cortar archivos fastq en paralelo
# 
#SBATCH -p hpc-bio-ampere
#SBATCH --chdir=/home/alumno09/lab-git
#SBATCH -J cut-alumno09
#SBATCH --cpus-per-task=1
#SBATCH --ntasks=4
#SBATCH --mail-type=NONE

echo "======================================"
echo "Cortando archivos fastq en paralelo"
echo "======================================"

# Verificar tamaños originales
echo "Tamaños ANTES del corte:"
ls -lh Sample*.fastq
echo ""

echo "Procesando archivos en paralelo..."

# Ejecutar file-cut.sh en paralelo para cada archivo (método explícito)
./file-cut.sh Sample1.fastq &
./file-cut.sh Sample2.fastq &
./file-cut.sh Sample3.fastq &
./file-cut.sh Sample4.fastq &

# Esperar a que terminen todos los procesos
wait

echo ""
echo "======================================"
echo "Procesamiento completado"
echo "======================================"
echo ""

# Mostrar tamaños finales
echo "Tamaños DESPUÉS del corte:"
ls -lh Sample*.fastq
