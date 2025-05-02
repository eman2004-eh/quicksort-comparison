# Makefile for Quick Sort Comparative Analysis

CXX = g++
MPICXX = mpic++
CXXFLAGS = -O3 -std=c++11 -Wall
OPENMP_FLAGS = -fopenmp
MPI_FLAGS = 

# Output executables
SEQUENTIAL_OUT = quicksort_sequential
MULTITHREADED_OUT = quicksort_multithreaded
OPENMP_OUT = quicksort_openmp
MPI_OUT = quicksort_mpi
ALL_OUT = quicksort_all_modes

# Source files
SEQUENTIAL_SRC = quicksort_sequential.cpp
MULTITHREADED_SRC = quicksort_multithreaded.cpp
OPENMP_SRC = quicksort_openmp.cpp
MPI_SRC = quicksort_mpi.cpp
ALL_SRC = quicksort.cpp

# Default target
all: sequential multithreaded openmp mpi all_modes

# Sequential version
sequential: $(SEQUENTIAL_SRC)
    $(CXX) $(CXXFLAGS) -o $(SEQUENTIAL_OUT) $(SEQUENTIAL_SRC)

# Conventional multi-threaded version
multithreaded: $(MULTITHREADED_SRC)
    $(CXX) $(CXXFLAGS) -pthread -o $(MULTITHREADED_OUT) $(MULTITHREADED_SRC)

# OpenMP version
openmp: $(OPENMP_SRC)
    $(CXX) $(CXXFLAGS) $(OPENMP_FLAGS) -o $(OPENMP_OUT) $(OPENMP_SRC)

# MPI version
mpi: $(MPI_SRC)
    $(MPICXX) $(CXXFLAGS) $(MPI_FLAGS) -o $(MPI_OUT) $(MPI_SRC)

# All modes in one executable
all_modes: $(ALL_SRC)
    $(MPICXX) $(CXXFLAGS) $(OPENMP_FLAGS) -o $(ALL_OUT) $(ALL_SRC)

# Run benchmarks
run_benchmarks: all
    @echo "Running sequential benchmark..."
    ./$(SEQUENTIAL_OUT)
    @echo "Running multi-threaded benchmark..."
    ./$(MULTITHREADED_OUT)
    @echo "Running OpenMP benchmark..."
    ./$(OPENMP_OUT)
    @echo "Running MPI benchmark with 4 processes..."
    mpirun -np 4 ./$(MPI_OUT)
    @echo "Running comprehensive benchmark with all modes..."
    ./$(ALL_OUT)

# Clean up
clean:
    rm -f $(SEQUENTIAL_OUT) $(MULTITHREADED_OUT) $(OPENMP_OUT) $(MPI_OUT) $(ALL_OUT) *.o

# Help target
help:
    @echo "Available targets:"
    @echo "  all             - Build all executables"
    @echo "  sequential      - Build sequential version"
    @echo "  multithreaded   - Build conventional multi-threaded version"
    @echo "  openmp          - Build OpenMP version"
    @echo "  mpi             - Build MPI version"
    @echo "  all_modes       - Build comprehensive version with all modes"
    @echo "  run_benchmarks  - Build and run all benchmarks"
    @echo "  clean           - Remove all executables"
    @echo "  help            - Display this help message"

.PHONY: all sequential multithreaded openmp mpi all_modes run_benchmarks clean help
