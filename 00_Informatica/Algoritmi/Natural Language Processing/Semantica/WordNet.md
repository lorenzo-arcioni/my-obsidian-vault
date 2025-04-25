# WordNet

> Fonte: [Miller et al., 1990 — WordNet](https://wordnet.princeton.edu/)

## 🧠 Cos'è WordNet?

WordNet è il **lessico computazionale dell’inglese più diffuso**, sviluppato con l’intento di riflettere teorie psicologiche sul funzionamento mentale del linguaggio.  
È strutturato attorno al concetto di **synset** (set di sinonimi), che rappresenta un **concetto**.

## 🧩 Synsets

- Ogni concetto è rappresentato da un **insieme di parole sinonime** → un *synset*.
- Un *word sense* è l’**occorrenza di una parola in un synset**.

Esempio:

$$
Synset: \{car¹_n, auto^1_n, automobile^1_n, machine^4_n, motorcar^1_n\}
$$

→ $machine^1_n$ in questo contesto è il **quarto senso del sostantivo** “machine”.

## 🚗 Esempio: il caso di *car*

Un esempio classico in WordNet è il lemma **car**. Esistono più synset con questo lemma, ognuno relativo a un significato differente:

$$
\begin{align*}
Synset 1: &\{car¹_n, auto^1_n, automobile^1_n, machine^4_n, motorcar^1_n\}\\
Synset 2: &\{car^2_n, railcar_n^1, railway car_n^1, railroad car_n^1\}\\
Synset 3: &\{cable car_n^1, car_n^3\}\\
Synset 4: &\{car^4_n, gondola_n^3\}\\
Synset 5: &\{car_n^5, elevator car_n^1\}\\
\end{align*}
$$

## 📝 Glosses (Definizioni testuali)

WordNet fornisce una definizione testuale per ogni synset, detta **glossa**:

- **Gloss di car¹**:
  > “a 4-wheeled motor vehicle; usually propelled by an internal combustion engine; 'he needs a car to get to work'”

- **Gloss di car²**:
  > “a wheeled vehicle adapted to the rails of railroad; 'three cars had jumped the rails'”

## 🔗 Relazioni semantiche

WordNet codifica diverse **relazioni semantiche tra synset**:

- **Iperonimia (is-a)**  
  → $car^1_n$ is-a $motor vehicle_n^1$

- **Meronimia (has-a)**  
  → $car^1_n$ has-a $car door^1_n$

- **Altre relazioni semantiche**:
  - Entailment
  - Similarità
  - Attributi

## 🧬 Relazioni lessicali

Anche le relazioni tra i *sensi delle parole* sono modellate:

- **Sinonimia**: parole che condividono un synset  
- **Antonimia**: es. $good$ è antonimo di $bad$  
- **Pertainimia**: es. $dental$ pertains to $tooth$  
- **Nominalizzazione / derivazione**: es. $service$ deriva da $serve$

## 🔄 WordNet come Grafo Semantico

WordNet può essere visto come un **grafo**, in cui i nodi sono synset e gli archi sono relazioni semantiche o lessicali.

📌 **Placeholder per immagine**:

```tikz
\documentclass[tikz,border=1cm,dvisvgm]{standalone}
\usepackage{tikz}
\usepackage{xcolor}

\begin{document}

\begin{tikzpicture}[
  every node/.style={font=\small},
  synset/.style={draw, rectangle, inner sep=3pt, minimum height=0.8cm, align=center},
  synset_highlight/.style={draw=red, thick, rectangle, inner sep=3pt, align=center},
  rel/.style={font=\scriptsize, fill=white, inner sep=1pt},
  every picture/.style={
    execute at end picture={
      % Bounding box ampliato del 10% su tutti i lati
      \useasboundingbox (-13,-14) rectangle (11,3);
    }
  }
]

% PRIMA RIGA (posizioni originali mantenute)
\node[synset] (wheeled) at (0,0) {\{wheeled vehicle\}};
\node[synset] (brake) at (6,0) {\{brake\}};

% SECONDA RIGA
\node[synset, minimum width=3.5cm] (wagon) at (-5,-2) {\{wagon, waggon\}};
\node[synset, minimum width=2.5cm] (wheel) at (6,-2) {\{wheel\}};

% TERZA RIGA
\node[synset, minimum width=3cm] (self) at (0,-4) {\{self-propelled vehicle\}};
\node[synset, minimum width=2.5cm] (splasher) at (6,-4) {\{splasher\}};

% QUARTA RIGA
\node[synset, minimum width=3cm] (motor) at (-4,-6) {\{motor vehicle\}};
\node[synset, minimum width=2.5cm] (tractor) at (0,-6) {\{tractor\}};
\node[synset, minimum width=5cm] (locomotive) at (6,-6) {\{locomotive, engine, locomotive engine, railway locomotive\}};

% QUINTA RIGA
\node[synset, minimum width=3cm] (golf) at (-7,-8) {\{golf cart, golfcart\}};
\node[synset_highlight, minimum width=4.5cm] (car) at (0,-8) {\{car, auto, automobile, machine, motorcar\}};
\node[synset_highlight, minimum width=2.5cm] (window) at (6,-8) {\{car window\}};

% SESTA RIGA
\node[synset_highlight, minimum width=3.5cm] (convertible) at (-4,-10) {\{convertible\}};
\node[synset, minimum width=3cm] (airbag) at (0,-10) {\{air bag\}};
\node[synset, minimum width=5cm] (accelerator) at (6,-10) {\{accelerator, accelerator pedal, gas pedal, throttle\}};

% CONNESSIONI IS-A (stesse del codice originale)
\draw[->] (wagon) to[bend right=10] node[rel, above] {is-a} (wheeled);
\draw[->] (self) -- node[rel, right] {is-a} (wheeled);
\draw[->] (motor) to[bend right=20] node[rel, above, sloped] {is-a} (self);
\draw[->] (tractor) -- node[rel, right] {is-a} (self);
\draw[->] (locomotive) to[bend left=20] node[rel, above, sloped] {is-a} (self);
\draw[->] (car) -- node[rel, right] {is-a} (motor);
\draw[->] (golf) -- node[rel, above, sloped] {is-a} (motor);
\draw[->] (convertible) to[bend right=10] node[rel, left] {is-a} (car);

% CONNESSIONI HAS-PART
\draw[->] (wheeled) -- node[rel, above] {has-part} (brake);
\draw[->] (wheeled) to[bend left=10] node[rel, right, sloped] {has-part} (wheel);
\draw[->] (wheeled) to[bend left=20] node[rel, right, sloped] {has-part} (splasher);
\draw[->] (car) -- node[rel, above] {has-part} (window);
\draw[->] (car) -- node[rel, right] {has-part} (airbag);
\draw[->] (car) to[bend right=10] node[rel, above, sloped] {has-part} (accelerator);

% ETICHETTE AGGIUNTIVE
\node[text=orange] (semantictext) at (-5,-1.2) {semantic relation};
\draw[->, orange, thick] (-4,-1.5) -- (-1.5,-5);

\node[text=red] (synsetstxt) at (3,-7.2) {synsets};
\draw[red, thick] (car) -- (window);
\draw[red, thick] (car) -- (convertible);
\draw[red, thick] (car) to[bend right=10] (accelerator);

\end{tikzpicture}

\end{document}
```

## 🌐 WordNet come Rete Semantica

Ma WordNet **non è solo un grafo**: è una **rete semantica vera e propria**.

> Una rete semantica è una rappresentazione strutturata della conoscenza, dove i concetti (synset) sono collegati da relazioni semantiche.

📌 **Esempio di Rete Semantica di WordNet**:  
![Schema rete semantica](https://www.researchgate.net/profile/Mohamed-Menai/publication/281892834/figure/fig1/AS:347228821573632@1459797210842/Example-of-a-semantic-network-in-wordnet_W640.jpg)

## 🌍 WordNet in altre lingue

Sebbene WordNet sia stato originariamente progettato per l’**inglese**, sono stati sviluppati diversi progetti per **adattarlo ad altre lingue**:

- **MultiWordNet**: WordNet italiano, allineato semanticamente con l’originale inglese.
- **EuroWordNet**: versioni per più lingue europee, con una struttura concettuale condivisa.
- **BabelNet**: estensione multilingue che unisce WordNet e Wikipedia.

> Queste versioni multilingue permettono confronti e inferenze semantiche cross-lingua, supportando applicazioni come machine translation, question answering e semantic search.

## ⚠️ Limiti di WordNet

Nonostante la sua utilità, WordNet presenta alcuni **limiti strutturali e concettuali**:

- 🏗️ **Costruito manualmente**: la creazione e l’aggiornamento dei synset avviene tramite lavoro umano → costoso e lento.
- 🔍 **Copertura limitata**: include soprattutto parole comuni e ben definite; mancano molti termini tecnici, neologismi, slang o forme idiomatiche.
- 🌐 **Poche lingue disponibili**: solo alcune lingue sono coperte da versioni ufficiali; molte lingue del mondo non hanno una risorsa WordNet completa.
- 📚 **Rigidità strutturale**: le relazioni sono fisse e gerarchiche; difficile modellare ambiguità, polisemia o uso contestuale.
- 🔄 **Non adatto a tutte le applicazioni**: ad esempio, in ambiti come sentiment analysis o text classification, approcci basati su word embeddings o transformer offrono prestazioni migliori.

## 📌 Conclusione

WordNet rappresenta una **risorsa lessicale fondamentale** per il trattamento automatico del linguaggio, con applicazioni importanti in analisi semantica, disambiguazione, IR e NLP in generale.

Tuttavia, le sue **limitazioni strutturali** e la **copertura ristretta** hanno spinto la comunità a esplorare **approcci distribuiti** (es. Word2Vec, GloVe, BERT) e **reti semantiche più ampie e aggiornate** (es. BabelNet, ConceptNet).

> 🧠 WordNet resta una pietra miliare nello studio del significato linguistico e nella costruzione di sistemi intelligenti basati sulla semantica.