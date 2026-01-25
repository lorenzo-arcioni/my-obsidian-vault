# AdaBoost: Theoretical Bounds

## Introduzione

La garanzia teorica fondamentale di AdaBoost è che l'errore di training dell'ipotesi finale **decade esponenzialmente** con il numero di iterazioni, a patto che ogni weak learner produca ipotesi con errore $\epsilon_t < 1/2$.

Questo risultato, formalizzato nel **Teorema 6** del paper di Freund e Schapire, è il cuore dell'analisi teorica di AdaBoost e spiega perché l'algoritmo funziona così bene in pratica.

## Teorema Principale (Teorema 6)

### Enunciato

**Teorema 6**: Supponiamo che il weak learning algorithm `WeakLearn`, quando chiamato da AdaBoost, generi ipotesi con errori $\epsilon_1, \ldots, \epsilon_T$ (come definiti nello Step 3 dell'algoritmo). Allora l'errore $\varepsilon$ dell'ipotesi finale $h_f$ output da AdaBoost è limitato superiormente da:

$$\varepsilon \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$$

dove $\varepsilon = \Pr_{i \sim D}[h_f(x_i) \neq y_i]$ è l'errore di training rispetto alla distribuzione iniziale $D$.

### Significato

Questo bound mostra che:

1. **L'errore decade esponenzialmente** se ogni $\epsilon_t$ è significativamente minore di $1/2$
2. **Il bound dipende da TUTTE le ipotesi**, non solo dalla peggiore (a differenza di algoritmi precedenti)
3. **Non richiede conoscenza a priori** delle accuratezze $\epsilon_t$

## Dimostrazione del Teorema 6

### Struttura della Dimostrazione

La dimostrazione si basa su due idee chiave:
1. Collegare i pesi finali agli errori di classificazione
2. Derivare un bound superiore sulla somma dei pesi finali

### Step 1: Relazione tra Pesi Finali ed Errori

**Lemma**: Se $h_f(x_i) \neq y_i$ (errore di classificazione), allora:

$$\prod_{t=1}^T \beta_t^{|h_t(x_i) - y_i|} \geq \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

**Dimostrazione del Lemma**:

Per definizione di $h_f$:

$$h_f(x_i) = 1 \iff \sum_{t=1}^T \alpha_t h_t(x_i) \geq \frac{1}{2}\sum_{t=1}^T \alpha_t$$

dove $\alpha_t = \log(1/\beta_t)$.

Se $h_f(x_i) \neq y_i$, ci sono due casi:

**Caso 1**: $y_i = 1$ ma $h_f(x_i) = 0$

Allora:
$$\sum_{t=1}^T \alpha_t h_t(x_i) < \frac{1}{2}\sum_{t=1}^T \alpha_t$$

Equivalentemente:
$$\sum_{t=1}^T \alpha_t (1 - h_t(x_i)) > \frac{1}{2}\sum_{t=1}^T \alpha_t$$

Quindi:
$$\sum_{t=1}^T \alpha_t |h_t(x_i) - 1| > \frac{1}{2}\sum_{t=1}^T \alpha_t$$

**Caso 2**: $y_i = 0$ ma $h_f(x_i) = 1$

Analogamente:
$$\sum_{t=1}^T \alpha_t h_t(x_i) \geq \frac{1}{2}\sum_{t=1}^T \alpha_t$$

Quindi:
$$\sum_{t=1}^T \alpha_t |h_t(x_i) - 0| \geq \frac{1}{2}\sum_{t=1}^T \alpha_t$$

In entrambi i casi:
$$\sum_{t=1}^T \alpha_t |h_t(x_i) - y_i| \geq \frac{1}{2}\sum_{t=1}^T \alpha_t$$

Prendendo l'esponenziale:
$$\exp\left(\sum_{t=1}^T \alpha_t |h_t(x_i) - y_i|\right) \geq \exp\left(\frac{1}{2}\sum_{t=1}^T \alpha_t\right)$$

Usando $\alpha_t = \log(1/\beta_t)$:
$$\prod_{t=1}^T \left(\frac{1}{\beta_t}\right)^{|h_t(x_i) - y_i|} \geq \prod_{t=1}^T \left(\frac{1}{\beta_t}\right)^{1/2}$$

Invertendo:
$$\prod_{t=1}^T \beta_t^{|h_t(x_i) - y_i|} \leq \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

Ricordando che $|h_t(x_i) - y_i|$ compare con esponente $1 - |h_t(x_i) - y_i|$ nei pesi, riscriviamo:

$$\prod_{t=1}^T \beta_t^{1 - |h_t(x_i) - y_i|} = \frac{\prod_{t=1}^T \beta_t}{\prod_{t=1}^T \beta_t^{|h_t(x_i) - y_i|}} \geq \frac{\prod_{t=1}^T \beta_t}{\left(\prod_{t=1}^T \beta_t\right)^{1/2}} = \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

### Step 2: Lower Bound sui Pesi degli Esempi Errati

Dal Lemma e dalla formula ricorsiva dei pesi:

$$w^{T+1}_i = D(i) \prod_{t=1}^T \beta_t^{1 - |h_t(x_i) - y_i|}$$

Se $h_f(x_i) \neq y_i$:

$$w^{T+1}_i \geq D(i) \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

Sommando su tutti gli esempi errati:

$$\sum_{i: h_f(x_i) \neq y_i} w^{T+1}_i \geq \sum_{i: h_f(x_i) \neq y_i} D(i) \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

$$= \left(\prod_{t=1}^T \beta_t\right)^{1/2} \sum_{i: h_f(x_i) \neq y_i} D(i)$$

$$= \varepsilon \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

dove $\varepsilon = \Pr_{i \sim D}[h_f(x_i) \neq y_i]$ è l'errore di training.

Quindi:

$$\sum_{i=1}^N w^{T+1}_i \geq \sum_{i: h_f(x_i) \neq y_i} w^{T+1}_i \geq \varepsilon \left(\prod_{t=1}^T \beta_t\right)^{1/2}$$

### Step 3: Upper Bound sulla Somma dei Pesi

Da `weight-updates.md`, sappiamo che:

$$W^{T+1} = \sum_{i=1}^N w^{T+1}_i = \prod_{t=1}^T \left(\beta_t(1-\epsilon_t) + \epsilon_t\right)$$

Con $\beta_t = \epsilon_t/(1-\epsilon_t)$:

$$\beta_t(1-\epsilon_t) + \epsilon_t = \epsilon_t + \epsilon_t = 2\epsilon_t$$

Aspetta, ricontrolliamo:

$$\beta_t(1-\epsilon_t) + \epsilon_t = \frac{\epsilon_t}{1-\epsilon_t}(1-\epsilon_t) + \epsilon_t = \epsilon_t + \epsilon_t = 2\epsilon_t$$

No, questo non è corretto. Rifacciamo:

$$W^{t+1} = W^t \left(\beta_t \sum_{i: h_t(x_i)=y_i} p^t_i + \sum_{i: h_t(x_i) \neq y_i} p^t_i\right)$$

$$= W^t(\beta_t(1-\epsilon_t) + \epsilon_t)$$

Con $\beta_t = \epsilon_t/(1-\epsilon_t)$:

$$\beta_t(1-\epsilon_t) + \epsilon_t = \frac{\epsilon_t}{1-\epsilon_t} \cdot (1-\epsilon_t) + \epsilon_t = \epsilon_t + \epsilon_t = 2\epsilon_t$$

Hmm, questo mi dà $W^{T+1} = \prod_{t=1}^T 2\epsilon_t$, ma non è quello che vogliamo.

Ricontrolliamo il calcolo. Dalla definizione:

$$W^{t+1} = \sum_i w^t_i \beta_t^{1-|h_t(x_i)-y_i|}$$

$$= \sum_{i:h_t(x_i)=y_i} w^t_i \beta_t + \sum_{i:h_t(x_i)\neq y_i} w^t_i$$

$$= W^t\left(\beta_t(1-\epsilon_t) + \epsilon_t\right)$$

Usando $\beta_t = \epsilon_t/(1-\epsilon_t)$:

$$\beta_t(1-\epsilon_t) + \epsilon_t = \epsilon_t + \epsilon_t = 2\epsilon_t$$

Questo sembra sbagliato. Controlliamo con un'altra parametrizzazione. Nel paper, la convessità è usata diversamente.

Ripartiamo dalla disuguaglianza fondamentale (Equazione 3 del paper):

$$\beta^r \leq 1 - (1-\beta)r$$

per $\beta \in [0,1]$ e $r \in [0,1]$.

Usando questa con $r = |h_t(x_i) - y_i|$ e rinominando $\beta_t$ come parametro:

$$\beta_t^{|h_t(x_i)-y_i|} \leq 1 - (1-\beta_t)|h_t(x_i)-y_i|$$

Quindi:

$$\beta_t^{1-|h_t(x_i)-y_i|} \geq ...$$ 

No, questo si applica all'esponente sbagliato. Nel paper, usano l'inverso. Dalla Section 2.1, l'update è:

$$w^{t+1}_i = w^t_i \beta^{\ell^t_i}$$

dove nel nostro caso $\ell^t_i = |h_t(x_i) - y_i|$ (la LOSS, non la correttezza).

Quindi dovrebbe essere:

$$w^{t+1}_i = w^t_i \beta_t^{|h_t(x_i) - y_i|}$$

Ma nel paper di AdaBoost (Figure 2), l'update è:

$$w^{t+1}_i = w^t_i \beta_t^{1 - |h_t(x_i) - y_i|}$$

Ah! C'è un'inversione perché in AdaBoost vogliamo DIMINUIRE il peso degli esempi corretti, non aumentarlo.

Ricominciamo con la notazione corretta. Definiamo:

$$\ell^t_i = |h_t(x_i) - y_i|$$ 

come la loss (alta se errato).

Allora l'update di AdaBoost è:

$$w^{t+1}_i = w^t_i \beta_t^{-\ell^t_i}$$

No, questo darebbe pesi che esplodono. Torniamo al paper.

Ok, seguiamo esattamente il paper. L'update è:

$$w^{t+1}_i = w^t_i \beta_t^{1-|h_t(x_i)-y_i|}$$

E dalla convessità (inequazione 3 del paper):

$$\beta^r \leq 1 - (1-\beta)r$$

Applichiamo con $r = 1 - |h_t(x_i) - y_i| \in [0,1]$:

$$\beta_t^{1-|h_t(x_i)-y_i|} \leq 1 - (1-\beta_t)(1-|h_t(x_i)-y_i|)$$

Quindi:

$$w^{t+1}_i \leq w^t_i [1 - (1-\beta_t)(1-|h_t(x_i)-y_i|)]$$

Sommando su $i$:

$$W^{t+1} \leq W^t \left[1 - (1-\beta_t) \sum_i p^t_i(1-|h_t(x_i)-y_i|)\right]$$

Ora, $\sum_i p^t_i(1-|h_t(x_i)-y_i|) = 1 - \epsilon_t$ (frazione di correttezza).

Quindi:

$$W^{t+1} \leq W^t[1 - (1-\beta_t)(1-\epsilon_t)]$$

Iterando:

$$W^{T+1} \leq \prod_{t=1}^T [1-(1-\beta_t)(1-\epsilon_t)]$$

Con $\beta_t = \epsilon_t/(1-\epsilon_t)$:

$$1-\beta_t = 1 - \frac{\epsilon_t}{1-\epsilon_t} = \frac{1-2\epsilon_t}{1-\epsilon_t}$$

$$(1-\beta_t)(1-\epsilon_t) = 1-2\epsilon_t$$

$$1-(1-\beta_t)(1-\epsilon_t) = 2\epsilon_t$$

Quindi:

$$W^{T+1} \leq \prod_{t=1}^T 2\epsilon_t = 2^T \prod_{t=1}^T \epsilon_t$$

Ma questo non corrisponde al bound nel teorema. Ricontrolliamo il paper.

Ah! Nel paper (proof of Theorem 6), minimizzano rispetto a $\beta_t$ per ottenere il bound migliore. Non usano necessariamente $\beta_t = \epsilon_t/(1-\epsilon_t)$.

Minimizziamo $1-(1-\beta)(1-\epsilon)$ rispetto a $\beta$:

$$f(\beta) = 1-(1-\beta)(1-\epsilon) = 1 - (1-\epsilon-\beta+\beta\epsilon) = \beta(1-\epsilon) + \epsilon$$

Derivando:

$$f'(\beta) = 1-\epsilon$$

Questo è sempre positivo per $\epsilon < 1$, quindi $f$ è crescente in $\beta$. Ma vogliamo minimizzare, e $\beta$ deve essere scelto in base all'ipotesi corrente.

Rileggiamo il paper più attentamente. Nella proof of Theorem 6:

> "Setting the derivative of the t-th factor to zero, we find that the choice of $\beta_t$ which minimizes the right hand side is $\beta_t = \epsilon_t/(1-\epsilon_t)$."

Quindi minimizzano:

$$g(\beta_t) = \frac{1-(1-\beta_t)(1-\epsilon_t)}{\sqrt{\beta_t}}$$

Dato il lower bound $W^{T+1} \geq \varepsilon \prod_t \sqrt{\beta_t}$ e upper bound $W^{T+1} \leq \prod_t [1-(1-\beta_t)(1-\epsilon_t)]$.

Combinando:

$$\varepsilon \prod_t \sqrt{\beta_t} \leq \prod_t [1-(1-\beta_t)(1-\epsilon_t)]$$

$$\varepsilon \leq \prod_t \frac{1-(1-\beta_t)(1-\epsilon_t)}{\sqrt{\beta_t}}$$

Minimizziamo ogni fattore separatamente:

$$\min_{\beta_t} \frac{1-(1-\beta_t)(1-\epsilon_t)}{\sqrt{\beta_t}}$$

Derivando:

$$\frac{d}{d\beta_t}\left[\frac{\beta_t(1-\epsilon_t)+\epsilon_t}{\sqrt{\beta_t}}\right] = \frac{d}{d\beta_t}\left[(1-\epsilon_t)\sqrt{\beta_t} + \frac{\epsilon_t}{\sqrt{\beta_t}}\right]$$

$$= (1-\epsilon_t)\frac{1}{2\sqrt{\beta_t}} - \frac{\epsilon_t}{2\beta_t^{3/2}}$$

$$= \frac{1}{2\sqrt{\beta_t}}\left[(1-\epsilon_t) - \frac{\epsilon_t}{\beta_t}\right]$$

Impostando a zero:

$$(1-\epsilon_t)\beta_t = \epsilon_t$$

$$\beta_t = \frac{\epsilon_t}{1-\epsilon_t}$$

Che è esattamente la scelta di AdaBoost!

Sostituendo:

$$\frac{1-(1-\beta_t)(1-\epsilon_t)}{\sqrt{\beta_t}} = \frac{\beta_t(1-\epsilon_t)+\epsilon_t}{\sqrt{\beta_t}}$$

Con $\beta_t = \epsilon_t/(1-\epsilon_t)$:

$$= \frac{\frac{\epsilon_t}{1-\epsilon_t}(1-\epsilon_t)+\epsilon_t}{\sqrt{\epsilon_t/(1-\epsilon_t)}}$$

$$= \frac{\epsilon_t + \epsilon_t}{\sqrt{\epsilon_t/(1-\epsilon_t)}}$$

$$= \frac{2\epsilon_t}{\sqrt{\epsilon_t/(1-\epsilon_t)}}$$

$$= 2\epsilon_t \sqrt{\frac{1-\epsilon_t}{\epsilon_t}}$$

$$= 2\sqrt{\epsilon_t(1-\epsilon_t)}$$

Perfetto! Quindi:

$$\varepsilon \leq \prod_{t=1}^T 2\sqrt{\epsilon_t(1-\epsilon_t)} = 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$$

Questo completa la dimostrazione del Teorema 6. ∎

## Forme Equivalenti del Bound

### Forma con Margine

Definiamo il **margine** (edge) di un'ipotesi rispetto a random guessing:

$$\gamma_t = \frac{1}{2} - \epsilon_t$$

Questo misura di quanto $h_t$ è migliore del caso. Allora:

$$\epsilon_t = \frac{1}{2} - \gamma_t$$

$$1 - \epsilon_t = \frac{1}{2} + \gamma_t$$

$$\epsilon_t(1-\epsilon_t) = \left(\frac{1}{2}-\gamma_t\right)\left(\frac{1}{2}+\gamma_t\right) = \frac{1}{4} - \gamma_t^2$$

Quindi:

$$\sqrt{\epsilon_t(1-\epsilon_t)} = \sqrt{\frac{1}{4}-\gamma_t^2}$$

E il bound diventa:

$$\varepsilon \leq 2^T \prod_{t=1}^T \sqrt{\frac{1}{4}-\gamma_t^2}$$

$$= \prod_{t=1}^T 2\sqrt{\frac{1}{4}-\gamma_t^2}$$

$$= \prod_{t=1}^T \sqrt{1-4\gamma_t^2}$$

### Forma con Kullback-Leibler Divergence

Usando l'approssimazione $\sqrt{1-x} \approx e^{-x/2}$ per $x$ piccolo:

$$\sqrt{1-4\gamma_t^2} \approx e^{-2\gamma_t^2}$$

Quindi:

$$\varepsilon \lessapprox \prod_{t=1}^T e^{-2\gamma_t^2} = \exp\left(-2\sum_{t=1}^T \gamma_t^2\right)$$

Più precisamente, usando $\sqrt{ab} = e^{\frac{1}{2}\log(ab)}$:

$$\sqrt{\epsilon_t(1-\epsilon_t)} = \exp\left(\frac{1}{2}[\log\epsilon_t + \log(1-\epsilon_t)]\right)$$

E il prodotto diventa:

$$\prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)} = \exp\left(\frac{1}{2}\sum_{t=1}^T [\log\epsilon_t + \log(1-\epsilon_t)]\right)$$

$$= \exp\left(-\sum_{t=1}^T \text{KL}\left(\frac{1}{2} \mid\mid \epsilon_t\right)\right)$$

dove $\text{KL}(p \mid\mid q) = p\log(p/q) + (1-p)\log((1-p)/(1-q))$ è la divergenza di Kullback-Leibler.

Quindi:

$$\varepsilon \leq 2^T \exp\left(-\sum_{t=1}^T \text{KL}\left(\frac{1}{2} \mid\mid \epsilon_t\right)\right)$$

### Forma Esponenziale Semplificata

Se tutti gli errori sono uguali, $\epsilon_t = \epsilon$ per ogni $t$:

$$\varepsilon \leq [2\sqrt{\epsilon(1-\epsilon)}]^T = \left[\sqrt{1-4\gamma^2}\right]^T$$

Usando $\sqrt{1-4\gamma^2} \leq e^{-2\gamma^2}$:

$$\varepsilon \leq e^{-2T\gamma^2}$$

Questo mostra chiaramente il **decadimento esponenziale**: se $\gamma > 0$, allora $\varepsilon \to 0$ esponenzialmente veloce in $T$.

## Numero di Iterazioni Necessario

### Per Errore Target

Data una soglia di errore target $\varepsilon_{\text{target}}$, quante iterazioni servono?

Dal bound $\varepsilon \leq e^{-2T\gamma^2}$ (caso errori uniformi):

$$e^{-2T\gamma^2} \leq \varepsilon_{\text{target}}$$

$$-2T\gamma^2 \leq \log \varepsilon_{\text{target}}$$

$$T \geq \frac{-\log \varepsilon_{\text{target}}}{2\gamma^2} = \frac{\log(1/\varepsilon_{\text{target}})}{2\gamma^2}$$

**Esempio**: Per ottenere $\varepsilon = 0.01$ con $\gamma = 0.1$:

$$T \geq \frac{\log(100)}{2(0.1)^2} = \frac{4.605}{0.02} \approx 230$$

Servono almeno 230 iterazioni.

### Dipendenza da γ

Il numero di iterazioni necessario scala come:

$$T = O\left(\frac{1}{\gamma^2}\log\frac{1}{\varepsilon}\right)$$

- Se $\gamma$ è piccolo (weak learner debole), servono molte iterazioni
- Se $\gamma$ è grande (weak learner forte), servono poche iterazioni
- La dipendenza logaritmica da $\varepsilon$ significa che ridurre l'errore di un fattore costante richiede solo un numero costante di iterazioni aggiuntive

## Confronto con Algoritmi Precedenti

### Boost-by-Majority

L'algoritmo **boost-by-majority** di Freund (1995) richiedeva:

$$T = O\left(\frac{1}{\gamma_{\min}^2}\log\frac{1}{\varepsilon}\right)$$

dove $\gamma_{\min} = \min_t \gamma_t$ è il margine minimo.

**Differenza chiave**: Il bound di boost-by-majority dipende solo dal weak learner PEGGIORE, mentre AdaBoost sfrutta tutti i weak learner:

$$\varepsilon_{\text{AdaBoost}} \leq \prod_{t=1}^T \sqrt{1-4\gamma_t^2} \leq \left[\sqrt{1-4\gamma_{\min}^2}\right]^T = \varepsilon_{\text{boost-by-majority}}$$

L'uguaglianza vale solo se tutti i $\gamma_t$ sono uguali al minimo.

### Esempio Numerico

Supponiamo $T=10$ iterazioni con:
- 5 iterazioni con $\gamma = 0.4$ (strong)
- 5 iterazioni con $\gamma = 0.1$ (weak)

**Boost-by-majority**:
$$\varepsilon \leq \left[\sqrt{1-4(0.1)^2}\right]^{10} = (0.98)^{10} \approx 0.817$$

**AdaBoost**:
$$\varepsilon \leq \left[\sqrt{1-4(0.4)^2}\right]^5 \cdot \left[\sqrt{1-4(0.1)^2}\right]^5$$
$$= (0.72)^5 \cdot (0.98)^5 \approx 0.193 \cdot 0.904 \approx 0.175$$

AdaBoost è molto migliore perché sfrutta le ipotesi forti!

## Ottimalità del Bound

### Teorema 3 del Paper

Il Teorema 3 stabilisce che il bound di AdaBoost è **ottimale** nella forma:

**Teorema 3**: Sia $B$ un algoritmo per il problema di on-line allocation con $N$ strategie. Supponiamo che esistano costanti positive $a$ e $c$ tali che per ogni numero di strategie $N$ e ogni sequenza di loss vectors:

$$L_B \leq c \min_i L_i + a \ln N$$

Allora per ogni $\beta \in (0,1)$, almeno una delle seguenti deve essere vera:

$$c \geq \frac{\ln(1/\beta)}{1-\beta} \quad \text{oppure} \quad a \geq \frac{1}{1-\beta}$$

Per la scelta ottimale $\beta_t = \epsilon_t/(1-\epsilon_t)$ di AdaBoost, entrambe le disuguaglianze diventano uguaglianze, quindi **AdaBoost raggiunge il bound ottimale**.

### Interpretazione

Questo significa che nessun algoritmo può ottenere bound asintoticamente migliori nella forma $c \cdot \text{best} + a \cdot \log N$ senza peggiorare almeno una delle due costanti $c$ o $a$.

## Bound Migliorato con Soglia Soft (Teorema 9)

### Enunciato

Se invece di usare una soglia hard a $1/2$, usiamo una funzione di soglia soft $F$ che soddisfa:

$$F(1-r) = 1-F(r)$$
$$F(r) \leq \frac{1}{2}\left(\prod_{t=1}^T \beta_t\right)^{1/2-r}$$

Allora l'errore dell'ipotesi finale è:

$$\varepsilon \leq 2^{T-1}\prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$$

**Miglioramento**: Fattore $2^{T-1}$ invece di $2^T$, ovvero **un miglioramento di un fattore 2**.

### Esempio di Funzione F

Una funzione che soddisfa i requisiti è la sigmoide:

$$F(r) = \frac{1}{1 + \prod_{t=1}^T \beta_t^{2r-1}}$$

Con questa scelta, l'ipotesi finale diventa probabilistica invece che deterministica.

## Training Error vs Generalization Error

### Bound sul Training Error

Tutto quanto visto finora riguarda il **training error** (errore sul training set):

$$\varepsilon_{\text{train}} = \frac{1}{N}\sum_{i=1}^N \mathbb{1}[h_f(x_i) \neq y_i]$$

Il Teorema 6 garantisce che questo decade esponenzialmente.

### Generalization Error

L'**errore di generalizzazione** è:

$$\varepsilon_{\text{gen}} = \Pr_{(x,y) \sim \mathcal{D}}[h_f(x) \neq y]$$

dove $\mathcal{D}$ è la distribuzione vera (sconosciuta) da cui vengono estratti i dati.

### Gap Training-Generalization

Dalla teoria dell'apprendimento PAC, usando VC-dimension:

**Teorema 8 del paper**: Se la classe di ipotesi deboli $\mathcal{H}$ ha VC-dimension $d$, allora la classe di ipotesi finali generate da AdaBoost dopo $T$ iterazioni ha VC-dimension al più:

$$d_{\text{AdaBoost}} \leq 2(d+1)(T+1)\log_2[e(T+1)]$$

Quindi, per il Teorema 7 di Vapnik, con probabilità almeno $1-\delta$:

$\varepsilon_{\text{gen}} \leq \varepsilon_{\text{train}} + \sqrt{\frac{d_{\text{AdaBoost}}}{N}\left(\log\frac{2N}{d_{\text{AdaBoost}}}+1\right) + \frac{1}{N}\log\frac{1}{\delta}}$

**Implicazione**: Il gap training-generalization cresce con $T$ (più iterazioni = modello più complesso = maggior rischio di overfitting).

Tuttavia, **empiricamente** AdaBoost mostra un comportamento sorprendente: spesso continua a migliorare la generalizzazione anche dopo centinaia di iterazioni, ben oltre il punto in cui il training error è zero!

### Spiegazione: Margin Theory

La teoria dei **margini** spiega parzialmente questo fenomeno. Il margine di un esempio $(x_i, y_i)$ è:

$\rho_i = y_i \cdot \frac{\sum_{t=1}^T \alpha_t (2h_t(x_i)-1)}{\sum_{t=1}^T \alpha_t}$

(convertendo labels in $\{-1,+1\}$).

**Interpretazione**: $\rho_i > 0$ significa predizione corretta, e valori grandi indicano maggior confidenza.

**Teorema (Schapire et al., 1998)**: Con probabilità $1-\delta$, l'errore di generalizzazione è limitato da:

$\varepsilon_{\text{gen}} \leq \Pr_i[\rho_i \leq \theta] + O\left(\frac{1}{\sqrt{N}}\sqrt{\frac{d}{\theta^2}\log^2\frac{1}{\theta} + \log\frac{1}{\delta}}\right)$

per qualsiasi margine $\theta > 0$.

**Conseguenza**: Anche dopo che il training error è zero, AdaBoost continua ad **aumentare i margini**, migliorando la generalizzazione.

## Convergenza del Training Error a Zero

### Condizione Sufficiente

**Proposizione**: Se esiste $\gamma > 0$ tale che $\gamma_t \geq \gamma$ per ogni $t$, allora:

$\lim_{T \to \infty} \varepsilon = 0$

**Dimostrazione**:

$\varepsilon \leq \left[\sqrt{1-4\gamma^2}\right]^T$

Poiché $\gamma > 0$, abbiamo $\sqrt{1-4\gamma^2} < 1$. Quindi:

$\lim_{T \to \infty} \left[\sqrt{1-4\gamma^2}\right]^T = 0$

∎

### Tasso di Convergenza

La convergenza è esponenzialmente veloce con tasso $\sqrt{1-4\gamma^2}$:

$\varepsilon = O(e^{-2\gamma^2 T})$

**Tempo per raggiungere errore ε**:

$T = O\left(\frac{1}{\gamma^2}\log\frac{1}{\varepsilon}\right)$

## Caso di Weak Learner Perfetto

### Se ε_t = 0

Se a un'iterazione $t$ si ottiene $\epsilon_t = 0$ (weak learner perfetto):

$\beta_t = \frac{0}{1} = 0$

Quindi:

$w^{t+1}_i = w^t_i \cdot 0^{1-|h_t(x_i)-y_i|} = \begin{cases}
0 & \text{se } h_t(x_i) = y_i \\
w^t_i & \text{se } h_t(x_i) \neq y_i
\end{cases}$

Tutti gli esempi classificati correttamente da $h_t$ ricevono peso zero!

**Conseguenza**: Se $h_t$ è perfetto su tutti gli esempi, allora tutti i pesi diventano zero e l'algoritmo termina.

**Bound sull'errore**:

$\varepsilon \leq 2^T \prod_{s=1}^{t-1}\sqrt{\epsilon_s(1-\epsilon_s)} \cdot 0 \cdot \prod_{s=t+1}^T \sqrt{\epsilon_s(1-\epsilon_s)} = 0$

L'ipotesi finale ha errore zero anche con una sola ipotesi perfetta.

## Deterioramento con ε_t → 1/2

### Comportamento Limite

Se $\epsilon_t \to 1/2$ (weak learner inutile):

$\gamma_t \to 0$

$\sqrt{1-4\gamma_t^2} \to 1$

Il bound diventa:

$\varepsilon \lesssim \prod_{t=1}^T 1 = 1$

Completamente non informativo!

**Significato**: Se il weak learner non fa meglio di random guessing, AdaBoost non può fornire garanzie.

### Numero di Iterazioni con γ Piccolo

Se $\gamma$ è molto piccolo, il numero di iterazioni necessario cresce drammaticamente:

$T = O\left(\frac{1}{\gamma^2}\log\frac{1}{\varepsilon}\right)$

**Esempio**: Con $\gamma = 0.01$ (errore 49% invece di 50%):

$T \geq \frac{\log(100)}{2(0.01)^2} = \frac{4.605}{0.0002} = 23025$

Servono oltre 23000 iterazioni! Praticamente infeasibile.

## Analisi Caso Non-Uniforme

### Dipendenza dalla Distribuzione Iniziale D

Il bound completo del Teorema 6 include la distribuzione iniziale $D$:

$\sum_{i: h_f(x_i) \neq y_i} D(i) \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$

**Interpretazione**: Esempi con $D(i)$ piccolo hanno garanzie più deboli.

### Bound per Sottoinsieme di Esempi

Dal Teorema 2 del paper (forma generale per Hedge), per qualsiasi sottoinsieme $S \subseteq \{1,\ldots,N\}$:

$\sum_{i \in S} D(i) \cdot \varepsilon_i \leq \frac{\ln(1/\prod_{t=1}^T \beta_t) - \ln(\sum_{i \in S} D(i))}{1-\prod_t \beta_t}$

dove $\varepsilon_i = \mathbb{1}[h_f(x_i) \neq y_i]$.

Questo permette di ottenere bound specifici per sottoinsiemi di interesse.

## Relazione con Loss Functions

### Exponential Loss

AdaBoost minimizza (approssimativamente) la **exponential loss**:

$L_{\exp}(y, f(x)) = e^{-yf(x)}$

dove $y \in \{-1,+1\}$ e $f(x) = \sum_t \alpha_t h_t(x)$.

Il training error $0-1$ è:

$L_{0-1}(y, f(x)) = \mathbb{1}[y \cdot f(x) \leq 0]$

**Relazione**:

$L_{0-1}(y, f(x)) \leq L_{\exp}(y, f(x))$

Quindi un upper bound su exponential loss implica un bound su $0-1$ loss.

### Bound via Exponential Loss

L'errore di training è:

$\varepsilon = \frac{1}{N}\sum_{i=1}^N \mathbb{1}[y_i f(x_i) \leq 0] \leq \frac{1}{N}\sum_{i=1}^N e^{-y_i f(x_i)}$

Dalla dimostrazione del Teorema 6, si può mostrare che:

$\frac{1}{N}\sum_{i=1}^N e^{-y_i f_T(x_i)} = 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$

Questo fornisce una derivazione alternativa del bound.

## Estensioni del Bound

### Multi-Class (AdaBoost.M1)

Per AdaBoost.M1 (classificazione $k$-aria), il Teorema 10 del paper stabilisce:

$\varepsilon \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$

identico al caso binario, ma con la condizione più stringente $\epsilon_t < 1/2$ (invece di $< 1/k$ per random guessing).

### Multi-Class con Pseudo-Loss (AdaBoost.M2)

Per AdaBoost.M2, il Teorema 11 dà:

$\varepsilon \leq (k-1) \cdot 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$

dove ora $\epsilon_t$ è la pseudo-loss invece dell'errore di classificazione.

**Differenza**: Fattore $(k-1)$ aggiuntivo dovuto alla riduzione da $N(k-1)$ esempi binari.

### Regression (AdaBoost.R)

Per AdaBoost.R (regressione), il Teorema 12 garantisce che il **mean squared error** soddisfa:

$\text{MSE} \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$

dove $\epsilon_t$ è definito tramite una riduzione al caso binario.

## Tightness del Bound

### Il Bound è Tight?

Il bound del Teorema 6 è generalmente **non tight**, nel senso che l'errore effettivo è spesso molto minore del bound.

**Esempio**: Con $T=10$, $\epsilon_t = 0.4$ ($\gamma = 0.1$):

**Bound teorico**:
$\varepsilon \leq (2\sqrt{0.4 \cdot 0.6})^{10} = (0.98)^{10} \approx 0.817$

**Errore tipico osservato**: $\varepsilon \approx 0.1$ o meno.

### Perché il Bound è Loose?

1. **Worst-case analysis**: Il bound vale per ogni sequenza di distribuzioni, anche adversariali
2. **Ignora struttura dei dati**: Non sfrutta correlazioni o pattern specifici
3. **Approssimazioni**: Diverse disuguaglianze nella dimostrazione introducono slack

### Bound Empirici

In pratica, si osservano spesso bound molto più stretti basati su:
- **Margin distribution**: Frazione di esempi con margine $> \theta$
- **Stabilità**: Varianza delle predizioni su perturbazioni
- **Rademacher complexity**: Misura della capacità della classe

## Implicazioni Pratiche

### Early Stopping

Dato che il bound cresce con $T$ (via VC-dimension), potrebbe sembrare necessario limitare $T$.

**Tuttavia**: In pratica, AdaBoost beneficia spesso di molte iterazioni grazie alla teoria dei margini.

**Strategia**: Usare validation set per scegliere $T$, non affidarsi ciecamente al bound teorico.

### Scelta del Weak Learner

Il bound suggerisce che weak learner con $\gamma$ più grande sono preferibili:

$\varepsilon \approx e^{-2\gamma^2 T}$

**Trade-off**:
- Weak learner più forte → $\gamma$ più grande → convergenza più rapida
- Weak learner più debole → maggior diversità → possibile migliore generalizzazione

### Quando Fermarsi?

Criteri pratici per terminare AdaBoost:

1. **Training error = 0**: Se il bound prevede convergenza, fermarsi quando raggiunto
2. **Validation error aumenta**: Segno di overfitting
3. **Budget computazionale**: Limite sul tempo/iterazioni
4. **ε_t ≥ 1/2**: Weak learner ha fallito, impossibile continuare

## Confronto con Altri Bound

### AdaBoost vs Bagging

**Bagging** (Bootstrap Aggregating) non ha garanzie teoriche di riduzione dell'errore, ma empiricamente funziona.

**AdaBoost** ha garanzie esponenziali ma può overfittare su dati rumorosi.

### AdaBoost vs Gradient Boosting

**Gradient Boosting** minimizza una loss function generale via gradient descent funzionale.

**Bound**: Dipende dalla loss function specifica. Per squared loss:

$\text{Loss} \leq \text{Loss}_0 - \eta \sum_{t=1}^T ||\nabla_t||^2$

Lineare invece che esponenziale, ma più flessibile.

### AdaBoost vs Deep Learning

**Deep Learning**: Nessun bound di generalizzazione convincente in generale (problema aperto).

**AdaBoost**: Bound chiari ma spesso loose. Preferito quando:
- Dataset piccolo/medio
- Interpretabilità importante  
- Garanzie teoriche richieste

## Conclusioni

Il Teorema 6 stabilisce che AdaBoost ha **convergenza esponenziale** dell'errore di training:

$\varepsilon \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)} \approx e^{-2T\gamma^2}$

**Proprietà chiave**:
1. **Esponenziale**: Errore decade esponenzialmente con $T$
2. **Ottimale**: Raggiunge bound ottimali (Teorema 3)
3. **Adattivo**: Sfrutta tutti i weak learner, non solo il peggiore
4. **Generale**: Si estende a multi-class e regressione

**Limitazioni**:
- Bound sul training error, non generalizzazione diretta
- Spesso loose in pratica
- Sensibile a $\gamma$ piccolo

**Teoria dei margini** fornisce spiegazione migliore della generalizzazione empirica eccellente di AdaBoost.