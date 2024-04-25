import pandas as pd

def transform_time_from_pedido(query, conn):
    return pd.read_sql(query, con=conn)