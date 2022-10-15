#!/bin/bash
module purge
module load $1
mpicc -o mpi_array_big mpi_array_big.c
srun --pty -p cpu-preempt -N 2 -c 4 --mem=6G date && mpirun mpi_array_big && date
rm mpi_array_big
