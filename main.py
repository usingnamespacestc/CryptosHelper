import dataGrabber
import sqlController
from fastapi import FastAPI

app = FastAPI()


@app.get("/get_crypto_list/")
async def get_crypto_list():
    return sqlController.get_crypto_list()
    # crypto_list = sqlController.get_crypto_list()
    # res = {}
    # for i in range(0, len(crypto_list)):
    #     res[i] = {"name": crypto_list[i][0], "symbol": crypto_list[i][1]}
    # return res


@app.get("/get_latest_price/{symbol}")
async def get_latest_price(symbol=str):
    res = sqlController.get_latest_price(symbol)
    return {"last_updated": res[0], "price": res[1]}


@app.get("/")
async def root():
    return {"message": "Hello World"}


if __name__ == '__main__':
    coin_data = dataGrabber.grab_data()
    sql_list = sqlController.update_data(coin_data)
    # sqlController.execute_sql(sql_list)
