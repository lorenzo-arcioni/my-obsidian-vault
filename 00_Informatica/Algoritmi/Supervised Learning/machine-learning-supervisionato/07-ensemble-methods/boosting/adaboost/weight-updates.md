# AdaBoost: Weight Updates

## Introduzione

Il meccanismo di aggiornamento dei pesi è il **cuore** di AdaBoost. Questo processo adattivo è ciò che permette all'algoritmo di:
1. Focalizzarsi progressivamente sugli esempi difficili
2. Combinare efficacemente ipotesi deboli in un'ipotesi forte
3. Ottenere convergenza esponenziale dell'errore

## La Regola di Aggiornamento

### Forma Generale

Ad ogni iterazione $t$, i pesi vengono aggiornati secondo:

$$w^{t+1}_i = w^t_i \cdot \beta_t^{1 - |h_t(x_i) - y_i|}$$

dove:
- $w^t_i$ è il peso dell'esempio $i$ all'iterazione $t$
- $\beta_t = \frac{\epsilon_t}{1 - \epsilon_t}$ è il parametro di aggiornamento
- $h_t(x_i)$ è la predizione dell'ipotesi debole $t$ sull'esempio $i$
- $y_i$ è la label vera dell'esempio $i$

### Interpretazione dell'Esponente

L'esponente $1 - |h_t(x_i) - y_i|$ misura quanto l'ipotesi $h_t$ è "corretta" sull'esempio $i$:

$$1 - |h_t(x_i) - y_i| = \begin{cases}
1 & \text{se } h_t(x_i) = y_i \text{ (predizione perfetta)} \\
0 & \text{se } h_t(x_i) \neq y_i \text{ (predizione completamente errata)} \\
\text{valore intermedio} & \text{altrimenti (ipotesi probabilistiche)}
\end{cases}$$

**Per ipotesi booleane** ($h_t(x_i) \in \{0,1\}$, $y_i \in \{0,1\}$):

$$1 - |h_t(x_i) - y_i| = \begin{cases}
1 & \text{se } h_t(x_i) = y_i \\
0 & \text{se } h_t(x_i) \neq y_i
\end{cases}$$

Questo porta alla forma semplificata:

$$w^{t+1}_i = \begin{cases}
w^t_i \cdot \beta_t & \text{se } h_t(x_i) = y_i \\
w^t_i \cdot 1 & \text{se } h_t(x_i) \neq y_i
\end{cases}$$

## Perché Questa Regola Funziona

### Proprietà di β_t

Ricordiamo che $\beta_t = \frac{\epsilon_t}{1 - \epsilon_t}$ dove $\epsilon_t$ è l'errore di $h_t$.

**Caso 1: Ipotesi molto accurata** ($\epsilon_t \ll 1/2$)
- $\beta_t \ll 1$
- Gli esempi corretti hanno peso moltiplicato per $\beta_t \ll 1$ → **forte diminuzione**
- Gli esempi errati mantengono il peso → **aumento relativo forte**

**Caso 2: Ipotesi mediocre** ($\epsilon_t \approx 1/2$)
- $\beta_t \approx 1$
- Gli esempi corretti hanno peso moltiplicato per $\approx 1$ → **poca diminuzione**
- Gli esempi errati mantengono il peso → **poco aumento relativo**

**Caso 3: Ipotesi perfetta** ($\epsilon_t = 0$)
- $\beta_t = 0$
- Tutti gli esempi corretti hanno peso → $0$
- Solo gli esempi errati (se esistono) mantengono peso

**Caso 4: Random guessing** ($\epsilon_t = 1/2$)
- $\beta_t = 1$
- Nessun cambiamento nei pesi: $w^{t+1}_i = w^t_i$

### Effetto sulla Distribuzione Normalizzata

Dopo normalizzazione, otteniamo:

$$p^{t+1}_i = \frac{w^{t+1}_i}{\sum_{j=1}^N w^{t+1}_j}$$

**Effetto relativo**:
- Esempi classificati **correttamente**: la loro frazione della probabilità totale **diminuisce**
- Esempi classificati **erroneamente**: la loro frazione della probabilità totale **aumenta**

Questo costringe il weak learner successivo a focalizzarsi sugli esempi difficili.

## Analisi Matematica Dettagliata

### Espansione Ricorsiva

Possiamo espandere ricorsivamente l'aggiornamento dei pesi:

$$w^{t+1}_i = w^t_i \cdot \beta_t^{1 - |h_t(x_i) - y_i|}$$

$$= w^{t-1}_i \cdot \beta_{t-1}^{1 - |h_{t-1}(x_i) - y_i|} \cdot \beta_t^{1 - |h_t(x_i) - y_i|}$$

$$= \cdots$$

$$= w^1_i \prod_{s=1}^t \beta_s^{1 - |h_s(x_i) - y_i|}$$

Partendo da $w^1_i = D(i)$:

$$w^{t+1}_i = D(i) \prod_{s=1}^t \beta_s^{1 - |h_s(x_i) - y_i|}$$

### Forma Logaritmica

Prendendo il logaritmo:

$$\log w^{t+1}_i = \log D(i) + \sum_{s=1}^t (1 - |h_s(x_i) - y_i|) \log \beta_s$$

Definendo $\alpha_s = \log \frac{1}{\beta_s}$ (il peso di voto):

$$\log w^{t+1}_i = \log D(i) - \sum_{s=1}^t (1 - |h_s(x_i) - y_i|) \alpha_s$$

**Interpretazione**: Il peso (in log-space) **diminuisce** proporzionalmente alla "correttezza" accumulata delle ipotesi sull'esempio $i$.

### Pesi come Funzione dell'Errore Cumulativo

Per ipotesi booleane, definiamo:

$$L_i(t) = \sum_{s=1}^t \mathbb{1}[h_s(x_i) \neq y_i]$$

il numero di volte che l'esempio $i$ è stato classificato erroneamente fino all'iterazione $t$.

Allora:

$$\sum_{s=1}^t (1 - |h_s(x_i) - y_i|) = t - L_i(t)$$

E quindi:

$$w^{t+1}_i = D(i) \prod_{s=1}^t \beta_s^{1 - \mathbb{1}[h_s(x_i) \neq y_i]} = D(i) \frac{\prod_{s=1}^t \beta_s}{\prod_{s: h_s(x_i) \neq y_i} \beta_s}$$

Possiamo riscrivere come:

$$w^{t+1}_i = D(i) \left(\prod_{s=1}^t \beta_s\right) \cdot \left(\prod_{s: h_s(x_i) = y_i} \frac{1}{\beta_s}\right)$$

**Osservazione chiave**: Gli esempi errati mantengono il fattore $\prod_{s=1}^t \beta_s$ mentre quelli corretti lo dividono per $\prod_{s: \text{corretto}} \frac{1}{\beta_s} > 1$.

## Somma Totale dei Pesi

### Evoluzione della Somma

Un calcolo importante per l'analisi teorica è la somma totale dei pesi:

$$W^t = \sum_{i=1}^N w^t_i$$

**Teorema**: La somma dei pesi soddisfa:

$$W^{t+1} = W^t \cdot \left(\beta_t p^t_{\text{correct}} + p^t_{\text{error}}\right)$$

dove:
- $p^t_{\text{correct}} = \sum_{i: h_t(x_i) = y_i} p^t_i = 1 - \epsilon_t$
- $p^t_{\text{error}} = \sum_{i: h_t(x_i) \neq y_i} p^t_i = \epsilon_t$

**Dimostrazione**:

$$W^{t+1} = \sum_{i=1}^N w^{t+1}_i = \sum_{i=1}^N w^t_i \beta_t^{1 - |h_t(x_i) - y_i|}$$

$$= \sum_{i: h_t(x_i) = y_i} w^t_i \beta_t + \sum_{i: h_t(x_i) \neq y_i} w^t_i$$

$$= W^t \left(\sum_{i: h_t(x_i) = y_i} p^t_i \beta_t + \sum_{i: h_t(x_i) \neq y_i} p^t_i\right)$$

$$= W^t \left(\beta_t (1 - \epsilon_t) + \epsilon_t\right)$$

### Formula Chiusa per W^T

Iterando la relazione precedente:

$$W^{T+1} = W^1 \prod_{t=1}^T \left(\beta_t (1 - \epsilon_t) + \epsilon_t\right)$$

Con $W^1 = \sum_{i=1}^N D(i) = 1$ e $\beta_t = \frac{\epsilon_t}{1-\epsilon_t}$:

$$W^{T+1} = \prod_{t=1}^T \left(\frac{\epsilon_t}{1-\epsilon_t}(1-\epsilon_t) + \epsilon_t\right) = \prod_{t=1}^T 2\epsilon_t(1-\epsilon_t)$$

Usando $\sqrt{ab} \leq \frac{a+b}{2}$:

$$W^{T+1} = 2^T \prod_{t=1}^T \epsilon_t(1-\epsilon_t) = 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}^2$$

Questa quantità è centrale nel bound dell'errore (vedi `theoretical-bounds.md`).

## Connessione con Hedge() e Multiplicative Weights

### Algoritmo Hedge()

AdaBoost deriva dall'algoritmo **Hedge()** per l'on-line allocation problem. In Hedge(), i pesi vengono aggiornati come:

$$w^{t+1}_i = w^t_i \cdot \beta^{\ell^t_i}$$

dove $\ell^t_i \in [0,1]$ è la "loss" della strategia $i$ al trial $t$.

### Riduzione da AdaBoost a Hedge()

La riduzione è "duale": 
- Le **strategie** di Hedge() corrispondono agli **esempi** di AdaBoost
- I **trial** di Hedge() corrispondono alle **ipotesi** di AdaBoost

Definiamo la "loss" in AdaBoost come:

$$\ell^t_i = 1 - |h_t(x_i) - y_i|$$

Questa è la **correttezza** dell'ipotesi $h_t$ sull'esempio $i$ (alta se corretta, bassa se errata).

Allora l'update di AdaBoost diventa:

$$w^{t+1}_i = w^t_i \cdot \beta_t^{\ell^t_i}$$

che è esattamente la forma di Hedge() con $\beta$ variabile ($\beta_t$ invece di $\beta$ fisso).

### Perché Multiplicative Update?

L'update moltiplicativo ha diverse proprietà desiderabili:

1. **Non-negatività**: Se $w^t_i \geq 0$ e $\beta_t > 0$, allora $w^{t+1}_i \geq 0$
2. **Scala-invarianza**: Moltiplicare tutti i pesi per una costante non cambia la distribuzione normalizzata
3. **Smoothness**: Cambiamenti graduali nei pesi (nessun reset brusco)
4. **Ottimalità teorica**: Garantisce i migliori bound possibili (Teorema 3 del paper)

## Esempi Illustrativi

### Esempio 1: Convergenza su Esempio Facile

Consideriamo un esempio $i$ classificato correttamente a ogni iterazione.

**Iterazione 1**:
- $h_1(x_i) = y_i$, quindi $w^2_i = w^1_i \cdot \beta_1$
- Se $\epsilon_1 = 0.1$, allora $\beta_1 = 1/9 \approx 0.111$
- $w^2_i \approx 0.111 \cdot w^1_i$

**Iterazione 2**:
- $h_2(x_i) = y_i$, quindi $w^3_i = w^2_i \cdot \beta_2$
- Se $\epsilon_2 = 0.2$, allora $\beta_2 = 1/4 = 0.25$
- $w^3_i = 0.25 \cdot 0.111 \cdot w^1_i \approx 0.028 \cdot w^1_i$

Dopo solo 2 iterazioni, il peso è diminuito a circa il 3% del valore iniziale!

### Esempio 2: Persistenza su Esempio Difficile

Consideriamo un esempio $j$ classificato erroneamente a ogni iterazione.

**Iterazione 1**:
- $h_1(x_j) \neq y_j$, quindi $w^2_j = w^1_j \cdot 1 = w^1_j$

**Iterazione 2**:
- $h_2(x_j) \neq y_j$, quindi $w^3_j = w^2_j \cdot 1 = w^1_j$

Il peso rimane costante (in valore assoluto)!

**Effetto relativo**: Mentre gli esempi facili vedono i loro pesi diminuire esponenzialmente, gli esempi difficili mantengono il peso. Dopo normalizzazione, la frazione di probabilità assegnata agli esempi difficili **aumenta drasticamente**.

### Esempio 3: Evoluzione con Errori Variabili

Dataset con $N=4$ esempi, $D$ uniforme ($w^1_i = 0.25$ per tutti).

| Iterazione | $i=1$ | $i=2$ | $i=3$ | $i=4$ | $\epsilon_t$ | $\beta_t$ |
|------------|-------|-------|-------|-------|--------------|-----------|
| $t=0$ (init) | C | C | C | C | - | - |
| $t=1$ | E | C | C | C | 0.25 | 1/3 |
| Dopo update | 0.25 | 0.083 | 0.083 | 0.083 | - | - |
| Norm | 0.5 | 0.167 | 0.167 | 0.167 | - | - |
| $t=2$ | E | E | C | C | 0.667 | 2 |
| Dopo update | 0.5 | 0.333 | 0.083 | 0.083 | - | - |
| Norm | 0.5 | 0.333 | 0.083 | 0.083 | - | - |

Dove C = corretto, E = errato.

**Osservazioni**:
- L'esempio 1, sempre errato, accumula probabilità crescente (0.25 → 0.5 → 0.5)
- Gli esempi 3 e 4, sempre corretti, perdono probabilità (0.25 → 0.167 → 0.083)
- L'esempio 2 ha comportamento misto

## Proprietà Importanti dell'Update

### Proprietà 1: Conservazione del Prodotto

Il prodotto dei pesi segue una legge semplice:

$$\prod_{i=1}^N w^{t+1}_i = \prod_{i=1}^N w^1_i \cdot \prod_{s=1}^t \beta_s^{N - \sum_i |h_s(x_i) - y_i|}$$

Questo è legato al prodotto geometrico delle distribuzioni.

### Proprietà 2: Relazione con l'Errore

Per ipotesi booleane, la somma dei pesi degli esempi errati dopo $t$ iterazioni è:

$$\sum_{i: h_t(x_i) \neq y_i} w^{t+1}_i = W^t \cdot \epsilon_t$$

Quindi la frazione (non normalizzata) di peso su esempi errati rimane $\epsilon_t$.

### Proprietà 3: Bound Inferiore sui Pesi Finali

Per ogni esempio $i$, il peso finale soddisfa:

$$w^{T+1}_i \geq D(i) \prod_{t=1}^T \beta_t$$

L'uguaglianza vale se e solo se $h_t(x_i) = y_i$ per ogni $t$ (esempio sempre corretto).

### Proprietà 4: Bound Superiore sui Pesi Finali

Per ogni esempio $i$:

$$w^{T+1}_i \leq D(i)$$

L'uguaglianza vale se e solo se $h_t(x_i) \neq y_i$ per ogni $t$ (esempio sempre errato).

## Focus Adattivo: Analisi Quantitativa

### Concentrazione della Probabilità

Definiamo:
- $S_t^{\text{easy}} = \{i : L_i(t) = 0\}$ (esempi sempre corretti fino a $t$)
- $S_t^{\text{hard}} = \{i : L_i(t) \geq t/2\}$ (esempi errati almeno metà delle volte)

La frazione di probabilità sugli esempi difficili cresce esponenzialmente:

$$\frac{\sum_{i \in S_t^{\text{hard}}} p^{t+1}_i}{\sum_{i \in S_t^{\text{easy}}} p^{t+1}_i} \geq \frac{1}{\prod_{s=1}^{t/2} \beta_s}$$

Se tutti i $\beta_s \approx \beta < 1$, allora:

$$\frac{p^{t+1}(\text{hard})}{p^{t+1}(\text{easy})} \geq \beta^{-t/2}$$

che cresce esponenzialmente con $t$!

### Esempio Numerico

Supponiamo $\beta_t = 0.2$ (errore $\epsilon_t = 1/6$) costante, e:
- 50% esempi sempre corretti
- 50% esempi errati metà delle volte

**Distribuzione iniziale**: 50-50

**Dopo 5 iterazioni**:
$$\frac{p^6(\text{hard})}{p^6(\text{easy})} \geq 0.2^{-2.5} \approx 44.7$$

Normalizzando:
- $p^6(\text{hard}) \approx 97.8\%$
- $p^6(\text{easy}) \approx 2.2\%$

Gli esempi difficili dominano completamente la distribuzione!

## Varianti dell'Update

### Variante con Confidence

In alcune estensioni, le ipotesi restituiscono anche una "confidence" $c_t(x_i) \in [0,1]$. L'update diventa:

$$w^{t+1}_i = w^t_i \cdot \beta_t^{c_t(x_i)(1 - |h_t(x_i) - y_i|)}$$

**Interpretazione**: Se l'ipotesi è poco confidente ($c_t(x_i) \approx 0$), l'aggiornamento è minimo anche se corretta.

### Variante con Cost-Sensitive Learning

Se gli esempi hanno costi diversi $C_i > 0$:

$$w^1_i = D(i) \cdot C_i$$

L'update rimane lo stesso, ma esempi con costo alto influenzano di più il weak learner.

### Variante con Ada-Weight Clipping

Per evitare pesi troppo piccoli/grandi:

$$w^{t+1}_i = \text{clip}\left(w^t_i \cdot \beta_t^{1 - |h_t(x_i) - y_i|}, w_{\min}, w_{\max}\right)$$

Questo migliora la stabilità numerica ma perde le garanzie teoriche.

## Interpretazione Geometrica

### Spazio dei Pesi

Possiamo visualizzare i pesi come un punto nello spazio $\mathbb{R}^N_+$ (ortante positivo).

**Inizializzazione**: Punto $w^1 = (D(1), \ldots, D(N))$

**Update**: Ogni iterazione applica una trasformazione diagonale:

$$w^{t+1} = \text{diag}(\beta_t^{1-|h_t(x_1)-y_1|}, \ldots, \beta_t^{1-|h_t(x_N)-y_N|}) \cdot w^t$$

Questa è una **scala non-uniforme** lungo le direzioni coordinate.

### Superfici di Livello

Le superfici $\{w : \sum_i w_i = c\}$ sono iperpiani. La normalizzazione proietta su $\sum_i p_i = 1$.

Gli update di AdaBoost si muovono lungo raggi dall'origine, poi normalizzano sul simplesso.

## Connessione con Gradient Descent

### Exponential Loss

AdaBoost può essere interpretato come gradient descent sulla **exponential loss**:

$$L(y, f(x)) = \exp(-y f(x))$$

dove $y \in \{-1, +1\}$ e $f(x) = \sum_t \alpha_t h_t(x)$.

**Relazione con i pesi**:

$$w^{t+1}_i \propto \exp(-y_i f_t(x_i))$$

dove $f_t = \sum_{s=1}^t \alpha_s h_s$ è il classificatore cumulativo.

### Gradient

Il gradiente della exponential loss rispetto a $f$ è:

$$\frac{\partial L(y, f)}{\partial f} = -y \exp(-y f)$$

In $f_t(x_i)$:

$$\frac{\partial}{\partial f_t} \exp(-y_i f_t(x_i)) = -y_i \exp(-y_i f_t(x_i)) \propto -y_i w^{t+1}_i$$

Quindi i pesi sono proporzionali al gradiente (negativo)!

### Gradient Descent Step

Un passo di gradient descent sarebbe:

$$f_{t+1}(x) = f_t(x) + \eta \sum_i y_i w^{t+1}_i \delta_{x_i}(x)$$

AdaBoost invece sceglie:

$$f_{t+1}(x) = f_t(x) + \alpha_{t+1} h_{t+1}(x)$$

dove $h_{t+1}$ è scelto per minimizzare approssimativamente la loss pesata dai gradienti $w^{t+1}_i$.

## Stabilità e Convergenza dei Pesi

### Convergenza Asintotica

Se esiste un insieme $S \subset \{1, \ldots, N\}$ di esempi "irriducibilmente difficili" tali che nessun weak learner può classificarli correttamente:

$$\lim_{t \to \infty} p^t_i = \begin{cases}
> 0 & \text{se } i \in S \\
0 & \text{se } i \notin S
\end{cases}$$

La distribuzione converge a concentrarsi completamente sugli esempi difficili.

### Oscillazioni

Se il weak learner è instabile (produce ipotesi molto diverse a ogni iterazione), i pesi possono oscillare.

**Esempio**: Consideriamo due ipotesi che alternano tra loro:
- $h_{\text{odd}}$: classifica correttamente $S_1$, sbaglia $S_2$
- $h_{\text{even}}$: classifica correttamente $S_2$, sbaglia $S_1$

Allora:
- Iterazioni dispari: $p^t$ concentrata su $S_2$, weak learner produce $h_{\text{odd}}$
- Iterazioni pari: $p^t$ concentrata su $S_1$, weak learner produce $h_{\text{even}}$

I pesi oscillano ma l'ipotesi finale combina correttamente entrambe.

## Conclusioni

L'aggiornamento dei pesi in AdaBoost:

1. **Implementa un focus adattivo** sugli esempi difficili tramite update moltiplicativo
2. **Deriva da principi teorici** (Hedge(), multiplicative weights)
3. **Garantisce convergenza esponenziale** dell'errore di training
4. **È stabile numericamente** con opportuni accorgimenti
5. **Ha interpretazioni multiple** (Bayesiano, gradient descent, game theory)

Il parametro $\beta_t = \epsilon_t/(1-\epsilon_t)$ codifica automaticamente l'accuratezza di ogni ipotesi, permettendo ad AdaBoost di adattarsi senza conoscenza a priori.

Nei prossimi file esploreremo come questi aggiornamenti garantiscono bound teorici sull'errore finale.