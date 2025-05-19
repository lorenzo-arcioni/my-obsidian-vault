# Skip-gram con Softmax

Il modello **Skip-gram** di *word2vec* con softmax è una tecnica di apprendimento non supervisionato usata per generare vettori densi (embedding) che rappresentano parole in uno spazio continuo a dimensione $D$. Vediamo nel dettaglio tutti i passaggi e le componenti del modello.

## Parametri da apprendere in Skip-Gram con Softmax

Nel modello Skip-Gram di word2vec, l'obiettivo principale è imparare rappresentazioni dense (embedding) delle parole che catturino il loro significato in relazione al contesto in cui appaiono. Per fare ciò, dobbiamo definire e apprendere dei parametri, che rappresentano queste strutture vettoriali.

### Definizione dei parametri

Sia $V$ il vocabolario di parole del modello, e sia $D$ la dimensione dello spazio di embedding, cioè il numero di componenti o caratteristiche usate per rappresentare ciascuna parola come un vettore numerico continuo. Ogni dimensione può essere interpretata come un "tema" o una caratteristica latente che cattura aspetti semantici o sintattici della parola.

Indichiamo con:

$$\large
\bm{\theta} =
\begin{bmatrix}
\bm{\theta}_W \\ \hline
\bm{\theta}_C
\end{bmatrix}
\quad\text{con}\quad
\bm{\theta}_W \in \mathbb{R}^{|V| \times d},\quad
\bm{\theta}_C \in \mathbb{R}^{|V| \times d}
$$

l'insieme dei parametri del modello, suddiviso in due matrici principali:

- **$\bm{\theta}_W$** (matrice degli embedding delle parole centro):
 
    - **Dimensione:** $|V| \times D$
    - Ogni riga di $\bm{\theta}_W$ è un vettore che rappresenta una parola specifica **nel ruolo di parola centrale** all’interno di una finestra di contesto. Questo significa che il vettore codifica le proprietà della parola quando è il punto focale della previsione del modello.
    - Il vettore di embedding in $\bm{\theta}_W$ viene usato dal modello per cercare di predire le parole di contesto che la circondano: ad esempio, dato un vettore centrale, il modello calcola la probabilità di ogni parola nel vocabolario come possibile parola di contesto.
    - Questa rappresentazione è fondamentale perché permette al modello di apprendere relazioni tra parole basate sulle co-occorrenze: parole con significati simili o usi simili tendono ad avere vettori vicini nello spazio degli embedding.
    - È importante notare che la stessa parola avrà vettori distinti in $\bm{\theta}_W$ e in $\bm{\theta}_C$, poiché il suo ruolo nel modello cambia (centro vs contesto). Questo permette una rappresentazione più ricca e flessibile del linguaggio.


- **$\bm{\theta}_C$** (matrice degli embedding delle parole contesto):

    - **Dimensione:** $|V| \times D$
    - Ogni riga di $\bm{\theta}_C$ è un vettore che rappresenta una parola **quando essa agisce come contesto** di una parola centrale. In altre parole, questi vettori sono usati per modellare le parole che circondano la parola centrale nella finestra di contesto.
    - La funzione di $\bm{\theta}_C$ è catturare le proprietà semantiche e sintattiche delle parole nel loro ruolo di contesto, cioè come "indizi" o segnali che aiutano a prevedere la parola centrale.
    - Ad esempio, la parola "delicious" avrà un embedding in $\bm{\theta}_C$ che riflette il suo uso frequente vicino a parole legate al cibo, mentre la stessa parola avrà un embedding differente in $\bm{\theta}_W$ quando appare come parola centrale.
    - Questa doppia rappresentazione consente al modello di distinguere come una parola si comporta quando è il fulcro della previsione (centro) rispetto a quando è un "supporto" per predire altre parole (contesto).
    - Grazie a $\bm{\theta}_C$, il modello impara a riconoscere quali parole di contesto sono più probabili dati i vettori delle parole centrali, migliorando così la capacità di rappresentare le relazioni semantiche tra parole.

Questa suddivisione di parametri consente al modello di catturare dinamiche diverse, come il significato di una parola quando appare come centro o quando appare come contesto nella finestra di contesto.

```tikz
\usepackage{tikz}
\documentclass[tikz, border=2pt]{standalone}
\usepackage{amsmath}
\usetikzlibrary{decorations.brace, positioning}
\begin{document}
\begin{tikzpicture}
 % Styles
 \tikzset{
 smalldot/.style={circle, fill=red!70!black, inner sep=0pt, minimum size=2pt}
 }
 % Shift to center the matrix (visually)
 \def\shiftright{10} % Aumentato ulteriormente per spostare tutto più a destra
 \def\matrixwidth{1.2}
 \def\matrixheight{7}
 \def\midpoint{0}
 \def\exp(trashift{0.5}
 \def\bracegap{1.0}
 % Title
 \node[font=\normalsize] at (\shiftright, 4) {1...D};
 % Main rectangle - ora con la linea orizzontale spezzata
 \draw[thin] (-\matrixwidth/2+\shiftright, -\matrixheight/2) -- (-\matrixwidth/2+\shiftright, \matrixheight/2);
 \draw[thin] (\matrixwidth/2+\shiftright, -\matrixheight/2) -- (\matrixwidth/2+\shiftright, \matrixheight/2);
 \draw[thin] (-\matrixwidth/2+\shiftright, \matrixheight/2) -- (\matrixwidth/2+\shiftright, \matrixheight/2);
 \draw[thin] (-\matrixwidth/2+\shiftright, -\matrixheight/2) -- (\matrixwidth/2+\shiftright, -\matrixheight/2);
 % Upper and lower fill
 \fill[green!30!gray!20] (-\matrixwidth/2+\shiftright, \midpoint) rectangle (\matrixwidth/2+\shiftright, \matrixheight/2);
 \fill[blue!20!gray!10] (-\matrixwidth/2+\shiftright, -\matrixheight/2) rectangle (\matrixwidth/2+\shiftright, \midpoint);
 % Dots inside
 \foreach \y in {3, 2, 0.5, -0.5, -1.5, -3} {
 \foreach \x in {-0.7, 0, 0.7} {
 \node[smalldot] at (\x*0.5+\shiftright, \y) {};
 }
 }
 % Word labels
 \node[text=green!50!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, 3) {aardvark};
 \node[text=green!50!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, 2) {apricot};
 \node[text=green!50!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, 1.3) {...};
 \node[text=green!50!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, 0.5) {zebra};
 \node[text=violet!70!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, -0.5) {aardvark};
 \node[text=violet!70!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, -1.5) {apricot};
 \node[text=violet!70!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, -2.2) {...};
 \node[text=violet!70!black, anchor=east] at (-\matrixwidth/2+\shiftright-0.3, -3) {zebra};
 % Theta (spostato più a sinistra)
 \node at (\shiftright - 3.5, -0.5) {$\boldsymbol{\theta} =$};
 % Linea centrale spezzata (con un gap)
 \def\gapsize{0.5} % Dimensione dello spazio nella linea centrale
 \draw[thin] (-\matrixwidth/2+\shiftright, \midpoint) -- (\shiftright-\gapsize, \midpoint); % Prima parte della linea orizzontale
 \draw[thin] (\shiftright+\gapsize, \midpoint) -- (\matrixwidth/2+\shiftright, \midpoint); % Seconda parte della linea orizzontale
 
 % Inner dots
 \node at (\shiftright, 1.3) {...};
 \node at (\shiftright, -2.2) {...};
 % Right-side indices
 \node[text=gray!80!black] at (\matrixwidth/2+\shiftright+\exp(trashift, 3) {1};
 \node[text=gray!80!black] at (\matrixwidth/2+\shiftright+\exp(trashift, 0.5) {V};
 \node[text=gray!80!black] at (\matrixwidth/2+\shiftright+\exp(trashift, -0.5) {V+1};
 \node[text=gray!80!black] at (\matrixwidth/2+\shiftright+\exp(trashift, -3) {2V};
 % Braces
 \draw[decorate, decoration={brace, mirror, amplitude=5pt}, thick]
 (\matrixwidth/2+\shiftright+\bracegap, \matrixheight/2) -- (\matrixwidth/2+\shiftright+\bracegap, \midpoint)
 node[midway, right=7pt] {W \quad target words};
 \draw[decorate, decoration={brace, mirror, amplitude=5pt}, thick]
 (\matrixwidth/2+\shiftright+\bracegap, \midpoint) -- (\matrixwidth/2+\shiftright+\bracegap, -\matrixheight/2)
 node[midway, right=7pt] {C \quad context \& noisewords};
\end{tikzpicture}
\end{document}
```

### Perché due matrici distinte?

- **Ruoli diversi**: 

  - $\mathbf{\theta}_W$: embedding quando la parola è **centro** (target da cui si predice).  
  - $\mathbf{\theta}_C$: embedding quando la parola è **contesto** (segnale per la previsione).

- **Esempio** (“Il **gatto** nero dorme…”):

  - “gatto” → $\mathbf{\theta}_W$ cattura come “gatto” governa il contesto (“nero”, “dorme”).  
  - “nero”, “dorme” → $\mathbf{\theta}_C$ catturano come questi agiscono da indizi per “gatto”.

### ⚠️ Problemi con un singolo embedding

1. **Ruolo funzionale perso**
  
   - Ogni parola può comparire sia come **centrale** sia come **di contesto**.
   - Esempio:
  
     - “**book**” come centrale (es. *"I read a book about history."*) → predice parole come *read*, *history*.
     - “**book**” come contesto (es. *"She put the book on the table."*) → aiuta a predire *put*, *table*.
  
   - Se usiamo **un solo embedding**, non distinguiamo questi ruoli → perdiamo informazione funzionale importante.

2. **Relazioni asimmetriche non modellate**

   - Il significato delle relazioni cambia a seconda della direzione:

     - “**eat**” → “**food**” = tipico: il verbo suggerisce l’oggetto (cosa si mangia).
     - “**food**” → “**eat**” = più debole: “food” potrebbe comparire in molti altri contesti (buy, cook, smell…).
  
   - Se usiamo lo stesso embedding per “food” in entrambi i ruoli, non possiamo catturare questa asimmetria.
   - Due matrici permettono:

     - $\theta_W$(eat) → embedding ottimizzato per predire cibo.
     - $\theta_C$(food) → embedding ottimizzato per essere predetto da verbi come *eat*.

3. **Embedding meno precisi**

   - Un solo embedding deve essere "tuttofare" → media tra ruoli e significati.
   - Risultato: vettori **più confusi, meno specializzati**, e performance peggiori in downstream tasks.
   - Due matrici aiutano a ottenere rappresentazioni **più informative e discriminative**.

### Numero totale di parametri

Il numero complessivo di parametri del modello è dato dalla somma degli elementi di entrambe le matrici:

$$
2 \cdot |V| \times D
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
| \|V\|    | "jam"       | vettore in $\mathbb{R}^D$              | vettore in $\mathbb{R}^D$                 |

- Quando "tablespoon" è parola centro, useremo la riga 2 di $\mathbf{\theta}_W$.
- Quando "tablespoon" è nel contesto, useremo la riga 2 di $\mathbf{\theta}_C$.

### Perché sono vettori?

Rappresentare le parole come vettori in uno spazio continuo di dimensione $D$ consente al modello di apprendere relazioni semantiche e sintattiche tra parole, ad esempio:

- Parole con significati simili tendono ad avere vettori vicini nello spazio,
- Relazioni di analogia possono essere rappresentate come vettori differenza, es. vettore("re") - vettore("uomo") + vettore("donna") ≈ vettore("regina").

### Riassumendo:

- $\mathbf{\theta}_W$ e $\mathbf{\theta}_C$ sono matrici di embedding distinte per parola centro e contesto.
- Entrambe hanno dimensione $|V| \times D$.
- Complessivamente abbiamo $2 \cdot |V| \times D$ parametri da imparare.
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

Vogliamo modellare la probabilità congiunta di osservare le parole di contesto data la parola centrale $w_t$, ossia:

$$\mathbb P(w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2} \mid w_t; \mathbf{\theta}) $$

Per semplicità si assume una **forte indipendenza condizionata** tra le parole di contesto dato il centro:

$$ \mathbb P(w_{t-2}, w_{t-1}, w_{t+1}, w_{t+2} \mid w_t; \mathbf{\theta}) \approx \prod_{j=-m, j \neq 0}^{m} \mathbb P(w_{t+j} \mid w_t; \mathbf{\theta})$$

Questo significa che ogni parola di contesto è indipendente dalle altre data la parola centrale.

## Come si calcola $\mathbb P(w_{t+j}\mid w_t)$?

Dato un centro $w_t$, vogliamo predire la parola di contesto $w_{t+j}$. Questa probabilità è modellata come una distribuzione categorica su tutto il vocabolario $V$.

1. Prendiamo l'embedding della parola centro: se $i$ è l'indice di $w_t$ in $\mathbf{\theta}_W$, consideriamo il vettore riga $\mathbf{\theta}_W^i$ (di dimensione $1 \times |D|$).
2. Calcoliamo i punteggi (logits) per tutte le parole del vocabolario come prodotto scalare tra ogni vettore di contesto in $\mathbf{\theta}_C$ e l'embedding del centro:

   $$
   \underbrace{\mathbf{z}_i}_{|V|\times 1}=\overbrace{\underbrace{\bm{\theta}_C}_{|V|\times D}}^{\text{as context}}\cdot\overbrace{\underbrace{{\bm{\theta}_{W}^i}^T}_{D\times 1}}^{\text{as center}}
   $$

   dove $\mathbf{z}$ è un vettore di dimensione $|V|$, con ogni elemento che rappresenta la similarità (dot product) tra la parola centro e una possibile parola di contesto.

3. Applichiamo la funzione **softmax** ai logits per ottenere una distribuzione di probabilità:

  $$
  \mathbf{p}_i = \text{softmax}(\mathbf{z}_i) = \begin{bmatrix}
  p_1 \\
  \\
  \vdots \\
  \\
  p_{|V|}
  \\[0.45em]
  \end{bmatrix}= \begin{bmatrix}
  \mathbb P(w_{t+j} = \text{`apple`} | w_t = \text{`apricot`}) \\
  \\
  \vdots \\
  \\
  \mathbb P(w_{t+j} = \text{`zucchini`} | w_t = \text{`apricot`})
  \end{bmatrix}
  =  
  \Large\begin{bmatrix}
  \frac{e^{z_1}}{\sum_{i=1}^{|V|} e^{z_{i}}} \\
  \\
  \vdots \\
  \\
  \frac{e^{z_{|V|}}}{\sum_{i=1}^{|V|} e^{z_{i}}}
  \end{bmatrix}
  $$

Così otteniamo la probabilità di ogni parola del vocabolario come contesto dato il centro $w_t$.

**Remark.** L'indice della parola $w_t$ nella matrice $\mathbf{\theta}_W$ è $i$.

## Interpretazione

- $\mathbf{p}$ è una distribuzione di probabilità discreta su $|V|$ parole.
- L'elemento $\mathbb P(w_{t+j} = \text{`tablespoon`} | w_t = \text{`apricot`})$ rappresenta la probabilità che la parola "tablespoon" sia nel contesto della parola "apricot".
- Assumiamo che $\text{`tablespoon`}$ abbia indice $g$ nella matrice $\mathbf{\theta}_C$.
- Il vettore riga $\mathbf{\theta}_C^g$ rappresenta l'embedding di "tablespoon".

## Funzione di perdita (loss)

Per addestrare il modello, abbiamo bisogno di confrontare la distribuzione predetta $\mathbf{p}_i$ con la parola di contesto **reale** osservata nel testo.

- La parola vera di contesto è rappresentata da un vettore **one-hot** $\mathbf{y}$, che è zero per tutte le parole tranne che per l'indice della parola reale (ad esempio "tablespoon").
  
$$
\mathbf{y} = [0, 0, ..., 1, ..., 0]
$$

- La funzione di loss è la **cross-entropy** tra la distribuzione vera e quella predetta:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \mathbf{y}^\top \log \mathbf{p}_i = -\log \mathbb P(w_{t+j} = \text{`tablespoon`} | w_t = \text{`apricot`}; \mathbf{\theta})
$$

In pratica, questa loss penalizza il modello quando la probabilità assegnata alla parola reale di contesto è bassa.

## Forma esplicita della loss

Sostituendo la definizione di $\mathbf{p}_i$:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \log \frac{\exp(\mathbf{\theta}_C^g \cdot {\mathbf{\theta}_W^i}^T)
}{\sum_{v=1}^{|V|} \exp(\mathbf{\theta}_C^v \cdot {\mathbf{\theta}_W^i}^T)}
$$

che si può riscrivere come:

$$
\mathcal{L}(w_{t+j}, w_t; \mathbf{\theta}) = - \underbrace{\mathbf{\theta}_C^g \cdot {\mathbf{\theta}_W^i}^T}_\text{Similarità contesto-parola} + \underbrace{\log \sum_{v=1}^{|V|} \exp(\mathbf{\theta}_C^v \cdot {\mathbf{\theta}_W^i}^T)}_\text{Similarità di tutti gli altri contesti con la stessa parola}
$$

Questa formula evidenzia il trade-off tra massimizzare la similarità centro-contesto della parola corretta e normalizzare le probabilità su tutto il vocabolario.

## Massimizzazione della likelihood su tutta la finestra

Per ogni parola centrale $w_t$, la probabilità congiunta di osservare tutte le parole di contesto nella finestra è:

$$
L(\mathbf{\theta}) = \prod_{j=-m, j \neq 0}^{m} \mathbb P(w_{t+j} | w_t; \mathbf{\theta})
$$

Il nostro obiettivo è trovare i parametri $\mathbf{\theta}$ che massimizzano la likelihood su tutto il corpus, ossia:

$$
\mathbf{\theta}^* = \arg\max_{\mathbf{\theta}} \prod_{t=1}^T \prod_{j=-m, j \neq 0}^m \mathbb P(w_{t+j} | w_t; \mathbf{\theta})
$$

## Minimizzazione della loss totale

Si usa la funzione di perdita negativa del logaritmo della likelihood, che è equivalente a minimizzare la somma della cross-entropy su tutte le parole del corpus:

$$
\mathbf{\theta}^* = \arg\min_{\mathbf{\theta}} \mathcal{L}(\mathbf{\theta}) = -\frac{1}{T} \sum_{t=1}^T \sum_{j=-m, j \neq 0}^m \log \mathbb P(w_{t+j} | w_t; \mathbf{\theta})
$$

Così il modello impara ad associare ad ogni parola centrale i vettori che predicono meglio il suo contesto.

## Riassunto

- Lo Skip-gram con softmax usa due embedding per ogni parola: uno come parola centrale, uno come contesto.
- Il modello prevede la probabilità delle parole di contesto data una parola centrale usando prodotti scalari e softmax.
- La funzione di perdita è la cross-entropy tra la distribuzione predetta e la parola di contesto reale.
- L’ottimizzazione massimizza la probabilità del contesto osservato sul corpus, migliorando gli embedding.

Questo approccio self-supervision permette di apprendere rappresentazioni semantiche delle parole direttamente da grandi quantità di testo non etichettato, ed è la base di modelli di embedding ampiamente usati nel NLP.
