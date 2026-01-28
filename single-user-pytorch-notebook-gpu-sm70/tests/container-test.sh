#!/bin/bash

set -e

echo '--- Python: torch check ---'
python -c 'import torch; print("torch", torch.__version__, "cuda:", torch.cuda.is_available())'

echo '--- Jupyter lab: check version ---'
jupyter lab --version || echo "❌ JupyterLab not found"

echo "✅ All tests passed!"
