import pandas as pd
import sqlalchemy as db
from sqlalchemy import text

def connect_db():
    engine = db.create_engine("mysql://root:root@172.16.5.4:3310/db_restaurante")
    conn = engine.connect()
 
    return conn


def connect_dw():
    engine = db.create_engine("mysql://root:root@172.16.5.4:3310/dw_restaurante")
    conn = engine.connect()
 
    return conn