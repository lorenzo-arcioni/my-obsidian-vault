# AdaBoost: Algorithm

## Setup del Problema

### Input
- **Training set**: $(x_1, y_1), \ldots, (x_N, y_N)$ dove:
  - $x_i \in \mathcal{X}$ (spazio delle istanze)
  - $y_i \in \{0, 1\}$ (etichette binarie)
- **Distribuzione iniziale**: $D$ sugli esempi (tipicamente uniforme: $D(i) = 1/N$)
- **Weak learning algorithm**: `WeakLearn`
- **Numero di iterazioni**: $T$

### Output
- **Ipotesi finale**: $h_f : \mathcal{X} \to \{0, 1\}$

### Weak Learner

Il weak learner è un algoritmo che:
- **Input**: Riceve una distribuzione $p^t$ sugli $N$ esempi
- **Output**: Produce un'ipotesi $h_t : \mathcal{X} \to [0, 1]$
- **Garanzia**: L'errore pesato rispetto a $p^t$ è $\epsilon_t < 1/2$

**Nota importante**: Le ipotesi deboli possono essere probabilistiche, restituendo valori in $[0, 1]$ interpretabili come probabilità di predire 1.

## Pseudocodice dell'Algoritmo

$$
\begin{aligned}
\textbf{Algorithm: AdaBoost} \\[6pt]

\textbf{Input: } & \{(x_1,y_1),\ldots,(x_N,y_N)\},\ D,\ \textit{WeakLearn},\ T \\[4pt]

\textbf{Initialize: } & w_i^{(1)} = D(i), \quad i=1,\ldots,N \\[6pt]

\textbf{For } & t = 1,\ldots,T: \\[4pt]

& 1.\quad p_i^{(t)} = \frac{w_i^{(t)}}{\sum_{j=1}^{N} w_j^{(t)}} \\[6pt]

& 2.\quad h_t \leftarrow \textit{WeakLearn}(p^{(t)}) \\[6pt]

& 3.\quad \varepsilon_t =
\sum_{i=1}^{N} p_i^{(t)} \lvert h_t(x_i) - y_i \rvert \\[6pt]

& 4.\quad \beta_t = \frac{\varepsilon_t}{1 - \varepsilon_t} \\[6pt]

& 5.\quad w_i^{(t+1)} =
w_i^{(t)} \cdot \beta_t^{\,1 - \lvert h_t(x_i) - y_i \rvert} \\[8pt]

\textbf{Output: } &
h_f(x) =
\begin{cases}
1, & \sum_{t=1}^{T} \log \frac{1}{\beta_t} \, h_t(x)
\ge \frac{1}{2} \sum_{t=1}^{T} \log \frac{1}{\beta_t} \\
0, & \text{otherwise}
\end{cases}
\end{aligned}
$$

## Analisi Dettagliata dei Passi

### Inizializzazione

$$
w^1_i = D(i) \quad \text{for } i = 1, \ldots, N
$$

I pesi iniziali sono impostati secondo la distribuzione $D$. Tipicamente $D$ è uniforme, quindi:
$$w^1_i = \frac{1}{N}$$

Questi pesi rappresentano l'importanza relativa di ciascun esempio. Inizialmente tutti gli esempi sono ugualmente importanti.

### Step 1: Normalizzazione dei Pesi

$$
p^t_i = \frac{w^t_i}{\sum_{j=1}^N w^t_j}
$$

La normalizzazione garantisce che $p^t$ sia una distribuzione di probabilità:
- $p^t_i \geq 0$ per ogni $i$
- $\sum_{i=1}^N p^t_i = 1$

Questa distribuzione viene fornita al weak learner per "focalizzarlo" sugli esempi attualmente più importanti.

### Step 2: Chiamata al Weak Learner

Il weak learner riceve $p^t$ e restituisce un'ipotesi $h_t : \mathcal{X} \to [0, 1]$.

**Interpretazione di $h_t(x)$**:
- Se $h_t$ è deterministico: $h_t(x) \in \{0, 1\}$
- Se $h_t$ è probabilistico: $h_t(x)$ è la probabilità di predire 1 per l'istanza $x$

### Step 3: Calcolo dell'Errore

$$
\epsilon_t = \sum_{i=1}^N p^t_i |h_t(x_i) - y_i|
$$

L'errore $\epsilon_t$ è l'errore pesato dell'ipotesi $h_t$ rispetto alla distribuzione $p^t$.

**Casi particolari**:
1. **Ipotesi booleane** ($h_t(x) \in \{0, 1\}$):
   $$|h_t(x_i) - y_i| = \begin{cases} 1 & \text{se } h_t(x_i) \neq y_i \\ 0 & \text{se } h_t(x_i) = y_i \end{cases}$$
   Quindi $\epsilon_t = \Pr_{i \sim p^t}[h_t(x_i) \neq y_i]$ (tasso di errore standard)

2. **Ipotesi probabilistiche**:
   $$|h_t(x_i) - y_i| = \begin{cases} h_t(x_i) & \text{se } y_i = 0 \\ 1 - h_t(x_i) & \text{se } y_i = 1 \end{cases}$$
   L'errore è la perdita attesa di una predizione randomizzata.

**Proprietà fondamentale**: Affinche il boosting funzioni, dobbiamo avere $\epsilon_t < 1/2$.

### Step 4: Calcolo del Parametro β

$$
\beta_t = \frac{\epsilon_t}{1 - \epsilon_t}
$$

Il parametro $\beta_t$ controlla l'aggiornamento dei pesi e il voto finale.

**Proprietà di $\beta_t$**:
- Poiché $\epsilon_t \in [0, 1]$, abbiamo $\beta_t \in [0, \infty)$
- Se $\epsilon_t < 1/2$: allora $\beta_t < 1$ (ipotesi utile)
- Se $\epsilon_t = 1/2$: allora $\beta_t = 1$ (ipotesi inutile, come random guess)
- Se $\epsilon_t > 1/2$: allora $\beta_t > 1$ (ipotesi "peggio di random")

**Relazione con l'accuratezza**:
- $\epsilon_t$ piccolo ⟹ $\beta_t$ piccolo ⟹ grandi cambiamenti nei pesi
- $\epsilon_t$ vicino a 1/2 ⟹ $\beta_t$ vicino a 1 ⟹ piccoli cambiamenti nei pesi

### Step 5: Aggiornamento dei Pesi

$$
w^{t+1}_i = w^t_i \cdot \beta_t^{1 - |h_t(x_i) - y_i|}
$$

Questo è il cuore dell'algoritmo. Analizziamo l'esponente:

$$
1 - |h_t(x_i) - y_i| = \begin{cases} 1 & \text{se } h_t(x_i) = y_i \text{ (predizione corretta)} \\ 0 & \text{se } h_t(x_i) \neq y_i \text{ (predizione errata)} \end{cases}
$$

oppure (caso probabilistico):

$$
1 - |h_t(x_i) - y_i| = \begin{cases} 1 -h_t(x_i) & \text{se } y_i = 0\\ h_t(x_i) & \text{se } y_i = 1
\end{cases}
$$

Quindi (caso booleano):
$$w^{t+1}_i = \begin{cases}
w^t_i \cdot \beta_t & \text{se } h_t(x_i) = y_i \\
w^t_i \cdot 1 & \text{se } h_t(x_i) \neq y_i
\end{cases}$$

**Interpretazione**:
- **Esempi corretti**: peso moltiplicato per $\beta_t < 1$ → peso **diminuisce**
- **Esempi errati**: peso moltiplicato per 1 → peso **rimane uguale**

In termini relativi (dopo normalizzazione):
- Gli esempi classificati correttamente diventano **meno importanti**
- Gli esempi classificati erroneamente diventano **più importanti**

**Caso probabilistico**: Per ipotesi probabilistiche, l'aggiornamento è graduale:
- Se $h_t(x_i)$ è vicino a $y_i$: peso diminuisce molto
- Se $h_t(x_i)$ è lontano da $y_i$: peso diminuisce poco (o aumenta)

### Evoluzione dei Pesi nel Tempo

Possiamo espandere ricorsivamente l'aggiornamento:

$$
w^{T+1}_i = w^1_i \prod_{t=1}^T \beta_t^{1 - |h_t(x_i) - y_i|}
$$

Per la distribuzione iniziale uniforme ($w^1_i = D(i)$):

$$
w^{T+1}_i = D(i) \prod_{t=1}^T \beta_t^{1 - |h_t(x_i) - y_i|}
$$

Questa formula mostra che il peso finale di un esempio dipende esponenzialmente dal numero di errori compiuti su di esso dalle varie ipotesi deboli.

## Ipotesi Finale

### Forma della Predizione

L'ipotesi finale combina le $T$ ipotesi deboli tramite un **voto pesato**:

$$
h_f(x) = \begin{cases}
1 & \text{se } \sum_{t=1}^T \left(\log \frac{1}{\beta_t}\right) h_t(x) \geq \frac{1}{2} \sum_{t=1}^T \log \frac{1}{\beta_t} \\
0 & \text{altrimenti}
\end{cases}
$$

### Interpretazione

Definiamo i **pesi di voto**:
$$
\alpha_t = \log \frac{1}{\beta_t} = \log \frac{1 - \epsilon_t}{\epsilon_t}
$$

Allora:
$$
h_f(x) = \begin{cases}
1 & \text{se } \sum_{t=1}^T \alpha_t h_t(x) \geq \frac{1}{2} \sum_{t=1}^T \alpha_t \\
0 & \text{altrimenti}
\end{cases}
$$

**Proprietà di $\alpha_t$**:
- Se $\epsilon_t < 1/2$: allora $\alpha_t > 0$ (ipotesi conta positivamente)
- Se $\epsilon_t = 1/2$: allora $\alpha_t = 0$ (ipotesi ignorata)
- Se $\epsilon_t \to 0$: allora $\alpha_t \to \infty$ (ipotesi perfetta ha peso massimo)

**Intuizione**: Ipotesi più accurate ricevono peso maggiore nel voto finale.

### Forma Equivalente

Possiamo riscrivere la condizione come:

$$
\sum_{t=1}^T \alpha_t h_t(x) \geq \frac{1}{2} \sum_{t=1}^T \alpha_t
$$

Ovvero:
$$
\frac{\sum_{t=1}^T \alpha_t h_t(x)}{\sum_{t=1}^T \alpha_t} \geq \frac{1}{2}
$$

Questa è una **media pesata** delle predizioni $h_t(x)$, dove i pesi sono $\alpha_t$.

### Caso Ipotesi Booleane

Se tutte le $h_t$ sono booleane ($h_t(x) \in \{0, 1\}$), allora:

$$
h_f(x) = \begin{cases}
1 & \text{se } \sum_{t: h_t(x)=1} \alpha_t > \sum_{t: h_t(x)=0} \alpha_t \\
0 & \text{altrimenti}
\end{cases}
$$

Cioè: $h_f$ predice la classe che ha ricevuto il **voto pesato maggiore**.

### Soglia Alternativa

In alcuni contesti, si usa una soglia diversa. Definendo:

$$
f(x) = \sum_{t=1}^T \alpha_t h_t(x)
$$

Si può scrivere:
$$
h_f(x) = \text{sign}\left(f(x) - \theta\right)
$$

dove $\theta = \frac{1}{2}\sum_{t=1}^T \alpha_t$ è la soglia.

## Parametri dell'Algoritmo

### Scelta di $T$ (Numero di Iterazioni)

Il numero di iterazioni $T$ è un iperparametro critico:

**Trade-off**:
- **$T$ troppo piccolo**: Non si sfrutta a pieno il boosting, errore di training alto
- **$T$ troppo grande**: Rischio di overfitting (anche se AdaBoost è sorprendentemente resistente)

**Approcci pratici**:
1. **Cross-validation**: Scegliere $T$ che minimizza l'errore di validazione
2. **Early stopping**: Fermarsi quando l'errore di validazione smette di migliorare
3. **Bound teorico**: Dalla teoria (Teorema 6), per raggiungere errore $\epsilon$ serve:
   $$T \approx \frac{1}{2\gamma^2} \ln \frac{1}{\epsilon}$$
   dove $\gamma = 1/2 - \epsilon_{\max}$ è il margine minimo

### Scelta della Distribuzione Iniziale D

Tipicamente si usa $D$ uniforme:
$$D(i) = \frac{1}{N} \quad \forall i$$

**Alternative**:
- Se si hanno informazioni a priori su quali esempi sono più importanti, si può usare una $D$ non uniforme
- Il bound teorico dipende da $D(i)$: esempi con $D(i)$ grande hanno garanzie migliori

### Gestione di $εₜ ≥ \frac{1}{2}$

Se a un'iterazione $t$ si ottiene $\epsilon_t \geq \frac{1}{2}$, il weak learner ha "fallito".

**Opzioni**:
1. **Terminare**: Fermare l'algoritmo a $T = t-1$ (scelta del paper)
2. **Invertire**: Usare $1 - h_t$ invece di $h_t$ (se $\epsilon_t > 1/2$, allora $1-h_t$ ha errore $< 1/2$)
3. **Scartare**: Ignorare $h_t$ e richiedere una nuova ipotesi

Il paper suggerisce la prima opzione: se il weak learner non può fare meglio di random guess su qualche distribuzione, il boosting non può procedere.

## Esempio di Esecuzione

Consideriamo un esempio giocattolo con $N=5$ esempi:

| i | $x_i$ | $y_i$ |
|---|-------|-------|
| 1 | ...   | 1     |
| 2 | ...   | 0     |
| 3 | ...   | 1     |
| 4 | ...   | 0     |
| 5 | ...   | 1     |

### Inizializzazione

$$w^1 = \left[\frac{1}{5}, \frac{1}{5}, \frac{1}{5}, \frac{1}{5}, \frac{1}{5}\right]$$
$$p^1 = w^1 = \left[\frac{1}{5}, \frac{1}{5}, \frac{1}{5}, \frac{1}{5}, \frac{1}{5}\right]$$

### Iterazione 1

Supponiamo `WeakLearn` restituisca $h_1$ con predizioni:
$$h_1(x_1)=1, h_1(x_2)=0, h_1(x_3)=0, h_1(x_4)=0, h_1(x_5)=1$$

**Errore**:
$$\epsilon_1 = \frac{1}{5}(|1-1| + |0-0| + |0-1| + |0-0| + |1-1|) = \frac{1}{5}$$

**Parametro**:
$$\beta_1 = \frac{1/5}{4/5} = \frac{1}{4}$$

**Aggiornamento pesi**:
- $w^2_1 = \frac{1}{5} \cdot (1/4)^{1-0} = \frac{1}{20}$ (corretto)
- $w^2_2 = \frac{1}{5} \cdot (1/4)^{1-0} = \frac{1}{20}$ (corretto)
- $w^2_3 = \frac{1}{5} \cdot (1/4)^{1-1} = \frac{1}{5}$ (errato)
- $w^2_4 = \frac{1}{5} \cdot (1/4)^{1-0} = \frac{1}{20}$ (corretto)
- $w^2_5 = \frac{1}{5} \cdot (1/4)^{1-0} = \frac{1}{20}$ (corretto)

**Normalizzazione**:
$$\sum w^2_i = \frac{4}{20} + \frac{1}{5} = \frac{2}{5}$$

$$p^2 = \left[\frac{1/20}{2/5}, \frac{1/20}{2/5}, \frac{1/5}{2/5}, \frac{1/20}{2/5}, \frac{1/20}{2/5}\right] = \left[\frac{1}{8}, \frac{1}{8}, \frac{1}{2}, \frac{1}{8}, \frac{1}{8}\right]$$

Notiamo che l'esempio 3 (classificato erroneamente) ora ha peso $1/2$, molto maggiore degli altri!

### Ipotesi Finale (dopo T iterazioni)

Con $\alpha_1 = \log(4) \approx 1.386$, e dopo aver raccolto $T$ ipotesi:

$$h_f(x) = \begin{cases}
1 & \text{se } \sum_{t=1}^T \alpha_t h_t(x) \geq \frac{1}{2}\sum_{t=1}^T \alpha_t \\
0 & \text{altrimenti}
\end{cases}$$

## Complessità Computazionale

### Per Iterazione
- **Step 1** (normalizzazione): $O(N)$
- **Step 2** (weak learner): $O(T_{WL}(N))$ dove $T_{WL}$ è il tempo del weak learner
- **Step 3** (calcolo errore): $O(N)$
- **Step 4** (calcolo $\beta$): $O(1)$
- **Step 5** (aggiornamento pesi): $O(N)$

**Totale per iterazione**: $O(N + T_{WL}(N))$

### Totale
**Complessità totale**: $O(T \cdot (N + T_{WL}(N)))$

Se il weak learner è lineare in $N$, la complessità diventa $O(T \cdot N)$.

## Note Implementative

### Stabilità Numerica

I pesi $w^t_i$ possono diventare molto piccoli o molto grandi. Per evitare problemi numerici:

1. **Lavorare in log-space**: Mantenere $\log w^t_i$ invece di $w^t_i$
2. **Rinormalizzazione frequente**: Dopo ogni update, rinormalizzare per evitare overflow/underflow
3. **Precisione**: Usare aritmetica a doppia precisione (float64)

### Gestione di Weak Learner Deterministici

Se il weak learner produce solo ipotesi booleane $h_t : \mathcal{X} \to \{0,1\}$:
- L'algoritmo funziona identicamente
- L'errore diventa semplicemente: $\epsilon_t = \Pr_{i \sim p^t}[h_t(x_i) \neq y_i]$
- L'interpretazione è più semplice: voto a maggioranza pesato

### Ottimizzazioni

1. **Early stopping su $ε_t$**: Se $\epsilon_t$ è molto vicino a 0, $h_t$ è quasi perfetta. Si può terminare.
2. **Caching**: Pre-calcolare le predizioni $h_t(x_i)$ per tutti gli esempi del training set
3. **Sparse updates**: Se solo pochi pesi cambiano significativamente, si possono aggiornare solo quelli

## Varianti dell'Ipotesi Finale

### Variante con Soglia Soft (Sezione 4.5 del Paper)

Invece di una soglia "hard" a 1/2, si può usare una funzione continua:

$$h_f(x) = F(r(x))$$

dove:
$$r(x) = \frac{\sum_{t=1}^T \alpha_t h_t(x)}{\sum_{t=1}^T \alpha_t}$$

e $F : [0,1] \to [0,1]$ è una funzione che soddisfa:
- $F(1-r) = 1 - F(r)$ (simmetria)
- $F(r) \leq \frac{1}{2}\left(\prod_{t=1}^T \beta_t\right)^{1/2 - r}$ (bound)

**Esempio**: Funzione sigmoide:
$$F(r) = \frac{1}{1 + \prod_{t=1}^T \beta_t^{2r-1}}$$

**Vantaggio**: Questa versione ha un bound sull'errore migliorato di un fattore 2 (Teorema 9).

### Weighted Median (per Regressione)

Nel caso di AdaBoost.R (regressione), l'ipotesi finale è una **mediana pesata**:

$$h_f(x) = \inf\left\{y : \sum_{t: h_t(x) \leq y} \alpha_t \geq \frac{1}{2}\sum_t \alpha_t\right\}$$

Questo generalizza il voto a maggioranza al caso continuo.

## Relazione con Altri Algoritmi

### Interpretazione Bayesiana

L'ipotesi finale di AdaBoost coincide con la **regola di decisione Bayesiana ottimale** sotto l'assunzione (spesso non realistica) che gli errori delle ipotesi deboli siano **indipendenti** condizionatamente alla label.

Sotto questa assunzione:
$$P(y=1 | h_1(x), \ldots, h_T(x)) \propto P(y=1) \prod_{t: h_t(x)=0} \epsilon_t \prod_{t: h_t(x)=1} (1-\epsilon_t)$$

E la regola ottimale è predire 1 se e solo se questa probabilità > 1/2, che è esattamente la regola di AdaBoost.

### Connessione con Hedge

AdaBoost è derivabile dall'algoritmo **Hedge** per l'on-line allocation problem tramite una riduzione "duale":

| Hedge() | AdaBoost |
|---------|----------|
| $N$ strategie | $N$ esempi di training |
| $T$ trial | $T$ ipotesi deboli |
| Loss $\ell^t_i$ della strategia $i$ al trial $t$ | "Loss" $1 - |h_t(x_i) - y_i|$ dell'esempio $i$ con ipotesi $t$ |
| Parametro $\beta$ fisso | Parametro $\beta_t$ variabile |

Questa connessione spiega l'update moltiplicativo dei pesi e fornisce intuizione sull'algoritmo.

### Forward Stagewise Additive Modeling

AdaBoost può essere visto come un caso speciale di **forward stagewise additive modeling** con loss function esponenziale:

$$L(y, f(x)) = \exp(-y f(x))$$

dove $f(x) = \sum_{t=1}^T \alpha_t h_t(x)$ e $y \in \{-1, +1\}$.

Ad ogni step, AdaBoost risolve approssimativamente:
$$(\alpha_t, h_t) = \arg\min_{\alpha, h} \sum_{i=1}^N \exp\left(-y_i\left(f_{t-1}(x_i) + \alpha h(x_i)\right)\right)$$

Questo spiega perché AdaBoost minimizza la loss esponenziale sul training set.