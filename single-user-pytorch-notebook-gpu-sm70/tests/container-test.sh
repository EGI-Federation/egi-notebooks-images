#!/bin/bash

set -e

echo '--- Python: torch check ---'
python -c 'import torch; print("torch", torch.__version__, "cuda:", torch.cuda.is_available())'

echo '--- Jupyter lab: check version ---'
jupyter lab --version || echo "❌ JupyterLab not found"

export PATH="/usr/local/julia/bin:/usr/bin:$PATH"
export JULIA_DEPOT_PATH=/opt/julia_depot

echo '--- Julia version ---'
julia --version

echo '--- Julia: test CUDA and IJulia ---'
julia -e "
    using Pkg
    using CUDA
    println(\"✅ CUDA.jl loaded\")
    using IJulia
    println(\"✅ IJulia.jl loaded\")
  "

echo "✅ All tests passed!"
