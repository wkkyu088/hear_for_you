'''
Create : post
Read   : get
Update : put
Delete : delete
'''
from fileinput import filename
from fastapi import FastAPI, File, Form, UploadFile
from pydantic import BaseModel
import sqlite3

from datetime import datetime
class Audio(BaseModel):
    id: str
    description: str | None = None


app = FastAPI()


# 상시모드
@app.get("/get-classification")
def get_classification(filename):
    conn = sqlite3.connect("HFU_Database.db")
    cur = conn.execute("SELECT * FROM STORAGE WHERE filename='%s'"%filename)
    storage = cur.fetchall()
    # 결과값을 얻은 후에는 해당 데이터 삭제하기
    print(storage)
    output = storage[-1][2]
    return output

@app.post("/send-audio/")
async def send_audio(file: UploadFile):    
    filename = datetime.now().strftime('%Y%d%m-%H:%M:%S-') + file.filename
    filepath = 'https://drive.google.com/file/d/1ZwOLHpafYP5L-fd5IYWbvPa-beb8rpIP/view?usp=sharing'

    conn = sqlite3.connect("HFU_Database.db")
    sql = "INSERT INTO STORAGE (filename, filepath) VALUES ('%s', '%s')" % (filename, filepath)
    conn.execute(sql)
    conn.commit()
    conn.close()

@app.post('/delete-audio')
async def delete_audio(filename):
    conn = sqlite3.connect("HFU_Database.db")
    sql = "DELETE FROM STORAGE WHERE filename='%s'" % filename
    conn.execute(sql)
    conn.commit()