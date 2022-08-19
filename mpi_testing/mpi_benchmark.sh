#!/bin/bash
module purge
module load $1
mpicc -o mpi_array_big mpi_array_big.c
#srun -p cpu-preempt -N 2 -c 4 mpirun mpi_array
srun -p cpu-preempt -N 2 -c 10 --mem=32000 mpirun mpi_array_big
rm mpi_array_big
