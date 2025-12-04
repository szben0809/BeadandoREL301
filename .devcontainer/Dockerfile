FROM python:3.12-slim

# Alap fejlesztői környezet létrehozása
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Munkakönyvtár a konténerben
WORKDIR /workspace
