# Oltre la definizione: Intuizione geometrica della SVD

## Cos'è la Decomposizione ai Valori Singolari (SVD)?

Ogni matrice $M \in \mathbb{C}^{m \times n}$ può essere scomposta come:

$$
M = U \Sigma V^*
$$

dove:
- $U$ è una matrice unitaria $m \times m$,
- $\Sigma$ è una matrice diagonale $m \times n$,
- $V$ è una matrice unitaria $n \times n$,
- $V^*$ è la trasposizione coniugata di $V$.

Questa scomposizione si può interpretare come una combinazione di **rotazioni** e **dilatazioni**. Un’intuizione geometrica: l’immagine di una sfera unitaria tramite $M$ diventa un’ellisse (o iperellisse).

## Intuizione geometrica: trasformazioni di un quadrato

Immagina un quadrato orientato (con frecce direzionali). Può essere:
- allungato o compresso (A, B),
- ruotato (C),
- riflesso (D),
- deformato per taglio (shear) (E).

Una **trasformazione lineare** mantiene diritte le linee rette. Anche se ruota, riflette o allunga, non curva nulla.

## Il punto chiave

Se ruotiamo il quadrato **prima** di applicare una trasformazione lineare $M$, possiamo fare in modo che la trasformazione si limiti ad allungare, comprimere o riflettere, **senza taglio**. Lo stesso vale per un cerchio che diventa un’ellisse: gli assi principali dell’ellisse rappresentano i **valori singolari** $\sigma_1$, $\sigma_2$.

## Formalizzazione della SVD

Sia $v_1, v_2$ una base ortonormale. Applichiamo $M$:

$$
Mv_1 = \sigma_1 u_1,\quad Mv_2 = \sigma_2 u_2
$$

Quindi, ogni vettore $x$ può essere scritto come:

$$
x = (x \cdot v_1) v_1 + (x \cdot v_2) v_2
$$

Applicando $M$:

$$
Mx = \sigma_1 u_1 (v_1 \cdot x) + \sigma_2 u_2 (v_2 \cdot x)
$$

Sostituendo termini, si ottiene la forma canonica:

$$
M = \sigma_1 u_1 v_1^* + \sigma_2 u_2 v_2^*
$$

che generalizza a:

$$
M = U \Sigma V^*
$$

## SVD in dimensioni superiori

Per matrici $m \times n$, la SVD diventa:

$$
M = U \Sigma V^*
$$

- Le **colonne di U** sono i vettori singolari sinistri,
- Le **righe di $V^*$** sono i vettori singolari destri,
- I **valori diagonali di $\Sigma$** sono i valori singolari $\sigma_i$, ordinati decrescentemente.

## Interpretazione geometrica dei valori singolari

Se un valore singolare è zero, significa che la trasformazione "schiaccia" lo spazio su una dimensione. Se alcuni valori sono piccoli, il comportamento della matrice è governato da poche direzioni principali.

## Collegamento con PCA

Data una matrice di dati $X \in \mathbb{R}^{n \times p}$:

$$
X = U \Sigma V^\top
$$

La matrice di covarianza è:

$$
X^\top X = V \Sigma^2 V^\top
$$

Quindi PCA cerca gli **assi principali** della varianza dei dati usando la SVD.

## Conclusione

La SVD è una potente tecnica che:
- decomprime trasformazioni lineari in rotazioni e dilatazioni,
- rivela la struttura interna di matrici,
- è alla base di algoritmi come PCA e compressione a bassa dimensionalità.

Per approfondimenti, si veda ad esempio *Trefethen & Bau III (1997)* o le visualizzazioni con `numpy.linalg.svd`.


## 🔄 Cosa rappresenta V^T nella SVD tradizionale?

Consideriamo la decomposizione ai valori singolari **completa**, cioè senza troncamenti:

$$
\mathbf{X} = \mathbf{U} \mathbf{S} \mathbf{V}^\top
$$

dove:

- $\mathbf{X} \in \mathbb{R}^{m \times n}$ è la matrice originale (ad esempio termini × documenti),
- $\mathbf{U} \in \mathbb{R}^{m \times m}$ è ortonormale: le colonne sono basi ortonormali dello spazio delle righe (es. spazio dei termini),
- $\mathbf{S} \in \mathbb{R}^{m \times n}$ è diagonale, con valori singolari non negativi in ordine decrescente,
- $\mathbf{V} \in \mathbb{R}^{n \times n}$ è ortonormale: le colonne sono basi ortonormali dello spazio delle colonne (es. spazio dei documenti).

---

### 📌 Ma cosa significa applicare $\mathbf{V}^\top$ a un vettore $\mathbf{x}$?

$$
\mathbf{z} = \mathbf{V}^\top \mathbf{x}
$$

Questa operazione ha un significato **geometrico fondamentale**: è un **cambio di base**.

- $\mathbf{x} \in \mathbb{R}^n$ è espresso nelle coordinate originali.
- $\mathbf{V}^\top$ proietta $\mathbf{x}$ nel **nuovo sistema di riferimento ortonormale** definito dalle colonne di $\mathbf{V}$.
- $\mathbf{z}$ sono le **coordinate di $\mathbf{x}$** rispetto alle **nuove direzioni principali** (cioè i "concetti" o "assi principali" trovati dalla SVD).

---

### 🧠 Intuizione

- Ogni colonna di $\mathbf{V}$ rappresenta una direzione **ortogonale** nel nuovo spazio dei concetti (assimilabile agli assi principali della varianza).
- Moltiplicare per $\mathbf{V}^\top$ ruota il sistema di coordinate per **rappresentare $\mathbf{x}$ in termini di quei concetti**.
- Se $\mathbf{x}$ è un documento, $\mathbf{V}^\top \mathbf{x}$ ci dice **quanto quel documento "partecipa" a ciascun concetto**.

---

### 🔁 E se voglio tornare indietro?

Si può ricostruire $\mathbf{x}$ da $\mathbf{z}$ così:

$$
\mathbf{x} = \mathbf{V} \mathbf{z}
$$

Perché $\mathbf{V}^\top$ è l'inverso di $\mathbf{V}$ (essendo ortogonale). Questo garantisce che il cambio di base sia **perfettamente invertibile**.

## 🧾 Ogni trasformazione lineare ammette una SVD

Sia $\mathbf{A} \in \mathbb{R}^{m \times n}$ una matrice arbitraria (non necessariamente quadrata, né simmetrica). Allora esiste una **decomposizione ai valori singolari** (SVD):

$$
\mathbf{A} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^\top
$$

dove:

- $\mathbf{U} \in \mathbb{R}^{m \times m}$ è ortogonale: $\mathbf{U}^\top \mathbf{U} = \mathbf{I}_m$,
- $\mathbf{V} \in \mathbb{R}^{n \times n}$ è ortogonale: $\mathbf{V}^\top \mathbf{V} = \mathbf{I}_n$,
- $\mathbf{\Sigma} \in \mathbb{R}^{m \times n}$ è diagonale (rettangolare), con $\sigma_1 \geq \sigma_2 \geq \dots \geq \sigma_r > 0$, e $r = \operatorname{rank}(\mathbf{A})$.

---

### ✏️ Dimostrazione (costruttiva)

1. **Costruiamo $\mathbf{A}^\top \mathbf{A}$**

$\mathbf{A}^\top \mathbf{A}$ è una matrice **simmetrica** e **semidefinita positiva**. Quindi, per il **teorema spettrale**, ha una decomposizione agli autovalori:

$$
\mathbf{A}^\top \mathbf{A} = \mathbf{V} \mathbf{\Lambda} \mathbf{V}^\top
$$

dove:

- $\mathbf{V}$ è ortogonale: le colonne sono autovettori ortonormali di $\mathbf{A}^\top \mathbf{A}$,
- $\mathbf{\Lambda} = \operatorname{diag}(\lambda_1, \dots, \lambda_n)$ è diagonale con $\lambda_i \geq 0$.

2. **Definiamo i valori singolari**

I valori singolari sono le **radici quadrate non negative** degli autovalori di $\mathbf{A}^\top \mathbf{A}$:

$$
\sigma_i = \sqrt{\lambda_i}, \quad \text{per } i = 1, \dots, r
$$

Costruiamo la matrice $\mathbf{\Sigma}$ come:

$$
\mathbf{\Sigma} = 
\begin{bmatrix}
\sigma_1 &        &        & \\
         & \ddots &        & \\
         &        & \sigma_r & \\
         &        &         & \mathbf{0}
\end{bmatrix} \in \mathbb{R}^{m \times n}
$$

3. **Costruiamo $\mathbf{U}$**

Definiamo:

$$
\mathbf{u}_i = \frac{1}{\sigma_i} \mathbf{A} \mathbf{v}_i \quad \text{per } i = 1, \dots, r
$$

Questi vettori $\mathbf{u}_i$ sono ortonormali e possiamo completare la base ortonormale in $\mathbb{R}^m$ per ottenere $\mathbf{U} \in \mathbb{R}^{m \times m}$.

---

### ✅ Conclusione

Abbiamo costruito:

- $\mathbf{V}$: base ortonormale degli autovettori di $\mathbf{A}^\top \mathbf{A}$,
- $\mathbf{\Sigma}$: radici degli autovalori (valori singolari),
- $\mathbf{U}$: immagini normalizzate dei $\mathbf{v}_i$ tramite $\mathbf{A}$.

Quindi:

$$
\mathbf{A} = \mathbf{U} \mathbf{\Sigma} \mathbf{V}^\top
$$

Questa decomposizione **esiste per ogni matrice reale $ \mathbf{A} $**. Di conseguenza, **ogni trasformazione lineare può essere vista come una rotazione → dilatazione → rotazione.**

---

### 📐 Interpretazione geometrica

- $\mathbf{V}^\top$: ruota (o cambia base) nel dominio,
- $\mathbf{\Sigma}$: scala (dilata o contrae) lungo assi ortogonali,
- $\mathbf{U}$: ruota nel codominio.

La SVD è quindi una **generalizzazione dell'autodecomposizione**, valida anche per matrici rettangolari.

