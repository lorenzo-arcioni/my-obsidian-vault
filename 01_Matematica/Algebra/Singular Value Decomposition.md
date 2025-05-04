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

Sia $\{\mathbf v_1, \cdots, \mathbf v_n\}$ una base **ortonormale** dello spazio di partenza, con $\mathbf v_i \in \mathbb{R}^n$, e sia $\mathbf{X} \in \mathbb{R}^{m \times n}$ una matrice qualsiasi. Applichiamo $\mathbf{X}$ ai vettori della base:

$$
\mathbf X \mathbf v_1 = \sigma_1 \mathbf u_1,\quad \cdots,\quad \mathbf X \mathbf v_n = \sigma_n \mathbf u_n
$$

dove:

- $\{\sigma_i\}_{i=1}^n$ sono i **valori singolari** di $\mathbf{X}$, ordinati in modo decrescente,
- $\{\mathbf{v}_i\}_{i=1}^n$ sono gli **autovettori** di $\mathbf{X}^\top \mathbf{X}$,
- $\{\mathbf{u}_i\}_{i=1}^n$ sono gli **autovettori** di $\mathbf{X} \mathbf{X}^\top$.

### 🔍 Intuizione geometrica

Ma perché proprio queste due matrici?

- $\mathbf{X}^\top \mathbf{X}$ è una matrice simmetrica $n \times n$ che **vive nello spazio di partenza**: i suoi autovettori $\mathbf{v}_i$ rappresentano le **direzioni privilegiate d’ingresso** su cui $\mathbf{X}$ agisce in modo particolarmente "coerente" (senza cambiare direzione, solo scalando).
- $\mathbf{X} \mathbf{X}^\top$, invece, è simmetrica $m \times m$ e vive nello spazio di arrivo: i suoi autovettori $\mathbf{u}_i$ sono le **direzioni di uscita** in cui $\mathbf{X}$ "proietta" ciascun $\mathbf{v}_i$.

I valori singolari $\sigma_i$ rappresentano **quante volte viene stirato** ogni vettore $\mathbf{v}_i$ nel passaggio verso $\mathbf{u}_i$.

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

## 🧠 Approfondimento


Ogni trasformazione lineare $\mathbf{X} \in \mathbb{R}^{m \times n}$, per quanto complessa, può essere sempre **scomposta in tre fasi geometriche**:

$$
\mathbf{X} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^\top
$$

Questa decomposizione corrisponde alla seguente **pipeline geometrica**:

### 🔹 1. Rotazione iniziale dello spazio ($\mathbf{V}^\top$)

- Ruota (o riflette) lo spazio originale per allinearlo alle direzioni principali della trasformazione.

- Trasforma ogni vettore $\mathbf{x}$ nel nuovo sistema di riferimento ortonormale: $\mathbf z= \mathbf V^⊤ \mathbf x$

- Intuitivamente, è come esprimere $\mathbf{x}$ in una nuova base ortogonale costruita sui concetti principali della trasformazione.

### 🔹 2. Scalatura assiale ($\mathbf{\Sigma}$)

- $\mathbf{\Sigma}$ è una matrice **diagonale** che **scala** ogni coordinata **indipendentemente** lungo un asse ortogonale.
- I valori diagonali $\sigma_1 \geq \sigma_2 \geq \dots \geq \sigma_r \geq 0$ sono i **valori singolari** e rappresentano **quanto** viene deformato lo spazio in ciascuna direzione.
- Nessuna rotazione o shearing: solo **dilatazione o contrazione**.
- In questo passaggio avviene il "cuore" della trasformazione: le direzioni principali vengono **ingrandite o compresse** in base alla loro **importanza informativa**.

### 🔹 3. Rotazione finale ($\mathbf{U}$)

- Dopo che il vettore è stato proiettato e scalato lungo le direzioni principali, $\mathbf{U}$ applica una rotazione (o riflessione) per posizionare il risultato nello spazio d'uscita: quello di $\mathbb{R}^m$ se $\mathbf{X} \in \mathbb{R}^{m \times n}$.

- La trasformazione $\mathbf{U}$ agisce come un cambio di base nello spazio del codominio:
essa assegna un significato geometrico e direzionale al risultato, stabilendo in quale direzione finale andrà ogni componente scalata.

- Geometricamente, $\mathbf{U}$ determina l’orientamento dell’ellisse risultante: mentre $\mathbf{V}^\top$ allinea l’ingresso alle direzioni principali e $\Sigma$ deforma (scala) secondo quelle direzioni, $\mathbf{U}$ decide come disporre quella deformazione nello spazio originale d’uscita.

### 🌌 Esempio Visivo

Immagina un **cerchio unitario** nello spazio 2D. Applichiamo $\mathbf{A}$ tramite la sua SVD:

<img src="../../images/svd_pipeline.png" width="600" style="display: block; margin-left: auto; margin-right: auto;">
<br>

L'immagine illustra geometricamente la decomposizione a valori singolari (SVD) di una matrice $\mathbf A$, mostrando come può essere interpretata come una sequenza di trasformazioni.

- **$\mathbf{V}^\top$** ruota il cerchio nella direzione delle **direzioni principali** (quelle dove deve avvenire lo stretching).
- **$\mathbf{\Sigma}$** schiaccia o dilata il cerchio lungo i suoi assi principali, trasformandolo in un ellisse.
- **$\mathbf{U}$** riallinea (ruota o riflette) l’ellisse nell’output space, secondo le direzioni principali dell'immagine di $\mathbf{X}$, cioè gli autovettori di $\mathbf{X} \mathbf{X}^\top$.

Risultato: da una figura simmetrica e isotropa (cerchio), otteniamo un oggetto deformato ma **con significato direzionale**.

### 🧬 Interpretazione concettuale

- Le **direzioni principali** (singular vectors) sono gli **assi di massima variazione** dell’azione di $\mathbf{X}$.
- I **valori singolari** dicono **quanto** $\mathbf{X}$ "stira" lo spazio lungo quei vettori.
- Questa decomposizione permette di **ridurre la dimensionalità** preservando la maggior parte dell’informazione (proiettando sui primi $k$ assi).

### ✅ Riassunto

| Passaggio | Matrice        | Tipo             | Azione nello spazio |
|-----------|----------------|------------------|---------------------|
| 1         | $\mathbf{V}^\top$ | Ortogonale       | Rotazione iniziale |
| 2         | $\mathbf{\Sigma}$ | Diagonale | Scalatura assiale  |
| 3         | $\mathbf{U}$      | Ortogonale       | Rotazione finale   |

👉 Questo rende la SVD **lo strumento matematico più naturale per comprendere e manipolare le trasformazioni lineari complesse** con una lente geometrica. 

## 📏 Proprietà

- I vettori di $\mathbf{U}$ e $\mathbf{V}$ formano **basi ortonormali** per lo spazio delle righe e delle colonne.
- I **valori singolari** $\sigma_i$ rappresentano la **quantità di informazione** trasportata lungo ciascuna direzione.
- $\text{rank}(\mathbf{X}) =$ numero di valori singolari non nulli.
- Può essere vista come una generalizzazione dell’autodecomposizione (eigendecomposition) per matrici rettangolari.

## 🔧 Riduzione Dimensionale tramite Truncated SVD

Spesso, molte direzioni in cui la matrice $\mathbf{X}$ proietta i dati risultano **trascurabili o rumorose**. La **Truncated SVD** consiste nel conservare **solo i primi $k \ll \min(m, n)$ valori singolari** più grandi:

$$
\mathbf{X} \approx \mathbf{X}_k = \mathbf{U}_k \mathbf{\Sigma}_k \mathbf{V}_k^\top
$$

- $\mathbf{U}_k \in \mathbb{R}^{m \times k}$ contiene i primi $k$ vettori singolari sinistri.
- $\mathbf{\Sigma}_k \in \mathbb{R}^{k \times k}$ contiene i primi $k$ valori singolari (i più grandi).
- $\mathbf{V}_k^\top \in \mathbb{R}^{k \times n}$ contiene i primi $k$ vettori singolari destri.

🔍 **Perché funziona?**

1. I valori singolari $\sigma_1 \geq \sigma_2 \geq \dots \geq \sigma_r$ sono ordinati in modo decrescente:  
   **i primi rappresentano le direzioni in cui $\mathbf{X}$ ha la massima "energia"** (varianza proiettata).

2. Geometricamente:  
   - Ogni direzione $\mathbf{v}_i$ corrisponde a un asse principale su cui $\mathbf{X}$ proietta i dati.
   - Il valore $\sigma_i$ misura **quanto è importante quella direzione**.
   - Troncando dopo $k$, scartiamo le direzioni meno influenti.

3. Matematicamente:  
   $$ 
   \mathbf{X}_k = \arg\min_{\text{rank-}k\text{ matrices } \mathbf{A}} \|\mathbf{X} - \mathbf{A}\|_F 
   $$
   cioè $\mathbf{X}_k$ è la **migliore approssimazione di rango $k$** di $\mathbf{X}$ in norma di Frobenius (somma dei quadrati degli scarti).

🚀 **Utilità**:
- **Compressione dei dati**: conserviamo solo l’informazione essenziale.
- **Riduzione del rumore**: eliminiamo direzioni deboli o casuali.
- **Estrazione di concetti latenti**: fondamentale in NLP, raccomandazione, clustering.


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
