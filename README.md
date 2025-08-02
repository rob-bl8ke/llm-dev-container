

# 🧠 LLM Engineering (Dockerized Dev Environment)

This project sets up a **fully containerized** environment for developing with LLMs, AI libraries, and Jupyter Lab — with **no local Conda or Python installation** required.

‼️Ensure to take a look at the possible gotchas getting this to run for the first time.

## 🔧 What's Included

- **Miniconda** + Mamba for Python environment management
- **Tiered install**: splits dependencies to avoid memory issues
- **Jupyter Lab** as the main UI
- Preinstalled libraries for:
  - 📊 Data science: pandas, numpy, matplotlib, scikit-learn
  - 🤖 AI/LLM: torch, transformers, langchain, sentence-transformers
  - 🧰 Tools: dotenv, openai, pydub, psutil, twilio

## 🚀 Getting Started

### 1. Clone & build

```bash
git clone https://github.com/your-org/llm_engineering.git
cd llm_engineering
docker compose up --build
````

### 2. Access Jupyter

Visit [http://localhost:8888](http://localhost:8888) in your browser. The token will appear in the console log.

## 📦 Daily Development

Using `docker compose down` is quite destructive to use often because of the length of time it takes to do a `docker compose up`. Better to stop the environment and restart it again until you have to clean up resources.

```bash
docker compose stop
docker compose start
```
which is the equivalent of...
```bash
docker compose restart
```


## 🔐 API Keys via `.env`

Create a `.env` file in the project root:

```
OPENAI_API_KEY=sk-xxx
GOOGLE_API_KEY=xxx
ANTHROPIC_API_KEY=xxx
```

These are accessible in your notebooks using `dotenv`.

## 💡 Notes

* All dependencies are installed inside the container.
* Environment is built in tiers to avoid memory crashes.
* Your project files are mounted into the container via volume.

## 📦 Clean Up

```bash
docker compose down         # Stop and remove the container
docker system prune -a      # Remove all images/containers (careful!)
```

# Environment without spinning up ollama locally

If all you want to do is run labs and connect to LLM cloud APIs then you will not need a local installation of `ollama`. In this case, go with a simpler version of `docker-compose.yml` that does not depend on an `ollama` container.

```docker
services:
  llm-env:
    build:
      context: .
    container_name: llm-engineering
    volumes:
      - .:/workspace
    ports:
      - "8888:8888"
    entrypoint: ["/workspace/bootstrap.sh"]
    tty: true
    stdin_open: true
```

# 💥 Gotchas

### `bootstrap.sh` no such file or directory

When trying to do a `docker compose up` you run into the issue below:

```
 => resolving provenance for metadata file                                                                                                                                                                                            0.0s
[+] Running 3/3
 ✔ llm-env                            Built                                                                                                                                                                                           0.0s 
 ✔ Network llm-dev-container_default  Created                                                                                                                                                                                         0.1s 
 ✔ Container llm-dev-container        Created                                                                                                                                                                                         0.1s 
Attaching to llm-dev-container
llm-dev-container  | exec /workspace/bootstrap.sh: no such file or directory
llm-dev-container exited with code 255
```

What's really happening (if you're on a Windows machine) is that if you run this in your editor (eg. Visual Studio Code) after cloning the repository, your`bootstrap.sh` file is replacing `\n` with `\r\n` (CRLF) the classic line-ending issue. When the file is copied to the container the file cannot be read properly by the Linux system. To fix this, the easiest thing to do is to ensure that your file is changed to LF instead of CRLF. You can do this in Visual Studio on the bottom status bar or simply set the defaults in settings. 