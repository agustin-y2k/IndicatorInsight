# Dockerfile
FROM python:3.9-slim

LABEL maintainer="r.pintos@alumno.um.edu.ar"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    && apt-get purge -y --auto-remove wget && \
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
<<<<<<< HEAD

=======
>>>>>>> develop

RUN pip install --no-cache-dir -r config/requirements.txt

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
