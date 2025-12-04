FROM python:3.12-slim

# Munkakönyvtár a konténeren belül
WORKDIR /app

# Függőségek bemásolása és telepítése
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Alkalmazáskód bemásolása
COPY . .

# Az alkalmazás 8080-as porton figyel, dokumentálás szempontjából lehet jelentősége elsődlegesen
EXPOSE 8080

# Az app indítása
CMD ["python", "BeadandoREL301.py"]
