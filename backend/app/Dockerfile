# Utilizar una imagen base de Python
FROM python:3.9-slim

# Etiqueta del mantenedor
LABEL maintainer="r.pintos@alumno.um.edu.ar"

# Instalar dependencias del sistema
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

# Establecer el directorio de trabajo en /app
WORKDIR /app

# Copiar los archivos necesarios al contenedor
COPY config/requirements.txt config/
COPY config/app.ini config/
COPY app.py .
COPY utils/data_downloader.py utils/
COPY utils/indicators/ ./utils/indicators/

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r config/requirements.txt

# Exponer el puerto 5000 para que la aplicación Flask pueda ser accesible
EXPOSE 5000

# Ejecutar uWSGI con la configuración proporcionada en uwsgi.ini
CMD ["uwsgi", "--ini", "config/app.ini"]
