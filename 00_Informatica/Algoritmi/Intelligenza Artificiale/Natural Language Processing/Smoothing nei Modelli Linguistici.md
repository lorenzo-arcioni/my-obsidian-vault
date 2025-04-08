# Smoothing nei Modelli Linguistici  

## Introduzione  
Lo **smoothing** è una tecnica fondamentale per gestire il problema dei **dati sparsi** nei modelli di linguaggio. Senza smoothing:  
- Gli **n-grammi non osservati** nel training ricevono probabilità zero, portando a **perplessità infinita** durante il test.  
- Il modello non può generalizzare a sequenze plausibili ma mai viste.  

L'idea è **ridistribuire la massa di probabilità** dagli n-grammi frequenti a quelli rari o assenti ("Rubare ai ricchi per dare ai poveri").  

## Tecniche Principali  

### 1. **Laplace (Add-One) Smoothing**  
Il Laplace Smoothing, noto anche come add-one smoothing, è una tecnica usata nei modelli di linguaggio probabilistici per gestire il problema degli zeri nelle stime di probabilità. Nei modelli basati su n-grammi, ad esempio, capita spesso che alcune combinazioni di parole non compaiano mai nel corpus di addestramento. Senza smoothing, queste combinazioni avrebbero probabilità pari a zero, il che può compromettere gravemente la generazione o la valutazione di frasi.

Il Laplace Smoothing risolve questo problema aggiungendo 1 al conteggio di ogni possibile n-gramma. In pratica, anche gli n-grammi mai visti ottengono un conteggio minimo, evitando probabilità nulle. 

Sebbene semplice ed efficace per corpus piccoli, il Laplace Smoothing tende a sovrastimare la probabilità degli eventi rari, penalizzando quelli frequenti. Per questo motivo, in applicazioni avanzate si preferiscono metodi più sofisticati come Good-Turing o Kneser-Ney smoothing. Tuttavia, il Laplace rimane una base utile per comprendere il concetto di smoothing nei modelli di linguaggio.

**Formula (Unigrammi):**  
$$
P_{\text{Laplace}}(w_i) = \frac{c(w_i) + 1}{N + V}
$$  
- $c(w_i)$: conteggio della parola $w_i$.  
- $N$: numero totale di token nel corpus.  
- $V$: dimensione del vocabolario. Questo semplicemente perché abbiamo aggiunto $+1$ per ogni parola.

**Formula generale per n-grammi**:  
Per un n-gramma $w_1, w_2, \dots, w_n$:  
$$
P_{\text{Laplace}}(w_n | w_1, \dots, w_{n-1}) = \frac{c(w_1, \dots, w_n) + 1}{\sum_{w}c(w_1, \dots, w_{n-1} w)+ 1} = \frac{c(w_1, \dots, w_n) + 1}{c(w_1, \dots, w_{n-1}) + V}
$$  
dove $c(w_1, \dots, w_{n-1})$ è il conteggio del contesto $(w_1, \dots, w_{n-1})$ e $V$ la dimensione del vocabolario (sempre perché abbiamo aggiunto $+1$ per ogni n-gramma con prefix $(w_1, \dots, w_{n-1})$).

**Ridistribuzione dei conteggi**:

Possiamo ottenere i conteggi risultati dall'applicazione dello smoothing con la seguente formula:  
$$
P_{\text{Laplace}}(w_n | w_1, \dots, w_{n-1}) = \frac{c(w_1, \dots, w_n) + 1}{c(w_1, \dots, w_{n-1}) + V} = \frac{c^*(w_1, \dots, w_n}{c(w_i, \ldots, w_{n-1})} \Rightarrow c^*(w_1, \dots, w_n) = \frac{(c(w_1, \dots, w_n) + 1) \cdot c(w_1, \dots, w_{n-1})}{c(w_1, \dots, w_{n-1}) + V}.
$$

In questo modo possiamo confrontare direttamente i conteggi ridistribuiti con quelli originali (MLE).

**Esempio**:  
Se $N=1000$ e $V=500$, un bigramma "gatto felice" con $c=3$ (e contesto "gatto" che appare 10 volte):  
$$
P_{\text{Laplace}} = \frac{3 + 1}{10 + 500} = \frac{4}{510} \approx 0.0078
$$  
Conteggio ridistribuito:  
$$
c^* = \frac{(3 + 1) \cdot 10}{10 + 500} = \frac{40}{510} \approx 0.078
$$

**Problema**:  
- Sovrastima degli eventi rari per $V$ grandi (es. $V=10^5$). Per un bigramma mai visto "gatto volante", con contesto "gatto" ($c=10$):  
$$
P_{\text{Laplace}} = \frac{0 + 1}{10 + 500} = \frac{1}{510} \approx 0.00196.
$$

---

### 2. Add-$k$ Smoothing

Un'alternativa all'add-one smoothing è spostare una quantità minore di massa probabilistica dagli eventi osservati a quelli non osservati. Invece di aggiungere 1 a ogni conteggio, aggiungiamo un conteggio frazionario $0 \leq k \leq 1$. Questo algoritmo è quindi chiamato add-k smoothing.

$$
P_{Add-k}(w_n |w_1, \ldots, w_{n−1}) = \frac{c(w_1, \ldots, w_n) + k}{c(w_1, \ldots, w_{n-1}) + kV}
$$

L'add-k smoothing richiede che si abbia un metodo per scegliere k; questo può essere fatto, ad esempio, ottimizzando su un devset. Sebbene l'add-k sia utile per alcune attività (inclusa la classificazione di testi), risulta comunque non funzionare bene per la modellazione linguistica, generando conteggi con varianze scarse e spesso sconti inappropriati.

---

### 3. **Good-Turing Smoothing**

#### **Definizione**  
Il **Good-Turing smoothing** è una tecnica statistica per stimare la probabilità di eventi rari o non osservati in un dataset, ridistribuendo la massa probabilistica dagli eventi frequenti a quelli assenti. È ampiamente utilizzato nella modellazione linguistica con $n$-grammi per gestire la sparsità dei dati.

#### **Formula Principale**  
Per un evento osservato $k$ volte, la probabilità scontata è:  
$$
P_{\text{GT}}(w) = \frac{k^*}{N}, \quad \text{dove } k^* = \frac{(k+1) \cdot N_{k+1}}{N_k},  
$$  
- $N_k$ = numero di eventi osservati **esattamente** $k$ volte nel corpus,  
- $N$ = numero totale di eventi osservati ($N = \sum_{k=1}^\infty k \cdot N_k$).  

**Probabilità per eventi non osservati** ($k=0$):  
$$
P_{\text{GT}}(w_{\text{new}}) = \frac{N_1}{N}.  
$$

#### **Esempio Pratico**  
**Dati del corpus**:  
- $N_1 = 10$ (eventi osservati 1 volta),  
- $N_2 = 5$ (eventi osservati 2 volte),  
- $N_3 = 1$ (eventi osservati 3 volte),  
- Totale eventi: $N = (1 \cdot 10) + (2 \cdot 5) + (3 \cdot 1) = 23$.  

**Calcoli**:  
1. **Eventi con $k=1$**:  
   $$k^* = \frac{2 \cdot N_2}{N_1} = \frac{2 \cdot 5}{10} = 1 \quad \Rightarrow \quad P_{\text{GT}} = \frac{1}{23} \approx 0.043.$$  

2. **Eventi con $k=2$**:  
   $$k^* = \frac{3 \cdot N_3}{N_2} = \frac{3 \cdot 1}{5} = 0.6 \quad \Rightarrow \quad P_{\text{GT}} = \frac{0.6}{23} \approx 0.026.$$  

3. **Eventi non osservati ($k=0$)**:  
   $$P_{\text{GT}}(0) = \frac{N_1}{N} = \frac{10}{23} \approx 0.435.$$  

#### **Limiti**  
1. **Instabilità per $N_{k+1} = 0$**: Se non ci sono eventi con conteggio $k+1$, $k^*$ non è calcolabile.  
2. **Performance per $k$ elevati**: Meno efficace per eventi frequenti ($k \geq 5$).  
3. **Complessità computazionale**: Richiede il calcolo di $N_k$ per tutti i $k$, proibitivo per corpus di grandi dimensioni.

---

### 4. **Kneser-Ney Smoothing (Stato dell'Arte)**  
Il Kneser-Ney smoothing è considerato il metodo più efficace per la modellazione linguistica con $n$-grammi, combinando **sconti dinamici** e una **probabilità di continuazione** per gestire contesti non osservati e ridurre il bias verso parole frequenti in contesti specifici.

#### **Formula Base**  
Per un bigramma $w_{i-1}w_i$:  
$$
P_{\text{KN}}(w_i | w_{i-1}) = \frac{\max(c(w_{i-1}, w_i) - d, 0)}{c(w_{i-1})} + \lambda(w_{i-1}) \cdot P_{\text{cont}}(w_i)
$$  
- **$d$**: Fattore di sconto (tipicamente $d = 0.75$).  
- **$P_{\text{cont}}(w_i)$**: Probabilità di continuazione, definita come:  
  $$
  P_{\text{cont}}(w_i) = \frac{|\{w_{i-1} : c(w_{i-1}, w_i) > 0\}|}{|\{(w_{j-1}, w_j) : c(w_{j-1}, w_j) > 0\}|}
  $$  
  - Numeratore: Numero di contesti **diversi** in cui $w_i$ appare.  
  - Denominatore: Numero totale di bigrammi osservati nel corpus.  

- **$\lambda(w_{i-1})$**: Fattore di normalizzazione per garantire che la somma delle probabilità sia 1:  
  $$
  \lambda(w_{i-1}) = \frac{d}{c(w_{i-1})} \cdot |\{w_i : c(w_{i-1}, w_i) > 0\}|
  $$  

#### **Intuizione**  
1. **Sconto (Discounting)**:  
   Riduce i conteggi degli $n$-grammi osservati per "riservare" massa probabilistica agli eventi non osservati.  
   - Esempio: Se un bigramma "San Francisco" appare 10 volte, il suo conteggio scontato diventa $10 - 0.75 = 9.25$.  

2. **Probabilità di Continuazione**:  
   Misura quanto una parola $w_i$ è **versatile** nell'apparire in contesti diversi.  
   - Penalizza parole come "Francisco" che appaiono spesso solo in contesti specifici (es. dopo "San").  
   - Premia parole come "the" o "di" che appaiono in molti contesti.  

#### **Varianti del Kneser-Ney**  
1. **Interpolated Kneser-Ney**:  
   Interpola tra probabilità di ordine superiore e inferiore, anche quando il contesto è osservato.  
   Formula:  
   $$
   P_{\text{KN}}(w_i | w_{i-1}) = \frac{\max(c(w_{i-1}, w_i) - d, 0)}{c(w_{i-1})} + \gamma(w_{i-1}) \cdot P_{\text{cont}}(w_i)
   $$  
   dove $\gamma(w_{i-1})$ dipende dal numero di bigrammi unici che seguono $w_{i-1}$.  

2. **Modified Kneser-Ney**:  
   Usa **sconti differenziati** per conteggi $c = 1$, $c = 2$, e $c \geq 3$:  
   - $d_1 = 0.75$ (per $c=1$),  
   - $d_2 = 0.5$ (per $c=2$),  
   - $d_3 = 0.25$ (per $c \geq 3$).  

#### **Esempio Pratico**  
**Corpus di Esempio**:  
- "il gatto dorme"  
- "il cane abbaia"  
- "il gatto miagola"  

**Calcoli**:  
1. **Conteggi Bigrammi**:  
   - "il gatto": 2  
   - "il cane": 1  
   - "gatto dorme": 1  
   - "gatto miagola": 1  
   - "cane abbaia": 1  

2. **Probabilità di Continuazione per "gatto"**:  
   - "gatto" appare dopo "il" (2 volte) e "dorme" (0).  
   - $P_{\text{cont}}(\text{"gatto"}) = \frac{1}{\text{Total bigrammi}} = \frac{1}{5} = 0.2$.  

3. **Calcolo di $P_{\text{KN}}(\text{"gatto"} | \text{"il"})$**:  
   - $c(\text{"il"}, \text{"gatto"}) = 2$, $d = 0.75$:  
     $$
     \frac{\max(2 - 0.75, 0)}{c(\text{"il"})} = \frac{1.25}{3} \approx 0.4167
     $$  
   - $\lambda(\text{"il"})$:  
     $$
     \lambda = \frac{0.75}{3} \cdot 2 = 0.5
     $$  
   - Termine di continuazione:  
     $$
     0.5 \cdot 0.2 = 0.1
     $$  
   - **Probabilità Finale**:  
     $$
     P_{\text{KN}} = 0.4167 + 0.1 = 0.5167
     $$  

#### **Vantaggi**  
1. **Gestione ottimale delle parole comuni**:  
   - "Francisco" avrà bassa $P_{\text{cont}}$ perché appare solo dopo "San".  
   - "the" avrà alta $P_{\text{cont}}$ perché appare in molti contesti.  

2. **Adattabilità a contesti sparsi**:  
   Usa informazioni degli $n$-grammi di ordine inferiore in modo più efficace rispetto a Good-Turing.  

3. **Performance superiori**:  
   È lo standard per modelli linguistici in task come traduzione automatica e riconoscimento vocale.  

#### **Limiti**  
1. **Complessità computazionale**:  
   Richiede il calcolo di $P_{\text{cont}}$ per tutte le parole e contesti, costoso per corpus di grandi dimensioni.  

2. **Scelta dei parametri**:  
   Il valore di $d$ e la variante (interpolated vs modified) influenzano significativamente i risultati.    

## Tabella di Confronto

| **Metodo**         | **Idee Chiave**                                                                 | **Vantaggi**                                  | **Svantaggi**                                                                 | **Casi d'Uso**                     |
|---------------------|---------------------------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------|
| **Laplace (Add-One)** | Aggiunge 1 al conteggio di ogni n-gramma per evitare probabilità zero.          | Semplice da implementare.                    | Sovrastima eventi rari, inefficace per vocabolari grandi ($V$ elevato).       | Corpus piccoli, prototipazione.     |
| **Add-$k$**          | Aggiunge un conteggio frazionario $k$ (es. 0.5) invece di 1.                   | Più flessibile di Laplace.                   | Difficoltà nella scelta di $k$, varianza elevata, sconti inappropriati.       | Classificazione testi, task specifici. |
| **Good-Turing**     | Ridistribuisce massa dagli eventi frequenti a quelli rari usando $N_k$.         | Fondamento teorico solido.                   | Instabile per $N_{k+1}=0$, complessità computazionale, inefficace per $k$ alti. | Corpus medi, modelli con sparsità.  |
| **Kneser-Ney**      | Combina sconti e probabilità di continuazione per gestire contesti.             | Gestione avanzata dei contesti, stato dell'arte. | Complessità implementativa, richiede calcolo di $P_{\text{cont}}$.            | Modelli linguistici avanzati (es. NLP moderno). |

## Conclusioni  
I metodi di smoothing risolvono il problema degli n-grammi non osservati o rari, ma con compromessi tra semplicità e accuratezza:  

1. **Laplace e Add-$k** sono adatti per **scenari semplici** (corpus piccoli o prototipi), ma diventano rapidamente inefficaci con vocabolari ampi.  
2. **Good-Turing** offre una **base teorica rigorosa** per la ridistribuzione della massa probabilistica, ma la sua complessità e instabilità lo rendono poco pratico per corpus molto grandi.  
3. **Kneser-Ney** è lo **stato dell'arte** per la modellazione linguistica, grazie alla combinazione di sconti dinamici e probabilità di continuazione, che penalizzano parole comuni in contesti specifici (es. "Francisco" dopo "San").  

**Raccomandazioni**:  
- Usare **Kneser-Ney** per task avanzati (es. riconoscimento vocale, traduzione automatica).  
- Optare per **Good-Turing** se è necessaria una ridistribuzione teorica senza troppa complessità.  
- **Laplace/Add-$k** sono utili solo in fase esplorativa o con dati limitati.  

In sintesi, la scelta dipende dal trade-off tra risorse computazionali, dimensione del corpus e necessità di precisione. Per applicazioni reali, Kneser-Ney rimane il gold standard nonostante la sua complessità.  