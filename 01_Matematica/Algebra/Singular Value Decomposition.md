# 📚 Singular Value Decomposition (SVD)

> "Se non puoi misurarlo, non puoi capirlo" – Lord Kelvin

## 📌 Introduzione

La **Singular Value Decomposition (SVD)** è una delle decomposizioni matriciali più importanti in algebra lineare, con applicazioni fondamentali in compressione dei dati, riduzione dimensionale, raccomandazione, elaborazione di segnali, visione artificiale e NLP.

## 🔍 Definizione Formale

Sia $\mathbf{X} \in \mathbb{R}^{m \times n}$ una matrice qualsiasi. La **SVD** è una fattorizzazione della matrice nella forma:

$$
\mathbf{X} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^{\top}
$$

dove:

- $\mathbf{U} \in \mathbb{R}^{m \times m}$: matrice ortogonale delle **left singular vectors**
- $\mathbf{\Sigma} \in \mathbb{R}^{m \times n}$: matrice diagonale con valori $\sigma_i$ detti **singular values** in ordine decrescente
- $\mathbf{V} \in \mathbb{R}^{n \times n}$: matrice ortogonale delle **right singular vectors**

## 🧠 Intuizione Geometrica

Una delle intuizioni più potenti della **Singular Value Decomposition** è che essa permette di "vedere" ogni **trasformazione lineare** come una sequenza ordinata di operazioni geometriche fondamentali nello spazio euclideo:

### 🔄 Trasformazioni Lineari come Sequenza Ordinata

Ogni trasformazione lineare $\mathbf{X} \in \mathbb{R}^{m \times n}$, per quanto complessa, può essere sempre **scomposta in tre fasi geometriche**:

$$
\mathbf{X} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^\top
$$

Questa decomposizione corrisponde alla seguente **pipeline geometrica**:

### 🔹 1. Rotazione iniziale dello spazio ($\mathbf{V}^\top$)

- Si tratta di una **rotazione (o riflessione)** del sistema di riferimento originale.
- In altre parole, $\mathbf{V}^\top$ "orienta" i vettori d'ingresso in una base ortonormale ottimale per la trasformazione successiva.
- Cambiamo punto di vista: ruotiamo lo spazio dei dati per **allineare** le direzioni principali della trasformazione.

Questa fase rappresenta una **preparazione**: porta i dati in un sistema di riferimento in cui la scalatura sarà **assiale** (cioè indipendente per ciascuna dimensione).

### 🔹 2. Scalatura assiale ($\mathbf{\Sigma}$)

- $\mathbf{\Sigma}$ è una matrice **diagonale** che **scala** ogni coordinata **indipendentemente** lungo un asse ortogonale.
- I valori diagonali $\sigma_1 \geq \sigma_2 \geq \dots \geq \sigma_r > 0$ sono i **valori singolari** e rappresentano **quanto** viene deformato lo spazio in ciascuna direzione.
- Nessuna rotazione o shearing: solo **dilatazione o contrazione**.

In questo passaggio avviene il "cuore" della trasformazione: le direzioni principali vengono **ingrandite o compresse** in base alla loro **importanza informativa**.

### 🔹 3. Rotazione finale ($\mathbf{U}$)

- Una volta che i vettori sono stati scalati, $\mathbf{U}$ effettua una **rotazione finale** per posizionare il risultato nello spazio di uscita (range).
- È un ulteriore cambiamento di base, ma questa volta nello **spazio codominio**.

### 📐 Rappresentazione schematica

$$
\mathbf{X} \mathbf{x}
= 
\underbrace{\mathbf{U}}_{\text{Rotazione finale}}
\underbrace{
\mathbf{\Sigma}
\underbrace{
\mathbf{V}^\top \mathbf{x}
}_{\text{Rotazione iniziale}}
}_{\text{Scalatura}}
$$

Quindi l’intera trasformazione può essere **visualizzata come**:
- ruotare i dati,
- scalarli lungo assi ortogonali,
- ruotarli di nuovo.

### 🌌 Esempio Visivo

Immagina un **cerchio unitario** nello spazio 2D. Applichiamo $\mathbf{X}$ tramite la sua SVD:

- **$\mathbf{V}^\top$** ruota il cerchio, trasformandolo in un’ellisse orientata.
- **$\mathbf{\Sigma}$** schiaccia o dilata l’ellisse lungo i suoi assi principali.
- **$\mathbf{U}$** ruota nuovamente l’ellisse nel suo spazio finale.

Risultato: da una figura simmetrica e isotropa (cerchio), otteniamo un oggetto deformato ma **con significato direzionale**.

### 🧬 Interpretazione concettuale

- Le **direzioni principali** (singular vectors) sono gli **assi di massima variazione** dell’azione di $\mathbf{X}$.
- I **valori singolari** dicono **quanto** $\mathbf{X}$ "stira" lo spazio lungo quei vettori.
- Questa decomposizione permette di **ridurre la dimensionalità** preservando la maggior parte dell’informazione (proiettando sui primi $k$ assi).

### ✅ Riassunto

| Passaggio | Matrice        | Tipo             | Azione nello spazio |
|-----------|----------------|------------------|---------------------|
| 1         | $\mathbf{V}^\top$ | Ortogonale       | Rotazione iniziale |
| 2         | $\mathbf{\Sigma}$ | Diagonale (reale) | Scalatura assiale  |
| 3         | $\mathbf{U}$      | Ortogonale       | Rotazione finale   |

👉 Questo rende la SVD **lo strumento matematico più naturale per comprendere e manipolare le trasformazioni lineari complesse** con una lente geometrica. 


## 📏 Proprietà

- I vettori di $\mathbf{U}$ e $\mathbf{V}$ formano **basi ortonormali** per lo spazio delle righe e delle colonne.
- I **valori singolari** $\sigma_i$ rappresentano la **quantità di informazione** trasportata lungo ciascuna direzione.
- $\text{rank}(\mathbf{X}) =$ numero di valori singolari non nulli.
- È strettamente legata all’**autovalori** della matrice $\mathbf{X}^\top \mathbf{X}$ e $\mathbf{X} \mathbf{X}^\top$.

## 🔧 Riduzione Dimensionale tramite Truncated SVD

Spesso, molte direzioni (componenti) sono **rumore** o trascurabili. Usiamo **solo i primi $k \ll \min(m,n)$** valori singolari:

$$
\mathbf{X} \approx \mathbf{X}_k = \mathbf{U}_k \mathbf{\Sigma}_k \mathbf{V}_k^\top
$$

- Otteniamo così una **approssimazione low-rank**.
- Utilissima per **compressione** e **estrazione di struttura latente**.

## 📊 Collegamento con LSA e Word Embeddings

🔗 Vedi la nota: [[Dense Word Embeddings]]  
SVD è alla base di tecniche come **LSA (Latent Semantic Analysis)**, dove:

- $\mathbf{X}$ è la matrice **term-document** (frequenze o tf-idf)
- La decomposizione estrae **argomenti latenti** che strutturano semanticamente il linguaggio

## 📐 Esempio Grafico

<div align='center'><img src="../../images/mysvd.png?raw=1" width='65%' ></div>

## 🧬 Interpretazione Probabilistica

- $\mathbf{X}^\top \mathbf{X}$ è la **covarianza tra termini** nello spazio dei documenti.
- $\mathbf{X} \mathbf{X}^\top$ è la **covarianza tra documenti** nello spazio dei termini.
- SVD decompone questa correlazione strutturata in **componenti ortogonali**.

## 🧾 Differenze tra SVD ed Eigendecomposition

| Metodo      | Tipo matrice     | Fattorizzazione                                  |
|-------------|------------------|--------------------------------------------------|
| SVD         | qualsiasi         | $\mathbf{X} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^\top$ |
| Eigendecomp | solo quadrate     | $\mathbf{X} = \mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{-1}$ |

Nota: SVD è più generale e robusta.

## ⚠️ Limiti della SVD

- Complessità computazionale elevata: $\mathcal{O}(mn\min(m,n))$
- Poco scalabile su matrici **molto grandi** (es. $10^6 \times 10^6$)
- Non si adatta bene a **matrici dinamiche** o sparse (come nel linguaggio naturale)
- Richiede **riaddestramento completo** per ogni nuovo documento/termine

## ✅ Vantaggi

- Estrae automaticamente **relazioni latenti**
- Riduce il rumore e le ridondanze
- Ottimo per compattare l'informazione
- Facilita la **similarità semantica** tra oggetti (es. documenti, parole)

## 🧪 Applicazioni

- **NLP**: Latent Semantic Analysis (LSA)
- **Motori di raccomandazione**: filtraggio collaborativo
- **Visione artificiale**: compressione di immagini
- **Machine Learning**: preprocessing per PCA e clustering

## 🧭 Conclusione

La SVD non è solo una tecnica matematica ma un **principio guida** per strutturare, comprimere e interpretare dati complessi. In ambito linguistico, è lo strumento matematico fondante di molte tecniche semantiche moderne.
