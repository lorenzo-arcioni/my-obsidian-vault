# Skip-gram con Softmax

Il modello **Skip-gram** di *word2vec* con softmax è una tecnica di apprendimento non supervisionato usata per generare vettori densi (embedding) che rappresentano parole in uno spazio continuo a dimensione $D$. Vediamo nel dettaglio tutti i passaggi e le componenti del modello.

## Parametri da apprendere in Skip-Gram con Softmax

Nel modello Skip-Gram di word2vec, l'obiettivo principale è imparare rappresentazioni dense (embedding) delle parole che catturino il loro significato in relazione al contesto in cui appaiono. Per fare ciò, dobbiamo definire e apprendere dei parametri, che rappresentano queste strutture vettoriali.

### Definizione dei parametri

Sia $V$ il vocabolario di parole del modello, e sia $D$ la dimensione dello spazio di embedding, cioè il numero di componenti o caratteristiche usate per rappresentare ciascuna parola come un vettore numerico continuo. Ogni dimensione può essere interpretata come un "tema" o una caratteristica latente che cattura aspetti semantici o sintattici della parola.

Indichiamo con:

$$
\Large \mathbf{\theta} = [\mathbf{\theta}_W; \mathbf{\theta}_C]
$$

l'insieme dei parametri del modello, suddiviso in due matrici principali:

- **$\mathbf{\theta}_W$** (matrice degli embedding delle parole centro):
  - **Dimensione:** $|V| \times D$
  - Ogni riga di $\mathbf{\theta}_W$ è un vettore che rappresenta una parola specifica **nel ruolo di parola centrale** all’interno di una finestra di contesto. Questo significa che il vettore codifica le proprietà della parola quando è il punto focale della previsione del modello.
  - Il vettore di embedding in $\mathbf{\theta}_W$ viene usato dal modello per cercare di predire le parole di contesto che la circondano: ad esempio, dato un vettore centrale, il modello calcola la probabilità di ogni parola nel vocabolario come possibile parola di contesto.
  - Questa rappresentazione è fondamentale perché permette al modello di apprendere relazioni tra parole basate sulle co-occorrenze: parole con significati simili o usi simili tendono ad avere vettori vicini nello spazio degli embedding.
  - È importante notare che la stessa parola avrà vettori distinti in $\mathbf{\theta}_W$ e in $\mathbf{\theta}_C$, poiché il suo ruolo nel modello cambia (centro vs contesto). Questo permette una rappresentazione più ricca e flessibile del linguaggio.


- **$\mathbf{\theta}_C$** (matrice degli embedding delle parole contesto):
  - **Dimensione:** $|V| \times D$
  - Ogni riga di $\mathbf{\theta}_C$ è un vettore che rappresenta una parola **quando essa agisce come contesto** di una parola centrale. In altre parole, questi vettori sono usati per modellare le parole che circondano la parola centrale nella finestra di contesto.
  - La funzione di $\mathbf{\theta}_C$ è catturare le proprietà semantiche e sintattiche delle parole nel loro ruolo di contesto, cioè come "indizi" o segnali che aiutano a prevedere la parola centrale.
  - Ad esempio, la parola "delicious" avrà un embedding in $\mathbf{\theta}_C$ che riflette il suo uso frequente vicino a parole legate al cibo, mentre la stessa parola avrà un embedding differente in $\mathbf{\theta}_W$ quando appare come parola centrale.
  - Questa doppia rappresentazione consente al modello di distinguere come una parola si comporta quando è il fulcro della previsione (centro) rispetto a quando è un "supporto" per predire altre parole (contesto).
  - Grazie a $\mathbf{\theta}_C$, il modello impara a riconoscere quali parole di contesto sono più probabili dati i vettori delle parole centrali, migliorando così la capacità di rappresentare le relazioni semantiche tra parole.

Questa suddivisione di parametri consente al modello di catturare dinamiche diverse, come il significato di una parola quando appare come centro o quando appare come contesto nella finestra di contesto.

### Perché due matrici distinte?

È fondamentale notare che nel modello Skip-Gram, le parole assumono ruoli diversi:
- Come parola **centro** (target da cui si predice il contesto),
- Come parola **contesto** (parole da prevedere attorno alla parola centro).

Di conseguenza, per ogni parola del vocabolario esistono due vettori distinti:
- Uno quando la parola agisce da centro,
- Uno quando la parola è parte del contesto.

Questo doppio embedding consente al modello di catturare dinamiche diverse, perché il significato di una parola può essere influenzato in modo differente dal suo ruolo nella frase.

### Esempi che chiariscono la differenza tra parole centro e parole contesto

Per capire perché è necessario distinguere tra embedding delle parole come **centro** ($\mathbf{\theta}_W$) e come **contesto** ($\mathbf{\theta}_C$), consideriamo un esempio pratico.

Supponiamo di avere la frase:

> "Il **gatto** nero dorme sul tappeto."

- La parola **gatto** qui è la parola centrale su cui vogliamo fare la previsione.
- Le parole attorno a "gatto" — come "Il", "nero", "dorme" — sono le parole di contesto.

Quando il modello guarda la parola **gatto** come parola centrale, la rappresenta con un vettore in $\mathbf{\theta}_W$ che sintetizza come questa parola "comanda" il contesto, cioè quali parole è probabile che la circondino.

Al contrario, le parole di contesto come "nero" o "dorme" hanno un embedding in $\mathbf{\theta}_C$ che riflette il loro ruolo di supporto: in questo caso, aiutano a fornire informazioni per riconoscere o prevedere la parola centrale.

### Perché questa distinzione è importante?

- La stessa parola può assumere ruoli diversi: una parola usata come centro (soggetto della previsione) ha una funzione diversa da quando è usata come contesto (fornisce segnali per la previsione).
  
- Ad esempio, la parola **"rosso"** in $\mathbf{\theta}_C$ rappresenta come un aggettivo che spesso accompagna nomi di colori o oggetti, mentre in $\mathbf{\theta}_W$ potrebbe riflettere quali contesti (parole di contorno) è probabile che appaiano vicino a "rosso" come parola centrale.

- Questa doppia rappresentazione permette al modello di imparare relazioni più sottili e asimmetriche tra le parole. Se avessimo un solo embedding per parola, perderemmo questa distinzione funzionale.

In sintesi, $\mathbf{\theta}_W$ e $\mathbf{\theta}_C$ rappresentano la stessa parola in due "ruoli" diversi, consentendo al modello di cogliere meglio le strutture e le dipendenze linguistiche.

### Problemi nell'usare un solo embedding per ogni parola (senza distinzione centro/contesto)

Se invece di avere due matrici separate $\mathbf{\theta}_W$ e $\mathbf{\theta}_C$ usassimo un **unico embedding** per ogni parola, cioè una singola rappresentazione vettoriale indipendentemente dal ruolo, potremmo incorrere in alcuni problemi importanti:

1. **Perdita di informazioni sul ruolo funzionale della parola:**

   - La parola può assumere significati o funzioni diverse quando è **centro** o quando è **contesto**.
   - Ad esempio, la parola "bank" (in inglese) può riferirsi a una sponda di un fiume o a una banca finanziaria. Come parola centrale, potrebbe essere più importante catturare il significato principale, mentre come contesto può fornire indizi diversi.
   - Usare un unico embedding rende difficile modellare questa ambiguità funzionale, poiché la stessa rappresentazione deve mediare entrambi i ruoli.

2. **Difficoltà nel modellare relazioni asimmetriche:**

   - Le relazioni tra parola centrale e contesto non sono simmetriche. Ad esempio, la parola centrale "mangiare" probabilmente si accompagna a contesti come "cibo", "pasto", mentre la parola "cibo" come contesto aiuta a predire "mangiare".
   - Un solo embedding non riesce a distinguere bene questi ruoli, perché la relazione "mangiare" → "cibo" non è la stessa di "cibo" → "mangiare".
   - Due embedding distinti permettono di modellare questa asimmetria, migliorando la qualità delle previsioni.

3. **Capacità ridotta di apprendere pattern più complessi:**

   - Con un unico embedding, il modello deve trovare una media "compromissoria" per rappresentare tutte le funzioni della parola, il che può portare a una perdita di precisione.
   - Questo può tradursi in embedding meno discriminativi e quindi in prestazioni inferiori nelle attività di rappresentazione semantica.

### Numero totale di parametri

Il numero complessivo di parametri del modello è dato dalla somma degli elementi di entrambe le matrici:

$$
2 \times |V| \times D
$$

Ovvero:
- $|V| \times D$ parametri per gli embedding come centro,
- $|V| \times D$ parametri per gli embedding come contesto.

### Visualizzazione intuitiva

Immagina il vocabolario come una lista di parole:

| Indice | Parola      | Embedding Centro ($\mathbf{\theta}_W$) | Embedding Contesto ($\mathbf{\theta}_C$) |
|--------|-------------|-----------------------------------------|--------------------------------------------|
| 1      | "lemon"     | vettore in $\mathbb{R}^D$              | vettore in $\mathbb{R}^D$                 |
| 2      | "tablespoon"| vettore in $\mathbb{R}^D$              | vettore in $\mathbb{R}^D$                 |
| ...    | ...         | ...                                     | ...                                        |
| |V|    | "jam"       | vettore in $\mathbb{R}^D$              | vettore in $\mathbb{R}^D$                 |

- Quando "tablespoon" è parola centro, useremo la riga 2 di $\mathbf{\theta}_W$.
- Quando "tablespoon" è nel contesto, useremo la riga 2 di $\mathbf{\theta}_C$.

### Perché sono vettori?

Rappresentare le parole come vettori in uno spazio continuo di dimensione $D$ consente al modello di apprendere relazioni semantiche e sintattiche tra parole, ad esempio:

- Parole con significati simili tendono ad avere vettori vicini nello spazio,
- Relazioni di analogia possono essere rappresentate come vettori differenza, es. vettore("re") - vettore("uomo") + vettore("donna") ≈ vettore("regina").

### Riassumendo:

- $\mathbf{\theta}_W$ e $\mathbf{\theta}_C$ sono matrici di embedding distinte per parola centro e contesto.
- Entrambe hanno dimensione $|V| \times D$.
- Complessivamente abbiamo $2 \times |V| \times D$ parametri da imparare.
- Questo doppio embedding è la chiave per modellare le relazioni tra parole in un modo più ricco e flessibile.

Questa struttura di parametri sarà la base su cui il modello Skip-Gram costruirà la sua funzione di probabilità e la sua funzione di perdita durante l'addestramento.

## Il concetto di self-supervision nello Skip-gram

Il training si basa su un grande corpus di testo, ad esempio:  
`... lemon, a tablespoon of apricot jam, a pinch ...`

Il modello considera una finestra di contesto di ampiezza $m$ (ad esempio $m=2$) centrata sulla parola al tempo $t$:

- La parola centrale è $w_t$, nel nostro esempio "apricot".
- Le parole del contesto sono quelle all’interno della finestra di dimensione $2m$ intorno a $w_t$:
  - $w_{t-2}$, $w_{t-1}$ a sinistra,
  - $w_{t+1}$, $w_{t+2}$ a destra.

|   | ~~lemon~~ | ~~a~~ | [tablespoon | of | **apricot** | jam | a] | ~~pinch~~ |
|:-:|:---------:|:-----:|:-----------:|:--:|:-----------:|:---:|:--:|:--------:|
|   |           |       |  $w_{t-2}$  | $w_{t-1}$ | **$w_t$** | $w_{t+1}$ | $w_{t+2}$ |          |

## Obiettivo del modello

Vogliamo modellare la probabilità congiunta di osservare le parole di contesto data la parola centrale:

$$ p(w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2} | w_t; \mathbf{\theta}) $$

Per semplicità si assume una **forte indipendenza condizionata** tra le parole di contesto dato il centro:

$$ p(w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2} | w_t; \mathbf{\theta}) \approx \prod_{j=-m, j \neq 0}^{m} p(w_{t+j} | w_t; \mathbf{\theta}) $$

Questo significa che ogni parola di contesto è indipendente dalle altre data la parola centrale.

## Come si calcola $p(w_{t+j}|w_t)$?

Dato un centro $w_t$, vogliamo predire la parola di contesto $w_{t+j}$. Questa probabilità è modellata come una distribuzione categorica su tutto il vocabolario $V$.

1. Prendiamo l'embedding della parola centro: se $i$ è l'indice di $w_t$ in $\mathbf{\theta}_W$, consideriamo il vettore riga $\mathbf{\theta}_W^i$ (di dimensione $1 \times |D|$).
2. Calcoliamo i punteggi (logits) per tutte le parole del vocabolario come prodotto scalare tra ogni vettore di contesto in $\mathbf{\theta}_C$ e l'embedding del centro:

   $$
   \mathbf{z} = \mathbf{\theta}_C \cdot {\mathbf{\theta}_W^i}^T
   $$

   dove $\mathbf{z}$ è un vettore di dimensione $|V|$, con ogni elemento che rappresenta la similarità (dot product) tra la parola centro e una possibile parola di contesto.

3. Applichiamo la funzione **softmax** ai logits per ottenere una distribuzione di probabilità:

   $$
   \mathbf{p} = \text{softmax}(\mathbf{z}) = \frac{e^{z_v}}{\sum_{v'=1}^{|V|} e^{z_{v'}}}
   $$

Così otteniamo la probabilità di ogni parola del vocabolario come contesto dato il centro.

## Interpretazione

- $\mathbf{p}$ è una distribuzione di probabilità discreta su $|V|$ parole.
- L'elemento $p(w_{t+j} = \text{`tablespoon`} | w_t = \text{`apricot`})$ rappresenta la probabilità che la parola "tablespoon" sia nel contesto della parola "apricot".

## Funzione di perdita (loss)

Per addestrare il modello, abbiamo bisogno di confrontare la distribuzione predetta $\mathbf{p}$ con la parola di contesto **reale** osservata nel testo.

- La parola vera di contesto è rappresentata da un vettore **one-hot** $\mathbf{y}$, che è zero per tutte le parole tranne che per l'indice della parola reale (ad esempio "tablespoon").
  
$$
\mathbf{y} = [0, 0, ..., 1, ..., 0]
$$

- La funzione di perdita è la **cross-entropy** tra la distribuzione vera e quella predetta:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \mathbf{y}^\top \log \mathbf{p} = -\log p(w_{t+j} | w_t; \mathbf{\theta})
$$

In pratica, questa perdita penalizza il modello quando la probabilità assegnata alla parola reale di contesto è bassa.

## Forma esplicita della loss

Sostituendo la definizione di $\mathbf{p}$:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \log \frac{\exp(\mathbf{\theta}_C[w_{t+j}] \cdot \mathbf{\theta}_W[w_t]^T)}{\sum_{v=1}^{|V|} \exp(\mathbf{\theta}_C[v] \cdot \mathbf{\theta}_W[w_t]^T)}
$$

che si può riscrivere come:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \mathbf{\theta}_C[w_{t+j}] \cdot \mathbf{\theta}_W[w_t]^T + \log \sum_{v=1}^{|V|} \exp(\mathbf{\theta}_C[v] \cdot \mathbf{\theta}_W[w_t]^T)
$$

Questa formula evidenzia il trade-off tra massimizzare la similarità centro-contesto della parola corretta e normalizzare le probabilità su tutto il vocabolario.

## Massimizzazione della likelihood su tutta la finestra

Per ogni parola centrale $w_t$, la probabilità congiunta di osservare tutte le parole di contesto nella finestra è:

$$
L(\mathbf{\theta}) = \prod_{j=-m, j \neq 0}^{m} p(w_{t+j} | w_t; \mathbf{\theta})
$$

Il nostro obiettivo è trovare i parametri $\mathbf{\theta}$ che massimizzano la likelihood su tutto il corpus, ossia:

$$
\mathbf{\theta}^* = \arg\max_{\mathbf{\theta}} \prod_{t=1}^T \prod_{j=-m, j \neq 0}^m p(w_{t+j} | w_t; \mathbf{\theta})
$$

## Minimizzazione della loss totale

Si usa la funzione di perdita negativa del logaritmo della likelihood, che è equivalente a minimizzare la somma della cross-entropy su tutte le parole del corpus:

$$
\mathbf{\theta}^* = \arg\min_{\mathbf{\theta}} \mathcal{L}(\mathbf{\theta}) = -\frac{1}{T} \sum_{t=1}^T \sum_{j=-m, j \neq 0}^m \log p(w_{t+j} | w_t; \mathbf{\theta})
$$

Così il modello impara ad associare ad ogni parola centrale i vettori che predicono meglio il suo contesto.

## Riassunto

- Lo Skip-gram con softmax usa due embedding per ogni parola: uno come parola centrale, uno come contesto.
- Il modello prevede la probabilità delle parole di contesto data una parola centrale usando prodotti scalari e softmax.
- La funzione di perdita è la cross-entropy tra la distribuzione predetta e la parola di contesto reale.
- L’ottimizzazione massimizza la probabilità del contesto osservato sul corpus, migliorando gli embedding.

Questo approccio self-supervision permette di apprendere rappresentazioni semantiche delle parole direttamente da grandi quantità di testo non etichettato, ed è la base di modelli di embedding ampiamente usati nel NLP.
