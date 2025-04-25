# 🧑‍💻 Lambda Calcolo per NLP

Il **lambda calcolo** è un sistema matematico inventato da **Alonzo Church** negli anni '30 per descrivere in modo preciso cosa significa **eseguire un calcolo**.  
È una base teorica della programmazione (soprattutto funzionale) e trova **applicazioni importanti nel Natural Language Processing (NLP)**, ovvero nella comprensione e rappresentazione del linguaggio naturale da parte dei computer.


## 🧩 Concetti Base del Lambda Calcolo

Il lambda calcolo è costruito su **3 concetti fondamentali**:


### 1️⃣ Variabili

Una **variabile** è un simbolo (come $x$, $y$, $z$) che rappresenta un valore o un'entità generica.

📌 Esempio:

- $x$ può rappresentare un numero, una parola, un concetto, ecc.


### 2️⃣ Astrazione (Definizione di funzione)

L'**astrazione** è il modo per **definire una funzione anonima** (cioè senza nome).  
Si scrive così:

$$
\lambda x.t
$$

Significa: "una funzione che prende $x$ e restituisce il risultato dell'espressione $t$".

📌 Esempio:

$$
\lambda x. x + 1
$$

Questa è una funzione che prende un numero $x$ e restituisce $x + 1$.


### 3️⃣ Applicazione (Uso della funzione)

L'**applicazione** è quando **si fornisce un argomento (input)** a una funzione.

📌 Esempio:

$$
(\lambda x. x + 1) \ 5
$$

Significa: "applica la funzione $\lambda x. x + 1$ all'argomento $5$".

👉 Risultato:

$$
5 + 1 = 6
$$


## 🔄 Operazioni Importanti nel Lambda Calcolo

Per manipolare le espressioni, si usano principalmente due operazioni:


### 🔁 Alpha Conversion (Rinominare variabili)

Serve per **evitare conflitti tra variabili**.  
Puoi cambiare il nome di una **variabile legata** (cioè usata dentro una funzione) senza cambiare il significato.

📌 Esempio:

$$
\lambda x.x \equiv \lambda y.y
$$

Queste due funzioni sono **equivalenti**: entrambe prendono un input e lo restituiscono senza modificarlo.


### 🧮 Beta Reduction (Applicare una funzione)

È l’operazione principale: **esegue effettivamente la funzione**.

Se hai una funzione:

$$
(\lambda x.t) \ s
$$

Si sostituisce la variabile $x$ con il valore $s$ nell’espressione $t$:

$$
t(s)
$$

📌 Esempio $t(x) = x+1$:

$$
(\lambda x.t) \ 4 \Rightarrow (\lambda x. x + 1) \ 4 \Rightarrow t(4) \Rightarrow 4 + 1 = 5
$$


## 🔍 Esempi Pratici di Lambda Espressioni

Vediamo alcune funzioni comuni scritte con il lambda calcolo:


### ✅ Identità

Restituisce l'input senza modificarlo:

$$
\lambda x. x
$$

📌 Esempio:

$$
(\lambda x.x)\ 7 = 7
$$


### 🔢 Funzione Costante

Restituisce sempre lo stesso valore, ignorando l'input:

$$
\lambda x. y
$$

📌 Esempio:  
$$
(\lambda x.42)\ 100 = 42
$$


### ⏹️ Funzione Quadrato

Restituisce il quadrato del numero dato:

$$
\lambda x. x \cdot x
$$

📌 Esempio:

$$
(\lambda x. x \cdot x) \ 4 = 4 \cdot 4 = 16
$$


### ➕ Funzione con più argomenti

Una funzione che moltiplica due numeri può essere scritta usando **funzioni nidificate**:

$$
\lambda x. \lambda y. x \cdot y
$$

📌 Esempio di applicazione:

$$
((\lambda x. \lambda y. x \cdot y) \ 3) \ 4 = (\lambda y. 3 \cdot y) \ 4 = 12
$$

## 🇮🇹 Lambda Calcolo in Linguistica

In **NLP**, il lambda calcolo viene utilizzato per rappresentare le espressioni semantiche del linguaggio naturale. Ciò implica l'uso di costanti, connettivi e quantificatori per modellare il significato delle frasi.

### Costanti Linguistiche
Per costruire frasi, utilizziamo costanti come "due", "rosso", "ama", "mangiato", "Giovanni", "Maria", ecc. Ogni parola o concetto nel linguaggio può essere rappresentato come una costante nel lambda calcolo.

### Connettivi e Quantificatori
Nel linguaggio naturale, possiamo avere connettivi logici come **o**, **e**, **non**, **se ... allora**, **per tutti**, **esiste**. Questi connettivi sono rappresentati in lambda calcolo come combinazioni di astrazioni e applicazioni.

Esempio di una frase:
$$ loves(John, Mary) $$

In lambda calcolo, questa potrebbe essere rappresentata come:
$$ \lambda x.\lambda y.loves(x, y)(John)(Mary) $$

#### Esempio di Frase Complessa
Consideriamo una frase come:
"**Mozzarella è rossa e Giovanni ha mangiato mozzarella.**"
In lambda calcolo, possiamo rappresentarlo come:
$$
(\lambda x.mozzarella(x) \land \lambda x.rossa(x) \land \lambda x.ate(giovanni, x))(m)
$$

Qui, ogni verbo e aggettivo viene trattato come una funzione che applica determinati predicati (come `mozarella`, `rossa`, `ate`) ai rispettivi argomenti.

Applicando le $\beta$-riduzioni a queste funzioni, otteniamo la frase complessa rappresentata in logica FOL:

$$
mozzarella(m) \land rossa(m) \land ate(giovanni, m).
$$

## Lambda Calcolo e Modellizzazione degli Eventi

Il lambda calcolo è anche molto utile per rappresentare eventi temporali. Un evento può essere definito come una relazione tra un'azione e il tempo in cui essa si verifica.

Esempio di evento nel lambda calcolo:

$$
\begin{aligned}
\mathrm{MANGIARE} &= \lambda e.\;\mathrm{mangiare}(e)\\
\mathrm{AGENTE}  &= \lambda x.\;\lambda e.\;\mathrm{agente}(e,x)\\
\mathrm{TEMA}    &= \lambda y.\;\lambda e.\;\mathrm{tema}(e,y)\\
\mathrm{TEMPO}   &= \lambda t.\;\lambda e.\;\mathrm{tempo}(e,t)\\
\mathrm{AND}     &= \lambda P.\;\lambda Q.\;\lambda z.\;P(z)\land Q(z)
\end{aligned}
$$

Componiamo queste funzioni per rappresentare:

> **“Giovanni ha mangiato una mela alle 12.”**

$$
(\mathrm{AND}\;\mathrm{MANGIARE}\;
  (\mathrm{AND}\;(\mathrm{AGENTE}\;\mathit{giovanni})\;
    (\mathrm{AND}\;(\mathrm{TEMA}\;\mathit{mela})\;
      (\mathrm{TEMPO}\;12)
    )
  )
)
$$

Applicando le β‐riduzioni otteniamo la funzione evento:

$$
\exists e \;\mathrm{mangiare}(e)\;\land\;\mathrm{agente}(e,\mathit{Giovanni})\;\land\;\mathrm{tema}(e,\mathit{mela})\;\land\;\mathrm{tempo}(e,12)
$$

Questo modello semantico rappresenta un evento in cui Giovanni mangia una mela, con un'azione che avviene nel passato. Ogni argomento dell'evento è rappresentato da un termine del lambda calcolo, permettendo una rappresentazione formale dell'evento.

## 🧠 Come estrarre la semantica dalle frasi?

Il **processo di composizione semantica** in NLP si basa sull'idea che il significato di una frase possa essere derivato in modo **composizionale**, partendo dal significato delle parole singole e combinandole secondo la struttura sintattica.

### 📚 Tabella: Grammar Rule + Semantic Attachment

| **Grammar Rule**                         | **Semantic Attachment**                                                                                                         |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------|
| $S \rightarrow NP\ VP$                   | $\{NP.sem(VP.sem)\}$                                                                                                           |
| $NP \rightarrow Det\ Nominal$           | $\{Det.sem(Nominal.sem)\}$                                                                                                     |
| $NP \rightarrow ProperNoun$             | $\{ProperNoun.sem\}$                                                                                                           |
| $Nominal \rightarrow Noun$              | $\{Noun.sem\}$                                                                                                                 |
| $VP \rightarrow Verb$                   | $\{Verb.sem\}$                                                                                                                 |
| $VP \rightarrow Verb\ NP$               | $\{Verb.sem(NP.sem)\}$                                                                                                         |
| $Det \rightarrow every$                 | $\{\lambda P.\lambda Q.\forall x[P(x) \Rightarrow Q(x)]\}$                                                                    |
| $Det \rightarrow a$                     | $\{\lambda P.\lambda Q.\exists x[P(x) \land Q(x)]\}$                                                                          |
| $Noun \rightarrow restaurant$           | $\{\lambda r.\ Restaurant(r)\}$                                                                                               |
| $ProperNoun \rightarrow Matthew$        | $\{\lambda m.\ m(\text{Matthew})\}$                                                                                           |
| $ProperNoun \rightarrow Franco$         | $\{\lambda f.\ f(\text{Franco})\}$                                                                                            |
| $ProperNoun \rightarrow Frasca$         | $\{\lambda f.\ f(\text{Frasca})\}$                                                                                            |
| $Verb \rightarrow closed$              | $\{\lambda x.\exists e[\text{Closing}(e) \land \text{Closed}(e,x)]\}$                                                         |
| $Verb \rightarrow opened$              | $\{\lambda w.\lambda z.\ w(\lambda x.\exists e[\text{Opening}(e) \land \text{Opener}(e,z) \land \text{Opened}(e,x)])\}$       |


Ecco i **passaggi fondamentali** per costruire la semantica di una frase tramite il lambda calcolo:

### 1️⃣ Analisi sintattica: costruzione dell'albero sintattico

La frase viene prima **analizzata sintatticamente** per produrre un **albero di parsing**.  
Ogni nodo dell'albero rappresenta una categoria grammaticale (come S, NP, VP, ecc.).

📌 **Esempio:**
> *Franco opened a restaurant*

L'albero generato avrà struttura:

```tikz
\documentclass[tikz,border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{trees}

\begin{document}

\begin{tikzpicture}[
  sibling distance=10mm,
  level distance=15mm,
  edge from parent/.style={draw,-latex},
  every node/.style={font=\small,align=center},
  level 1/.style={sibling distance=35mm},
  level 2/.style={sibling distance=25mm},
  level 3/.style={sibling distance=15mm}
  ]

\node {S}
  child {node {NP}
    child {node {PropNoun}
      child {node[terminal] {Franco}}}}
  child {node {VP}
    child {node {V}
      child {node[terminal] {opened}}}
    child {node {NP}
      child {node {Det \\ Nominal}
        child {node {Det}
          child {node[terminal] {a}}}
        child {node {Nominal}
          child {node {Noun}
            child {node[terminal] {restaurant}}}}}}};

\end{tikzpicture}

\end{document}
```
### 2️⃣ Semantica lessicale: assegnazione di significati ai terminali

A ciascun **terminale dell'albero** (cioè ogni parola) viene assegnata una **forma semantica in lambda calcolo**.

#### 📌 Terminali (foglie dell’albero)

- `Franco`  
  $$ \lambda f.\,f(\text{Franco}) $$

- `opened`  
  $$ \lambda w.\lambda z.\,w(\lambda x.\exists e\,[Opening(e) \land Opener(e,z) \land Opened(e,x)]) $$

- `a`  
  $$ \lambda P.\lambda Q.\,\exists x\,[P(x) \land Q(x)] $$

- `restaurant`  
  $$ \lambda r.\,Restaurant(r) $$

#### 📌 Composizione semantica (Bottom-up)

- **Nominal → Noun**  
  $$ \text{Nominal.sem} = \text{Noun.sem} = \lambda r.\,Restaurant(r) $$

- **Det + Nominal → NP**  
  $$ \text{NP.sem} = \text{Det.sem}(\text{Nominal.sem}) $$
  $$ = (\lambda P.\lambda Q.\,\exists x\,[P(x) \land Q(x)])(\lambda r.\,Restaurant(r)) $$
  $$ = \lambda Q.\,\exists x\,[Restaurant(x) \land Q(x)] $$

- **VP → Verb + NP**  
  $$ \text{VP.sem} = \text{Verb.sem}(\text{NP.sem}) $$
  $$ = (\lambda w.\lambda z.\,w(\lambda x.\exists e\,[Opening(e) \land Opener(e,z) \land Opened(e,x)]))(\lambda Q.\,\exists x\,[Restaurant(x) \land Q(x)]) $$
  $$ = \lambda z.\,(\lambda Q.\,\exists x\,[Restaurant(x) \land Q(x)])(\lambda x.\exists e\,[Opening(e) \land Opener(e,z) \land Opened(e,x)]) $$
  $$ = \lambda z.\,\exists x\,[Restaurant(x) \land \exists e\,[Opening(e) \land Opener(e,z) \land Opened(e,x)]] $$

- **NP → ProperNoun (`Franco`)**  
  $$ \lambda f.\,f(\text{Franco}) $$

- **S → NP + VP**  
  $$ \text{S.sem} = \text{NP.sem}(\text{VP.sem}) $$
  $$ = (\lambda f.\,f(\text{Franco}))(\lambda z.\,\exists x\,[Restaurant(x) \land \exists e\,[Opening(e) \land Opener(e,z) \land Opened(e,x)]]) $$
  $$ = \exists x\,[Restaurant(x) \land \exists e\,[Opening(e) \land Opener(e,\text{Franco}) \land Opened(e,x)]] $$

✅ **Risultato finale (Semantica della frase)**

**Franco opened a restaurant**  
$$ \exists x\,[Restaurant(x) \land \exists e\,[Opening(e) \land Opener(e,\text{Franco}) \land Opened(e,x)]] $$

## ⚠️ Limiti dell'approccio composizionale basato sul Lambda Calcolo

Sebbene il lambda calcolo sia uno strumento molto potente per rappresentare la **semantica formale** del linguaggio naturale, presenta diversi limiti importanti quando viene applicato direttamente in NLP.

### 1️⃣ È Difficile!

L'analisi semantica formale richiede:

- Conoscenze avanzate di logica e lambda calcolo.
- Una grammatica sintattica/semantica dettagliata e ben definita.
- Un processo di parsing robusto per generare alberi sintattici corretti.
- Meccanismi per eseguire **beta-riduzioni** e **composizione funzionale** tra i costituenti.

➡️ Anche per frasi semplici, la derivazione formale può diventare **complessa e poco scalabile**.

### 2️⃣ Assunzioni semplificative (e pericolose!)

Una semplificazione comune è quella di assumere che **ogni terminale** (cioè ogni parola) abbia **un solo significato preciso**.

🔴 Esempi:

- `Franco` → $\text{Franco}$  
- `Opening` → $\text{Opening}(e)$  
- `Restaurant` → $\text{Restaurant}(x)$  

❗ In realtà, **le parole sono ambigue**:  
- `Opening` può essere un verbo (es. "he is opening") o un nome ("the grand opening").
- `Bank` può indicare un edificio o il lato di un fiume.
- `Franco` potrebbe anche essere un aggettivo ("un tono franco").

### 3️⃣ Serve la Semantica Lessicale

Per trattare **l’ambiguità del significato delle parole**, dobbiamo **andare oltre la semantica composizionale** e occuparci della **[[Semantica Lessicale|semantica lessicale]]**:

- Capire **i diversi sensi di una parola** in base al contesto.
- Costruire **rappresentazioni concettuali** (come frame, ontologie, word sense).
- Integrare risorse come **WordNet**, **FrameNet**, o modelli **word embeddings**.

### ✅ Conclusione

Il lambda calcolo è fondamentale per modellare la **composizione del significato**, ma da solo **non basta**. Per interpretare correttamente una frase, dobbiamo prima **capire le parole**, poi possiamo comporre i loro significati.

```diff
+ Prima la semantica lessicale, poi quella composizionale!
```