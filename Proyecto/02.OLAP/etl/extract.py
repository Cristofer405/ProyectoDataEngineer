import pandas as pd

def extract_only_table(tabla, conn):
    df = pd.read_sql(f"SELECT * FROM {tabla}", con = conn)
    return df

