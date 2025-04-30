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
