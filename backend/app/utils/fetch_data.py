import pymongo
import logging
from .data_downloader import download_and_store_data, update_latest_data
import datetime

def fetch_company_data(symbol):
    try:
        client = pymongo.MongoClient("mongodb://mongodb:27017/")
        db = client["indicator_insight"]

        collection = db[symbol]
        # Comprobar si la colección no está vacía
        data_count = collection.count_documents({})

        # Si la colección está vacía, descargar y almacenar datos históricos
        if data_count == 0:
            logging.info(f"No data found for symbol {symbol}. Downloading and storing historical data.")
            download_and_store_data(datetime.datetime.today().strftime('%Y-%m-%d'), symbol)

        else:
            # Obtener la fecha de hoy
            today = datetime.datetime.now().strftime('%Y-%m-%d')
            
            # Obtener la fecha del último documento en el mismo formato que today
            latest_document = collection.find_one(sort=[('Date', -1)])
            latest_document_date = latest_document['Date'].strftime('%Y-%m-%d')

            if latest_document_date != today:
                logging.info(f"Data found for symbol {symbol} but not for today's date. Downloading and storing missing historical data.")
                download_and_store_data(today, symbol)
            else:
                logging.info(f"Data found for symbol {symbol} and for today's date. Updating today's data.")
                update_latest_data(symbol)

        # Obtener y devolver todos los datos de la colección
        cursor = collection.find({}, {"_id": 0, "Date": 1, "Open": 1, "High": 1, "Low": 1, "Close": 1, "Adj Close": 1, "Volume": 1})
        data = list(cursor)
        return data

    except pymongo.errors.PyMongoError as e:
        logging.error(f"A MongoDB error occurred: {e}")
        return None
    except Exception as e:
        logging.exception(f"An unexpected error occurred: {e}")
        return None