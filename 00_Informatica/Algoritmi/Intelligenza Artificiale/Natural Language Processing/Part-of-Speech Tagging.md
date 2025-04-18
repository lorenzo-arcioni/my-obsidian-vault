# Part-of-Speech (PoS) Tagging

## Definizione

Il **Part-of-Speech (PoS) Tagging**, o **etichettatura delle categorie grammaticali**, è il processo di assegnazione a ciascuna parola di un testo un'etichetta grammaticale che indica la sua funzione sintattica, come **sostantivo**, **verbo**, **aggettivo**, **avverbio**, ecc.

Questa tecnica è un passo fondamentale nell'elaborazione del linguaggio naturale (NLP), perché consente ai sistemi informatici di comprendere la struttura grammaticale di una frase, facilitando operazioni più complesse come l'analisi sintattica, la traduzione automatica, l'estrazione di informazioni o la generazione di testo.

Il PoS tagging può essere effettuato:
- in modo **rule-based**, con l'uso di dizionari e regole grammaticali;
- oppure con metodi **statistici o basati su machine learning**, che apprendono dai corpora annotati.

Nelle prossime sezioni approfondiremo i principali metodi, esempi pratici e librerie utili.

## Universal PoS Tagset

Per favorire l'interoperabilità tra linguaggi e strumenti NLP, è stato definito un set di **17 tag universali**, adottato da risorse come Universal Dependencies. Questi tag rappresentano una categorizzazione "coarse-grained", cioè meno dettagliata ma più generalizzabile rispetto a quelli specifici dei singoli treebank.

> "...this set of coarse-grained POS categories is defined operationally, by collapsing language (or treebank) specific distinctions to a set of categories that exists across all languages..."

### I 17 Universal PoS Tags:

- **VERB** – verbi (tutti i tempi e modi)
- **NOUN** – nomi comuni e propri
- **PROPN** – nomi propri
- **PRON** – pronomi
- **AUX** – ausiliari
- **ADJ** – aggettivi
- **ADV** – avverbi
- **ADP** – adposizioni (preposizioni e postposizioni)
- **INTJ** – interiezioni (esclamazioni)
- **CCONJ** – congiunzioni coordinanti (e, o, ma)
- **SCONJ** – congiunzioni subordinanti (che, se, quando)
- **DET** – determinanti
- **NUM** – numerali cardinali
- **PART** – particelle o altre parole funzionali
- **PUNCT** – punteggiatura
- **SYM** – simboli (es. \$, sostituibili con "dollaro")
- **X** – altri (parole straniere, errori, abbreviazioni)

Tuttavia, dato che ogni lingua possiede le proprie specificità grammaticali, nei diversi **treebank** (cioè corpora linguistici annotati) vengono spesso usati tag più dettagliati o personalizzati. Il sistema di tag **universali** serve quindi a creare un livello comune e semplificato, utile per:

- il confronto tra lingue diverse;
- la portabilità di modelli NLP multilingua;
- la generalizzazione nei task di apprendimento automatico;
- l’integrazione con risorse linguistiche come *Universal Dependencies*.

Questo compromesso tra granularità e compatibilità permette agli strumenti NLP di operare efficacemente su più lingue con un set standardizzato di categorie grammaticali.


## Esempio di Frase con PoS Tagging

Per chiarire l'applicazione pratica del PoS tagging, si può considerare la seguente frase inglese:

> **The oboist Heinz Holliger has taken a hard line about the problems.**

| Token       | Tag originale | Tag universale |
|-------------|---------------|----------------|
| The         | DT            | DET            |
| oboist      | NN            | NOUN           |
| Heinz       | NNP           | NOUN           |
| Holliger    | NNP           | NOUN           |
| has         | VBZ           | VERB           |
| taken       | VBN           | VERB           |
| a           | DT            | DET            |
| hard        | JJ            | ADJ            |
| line        | NN            | NOUN           |
| about       | IN            | ADP            |
| the         | DT            | DET            |
| problems    | NNS           | NOUN           |
| .           | .             | PUNCT          |

Questa trasformazione consente di uniformare l’analisi linguistica e migliorare la compatibilità tra corpus e strumenti NLP in lingue diverse.

<a href="https://universaldependencies.org/u/pos/">Qui</a> è possibile trovare un elenco completo dei tag universali e il loro mapping nelle diverse lingue.

## 🔄 Ambiguità lessicale nel PoS Tagging

Nel processo di PoS Tagging, una delle principali difficoltà è rappresentata dall’ambiguità: **la stessa parola può appartenere a categorie grammaticali differenti**, a seconda del contesto.

### 🧠 Esempio della parola "well"

La parola _well_ è un classico esempio di ambiguità grammaticale in inglese. Ecco come può essere interpretata in frasi diverse:

| Frase                                         | Categoria grammaticale | Tag  |
|----------------------------------------------|-------------------------|------|
| _How to increase the water pressure from a well?_ | Nome (pozzo)            | `NOUN` |
| _Tears well in her eyes_                     | Verbo (sgorgare)        | `VERB` |
| _The wound is nearly well_                   | Aggettivo (guarito)     | `ADJ` |
| _The party went well_                        | Avverbio (bene)         | `ADV` |

#### 🗂️ Schema concettuale dell’ambiguità (esempio con "well")

```plaintext
Input: "How to increase the well"

       [ How ]   [ to ]   [ increase ]   [ the ]   [ well ]
          ↓         ↓          ↓           ↓          ↓
                                 PoS Tagger
                                       ↓
           Output:  ADV  |  PART  |  VERB  |  DET  |  ???
                                                   ↳ NOUN
                                                   ↳ ADV
                                                   ↳ ADJ
```

🧩 La parola "well" ha **più possibili etichette** (`NOUN`, `ADV`, `ADJ`), e il sistema di tagging deve scegliere la più adatta **in base al contesto**.

🔍 **Conclusione**: il contesto è fondamentale per disambiguare correttamente il significato.

### 📊 Frequenza dell’ambiguità: Brown Corpus

L’ambiguità non è un fenomeno raro. Analizzando il **Brown Corpus**, un corpus linguistico ampiamente utilizzato per l’inglese, si osservano i seguenti dati:

| Misura                          | Percentuale |
|---------------------------------|-------------|
| Tipi di parola ambigui (types)  | 11.5%       |
| Token ambigui (nei testi reali) | 40%         |

💡 **Interpretazione**: anche se solo una piccola parte dei lemmi è ambigua, queste parole compaiono molto spesso nei testi, rendendo l’ambiguità un problema ricorrente nei corpus reali.

```tikz
\usepackage{tikz}
\usetikzlibrary{arrows.meta, positioning, shapes.geometric}

\begin{document}
\begin{tikzpicture}[
    node distance=3cm,
    scale=1.2,
    box/.style={
        draw, 
        rectangle, 
        minimum width=3cm, 
        minimum height=1.5cm, 
        align=center, 
        rounded corners=3pt, 
        thick
    },
    arrow/.style={->, >=Stealth, thick}
]

% Nodi
\node[box] (A) {Sequence of words};
\node[box, right=of A] (B) {Tagset};
\node[box, right=of B] (C) {PoS};
\node[box, right=of C] (D) {Tagger};
\node[box, right=of D] (E) {PoS-tagged\\sequence};

% Frecce
\draw[arrow] (A) -- (B);
\draw[arrow] (B) -- (C);
\draw[arrow] (C) -- (D);
\draw[arrow] (D) -- (E);

\end{tikzpicture}
\end{document}
```

## Rule-based PoS tagging (dagli anni '60)

Il PoS tagging basato su regole è uno dei primi approcci sviluppati per l’assegnazione delle categorie grammaticali, risalente agli anni '60. Si basa su un insieme di **regole linguistiche scritte a mano** che utilizzano informazioni **lessicali e contestuali** per determinare il ruolo grammaticale di ogni parola in una frase.

### Componenti principali

- Un **lessico**: contiene le parole e le possibili etichette grammaticali associate.
- Un insieme di **regole di disambiguazione**: scritte da linguisti per risolvere le ambiguità in base al contesto sintattico.

Le regole hanno spesso la forma:
> *Se una parola può essere sia un nome che un verbo, ma segue un determinante, allora è un nome.*

### Esempio

Frase:
> *Time flies like an arrow.*

- Lessico:
  - Time → Nome / Verbo  
  - flies → Nome / Verbo  
  - like → Verbo / Preposizione  

- Regole:
  - *Se la prima parola è maiuscola e si trova all’inizio della frase, preferisci Nome.*
  - *Se una parola segue un nome ed è compatibile come verbo, mantieni il verbo.*

Etichettatura risultante:
> Time/**Nome** flies/**Verbo** like/**Preposizione** an/**Det** arrow/**Nome**

### Pro e contro

✅ Funziona bene in **domini specifici**  
❌ Richiede una **scrittura intensiva di regole** da parte di esperti  
❌ È **poco adattabile** a nuovi testi o domini

## Part-of-Speech Tagging Stocastico

A partire dagli anni '70, il **PoS tagging** ha iniziato a essere affrontato anche con **metodi probabilistici**, cioè **stocastici**.

L'idea alla base è semplice: usare i **modelli di Markov nascosti (HMM)** per selezionare la **sequenza di etichette grammaticale più probabile** data una sequenza di parole.

Formalmente, il problema può essere formulato come segue:

$$
\hat{t}_1^n = \underset{t_1^n \in \text{Tagset}^n}{\arg\max} \ P(t_1^n \mid w_1^n)
$$

In altre parole, cerchiamo la sequenza di tag $t_1^n$ che **massimizza la probabilità condizionata** dato l'input $w_1^n$, ovvero la sequenza di parole osservate.

### Teorema di Bayes

Per calcolare questa probabilità, possiamo ricorrere al **teorema di Bayes**:

$$
P(x \mid y) = \frac{P(y \mid x) \cdot P(x)}{P(y)}
$$

Applicandolo al nostro problema:

$$
P(t_1^n \mid w_1^n) = \frac{P(w_1^n \mid t_1^n) \cdot P(t_1^n)}{P(w_1^n)}
$$

Poiché $P(w_1^n)$ è costante rispetto ai tag $t_1^n$, possiamo ignorarlo nel calcolo dell'$\arg\max$. Otteniamo quindi:

$$
\hat{t}_1^n = \underset{t_1^n \in \text{Tagset}^n}{\arg\max} \ \frac{P(w_1^n \mid t_1^n) \cdot P(t_1^n)}{P(w_1^n)} \approx \underset{t_1^n \in \text{Tagset}^n}{\arg\max} P(w_1^n \mid t_1^n) \cdot P(t_1^n)
$$

Dove:
- $P(w_1^n \mid t_1^n)$ è la **verosimiglianza** (*likelihood*): probabilità di osservare le parole date le etichette.
- $P(t_1^n)$ è la **probabilità a priori** (*prior*) delle etichette grammaticali.

In pratica, cerchiamo la sequenza di PoS tag che **spiega meglio le parole osservate**, tenendo anche conto di quanto sia **probabile a priori** quella sequenza di tag. Ma come calcolare queste probabilità?

### Assunzione 1: La parola dipende solo dal suo PoS tag

Per semplificare il calcolo della **verosimiglianza** $P(w_1^n \mid t_1^n)$, si fa la seguente assunzione:

> Ogni parola $w_i$ dipende solo dal suo corrispondente tag $t_i$.

Formalmente:

$$
P(w_1^n \mid t_1^n) = \prod_{i=1}^{n} P(w_i \mid t_i)
$$

Questa è un’**assunzione di indipendenza condizionata**: ci permette di calcolare la probabilità delle parole in modo **locale**, tag per tag, invece che sull'intera sequenza.

### Assunzione 2: Ogni tag dipende solo dal tag precedente

Per semplificare il calcolo della **prior** $P(t_1^n)$, si assume che ogni tag dipenda **solo dal tag precedente**:

> Questo è noto come **bigram model** o **Markov assumption di primo ordine**.

Formalmente:

$$
P(t_1^n) = \prod_{i=1}^{n} P(t_i \mid t_{i-1})
$$

Questo significa che la sequenza dei tag viene modellata come una **catena di Markov**: non consideriamo tutta la storia passata dei tag, ma solo quello immediatamente precedente.

### Combinazione delle due assunzioni

Applicando insieme le due assunzioni precedenti otteniamo:

$$
P(w_1^n \mid t_1^n) \cdot P(t_1^n) = \prod_{i=1}^{n} P(w_i \mid t_i) \cdot P(t_i \mid t_{i-1})
$$

Questo prodotto è il cuore del PoS tagging stocastico: stimiamo la **probabilità congiunta** della sequenza parole-tag usando stime locali.

### Stima delle probabilità dai corpora

Grazie a **corpora annotati** (es. Penn Treebank, Universal Dependencies), possiamo stimare le due componenti:

- **Probabilità di emissione** (likelihood):  
  $$
  P(w_i \mid t_i) = \frac{\text{conteggio}(t_i, w_i)}{\text{conteggio}(t_i)}
  $$

- **Probabilità di transizione** (prior):  
  $$
  P(t_i \mid t_{i-1}) = \frac{\text{conteggio}(t_{i-1}, t_i)}{\text{conteggio}(t_{i-1})}
  $$

Queste stime si basano sulla **frequenza relativa** osservata nei corpus PoS-annotati.

### Come trovare la sequenza di tag ottimale?

Ora abbiamo:
- le probabilità $P(w_i \mid t_i)$ → emissione
- le probabilità $P(t_i \mid t_{i-1})$ → transizione

Ma dobbiamo trovare la **sequenza di tag $\hat{t}_1^n$** che **massimizza il prodotto** di questi termini.

Questo è un problema classico di **decodifica in modelli di Markov nascosti**.

### Utilizzo degli Hidden Markov Models

Per risolvere il problema del PoS tagging — ovvero associare la sequenza di parole a una sequenza di tag grammaticale — si può modellare il processo come un **Hidden Markov Model (HMM)**.

Un HMM è un modello statistico in cui:
- Esiste una **sequenza nascosta di stati** (nel nostro caso, i **tag** grammaticali).
- Ogni stato emette un'**osservazione** (nel nostro caso, una **parola** del testo).
- Le transizioni tra stati e le emissioni sono regolate da **probabilità**.

#### Due assunzioni fondamentali di un HMM di primo ordine

1. **Assunzione di Markov**:  
   Ogni stato (tag) dipende solo dallo **stato precedente**:
   $$
   P(t_i \mid t_1^{i-1}) \approx P(t_i \mid t_{i-1})
   $$

2. **Assunzione di emissione indipendente**:  
   Ogni parola dipende solo dal **tag corrente**, non dagli altri tag o parole:
   $$
   P(w_i \mid t_1^n, w_1^{i-1}) \approx P(w_i \mid t_i)
   $$

Applicando queste due assunzioni otteniamo la formula:
$$
\hat{t}_1^n = \arg\max_{t_1^n \in Tagset^n} \prod_{i=1}^n P(w_i \mid t_i) \cdot P(t_i \mid t_{i-1})
$$

[[Hidden Markov Models|Qui]] è diposnibile una descrizione dettagliata degli HMM.

---

### Esempio: Jason Eisner task (2002)

Un esempio classico per spiegare gli HMM è il **"Jason Eisner task"**:

> Jason tiene un diario con il numero di gelati mangiati ogni giorno dell'estate.
> Il suo obiettivo è ricostruire, a partire da questi numeri, se ogni giorno era caldo (**H**) o freddo (**C**).

Formalmente:
- La sequenza **osservata** $O$ è il numero di gelati mangiati ogni giorno.
- La sequenza **nascosta** $Q$ è la condizione meteorologica (**H**ot o **C**old).
- Ogni giorno Jason sceglie quanti gelati mangiare **in base al meteo**.
- L’obiettivo è **inferire la sequenza di stati** che ha prodotto le osservazioni.

Questo è del tutto analogo al PoS tagging:
- Le **osservazioni** sono le parole del testo.
- Gli **stati nascosti** sono i tag grammaticali.
- L’obiettivo è inferire la **sequenza di tag più probabile** dato il testo osservato.

---

### Riassunto dei componenti di un HMM per il PoS tagging

| Componente | Significato NLP | Simbolo | Come si calcola |
|------------|------------------|---------|------------------|
| Stati $Q$ | Tag PoS | $t_i$ | Predefiniti nel tagset |
| Osservazioni $O$ | Parole del testo | $w_i$ | Input della frase |
| Transizione | $P(t_i \mid t_{i-1})$ | Tag → Tag | Frequenze nei corpora |
| Emissione | $P(w_i \mid t_i)$ | Tag → Parola | Frequenze nei corpora |
| Iniziale $\pi(t_1)$ | Probabilità iniziale di ogni tag | $P(t_1)$ | Conta quanti tag iniziali in corpus |

---

### Obiettivo finale

Data una frase (sequenza di parole), vogliamo trovare:

$$
\hat{t}_1^n = \arg\max_{t_1^n} P(w_1^n \mid t_1^n) \cdot P(t_1^n)
$$

E la soluzione più efficiente per trovare questa sequenza è l’**algoritmo di Viterbi**, che vedremo nella prossima sezione.


#### Esempio pratico


Supponiamo di avere il seguente **corpus annotato** (PoS-tagged):

```
the/DT dog/NN sleeps/VBZ  
the/DT cat/NN eats/VBZ  
dogs/NNS bark/VBP  
cats/NNS sleep/VBP  
a/DT dog/NN barks/VBZ  
```

---

### 1. Insieme dei tag e parole

- **Tag (Q)** = { DT, NN, NNS, VBZ, VBP }
- **Parole (O)** = { the, a, dog, dogs, cat, cats, sleeps, eats, barks, bark, sleep }

---

### 2. Probabilità di transizione

Annotiamo le transizioni tra tag (incluso START):

| Transizione        | Conteggio | Probabilità |
|--------------------|-----------|-------------|
| START → DT         | 3         | 3/5         |
| START → NNS        | 2         | 2/5         |
| DT → NN            | 3         | 1.0         |
| NN → VBZ           | 3         | 1.0         |
| NNS → VBP          | 2         | 1.0         |

---

### 3. Probabilità di emissione

#### DT
| Parola | Conteggio | Probabilità |
|--------|-----------|-------------|
| the    | 2         | 2/3         |
| a      | 1         | 1/3         |

#### NN
| Parola | Conteggio | Probabilità |
|--------|-----------|-------------|
| dog    | 2         | 2/3         |
| cat    | 1         | 1/3         |

#### NNS
| Parola | Conteggio | Probabilità |
|--------|-----------|-------------|
| dogs   | 1         | 1/2         |
| cats   | 1         | 1/2         |

#### VBZ
| Parola | Conteggio | Probabilità |
|--------|-----------|-------------|
| sleeps | 1         | 1/3         |
| eats   | 1         | 1/3         |
| barks  | 1         | 1/3         |

#### VBP
| Parola | Conteggio | Probabilità |
|--------|-----------|-------------|
| bark   | 1         | 1/2         |
| sleep  | 1         | 1/2         |

---

### 4. Rappresentazione TikZ del modello HMM

```tikz
\usepackage{tikz}
\usetikzlibrary{arrows.meta, positioning, shapes.multipart}

\begin{document}

\begin{tikzpicture}[
  ->, >=Stealth,
  every node/.style={font=\small},
  state/.style={circle, draw, minimum size=1.2cm},
  box/.style={rectangle, draw, fill=blue!10, align=left, minimum width=3.2cm},
  ]

% Nodes (states)
\node[state] (DT) {DT};
\node[state, right=3cm of DT] (NN) {NN};
\node[state, right=3cm of NN] (VBZ) {VBZ};
\node[state, below=3cm of DT] (NNS) {NNS};
\node[state, right=3cm of NNS] (VBP) {VBP};
\node[circle, draw, minimum size=0.8cm, left=2cm of DT] (START) {START};

% Transitions
\path (START) edge node[above] {3/5} (DT);
\path (START) edge node[left] {2/5} (NNS);
\path (DT) edge node[above] {1.0} (NN);
\path (NN) edge node[above] {1.0} (VBZ);
\path (NNS) edge node[above] {1.0} (VBP);

% Emission boxes
\node[box, below=1.5cm of DT] (B_DT) {
  $P(\text{the} \mid DT) = \frac{2}{3}$\\
  $P(\text{a} \mid DT) = \frac{1}{3}$
};

\node[box, below=1.5cm of NN] (B_NN) {
  $P(\text{dog} \mid NN) = \frac{2}{3}$\\
  $P(\text{cat} \mid NN) = \frac{1}{3}$
};

\node[box, below=1.5cm of VBZ] (B_VBZ) {
  $P(\text{sleeps} \mid VBZ) = \frac{1}{3}$\\
  $P(\text{eats} \mid VBZ) = \frac{1}{3}$\\
  $P(\text{barks} \mid VBZ) = \frac{1}{3}$
};

\node[box, below=1.5cm of NNS] (B_NNS) {
  $P(\text{dogs} \mid NNS) = \frac{1}{2}$\\
  $P(\text{cats} \mid NNS) = \frac{1}{2}$
};

\node[box, below=1.5cm of VBP] (B_VBP) {
  $P(\text{bark} \mid VBP) = \frac{1}{2}$\\
  $P(\text{sleep} \mid VBP) = \frac{1}{2}$
};

% Emission connections (dashed)
\draw[dashed] (DT) -- (B_DT);
\draw[dashed] (NN) -- (B_NN);
\draw[dashed] (VBZ) -- (B_VBZ);
\draw[dashed] (NNS) -- (B_NNS);
\draw[dashed] (VBP) -- (B_VBP);

\end{tikzpicture}

\end{document}
```

---

Questa rappresentazione è un **HMM completo** per un compito PoS più realistico.

Vuoi anche un esempio di **decodifica con algoritmo di Viterbi** su una frase nuova come `"the dog eats"` o `"dogs sleep"`?

#### Conclusione

Questo è un semplice esempio pratico che mostra **come costruire un HMM da un corpus annotato**, calcolare tutte le probabilità, e disegnare il grafo corrispondente con TikZ. Nella realtà si lavora su tagset e vocabolari molto più grandi, ma il concetto è lo stesso.

Se vuoi posso anche implementarlo in Python o calcolare la sequenza più probabile con Viterbi!