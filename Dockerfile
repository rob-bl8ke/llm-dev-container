FROM continuumio/miniconda3

WORKDIR /workspace

# Copy all required files into the container
COPY environment.base.yml .
COPY requirements.data.txt .
COPY requirements.llm.txt .
COPY requirements.tools.txt .
COPY bootstrap.sh .

# Make the bootstrap script executable
RUN chmod +x /workspace/bootstrap.sh

# Install mamba and create base environment
RUN conda install -y -n base -c conda-forge mamba && \
    mamba env create -f environment.base.yml && \
    conda clean -afy

# Register the Jupyter kernel
RUN conda run -n llms python -m ipykernel install --user --name=llms
