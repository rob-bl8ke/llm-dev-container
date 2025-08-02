#!/bin/bash
set -e

echo "🔁 Activating Conda environment..."
source /opt/conda/etc/profile.d/conda.sh
conda activate llms

echo "📦 Installing Tier 2 - Data Science libraries..."
pip install -r /workspace/requirements.data.txt

echo "🤖 Installing Tier 3 - LLM libraries..."
pip install -r /workspace/requirements.llm.txt

echo "🧰 Installing Tier 4 - Tools..."
pip install -r /workspace/requirements.tools.txt

echo "🚀 Launching Jupyter Lab..."
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root
