# Devops beadandó - Szablics Benedek (REL301)

## Általános információk és a projekt során használt fejlesztői eszközök

Ez a projekt a Gábor Dénes Egyetem mérnökinformatikus BSc képzése keretében( távoktatás munkarend) megszervezett "DevOps" c. tantárgy teljesítésének (egyik) feltételeként meghatározott beadandó feladat elkészítésének rövid dokumentációját tartalmazza.

A programot Visual Studio Code fejlesztői környezetben, Python nyelven írtam. A szerver létrehozása, valamint az alkalmazás böngészőből történő elérhetőségének biztosítása érdekében Flask webes keretrendszert használtam.
Egy egyszerű Flask alapú webalkalmazásról van tehát szó, amely HTTP-n, a 8080-as porton érhető el, és egy rövid szöveget ("Hello DevOps! Ez Szablics Benedek beadandó feladata.") jelenít meg.

A verziókövetéshez Gitet, a konténeralapú virtualizációhoz Dockert, a fejlesztői környezet egységesítéséhez és reprodukálhatóságához pedig Dev Containert használtam. A repository-t GitHubon tároltam.

A beadandó elkészítése nagyvonalakban a következő lépésekből állt:

## I. Alkalmazás (fejlesztés és build)

Az alkalmazás tehát Python és Flask segítségével készült.
A programot az azonos elnevezésű projektmappa létrehozását követően "BeadandoREL301.py" néven mentettem.

A kód megírását követően beállítottam a Python környezetet, ennek részeként:
1. létrehoztam és aktiváltam a virtuális környezetet (venv) ["py -m venv venv", majd "venv\Scripts\activate" parancs a terminalba (cmd)];
2. létrehoztam a requirements.txt fájlt, a "flask==3.0.0" tartalommal;
3. Telepítettem a Flasket a "pip install -r requirements.txt" paranccsal.


Ezután futtattam a programot, majd böngészőből leellenőriztem azt (a terminalban megjelenő hivatkozások mellett a "https://localhost:8080" linken keresztül is).


A program hibamentesen elindult, és a Flask alkalmazás a 8080-as proton keresztül HTTP-n elérhetővé vált. A böngészőben a http://localhost:8080 cím megnyitásakor a vártnak megfelelően megjelent a saját üzenetem ("Hello DevOps! Ez Szablics Benedek beadandó feladata.").
Mindez igazolta, hogy a környezet előkészítése, a függőségek telepítése és a program implementálása sikeresen megtörtént.

### Ia. Build és (helyi) futtatás - külső felhasználóknak

#### A buildeléshez a következő parancs szükséges:

"pip install -r requirements.txt".

#### Az alkalmazás a következő paranccsal futtatható:

"python BeadandoREL301.py".


## II. README.md

Az alkalmazás megírását és a futtatás ellenőrzését követően létrehoztam jelen README.md fájlt, és dokumentáltam az eddig megtett lépéseket. Ezt követően a dokumentációt a hátralevő feladatok kivitelezésével párhuzamosan bővítettem.



## III. Git használata - trunk-based fejlesztés

A Git használata érdekében először létrehoztam a .gitignore fájlt a projekt gyökerében, a következő tartalommal:
"venv/
__pycache__/
*.pyc".


Ezután eltávolítottam a venv mappát a Git stagingből (nem töröltem a fizikális venv mappát, csak kivettem a Git alól):

"git rm -r --cached venv".


Erre azért volt szükség, hogy a virtuális környezet (venv/) ne kerüljön a Git repóba.


Az alkalmazás fejlesztését, buildelését és a dokumentáció (README.md) készítésének elkezdését követően inicializáltam a Git repository-t a lokális gépen:

"git init
git add .
git commit -m "Initial commit: Elso commit Szablics Benedek DevOps beadandojahoz".


Ezután röviden ellenőriztem az iméntieket a "git status" paranccsal, majd létrehoztam egy publikus GitHub repository-t, összekapcsoltam vele a lokális projektet és feltöltöttem az első commitot a main branchre:

"git remote add origin <https://github.com/szben0809/BeadandoREL301.git>

git branch -M main
git push -u origin main".

Ezzel a main ág (trunk) létrejött, és a kiinduló projektstruktúra verziókövethetővé vált.

A feladat legalább egy feature branchet ír elő. Ennek megfelelően létrehoztam egy külön fejlesztési ágat:

"git checkout -b feature/kulon-ag"

majd ezt pusholtam:

"git push -u origin feature/kulon-ag"

Ezen az ágon kisebb funkcionális módosítást hajtottam végre a VS Codeban: megváltoztattam a visszaadott üzenet szövegét "Hello DevOps! Ez Szablics Benedek beadandó feladata." helyett "Hello DevOps! Ez Szablics Benedek beadandó feladatának külön fejlesztési ága.", majd commitoltam:

"git commit -m "A kiírás megváltoztatása".

Mivel először véletlenül rossz címet adtam a commitnak, ezt javítanom kellett, amelynek érdekében force push-t alkalmaztam:

"git push --force-with-lease origin feature/kulon-ag".

Ez szerencsére nem okozott problémát.

A módosítások áttekintése, ellenőrzése után a "feature/kulon-ag" ágat összeolvasztottam a main ággal. Ennek érdekében Githubon Pull Requestet hoztam létre.

Emellett a tanultak alkalmazásával létrehoztam még egy külön ágat, amelyben a program a "Hello Devops! Ez megint egy másik szöveg." szöveget írja ki.



## IV. Dockerizálás

A projekt gyökérkönyvtárában létrehoztam egy "Dockerfile" nevű fájlt az alábbi tartalommal:

"FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python", "BeadandoREL301.py"]"

Ez a Dockerfile beállítja az /app munkakönyvtárat, bemásolja a requirements.txt fájlt, telepíti a szükséges függőségeket, bemásolja az alkalmazás forráskódját a konténerbe, illetve beállítja, hogy a konténer indulásakor automatikusan elinduljon a Flask alkalmazás a BeadandoREL301.py futtatásával.

### IVa. Docker image buildelése és futtatása - külső felhasználóknak

Az alkalmazás Docker-konténerben történő felépítéséhez és futtatásához az alábbi parancsok szükségesek:

#### (A) Image buildelése
A projekt gyökérkönyvtárában az alábbi paranccsal hozható létre a Docker image:

"docker build -t devops-beadando-rel301:v1 ."

[Ez a parancs felépíti a devops-beadando-rel301:v1 nevű Docker imaget a fenti Dockerfile felhasználásával].

#### (B) Konténer futtatása

Az elkészült image a következő paranccsal futtatható:

"docker run -p 8080:8080 devops-beadando-rel301:v1".

## V. Dev Container (kötelezően választandó feladat)

A projekt fejlesztéséhez és későbbi reprodukálhatóságához Visual Studio Code Dev Containert hoztam létre. Ennek célja, hogy a fejlesztői környezet egységesen, konténerben legyen biztosítva, függetlenül a host gép beállításaitól.

### V.1. Dev Container konfiguráció

A projekt gyökérkönyvtárában létrehoztam egy ".devcontainer" nevű mappát, a "devcontainer.json", illetve a "Dockerfile" fájlokkal.


### A ".devcontainer/devcontainer.json" tartalma:
{  "name": "DevOps Beadando REL301",
  "build": {
    "dockerfile": "Dockerfile",
    "context": ".."
  },
  "workspaceFolder": "/workspace",
  "forwardPorts": [8080],
  "postCreateCommand": "pip install -r requirements.txt",
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python"]}}}.

### A ".devcontainer/Dockerfile" tartalma:

"FROM python:3.12-slim

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace".

A fenti konfiguráció biztosítja, hogy
- a Dev Container a python:3.12-slim image-re épüljön,
- elérhető legyen a Git a konténeren belül,
- a projekt forráskódja a /workspace könyvtárba legyen felcsatolva,
- a konténer létrehozását követően automatikusan lefusson a pip install -r requirements.txt parancs (így a szükséges Python-függőségek azonnal rendelkezésre állnak),
- a 8080-as port forwaldolva legyen, így a Flask alkalmazás Dev Containerből futtatva is elérhető legyen a host gépről.

## Va. A projekt megnyitása és futtatása Dev Containerben - külső felhasználóknak

### i. Előfeltételek
A projekt megnyitásához, futtattásához Docker, Visual Studio Code, illetve utóbbiban Dev Containers kiegészítő telepítése szükséges.

### ii. Projekt megnyitása konténerben

A projekt megnyitása érdekében az alábbi lépéseket érdemes követni:

1. Nyisd meg a projekt mappáját Visual Studio Code-ban.
2. A VS Code jobb alsó sarkában megjelenő értesítésnél váalszd a "Reopen in Container" opciót.
3. A Dev Container buildelése és indítása néhány percet igénybe vehet. A folyamat végén a projekt már a konténeren belüli Python-környezetben lesz megnyitva.

### iii. Alkalmazás futtatása Dev Containerben

A VS Code beépített termináljában a konténer elindulását követően a "python BeadandoREL301.py" paranccsal futtatható az alkalmazás.

Sikeres indítást követően az alkalmazás a host gépről is elérhető a böngészőben a "http://localhost:8080" linken.

A Dev Container így biztosítja, hogy a projekt egy könnyen reprodukálható, egységes fejlesztői környezetben fusson, függetlenül a host rendszer egyedi beállításaitól.