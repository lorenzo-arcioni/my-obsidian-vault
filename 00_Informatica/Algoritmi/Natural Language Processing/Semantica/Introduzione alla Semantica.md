# Introduzione alla Semantica

La **semantica** è la parte della linguistica che studia il significato delle parole, delle frasi e dei testi. Essa si occupa di come le parole rappresentano concetti e oggetti nel mondo e come si combinano per creare significati complessi. Una delle sfide principali della semantica è la relazione tra il linguaggio e il mondo esterno, che viene esplorata attraverso diverse teorie, tra cui la teoria del **triangolo del significato**.

## Il Triangolo del Significato

Il **triangolo del significato** è una rappresentazione grafica che mostra la relazione tra tre concetti chiave nella semantica:

1. **Oggetto (o riferimento)**: l'oggetto che una parola rappresenta nel mondo reale o immaginato.
2. **Simbolo (o espressione)**: la forma linguistica della parola, la sequenza di suoni o lettere che usiamo per designare un concetto.
3. **Concetto**: la rappresentazione mentale che abbiamo di un oggetto.

Questi tre elementi sono legati in modo complesso. Il simbolo (la parola) rimanda a un concetto che, a sua volta, si riferisce a un oggetto o un evento nel mondo esterno. Il triangolo dimostra che il significato di una parola non è solo una relazione diretta tra la parola e l'oggetto, ma dipende anche dalle percezioni e interpretazioni mentali degli individui.

```tikz
\usepackage{tikz}
\documentclass[tikz,border=3.14mm]{standalone}
\begin{document}
\begin{tikzpicture}
    % Definisce i nodi
    \node (simbolo) at (0, 0) {Simbolo};
    \node (concetto) at (4, 4) {Concetto};
    \node (oggetto) at (8, 0) {Oggetto};
    
    % Aggiungi le frecce
    \draw[->] (simbolo) -- (concetto);
    \draw[->] (concetto) -- (oggetto);
    \draw[->] (oggetto) -- (simbolo);
\end{tikzpicture}
\end{document}
```
Questa rappresentazione mostra come i concetti di "simbolo", "concetto" e "oggetto" sono interconnessi, con ognuno che influenza e media l'altro.

### Analisi del Significato della Parola "Dog"

Per comprendere meglio il funzionamento del **Triangolo del Significato** applicato a una parola comune come **"dog"** (cane), esamineremo come i tre componenti interagiscono: il **simbolo**, il **concetto** e l'**oggetto**.

1. **Simbolo**: Il termine **"dog"** (la parola scritta o pronunciata) è il simbolo linguistico che utilizziamo per riferirci a un concetto.
2. **Concetto**: Quando sentiamo o leggiamo la parola **"dog"**, la nostra mente attiva un'immagine o una rappresentazione mentale di un cane, che può variare da individuo a individuo, ma solitamente include caratteristiche generali come "animale a quattro zampe", "mammifero", "domestico", "compagno dell'uomo", ecc.
3. **Oggetto**: Il **"dog"** nel mondo reale si riferisce a un animale concreto, che appartiene alla specie canina. È un essere vivente che esiste fisicamente e può essere osservato e toccato.

## Semantica Sintattica e Analisi Semantica

### Analisi Sintattica e Semantica

La **sintassi** riguarda la struttura grammaticale delle frasi, cioè come le parole sono organizzate e collegate tra loro per formare frasi coerenti. La **semantica**, d'altra parte, si occupa di come i significati sono associati a queste strutture. Un'importante area di studio è come la sintassi può guidare l'interpretazione semantica, un processo noto come **analisi semantica sintattica**.

In un'analisi semantica sintattica, si esamina come le strutture grammaticali (come soggetto, verbo e complemento) siano legate ai significati. Ad esempio, se prendiamo la frase:

**"Book the flight to Houston"**

Questa frase contiene un verbo ("book"), un oggetto diretto ("flight") e una destinazione ("Houston"). La sintassi della frase guida l'interpretazione semantica, che implica che l'azione descritta dal verbo riguarda l'atto di prenotare un volo verso una destinazione specifica.

### Attacchi Semantici (Semantic Attachments)

In un'analisi semantica, gli **attacchi semantici** si riferiscono a come i significati vengono "attaccati" o associati alle diverse parti di una frase. In altre parole, come la sintassi di una frase guida l'interpretazione dei singoli elementi. Prendiamo ad esempio la frase **"Book the flight to Houston"**.

- **"Book"** è un verbo che indica l'azione di prenotare.
- **"The flight"** è il complemento oggetto che si riferisce all'entità che viene prenotata, ovvero il volo.
- **"To Houston"** è un complemento di luogo che specifica la destinazione.

La **sintassi** della frase è chiara: c'è un verbo che rappresenta l'azione, un oggetto che riceve l'azione e una destinazione che completa il significato. L'interpretazione semantica dipende da come i vari componenti della frase sono "attaccati" alla loro funzione nel mondo.

### Dal simbolo al Significato

Quando un parlante sente o legge la frase **"Book the flight to Houston"**, il significato emerge dalla combinazione tra il simbolo (la parola "book", "flight", "Houston") e il contesto di riferimento (come l'idea di prenotare un volo). Il processo semantico è influenzato dalla sintassi che lega insieme questi elementi e costruisce una rappresentazione coerente del significato.

#### Esempio di Analisi Sintattica e Semantica:

1. **Sintassi**:
   - "Book" è il verbo (azione).
   - "The flight" è il complemento oggetto (ciò che è prenotato).
   - "To Houston" è il complemento di destinazione (dove si dirige il volo).
   
2. **Semantica**:
   - **"Book"** implica l'atto di prenotare qualcosa.
   - **"The flight"** è l'entità che è soggetta a questo atto (un volo).
   - **"To Houston"** fornisce la destinazione del volo, che è un luogo geografico.

Questo esempio evidenzia come la struttura sintattica della frase influenzi e guidi la comprensione semantica.

### Sintassi e Semantica nella Pratica

Quando analizziamo frasi più complesse o ambigue, vediamo che la sintassi gioca un ruolo fondamentale nel determinare come i significati vengano strutturati. Ad esempio, la differenza tra le frasi **"I saw the man with the telescope"** e **"I saw the man with a telescope"** è data dal diverso significato che assumono in base alla struttura sintattica. In entrambe le frasi, "I saw the man" è una struttura simile, ma l'elemento "with the telescope" può essere interpretato in modi diversi a seconda che si tratti di uno strumento in possesso della persona che ha visto o della persona stessa che viene vista con lo strumento.

### Problema della molteplicità degli alberi di parsing
- **Assunzione**: Si assume di avere abbastanza conoscenza su uno specifico esempio e il suo albero di parsing.
- **Problema fondamentale**:  
  > Esiste un numero infinito di esempi e di alberi di parsing possibili!
  
  Questo rende impossibile gestire la semantica enumerando manualmente ogni caso singolo.

### Formalismo finito: una soluzione già conosciuta
- Abbiamo già affrontato un problema simile nella definizione di un linguaggio:
  - **Non** enumeriamo tutte le stringhe del linguaggio.
  - Invece, utilizziamo un **formalismo finito**, come una [[Grammatiche Context-free|grammatica libera dal contesto (CFG)]], per generare tutte le stringhe valide.
- **Estensione all'analisi semantica**:
  - Possiamo applicare lo stesso approccio alla semantica.
  - Associamo un **significato** (semantica) a ciascuna produzione grammaticale.
- **Ipotesi "Rule-to-Rule"**:
  > Ogni regola sintattica ha associata una regola semantica che specifica come calcolare il significato della struttura corrispondente.

### Estensione delle CFG con allegati semantici

Possiamo estendere le grammatiche libere dal contesto (CFG) aggiungendo "allegati semantici" (semantic attachments).

Una produzione arricchita avrà la forma:

$$
A \rightarrow \beta_1 \, \beta_2 \, \ldots \, \beta_n \; \{ f(\beta_1.sem, \ldots, \beta_n.sem) \}
$$

dove:
- $A$ è un simbolo non terminale.
- $\beta_i$ sono simboli (terminali o non terminali) della produzione.
- $f$ è una funzione che combina le semantiche dei sottoelementi per determinare la semantica dell'intera produzione.

### Funzioni di allegato semantico
**Che cosa possiamo allegare alle regole delle CFG?**
- La funzione $f$ può essere un frammento di programma che:
  - Calcola l'integrazione semantica in fase di analisi bottom-up.
  - I risultati semantici intermedi vengono **memorizzati** nei non terminali.
- È importante ricordare:
  - **Lex** e **Yacc** permettono di associare codice eseguibile ai parsing rules.

**Limiti pratici**:
- Di solito utilizziamo espressioni logiche piuttosto che codice arbitrario.
- Questo solleva nuove domande:
  - Come possiamo progettare grammatiche in grado di produrre programmi o formule semantiche?

### Formalismo suggerito: Logica del Primo Ordine (FOL)

Una delle opzioni principali è adottare la **Logica del Primo Ordine (First-Order Logic, FOL)** per esprimere i significati.

Breve ripasso dei concetti base della FOL:

- **Termini**:
  
    - Costanti
    - Variabili
    - Funzioni applicate ai termini
- **Formule atomiche**:
  
    - Predicati applicati ai termini
- **Connettivi logici**:
  
    - $\land$ (and), $\lor$ (or), $\neg$ (not), $\rightarrow$ (implica), $\leftrightarrow$ (equivalente)
- **Quantificatori**:
  
    - $\forall$ (per ogni)
    - $\exists$ (esiste)

> **Nota**: La scelta di utilizzare la FOL permette di rappresentare la semantica in modo strutturato e manipolabile logicamente, facilitando il ragionamento automatico.

#### Produzione della FOL:

$$
\begin{aligned}
\text{Formula} \quad &\rightarrow \qquad \text{AtomicFormula} \\
&\quad\quad\; | \quad \text{Formula Connective Formula} \\
&\quad\quad\; | \quad \text{Quantifier Variable Formula} \\
&\quad\quad\; | \quad \neg \text{Formula} \\
&\quad\quad\; | \quad (\text{Formula}) \\[10pt]

\text{AtomicFormula} \quad &\rightarrow \quad \text{Predicate}(Term, \ldots) \\[10pt]

\text{Term} \quad &\rightarrow \quad \text{Function}(Term, \ldots) \\
&\quad\quad\; | \quad \text{Constant} \\
&\quad\quad\; | \quad \text{Variable} \\[10pt]

\text{Connective} \quad &\rightarrow \quad \land \quad | \quad \lor \quad | \quad \Rightarrow \\[10pt]

\text{Quantifier} \quad &\rightarrow \quad \forall \quad | \quad \exists \\[10pt]

\text{Constant} \quad &\rightarrow \quad A \quad | \quad VegetarianFood \quad | \quad Maharani \quad \ldots \\[10pt]

\text{Variable} \quad &\rightarrow \quad x \quad | \quad y \quad | \quad \ldots \\[10pt]

\text{Predicate} \quad &\rightarrow \quad Serves \quad | \quad Near \quad | \quad \ldots \\[10pt]

\text{Function} \quad &\rightarrow \quad LocationOf \quad | \quad CuisineOf \quad | \quad \ldots
\end{aligned}
$$


### Esempi di rappresentazione semantica in FOL

- **La posizione de "Le Scalette" è Nemi**  
  $$
  LocationOf(LeScalette, Nemi)
  $$

- **"Le Scalette" è un ristorante e si trova a Nemi**  
  $$
  Restaurant(LeScalette) \land LocationOf(LeScalette, Nemi)
  $$

- **Esiste un ristorante a Nemi?**  
  $$
  \exists x (Restaurant(x) \land LocationOf(x, Nemi))
  $$

- **Tutte le pizzerie servono pizze**  
  $$
  \forall x (Pizzeria(x) \Rightarrow Serves(x, Pizza))
  $$


> **Nota**: L'uso della FOL consente di esprimere relazioni complesse tra oggetti in modo preciso e permette l'applicazione di tecniche di inferenza automatica basate sulla logica.

#### Limiti pratici della FOL per NLP
La **Logica del Primo Ordine (FOL)** è utile per rappresentare significati precisi, ma ha diversi limiti quando si applica al linguaggio naturale:

- **Ambiguità**: FOL non gestisce bene i **doppi significati**: serve scrivere più versioni logiche e non sa scegliere quella corretta senza contesto.
- **Mancanza di contesto e pragmatica**: FOL rappresenta solo il **significato letterale**, ignorando:

    - tono
    - intento (richiesta, domanda, ecc.)
    - conoscenza implicita

      Esempio:  
      > "Puoi passarmi il sale?"

      In FOL è una domanda sulla capacità, non una richiesta.

- **Complessità computazionale**: Le inferenze in FOL possono essere lente o costose su testi reali.  
Nell’NLP moderno, servono risposte rapide e flessibili.

### **Lambda Calcolo per NLP**  
Il **lambda calcolo** è un formalismo utilizzato per rappresentare funzioni e applicazioni funzionali in modo conciso. In NLP, il lambda calcolo permette di **formalizzare il significato** delle parole e delle frasi come **funzioni** che possono essere applicate a argomenti per produrre significati complessi.  

Quando lo colleghiamo alla **Logica del Primo Ordine (FOL)**, possiamo vedere come il lambda calcolo agisca come una **potente estensione** della FOL. La FOL fornisce un linguaggio formale per rappresentare le relazioni logiche e le strutture tra entità, mentre il lambda calcolo permette di manipolare queste relazioni con **funzioni** che combinano significati a livello più complesso.

#### **Collegamento tra Lambda Calcolo e FOL**
Mentre la FOL si concentra sulla **logica** e sulle **relazioni** (come esprimere "Ogni cane è un animale"), il **lambda calcolo** consente di **costruire funzioni** per esprimere questi concetti in modo più flessibile. Ad esempio:

- Una frase come "Il cane mangia" può essere rappresentata in FOL come:

$$
Dog(x) \land  Eats(x, food)
$$

Dove $Dog(x)$ indica che $x$ è un cane e $Eats(x, food)$ indica che $x$ mangia cibo.

- Con il **lambda calcolo**, possiamo trattare questo come una **funzione** che prende un argomento ($x$) e restituisce una proposizione che combina la **natura dell'oggetto** e la sua **azione**. La frase potrebbe essere rappresentata come:

$$
\lambda x (Dog(x) \land  Eats(x, food))
$$

In questo caso, il **lambda** $λx$ indica che stiamo creando una funzione che può essere applicata a un oggetto $x$ (ad esempio, un cane), e il risultato è la relazione tra $x$ e l'azione di mangiare.

In pratica, il lambda calcolo permette di **manipolare i significati semantici** a un livello più granulare, permettendo alle parole e alle frasi di essere trattate come funzioni che possono essere applicate a variabili e altre funzioni, creando rappresentazioni semantiche più **dinamiche e flessibili**.

[[Lambda Calcolo per NLP]]

### ⚠️ Limiti dell'approccio composizionale

1. **È complicato**  
   Richiede parsing preciso, regole formali, e molta logica. Anche frasi semplici generano strutture complesse.

2. **Assume significati univoci**  
   Si semplifica pensando che ogni parola (es. `book`, `opening`) abbia un solo significato. Ma molte parole sono **ambigue**.

3. **Serve la semantica lessicale**  
   Prima di comporre significati, bisogna sapere **quale significato** ha ogni parola nel contesto.

➡️ Il lambda calcolo è utile, ma **non basta**: ci vuole anche semantica lessicale!

## 📝 **Semantica Lessicale**


La **semantica lessicale** riveste un ruolo cruciale nell’ambito dell’**Elaborazione del Linguaggio Naturale (NLP)**, poiché fornisce le basi per comprendere il significato delle parole — e, di conseguenza, il significato di frasi, testi e interazioni linguistiche più complesse.

### ✅ Perché è importante nella NLP?

L’NLP si basa sulla capacità delle macchine di "comprendere" il linguaggio umano. Per farlo, è necessario che i sistemi siano in grado di:

- **Distinguere tra i diversi sensi di una parola** (disambiguazione semantica).
- **Riconoscere sinonimi e concetti simili**, per migliorare la comprensione e la generazione del linguaggio.
- **Analizzare le relazioni semantiche** tra parole, ad esempio per costruire grafi di conoscenza o rispondere a domande.
- **Eseguire traduzioni automatiche**, dove è essenziale scegliere la traduzione corretta tra più possibili significati.
- **Eseguire inferenze semantiche**, cioè dedurre nuove informazioni implicite a partire dal significato delle parole presenti.

### 🔍 Applicazioni pratiche

Ecco alcuni casi in cui la semantica lessicale è direttamente applicata nella NLP:

- **Word Sense Disambiguation (WSD)**: determinare automaticamente quale significato ha una parola in un dato contesto.
- **Information Retrieval e Search Engines**: migliorare i risultati delle ricerche comprendendo sinonimi, iponimi e concetti correlati.
- **Chatbot e Assistenti Virtuali**: interpretare correttamente le richieste degli utenti grazie alla comprensione del significato delle parole.
- **Traduzione automatica**: evitare errori di traduzione legati alla polisemia.
- **Text Summarization e Text Classification**: analizzare il contenuto lessicale per riassumere, classificare o etichettare automaticamente testi.

### 🧠 Esempio concreto

Considera la parola *"bank"*:
- In una frase come *"He went to the bank to deposit money"*, il sistema deve sapere che *bank* si riferisce a un istituto finanziario.
- In *"They sat by the bank of the river"*, invece, *bank* si riferisce alla riva del fiume.

Senza un’analisi semantica lessicale, questi due usi potrebbero facilmente essere confusi, compromettendo la qualità dell’interpretazione del linguaggio.


Per un approfondimento completo su questi temi, ti invitiamo a visitare il link [[Semantica Lessicale]], dove troverai una trattazione più dettagliata.


## 🌍 **Reti Lessicali e Ontologie**

### **WordNet e BabelNet**
**WordNet** è una rete semantica che collega parole in base a significati simili e relazioni gerarchiche. **BabelNet** è una versione estesa che integra traduzioni multilingue.

[Link alla nota su WordNet](#)  
[Link alla nota su BabelNet](#)

### **Word Sense Disambiguation (WSD)**
La **disambiguazione del senso delle parole** (WSD) è il processo di determinare quale senso di una parola è utilizzato in un dato contesto. Questo è essenziale per migliorare la comprensione semantica dei testi.

[Link alla nota su WSD](#)

### **Entity Linking**
Il **collegamento delle entità** associa nomi di entità (come persone, luoghi, organizzazioni) a risorse strutturate, come database o ontologie, per migliorare l'interpretazione del significato.

[Link alla nota su Entity Linking](#)

### **Ontologie**
Le **ontologie** sono modelli semantici che descrivono concetti e le relazioni tra di essi in un dominio specifico. Sono usate per strutturare la conoscenza e migliorare l'analisi semantica.

[Link alla nota su Ontologie](#)

## ✨ Conclusioni

In questo approfondimento, abbiamo esplorato i concetti fondamentali della **semantica** in NLP, partendo dalla sua definizione fino ad arrivare agli strumenti formali utilizzati per analizzare e rappresentare il significato delle parole e delle frasi. Abbiamo visto come la **Logica del Primo Ordine (FOL)** e il **lambda calcolo** siano strumenti potenti per modellare la semantica, offrendo una base logica e funzionale per rappresentare il significato linguistico in modo strutturato.

La **semantica lessicale** ci ha mostrato come la lemmatizzazione e la disambiguazione dei sensi delle parole siano cruciali per comprendere il significato nel contesto. La possibilità di costruire **ontologie** e utilizzare risorse come **WordNet** e **BabelNet** ci permette di connettere concetti e costruire conoscenze semantiche più ampie, supportando applicazioni come il **Word Sense Disambiguation** e l'**Entity Linking**.

In sintesi, la semantica in NLP non è solo una questione di comprensione dei significati delle parole singole, ma anche di come questi significati si intrecciano a livello sintattico, contestuale e pragmatico. Utilizzare strumenti come la FOL e il lambda calcolo permette di affrontare le sfide della complessità semantica in modo formale e rigoroso, aprendo la strada a applicazioni di NLP più sofisticate e precise.

L'interazione tra linguaggio, significato e contesto continua ad essere un campo di ricerca estremamente dinamico e promettente, con un potenziale enorme per migliorare le capacità delle macchine di comprendere e interpretare il linguaggio naturale.