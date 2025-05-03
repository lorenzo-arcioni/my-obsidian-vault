# 📚 Singular Value Decomposition (SVD)

> "Se non puoi misurarlo, non puoi capirlo" – Lord Kelvin

## 📌 Introduzione

La **Singular Value Decomposition (SVD)** è una delle tecniche più potenti e versatili dell’algebra lineare. È un metodo che ci permette di "guardare dentro" una matrice e capirne il comportamento profondo, rivelandone le direzioni principali di azione e le dimensioni lungo cui opera.

Immagina una trasformazione come qualcosa che prende un insieme di punti e li sposta, allunga, schiaccia o ruota nello spazio. La SVD ci permette di scomporre questa trasformazione complessa in tre passaggi semplici e interpretabili:

- una **rotazione iniziale**, che riallinea il sistema di riferimento;
- una **scalatura**, che modifica le lunghezze lungo gli assi principali;
- una **rotazione finale**, che orienta il risultato nello spazio d’uscita.

In sostanza, SVD svela la struttura nascosta di qualsiasi matrice, anche se non è quadrata, anche se ha righe o colonne ridondanti, o persino se è "disturbata" dal rumore. 

Questa capacità di scomporre e reinterpretare trasformazioni la rende una tecnica centrale in molti campi: compressione delle immagini, riconoscimento facciale, sistemi di raccomandazione, ricerca semantica nei testi, e tanto altro.


## 🔍 Definizione Formale

Sia $\{\mathbf v_1, \cdots, \mathbf v_n\}$ con $\mathbf v_i \in \mathbb{R}^m$ una base ortonormale e $\mathbf{X} \in \mathbb{R}^{m \times n}$ una matrice qualsiasi. Applichiamo $\mathbf{X} \in \mathbb{R}^{m \times n}$ a $\mathbf v_1, \cdots \mathbf v_n$:

$$
\mathbf X \mathbf v_1 = \sigma_1 \mathbf u_1,\quad \cdots \quad \mathbf X \mathbf v_n = \sigma_n \mathbf u_n
$$

dove:

- $\{\sigma_i\}_{i=1}^n$ sono i valori singolari di $\mathbf{X}$ in ordine decrescente
- $\{\mathbf{u}_i\}_{i=1}^n$ sono vettori i vettori singolari destri di $\mathbf{X}$

Quindi, dato che abbiamo una base ortonormale, ogni vettore $\mathbf x$ può essere scritto come:

$$
\mathbf x = (\mathbf v_1 \cdot \mathbf x) \mathbf v_1 + \cdots + (\mathbf v_n \cdot \mathbf x) \mathbf v_n
$$

Applicando $\mathbf X$:

$$
\mathbf X \mathbf x = \sigma_1 (\mathbf v_1 \cdot \mathbf x) \mathbf u_1 + \cdots + \sigma_n (\mathbf v_n \cdot \mathbf x) \mathbf u_n
$$

Sostituendo termini, si ottiene la forma canonica:

$$
\mathbf{X} \mathbf{x} = \sum_{i=1}^{n} \sigma_i (\mathbf{v}_i \cdot \mathbf{x}) \mathbf{u}_i
$$

Cerchiamo ora di scrivere questa formula in forma matriciale:

1. **Raggruppiamo le proiezioni**  
   Definiamo il vettore delle coordinate di $\mathbf{x}$ nella base $\{\mathbf{v}_i\}_{i=1}^n$:
   $$
     z_i = \mathbf{v}_i \cdot \mathbf{x},
     \quad
     \mathbf{z} = 
     \begin{bmatrix}
       z_1\\
       \vdots\\
       z_n
     \end{bmatrix}.
   $$
   Per ortonormalità, $\mathbf{z} = V^\top \mathbf{x}$. Ricordiamo, dato che $V$ è una matrice ortogonale, che $V^T V = I \Rightarrow V^\top = V^{-1}$.

2. **Applichiamo la scalatura**  
   La matrice dei valori singolari $\Sigma$ agisce su $\mathbf{z}$ moltiplicando ciascuna componente $z_i$ per $\sigma_i$:
   $$
     \Sigma\,\mathbf{z}
     = 
     \begin{bmatrix}
       \sigma_1 & & 0 \\
       & \ddots & \\
       0 & & \sigma_n
     \end{bmatrix}
     \begin{bmatrix}
       z_1 \\
       \vdots \\
       z_n
     \end{bmatrix}
     =
     \begin{bmatrix}
       \sigma_1\,z_1 \\
       \vdots \\
       \sigma_n\,z_n
     \end{bmatrix}.
   $$

3. **Sommiamo lungo gli $\mathbf{u}_i$**  
   Il vettore risultante si combina con i vettori singolari sinistri $\{\mathbf{u}_i\}$:
   $$
     \sum_{i=1}^n (\sigma_i\,z_i)\,\mathbf{u}_i
     = U\,(\Sigma\,\mathbf{z}).
   $$

4. **Mettiamo tutto insieme**
   $$
     \mathbf{X}\,\mathbf{x}
     = U\,\bigl(\Sigma\,(V^\top \mathbf{x})\bigr)
     = \bigl(U\,\Sigma\,V^\top\bigr)\,\mathbf{x}.
   $$
   Poiché vale per ogni vettore $\mathbf{x}$, ne segue la **forma canonica**:
   $$
     \boxed{
       \mathbf{X} = U\,\Sigma\,V^\top
     }
   $$

### 📐 Interpretazione Geometrica

Questa formula mostra come la SVD scompone ogni trasformazione lineare in una **sequenza ordinata** di operazioni:

1. **Rotazione** (o cambio di base) del vettore di input nello spazio delle $\mathbf{v}_i$, tramite $\mathbf{V}^\top$.
2. **Scalatura anisotropa** lungo queste direzioni, con coefficienti $\sigma_i$.
3. **Rotazione** finale nello spazio delle $\mathbf{u}_i$, tramite $\mathbf{U}$.

Questa decomposizione è non solo utile dal punto di vista computazionale, ma rivela anche la **struttura interna** della trasformazione stessa.

Quindi sia $\mathbf{X} \in \mathbb{R}^{m \times n}$ una matrice qualsiasi. La **SVD** è una fattorizzazione della matrice nella forma:

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

<img src="../../images/svd_pipeline.png" width="600" style="display: block; margin-left: auto; margin-right: auto;">
<br>

L'immagine illustra geometricamente la decomposizione a valori singolari (SVD) di una matrice **A**, mostrando come può essere interpretata come una sequenza di trasformazioni.

### 🔹 1. Rotazione iniziale dello spazio ($\mathbf{V}^\top$)

- Si tratta di una **rotazione (o riflessione)** del sistema di riferimento originale.
- In altre parole, $\mathbf{V}^\top$ "orienta" i vettori d'ingresso in una base ortonormale ottimale per la trasformazione successiva.
- Cambiamo punto di vista: ruotiamo lo spazio dei dati per **allineare** le direzioni principali della trasformazione.

Questa fase rappresenta una **preparazione**: porta i dati in un sistema di riferimento in cui la scalatura sarà **assiale** (cioè indipendente per ciascuna dimensione).

#### Ma cosa significa applicare $\mathbf{V}^\top$ a un vettore $\mathbf{x}$?

$$
\mathbf{z} = \mathbf{V}^\top \mathbf{x}
$$

Questa operazione ha un significato **geometrico fondamentale**: è un **cambio di base**.

- $\mathbf{x} \in \mathbb{R}^n$ è espresso nelle coordinate originali.
- $\mathbf{V}^\top$ proietta $\mathbf{x}$ nel **nuovo sistema di riferimento ortonormale** definito dalle colonne di $\mathbf{V}$.
- $\mathbf{z}$ sono le **coordinate di $\mathbf{x}$** rispetto alle **nuove direzioni principali** (cioè i "concetti" o "assi principali" trovati dalla SVD).

#### 🧠 Intuizione

- Ogni colonna di $\mathbf{V}$ rappresenta una direzione **ortogonale** nel nuovo spazio dei concetti (assimilabile agli assi principali della varianza).
- Moltiplicare per $\mathbf{V}^\top$ ruota il sistema di coordinate per **rappresentare $\mathbf{x}$ in termini di quei concetti**.
- Se $\mathbf{x}$ è un documento, $\mathbf{V}^\top \mathbf{x}$ ci dice **quanto quel documento "partecipa" a ciascun concetto**.

### 🔹 2. Scalatura assiale ($\mathbf{\Sigma}$)

- $\mathbf{\Sigma}$ è una matrice **diagonale** che **scala** ogni coordinata **indipendentemente** lungo un asse ortogonale.
- I valori diagonali $\sigma_1 \geq \sigma_2 \geq \dots \geq \sigma_r \geq 0$ sono i **valori singolari** e rappresentano **quanto** viene deformato lo spazio in ciascuna direzione.
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
- Può essere vista come una generalizzazione dell’autodecomposizione (eigendecomposition).

## 🔧 Riduzione Dimensionale tramite Truncated SVD

Spesso, molte direzioni (componenti) sono **rumore** o trascurabili. Usiamo **solo i primi $k \ll \min(m,n)$** valori singolari:

$$
\mathbf{X} \approx \mathbf{X}_k = \mathbf{U}_k \mathbf{\Sigma}_k \mathbf{V}_k^\top
$$

- Otteniamo così una **approssimazione low-rank**.
- Utilissima per **compressione** e **estrazione di struttura latente**.

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

- **NLP**: [[Latent Semantic Analysis]] (LSA)
- **Motori di raccomandazione**: filtraggio collaborativo
- **Visione artificiale**: compressione di immagini
- **Machine Learning**: preprocessing per PCA e clustering

## 🧭 Conclusione

La SVD non è solo una tecnica matematica ma un **principio guida** per strutturare, comprimere e interpretare dati complessi. In ambito linguistico, è lo strumento matematico fondante di molte tecniche semantiche moderne.
