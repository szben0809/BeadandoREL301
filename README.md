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

Ezután futtattam a programot ("python BeadandoREL301.py"), majd böngészőből leellenőriztem azt (a terminalban megjelenő hivatkozások mellett a "https://localhost:8080" linken keresztül is).

A program hibamentesen elindult, és a Flask alkalmazás a 8080-as porton keresztül HTTP-n elérhetővé vált. A böngészőben a http://localhost:8080 cím megnyitásakor a vártnak megfelelően megjelent a saját üzenetem ("Hello DevOps! Ez Szablics Benedek beadandó feladata.").
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

Erre azért volt szükség, hogy a virtuális környezet (venv/) ne kerüljön a Git repóba.

Az alkalmazás fejlesztését, buildelését és a dokumentáció (README.md) készítésének elkezdését követően inicializáltam a Git repository-t a lokális gépen:

"git init
git add .
git commit -m "Initial commit: Elso commit Szablics Benedek DevOps beadandojahoz".


Ezután röviden ellenőriztem az iméntieket a "git status" paranccsal, majd a github.com-on létrehoztam egy publikus GitHub repository-t, összekapcsoltam vele a lokális projektet és feltöltöttem az első commitot a main branchre:

"git remote add origin https://github.com/szben0809/BeadandoREL301.git
git branch -M main
git push -u origin main"

Ezzel a main ág (trunk) létrejött, és a kiinduló projektstruktúra verziókövethetővé vált.

A feladat legalább egy feature branchet ír elő. Ennek megfelelően létrehoztam egy külön fejlesztési ágat:

"git checkout -b feature/kulon-ag"

majd ezt pusholtam:

"git push -u origin feature/kulon-ag"

Ezen az ágon kisebb funkcionális módosítást hajtottam végre ( megváltoztattam a visszaadott üzenet szövegét "Hello DevOps! Ez Szablics Benedek beadandó feladata." helyett "Hello DevOps! Ez Szablics Benedek beadandó feladatának külön fejlesztési ága.), majd commitoltam:




## III. Buildelés



## III. Buildelés - Docker Image készítés

Python/Flask esetén a buildelés optimálisan megoldható Docker image készítés által.

### IIIa. Útmutató a buildeléshez külső személy számára

A docker image a "docker build -t hello-devops:v1" paranccsal építhető. A futtatás a "docker run -p 8080:8080 hello-devops:v1" parancsra történik.