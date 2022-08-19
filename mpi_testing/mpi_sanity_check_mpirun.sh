#!/bin/bash
module purge
if [[ $# -gt 0 ]]
then
	module load $1
fi
mpicc -o mpi_array mpi_array.c
srun -p cpu-preempt -N 2 -c 4 mpirun mpi_array
rm mpi_array
