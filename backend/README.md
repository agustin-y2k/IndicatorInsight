# Indicator Insight

Indicator Insight es una aplicación web que proporciona análisis técnico financieros para usuarios principiantes y expertos. Utiliza indicadores técnicos como medias móviles y el índice de movimiento direccional promedio (ADX) para ofrecer recomendaciones sobre posibles oportunidades de compra o venta de acciones.

## Tabla de Contenidos

- [Indicator Insight](#indicator-insight)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Requisitos Previos](#requisitos-previos)
  - [Configuración](#configuración)
  - [Instalación](#instalación)
  - [Uso](#uso)
  - [Estructura del Proyecto](#estructura-del-proyecto)
  - [Métricas](#métricas)

## Requisitos Previos

Para poder ejecutar y utilizar Indicator Insight, asegúrate de tener instalado lo siguiente en tu sistema:

- Docker
- Python 3.9

## Configuración

1. Clona este repositorio en tu máquina local.
2. Asegúrate de tener Docker instalado y funcionando.
3. Asegúrate de tener Python 3.9 instalado en tu sistema.
4. Navega hasta el directorio del proyecto en tu terminal.

## Instalación

```bash
docker-compose up -d
```

## Uso

Una vez que los servicios estén en funcionamiento, puedes acceder a la aplicación web en http://localhost:5000. La aplicación proporciona los siguientes endpoints:


**Medias Móviles**

![METHOD](https://img.shields.io/badge/method-POST-yellow.svg) 

`'companies/<symbol>/indicators/<ma_type>`

        {
        "moving_average_type": " ",
        "periods": [ , , ...]
        }

**ADX**

![METHOD](https://img.shields.io/badge/method-POST-yellow.svg) 

`/companies/<symbol>/indicators/adx`

**Metricas**

![METHOD](https://img.shields.io/badge/method-GET-green.svg)

`/metrics`


## Estructura del Proyecto
El proyecto está estructurado de la siguiente manera:

 - *app.py*: Contiene la lógica principal de la aplicación Flask.
 - *data_downloader.py*: Se encarga de descargar y almacenar datos históricos de compañías financieras, actualizando el ultimo cada una hora.
 - *indicators/*: Carpeta que contiene los módulos para el cálculo de indicadores técnicos.
 - *fetch_data.py*: Se utiliza para recuperar datos almacenados en la base de datos MongoDB.
 - *app.ini*: Archivo de configuración para uWSGI.
 - *Dockerfile*: Archivo de configuración para construir la imagen de la API Flask.
 - *docker-compose.yml*: Archivo de configuración para Docker Compose.

## Métricas
La aplicación proporciona métricas que pueden ser recopiladas por Prometheus para su posterior visualización en Grafana. Las métricas disponibles incluyen el recuento total de solicitudes HTTP y la latencia de las solicitudes.

 ***Prometheus***

`localhost:9090`

 ***Grafana***

`localhost:3000`