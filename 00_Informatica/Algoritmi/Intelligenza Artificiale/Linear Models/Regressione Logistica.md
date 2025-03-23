# Regressione Logistica

La **regressione logistica** è un modello di classificazione che stima direttamente la probabilità di appartenenza a una classe, basandosi su un approccio **discriminativo**. Questo la differenzia da metodi **generativi** come l'Analisi Discriminante Lineare (LDA), che modellano esplicitamente le distribuzioni delle features condizionate alle classi. Per una trattazione dettagliata del quadro probabilistico, consulta la [[Classificazione Binaria]].

## **Fondamenti Probabilistici**

### Collegamento con il Logit e la Sigmoide
Il **logit** rappresenta il *logaritmo del rapporto delle probabilità* (log-odds) tra classe positiva e negativa:
$$
\text{logit}(p) = \ln\left(\frac{p}{1-p}\right) = \mathbf x^\top \mathbf{w} +b
$$

![Funzione logit](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Logit.svg/1920px-Logit.svg.png)

*Figura 2.0: Funzione logit.*

La **funzione sigmoide** $\sigma(\cdot)$ ne è l'inversa:
$$
p = \sigma(\mathbf x^\top \mathbf{w} + b) = \frac{1}{1 + e^{-(\mathbf x^\top \mathbf{w} + b)}}
$$

![Funzione sigmoide](https://upload.wikimedia.org/wikipedia/commons/8/88/Logistic-curve.svg)

*Figura 2.1: Funzione sigmoide.*

Questa relazione deriva direttamente dalla massimizzazione della *verosimiglianza* (MLE) sotto un modello lineare generalizzato (GLM). Per i dettagli analitici, vedi la [[Classificazione Binaria]].

## **Definizioni Generali**
Dato un dataset $\mathcal D = \{(\mathbf x_i, y_i)\}_{i=1}^n$, una regressione logistica classifica le osservazioni in due classi: $y_i \in \{0, 1\}$. La funzione stimata $\hat{f}_\mathbf w$ utilizza la funzione sigmoide per mappare i vettori $\mathbf x_i \in \mathbb R^{(m+1)}$ in probabilità tramite un vettore di pesi $\mathbf w \in \mathbb R^{m+1}$. Per semplicità, assumeremo che i vettori siano:

$$
\mathbf w = \begin{bmatrix} w_0 \\ \vdots \\ w_m \end{bmatrix} \quad \text{e} \quad \mathbf x = \begin{bmatrix} x_0 = 1 \\ x_1 \\ \vdots \\ x_m \end{bmatrix}.
$$

Quindi:

$$
\hat{f}_\mathbf w(\mathbf x_i) = \sigma(\mathbf x^\top \mathbf{w}) = \frac{1}{1 + e^{-(\mathbf x^\top \mathbf{w})}}.
$$

In questo modo la funzione stimata diventa:

$$
\hat{f}_\mathbf w(\mathbf x_i) = \sigma(\mathbf{x}_i^\top \mathbf w) = \frac{1}{1 + e^{-\mathbf{x}_i^\top \mathbf w}}
$$

Quindi:
- $p(y_i=1 \mid \mathbf x_i, \mathbf w) = \sigma(\mathbf{x}_i^\top \mathbf w) = \frac{1}{1 + e^{-\mathbf{x}_i^\top \mathbf w}}$
- $p(y_i=0 \mid \mathbf x_i, \mathbf w) = 1 - \sigma(\mathbf{x}_i^\top \mathbf w) = \frac{e^{-\mathbf{x}_i^\top \mathbf w}}{1 + e^{-\mathbf{x}_i^\top \mathbf w}}$

Quindi, la verosimiglianza del vettore di tutte le osservazioni $\mathbf y$ dati un vettore di pesi $\mathbf w$ e una matrice di features $\mathbf X \in \mathbb R^{n \times (m+1)}$ viene definita come:

$$\begin{align*}
p(\mathbf y \mid \mathbf X, \mathbf w) &= \prod_{i=1}^n \hat{f}_\mathbf w(\mathbf x_i)^{y_i} \left(1 - \hat{f}_\mathbf w(\mathbf x_i)\right)^{1 - y_i}\\ 
&=\prod_{i=1}^n \sigma(\mathbf{x}_i^\top \mathbf w)^{y_i} \left(1 - \sigma(\mathbf{x}_i^\top \mathbf w)\right)^{1 - y_i}.
\end{align*}
$$

In questo modo, quando (la label del dataset) $y_i = 1$, consideriamo la probabilità predetta dal modello per la classe $1$, mentre quando $y_i = 0$, consideriamo la probabilità predetta dal modello per la classe $0$.

Il nostro obiettivo è quello di trovare il vettore di pesi $\mathbf w$ che massimizza questa funzione di verosimiglianza.

## **Ottimizzazione del Modello**
Ora possiamo quindi definire la funzione di verosimiglianza (Likelihood Function) come:

$$
\mathcal{L}(\mathbf{w}) = \prod_{i=1}^n p(y_i \mid \mathbf x_i, \mathbf w) = \prod_{i=1}^n \sigma(\mathbf{x}_i^\top \mathbf w)^{y_i} \left(1 - \sigma(\mathbf{x}_i^\top \mathbf w)\right)^{1 - y_i}.
$$

Chiaramente, questa funzione non è lineare ne tanto meno convessa (grazie alla funzione sigmoide), quindi non possiamo sfruttare le care tecniche di ottimizzazione convessa. Questo può essere un problema non da poco, ma che risolveremo di seguito.

### Funzione di Perdita (Log-Loss)
Applicando il logaritmo ad entrambi i membri della funzione di verosimiglianza otteniamo: 

$$
\ln \mathcal{L}(\mathbf{w}) = \sum_{i=1}^n \left(y_i \ln(\sigma(\mathbf{x}_i^\top \mathbf w)) + (1 - y_i) \ln(1 - \sigma(\mathbf{x}_i^\top \mathbf w))\right).
$$

In questo modo, dato che il logaritmo è una funzione monotona crescente, non modifichiamo il problema di massimizzazione della funzione di verosimiglianza.

In più, applicando un coefficiente (negativo) di mediazione $-\frac{1}{n}$, otteniamo una nuova funzione di perdita $\mathcal{LL}(\mathbf w)$ detta **Log-Loss** o **Cross-Entropy** o **Logarithmic Loss**:

$$
\mathcal{LL}(\mathbf{w}) = -\frac{1}{n} \sum_{i=1}^n \left(y_i \ln(\sigma(\mathbf{x}_i^\top \mathbf w)) + (1 - y_i) \ln(1 - \sigma(\mathbf{x}_i^\top \mathbf w))\right).
$$

Quindi il nostro problema di massimizzazione della funzione di verosimiglianza diventa un problema di minimizzazione della funzione di perdita (grazie al fattore di mediazione negativo).



## **Estensione Multiclasse: Softmax e Logica Multinomiale**

### Generalizzazione del Logit
In problemi con $K > 2$ classi, si introduce un vettore di pesi $\mathbf{w}_k$ per ogni classe. I **logit** diventano:
$$
\hat{f}_\mathbf w_k(\mathbf{x}_i) = \mathbf{w}_k^T \mathbf{x}_i + b_k \quad \text{per } k = 1, ..., K
$$

### Funzione Softmax
La softmax generalizza la sigmoide mappando i logit in probabilità:
$$
\hat{p}_{i,k} = \frac{e^{\hat{f}_\mathbf w_k(\mathbf{x}_i)}}{\sum_{j=1}^K e^{\hat{f}_\mathbf w_j(\mathbf{x}_i)}} 
$$
**Proprietà chiave**:
- $\sum_{k=1}^K \hat{p}_{i,k} = 1$
- Sensibile a differenze relative tra logit: $\hat{p}_{i,k}$ domina se $\hat{f}_\mathbf w_k \gg \hat{f}_\mathbf w_j$ per $j \neq k$.

### Loss Function Multiclasse
La funzione di perdita è l'entropia incrociata multiclasse:
$$
\ell(\mathbf{W}, \mathbf{b}) = -\sum_{i=1}^n \sum_{k=1}^K y_{i,k} \ln(\hat{p}_{i,k})
$$
**Ottimizzazione**:  
I gradienti rispetto a $\mathbf{w}_k$ sono:
$$
\nabla_{\mathbf{w}_k} \ell = \sum_{i=1}^n (\hat{p}_{i,k} - y_{i,k}) \mathbf{x}_i
$$
Questo mostra come gli errori $(\hat{p}_{i,k} - y_{i,k})$ guidino l'aggiornamento dei pesi.

## **Confronto con l'Analisi Discriminante Lineare (LDA)**

| **Caratteristica**       | **Regressione Logistica**                          | **LDA**                                  |
|--------------------------|---------------------------------------------------|------------------------------------------|
| **Tipo di Modello**       | Discriminativo                                    | Generativo                               |
| **Assunzioni**           | Nessuna su $p(\mathbf{x} \mid y)$               | Features ~ Gaussiane con stessa covarianza |
| **Stima Parametri**      | Massimizzazione della verosimiglianza             | Massimizzazione joint likelihood        |
| **Robustezza**           | Maggiore in assenza di normalità delle features   | Sensibile a violazioni delle assunzioni  |
| **Interpretazione**      | Coefficienti come log-odds ratio                  | Coefficienti legati a media e covarianza |

## **Aspetti Pratici**

### Regolarizzazione
Per evitare overfitting, si aggiungono termini di penalità alla loss:
- **L1 (Lasso)**: $\lambda \|\mathbf{w}\|_1$ → Sparsità (selezione features).
- **L2 (Ridge)**: $\lambda \|\mathbf{w}\|_2^2$ → Contrazione coefficienti.

Esempio con regolarizzazione L2:
$$
\ell_{\text{reg}}(\mathbf{w}) = \ell(\mathbf{w}) + \lambda \sum_{j=1}^n w_j^2
$$

### Soglie di Decisione Non Standard
La soglia 0.5 è ottimale solo se:
- Costi di falsi positivi/negativi sono bilanciati.
- La distribuzione delle classi è uniforme.

In scenari sbilanciati, si può ottimizzare la soglia massimizzando l'**F1-score** o minimizzando costi specifici.

## **Esempio: Interpretazione Coefficienti**

Supponiamo un modello con:
- **Feature**: Età ($\mathbf{x}_1$), Reddito ($\mathbf{x}_2$).
- **Coefficiente stimato**: $\mathbf{w} = [0.8, -0.2]$.

**Interpretazione**:
- **Età**: Un aumento di 1 anno moltiplica gli odds ratio per $e^{0.8} ≈ 2.23$ (favorevole alla classe positiva).
- **Reddito**: Un aumento di 1 unità moltiplica gli odds ratio per $e^{-0.2} ≈ 0.82$ (sfavorevole).

## **Limiti della Regressione Logistica**

1. **Linearità nei Confini**: Assume che il logit sia lineare nelle features → Non cattura interazioni complesse.
2. **Sensibilità a Correlazioni**: Features altamente correlate possono destabilizzare i coefficienti.
3. **Classi Separabili**: Se le classi sono linearmente separabili, i coefficienti divergono ($\|\mathbf{w}\| \to \infty$).

Per superare questi limiti, si possono introdurre:
- **Feature Polinomiali**: $\mathbf{x}_1^2, \mathbf{x}_1 \mathbf{x}_2$.
- **Kernel Methods**: Mappare implicitamente in spazi ad alta dimensionalità.