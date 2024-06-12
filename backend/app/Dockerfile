# Dockerfile
FROM python:3.9-slim

LABEL maintainer="r.pintos@alumno.um.edu.ar"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    gcc \
    && \
    wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && \
    ./configure --prefix=/usr && \
    make && \
    make install && \
    cd .. && \
    rm -rf ta-lib* && \
    apt-get purge -y --auto-remove build-essential wget && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY config/requirements.txt config/
COPY main.py .
COPY __init__.py .
COPY utils/data_downloader.py utils/
COPY utils/get_data.py utils/
COPY utils/auth.py utils/
COPY utils/indicators/ ./utils/indicators/
COPY routes/ ./routes/
COPY models/ ./models/


RUN pip install --no-cache-dir -r config/requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

