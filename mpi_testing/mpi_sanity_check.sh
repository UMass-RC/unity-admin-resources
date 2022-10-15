#!/bin/bash
module purge
if [[ $# -gt 0 ]]; then
    module load $1
fi
mpicc -o mpi_array mpi_array.c
# if it's not --pty the nested srun doesn't work
#srun --pty -p cpu-preempt -N 2 -c 4 srun mpi_array
srun --pty -p cpu-preempt -N 2 -c 4 mpi_array
rm mpi_array

