# Face Recognition e Localizzazione del Volto

## Introduzione

Il riconoscimento facciale rappresenta una delle tecnologie biometriche più promettenti e ampiamente studiate nel campo della computer vision. A differenza di altre modalità biometriche, il volto umano offre un equilibrio unico tra accuratezza, accettabilità sociale e facilità di acquisizione.

## Confronto con Altri Sistemi Biometrici

La fattibilità di un sistema biometrico è determinata principalmente da tre fattori fondamentali: **accuratezza**, **affidabilità** e **accettabilità**. Confrontiamo il riconoscimento facciale con altre tecnologie biometriche per comprenderne meglio i vantaggi e le limitazioni.

### DNA
Il DNA rappresenta il tratto più accurato per l'identificazione biologica. Ogni individuo (eccetto i gemelli identici) possiede un profilo genetico unico che permette un'identificazione praticamente certa. Tuttavia, questa accuratezza ha un prezzo: le procedure necessarie per l'acquisizione del DNA sono altamente intrusive, richiedendo campioni biologici come sangue, saliva o tessuti. Questo rende il DNA inadatto per applicazioni quotidiane o di accesso rapido, limitandone l'uso principalmente al campo forense e alle indagini criminali.

### Impronte Digitali
Le impronte digitali rappresentano storicamente la prima forma di biometria ampiamente adottata e offrono un buon compromesso in termini di accuratezza. Sono relativamente ben accettate nella società moderna. Tuttavia, presentano alcune limitazioni significative che ne possono compromettere l'efficacia:

- **Richiesta di collaborazione**: l'utente deve posizionare attivamente il dito sul sensore in modo corretto
- **Qualità variabile**: le impronte possono essere di bassa qualità a causa di vari fattori (dita sporche, usurate dal lavoro manuale, ferite, età avanzata)
- **Connotazioni negative**: alcune persone associano l'uso delle impronte digitali alle procedure di identificazione criminale, creando una resistenza psicologica all'uso di questa tecnologia

### Riconoscimento Facciale
Il volto umano presenta caratteristiche uniche che lo rendono particolarmente attraente come modalità biometrica, bilanciando vantaggi pratici con accettabilità sociale.

**Vantaggi:**

- **Alta accettabilità sociale**: riconoscere le persone dal volto è un processo naturale per gli esseri umani. Fin dalla nascita, siamo programmati per identificare e memorizzare i volti. Inoltre, le persone sono abituate a essere fotografate in numerosi contesti quotidiani (documenti, social media, videoconferenze)

- **Universalità elevata**: ogni persona possiede un volto, rendendo questa biometria applicabile a tutta la popolazione senza eccezioni

- **Livello igienico superiore**: a differenza delle impronte digitali o della scansione dell'iride, il riconoscimento facciale non richiede alcun contatto fisico con dispositivi, eliminando preoccupazioni igieniche e rendendo il processo più confortevole

- **Facilità di integrazione tecnologica**: i dispositivi di acquisizione (telecamere) sono economici, ampiamente disponibili e facili da installare. Possono essere integrati facilmente in applicazioni di controllo remoto, accesso logico, sorveglianza e autenticazione mobile

- **Basso sforzo richiesto dall'utente**: l'utente non deve compiere azioni particolari o posizionarsi in modo preciso. Il sistema può acquisire il volto anche a distanza e in movimento

- **Prestazioni elevate in condizioni controllate**: quando le condizioni di illuminazione, posa e risoluzione sono ottimali, i sistemi di riconoscimento facciale raggiungono tassi di riconoscimento molto elevati

**Svantaggi:**

- **Accuratezza da migliorare**: rispetto ad altre biometrie come le impronte digitali o l'iride, l'accuratezza in condizioni non controllate (illuminazione variabile, pose diverse, espressioni) rimane una sfida significativa

- **Complessità dell'oggetto**: il volto è un oggetto tridimensionale complesso, la cui apparenza cambia significativamente in funzione di numerosi fattori. Non è una superficie rigida ma deformabile, soggetta a espressioni, invecchiamento e modifiche intenzionali

## Applicazioni del Riconoscimento Facciale

Il riconoscimento facciale ha trovato applicazione in numerosi settori, ciascuno con requisiti specifici:

- **Ambito forense**: identificazione di sospetti, ricerca di persone scomparse, analisi di filmati di sorveglianza in indagini criminali

- **Dispositivi mobili e applicazioni**: autenticazione biometrica per smartphone, tablet, applicazioni bancarie e pagamenti digitali, sostituendo password e PIN

- **Controllo delle frontiere**: verifica automatica dell'identità nei punti di passaggio aeroportuali e terrestri, confronto tra il volto del viaggiatore e la foto sul passaporto

- **Ricerca di persone nella folla**: sistemi di sorveglianza intelligente per la sicurezza pubblica, identificazione di persone ricercate in grandi assembramenti

- **Controllo degli accessi**: accesso a edifici, aree riservate, sistemi informatici senza necessità di badge o chiavi fisiche

## Problematiche Principali del Riconoscimento Facciale

Il riconoscimento facciale deve affrontare diverse sfide tecniche che ne complicano l'implementazione pratica. Queste sfide possono essere categorizzate in base alla loro natura.

### 1. Variazioni Intra-Personali

Uno dei problemi più significativi è che lo stesso individuo può apparire molto diverso in immagini acquisite in momenti o condizioni differenti. Queste variazioni vengono comunemente riassunte nell'acronimo **A-PIE**:

- **Aging (Invecchiamento)**: il volto umano cambia continuamente nel corso della vita. I cambiamenti possono essere graduali (rughe, perdita di tono della pelle, modifiche nella struttura ossea) o improvvisi (aumento/perdita di peso, barba, capelli). Questi cambiamenti rendono difficile il confronto tra immagini acquisite a distanza di anni

- **Pose (Posa)**: l'angolazione e l'orientamento del volto rispetto alla telecamera influenzano drasticamente l'aspetto. Un volto frontale appare molto diverso da uno di profilo o semi-profilo. La posa introduce deformazioni prospettiche, occlusioni parziali (una parte del volto può essere nascosta) e variazioni nella visibilità delle caratteristiche facciali

- **Illumination (Illuminazione)**: le condizioni di luce rappresentano uno dei fattori più critici. La stessa persona può apparire irriconoscibile sotto illuminazioni diverse. Ombre forti possono nascondere caratteristiche importanti, mentre una luce troppo forte può saturare le informazioni cromatiche. La direzione, l'intensità e il colore della luce influenzano la percezione del volto

- **Expression (Espressione)**: le espressioni facciali modificano significativamente la geometria del volto. Un sorriso, una smorfia, uno sguardo sorpreso producono deformazioni locali importanti, specialmente nella regione della bocca e degli occhi. Il volto umano non è un oggetto rigido ma una superficie deformabile

### 2. Similarità Inter-Personali

Persone diverse possono presentare caratteristiche facciali simili, rendendo difficile la discriminazione. Questo è particolarmente vero per:
- Membri della stessa famiglia (somiglianze genetiche)
- Persone dello stesso gruppo etnico
- Gemelli non identici
- Persone con caratteristiche somatiche comuni

### 3. Occlusioni e Travestimenti

Il volto può essere parzialmente o totalmente oscurato da elementi che ne alterano l'aspetto:

- **Occlusioni naturali**: capelli che coprono parte del volto, mano davanti alla bocca
- **Accessori comuni**: occhiali (da vista o da sole), cappelli, sciarpe, mascherine
- **Modifiche estetiche**: makeup intenso, tatuaggi, piercing
- **Modifiche permanenti**: chirurgia plastica, cicatrici
- **Travestimenti intenzionali**: maschere, trucco teatrale, modifiche deliberate per ingannare il sistema

È particolarmente interessante notare che è relativamente semplice eludere i sistemi di localizzazione facciale. Studi sulla cosiddetta **Adversarial Fashion** hanno dimostrato che oscurando strategicamente il ponte nasale (l'area tra gli occhi) o invertendo lo schema cromatico del volto attraverso makeup specifico, è possibile rendersi "invisibili" a molti sistemi di rilevamento automatico.

## Architettura di un Sistema di Riconoscimento Facciale

Un sistema completo di riconoscimento facciale si articola in una pipeline di elaborazione composta da diverse fasi, ciascuna con obiettivi specifici.

### 1. Acquisizione e Miglioramento dell'Immagine (Image Enhancement)

La prima fase consiste nell'acquisizione dell'immagine del volto. A seconda della distanza e del contesto, l'immagine catturata può contenere solo il volto o un ambiente più ampio circostante. In quest'ultimo caso, è necessario un miglioramento dell'immagine prima di procedere.

L'**image enhancement** comprende diverse operazioni:
- Aumento della nitidezza (sharpness) per rendere i dettagli più visibili
- Eliminazione o riduzione della sfocatura (deblurring) quando possibile
- Aumento del contrasto per enfatizzare le differenze tra regioni chiare e scure
- Riduzione del rumore per migliorare la qualità complessiva
- Correzione dell'illuminazione per bilanciare zone sovraesposte o sottoesposte

### 2. Rilevamento e Localizzazione

Spesso si usano i termini "detection" e "localization" come sinonimi, ma esiste una differenza concettuale importante:

- **Detection (Rilevamento)**: fornisce una risposta binaria alla domanda "è presente un volto in questa immagine?". La risposta può essere semplicemente "sì" o "no"

- **Localization (Localizzazione)**: oltre a rilevare la presenza del volto, fornisce la posizione esatta dell'elemento all'interno dell'immagine, tipicamente sotto forma di coordinate di un rettangolo di contenimento (bounding box)

### 3. Estrazione delle Regioni di Interesse (ROI)

Una volta localizzato il volto, è possibile ritagliare le **regioni di interesse (ROI)** per ridurre il tempo di elaborazione. Concentrandosi solo sulle regioni rilevanti, le fasi successive possono operare su porzioni più piccole dell'immagine, aumentando l'efficienza computazionale.

È possibile adottare un approccio gerarchico: invece di fermarsi alla regione contenente l'intero volto, si può procedere identificando diverse sotto-regioni o **patches** (porzioni). Gli approcci basati su patch sono diventati molto popolari nel riconoscimento facciale perché:
- Considerano una partizione dell'immagine del volto in regioni più piccole
- Sono più robusti alle variazioni dovute a occlusioni parziali (una patch può essere occlusa, ma le altre rimangono disponibili)
- Gestiscono meglio l'illuminazione non uniforme (diverse patch possono essere normalizzate indipendentemente)
- Permettono di dare pesi diversi a regioni più o meno discriminanti

### 4. Estrazione delle Caratteristiche e Costruzione del Template

La fase finale consiste nell'estrarre caratteristiche discriminanti dal volto e costruire un **template** (o chiave biometrica). Questo template è una rappresentazione compatta del volto che cattura le informazioni essenziali per l'identificazione, eliminando le ridondanze e le variazioni non rilevanti.

## Face Localization (Localizzazione del Volto)

La localizzazione del volto rappresenta il primo passo critico in qualsiasi sistema di riconoscimento facciale. Senza una localizzazione accurata, tutte le fasi successive risultano compromesse.

### Definizione del Problema

**Problema**: data una singola immagine o una sequenza video, rilevare la presenza di uno o più volti e localizzare la loro posizione esatta all'interno dell'immagine.

La **posizione esatta** è fondamentale perché viene utilizzata per identificare la regione da ritagliare, permettendo alle successive elaborazioni di concentrarsi esclusivamente sulla regione di interesse, migliorando sia l'efficienza che l'accuratezza.

### Requisiti di Robustezza

Un sistema di localizzazione robusto deve essere indipendente rispetto a numerosi fattori:

- **Posizione**: non possiamo assumere che il volto sia sempre al centro dell'immagine. Il sistema deve essere in grado di rilevare volti in qualsiasi posizione

- **Orientamento (Pose)**: il volto può essere frontale, di profilo, semi-profilo, o visto dall'alto o dal basso. Il sistema deve gestire tutte queste variazioni angolari

- **Scala**: dobbiamo essere in grado di rilevare volti di diverse dimensioni, da quelli che occupano quasi l'intera immagine a volti piccoli in immagini ad alta risoluzione. Questo è particolarmente importante in scenari di sorveglianza dove le persone possono essere a distanze molto diverse dalla telecamera

- **Espressione**: le espressioni facciali modificano la geometria del volto. Il sistema deve riconoscere un volto sia neutro che sorridente, sorpreso o corrucciato. Inoltre, in un'immagine con più persone, ciascuna può avere un'espressione diversa

- **Illuminazione**: le condizioni di luce variano enormemente tra ambienti interni ed esterni, tra giorno e notte, con luce naturale o artificiale

- **Background complesso (cluttered background)**: lo sfondo può contenere pattern, texture e oggetti che possono confondere il detector, generando **false detection** (falsi positivi). Ad esempio, certe configurazioni di oggetti potrebbero suggerire la presenza di un volto dove non c'è

### Sfide nella Rilevazione

Un problema fondamentale è: **quando possiamo essere sicuri di aver rilevato effettivamente un volto?** I sistemi automatici possono generare:

- **False detection (Falsi positivi)**: il sistema rileva un volto dove non c'è
- **Missed detection (Falsi negativi)**: il sistema non rileva un volto presente

L'obiettivo è minimizzare entrambi questi errori, ma spesso esiste un trade-off: aumentando la sensibilità per ridurre i falsi negativi, si rischia di aumentare i falsi positivi, e viceversa.

### Vulnerabilità: Adversarial Fashion

La risposta alla domanda "può la Face Localization essere ingannata?" è affermativa. Con makeup strategico o altri elementi applicati sul volto, è possibile nascondersi dai sistemi di localizzazione. Questo campo di ricerca è noto come **Adversarial Fashion**.

Tecniche particolarmente efficaci includono:
- Oscurare il ponte nasale (l'area tra gli occhi), che è una regione critica per molti algoritmi
- Invertire lo schema cromatico del volto attraverso makeup che inverte le zone chiare e scure
- Applicare pattern specifici che confondono i modelli di machine learning

## Approcci alla Face Localization

Esistono diverse filosofie per affrontare il problema della localizzazione del volto, ciascuna con i propri punti di forza.

### 1. Tecniche Feature-Based (Basate su Caratteristiche)

Queste tecniche fanno uso esplicito della conoscenza sull'aspetto atteso del volto umano. L'idea è sfruttare ciò che sappiamo a priori su come appare un volto: ha due occhi, un naso, una bocca, con disposizioni geometriche ben definite. Il volto è caratterizzato da un insieme di features (caratteristiche) a diversi livelli di astrazione.

**Proprietà sfruttabili** (ordinate dal livello più basso al più alto):

#### Proprietà a Livello di Pixel

Al livello più elementare, possiamo sfruttare proprietà locali dei singoli pixel o piccole regioni:

- **Edges (Bordi)**: i bordi rappresentano discontinuità nell'intensità o nel colore. Il volto presenta bordi caratteristici (contorno del volto, bordi degli occhi, della bocca, del naso). Rilevando i bordi e analizzandone la configurazione, è possibile identificare strutture facciali

- **Colore della pelle**: la pelle umana ha caratteristiche cromatiche distintive che possono essere modellate statisticamente. Nonostante le variazioni dovute all'etnia, alla luce e ad altri fattori, esiste un range di colori riconducibili alla pelle umana. La segmentazione basata sul colore della pelle permette di identificare regioni candidate a contenere volti

#### Proprietà Geometriche del Volto

A un livello intermedio, possiamo sfruttare la geometria intrinseca del volto:

- **Constellation (Costellazione)**: la configurazione spaziale delle componenti facciali segue regole precise. Gli occhi si trovano a una certa distanza l'uno dall'altro, il naso è centrato tra gli occhi e sopra la bocca, le orecchie sono ai lati. Questa "costellazione" di punti è caratteristica

- **Feature Searching (Ricerca di Caratteristiche)**: si cercano componenti specifiche del volto (occhi, naso, bocca) separatamente, per poi verificarne la disposizione geometrica. Ad esempio, si possono cercare prima gli occhi (usando filtri specifici), poi verificare se sotto di essi c'è una bocca nella posizione attesa

#### Template Matching (Confronto con Template)

Al livello più alto, si utilizzano modelli completi del volto:

- **Correlazione**: si confronta una regione dell'immagine con template predefiniti di volti, calcolando misure di similarità. Se la correlazione supera una certa soglia, si ipotizza la presenza di un volto

- **Snakes (Contorni Attivi)**: curve deformabili che si adattano dinamicamente ai bordi del volto. Partendo da una posizione iniziale, il "snake" si muove e deforma per aderire ai contorni reali del volto presente nell'immagine

- **Active Shape Models (Modelli di Forma Attivi)**: modelli statistici che catturano la variabilità della forma del volto. Appresi da un set di esempi, questi modelli possono deformarsi per adattarsi a nuovi volti, rimanendo coerenti con le forme tipiche apprese

### 2. Tecniche Image-Based (Basate sull'Immagine)

A differenza delle tecniche feature-based, che codificano esplicitamente la conoscenza su "cos'è un volto", le tecniche image-based affrontano la localizzazione come un problema generico di **pattern recognition**. Il volto viene considerato come una classe di oggetti che il sistema deve imparare a riconoscere.

**Filosofia**: invece di dire al sistema "un volto ha due occhi, un naso e una bocca in questa configurazione", gli mostriamo migliaia di esempi di volti e non-volti, lasciando che il sistema apprenda autonomamente cosa distingue un volto da un non-volto.

**Obiettivo**: imparare a riconoscere un'immagine di volto basandosi su numerosi esempi. Più esempi forniamo durante la fase di training, migliore sarà la capacità di generalizzazione del sistema.

**Caratteristiche di questo approccio**:
- Il training è tipicamente la fase più onerosa computazionalmente
- Richiede grandi dataset di esempi positivi (volti) e negativi (non-volti)
- Una volta addestrato, il sistema può essere molto veloce in fase di detection
- La qualità dipende criticamente dalla varietà e rappresentatività degli esempi di training

**Metodi utilizzabili**:

- **Subspace Methods (Metodi di Sottospazio)**: tecniche come PCA (Principal Component Analysis) e LDA (Linear Discriminant Analysis) che proiettano le immagini in uno spazio di dimensionalità ridotta dove i volti sono meglio separabili dai non-volti

- **Reti Neurali**: sistemi ispirati al funzionamento del cervello, capaci di apprendere rappresentazioni complesse attraverso molteplici livelli di elaborazione

- **Support Vector Machines (SVM)**: algoritmi di classificazione che cercano l'iperpiano ottimale per separare le due classi (volti e non-volti) nello spazio delle caratteristiche

- **Hidden Markov Models (HMM)**: modelli probabilistici particolarmente utili per sequenze, applicabili alla scansione sequenziale di un'immagine

### 3. Approcci Recenti

La ricerca continua a evolvere, con approcci sempre più sofisticati:

- **Consensus of Exemplars**: "Localizing Parts of Faces Using a Consensus of Exemplars" (Belhumeur et al., 2013) utilizza un consenso di esempi memorizzati per localizzare parti specifiche del volto con maggiore precisione. L'idea è mantenere un database di esempi (exemplar) con distribuzioni specifiche di costellazioni di landmarks, confrontando le nuove immagini con questi riferimenti

- **Deep Learning**: approcci basati su reti neurali profonde che hanno rivoluzionato il campo negli ultimi anni, apprendendo automaticamente rappresentazioni gerarchiche sempre più astratte

## Algoritmo A: Hsu, Mottaleb e Jain (2002)

Questo algoritmo rappresenta un esempio pratico e completo di localizzazione facciale basata su caratteristiche (feature-based). La sua struttura è paradigmatica di molti approcci simili e illustra bene i principi generali della localizzazione facciale.

### Struttura Generale

L'algoritmo si articola in **due macro-fasi**:

1. **Face Candidates Detection** (Rilevamento dei Candidati Volti)
2. **Face Candidates Verification** (Verifica dei Candidati) attraverso il rilevamento delle caratteristiche facciali

Questo è un pattern generale molto comune nel rilevamento di oggetti: prima si identificano regioni candidate utilizzando caratteristiche più generali e computazionalmente meno costose, poi si procede con verifiche più dettagliate e precise per confermare o scartare i candidati.

La filosofia è: meglio avere alcuni falsi positivi iniziali (che verranno scartati nella fase di verifica) piuttosto che perdere volti reali nella prima fase (falsi negativi che non potrebbero essere recuperati successivamente).

### Fase 1: Rilevamento dei Candidati Volti

Questa fase si occupa di identificare regioni dell'immagine che potrebbero contenere volti. Si articola in diverse sotto-fasi di pre-processing e segmentazione.

#### 1.1 Compensazione dell'Illuminazione (Illumination Compensation)

L'illuminazione è uno dei fattori più critici nel riconoscimento facciale. Il tono della pelle percepito dipende non solo dalle caratteristiche intrinseche della pelle, ma anche:
- Dall'illuminazione complessiva della scena
- Dalle caratteristiche dei sensori che hanno catturato l'immagine
- Dalla direzione e intensità delle sorgenti luminose

**Concetto di Reference White**

La compensazione dell'illuminazione utilizza il concetto di **"reference white"** (bianco di riferimento) per normalizzare l'apparenza del colore. Questo è un processo standardizzato che permette di rendere i colori comparabili anche quando acquisiti in condizioni di illuminazione diverse.

**Procedura di identificazione del Reference White**:

## Compensazione dell'Illuminazione: Procedura Dettagliata con Formule

### 1. Calcolo del Luma

Il **luma** rappresenta una misura della luminosità percepita di un pixel. A differenza della semplice media aritmetica delle componenti RGB, il luma tiene conto della percezione umana non lineare della luce.

#### Gamma-Compressione

Prima di calcolare il luma, le componenti RGB devono essere **gamma-compresse**. La gamma-compressione applica una trasformazione non lineare per compensare la risposta non lineare dell'occhio umano alla luce.

Per ogni componente di colore $C \in \{R, G, B\}$ con valori normalizzati nell'intervallo $[0, 1]$, la gamma-compressione è definita come:

$$C' = C^\gamma$$

dove:
- $\gamma$ è il parametro di gamma, tipicamente $\gamma \approx 0.45$ (oppure si usa $1/2.2 \approx 0.4545$)
- $C'$ è la componente gamma-compressa (indicata come $R'$, $G'$, $B'$)

**Nota**: se le componenti RGB sono nell'intervallo $[0, 255]$, si normalizzano prima a $[0, 1]$ dividendo per 255, si applica la gamma-compressione, e poi eventualmente si riporta a $[0, 255]$ moltiplicando per 255.

#### Formula del Luma

Una volta ottenute le componenti gamma-compresse $R'$, $G'$, $B'$, il luma $Y'$ si calcola come **somma pesata**:

$$Y' = w_R \cdot R' + w_G \cdot G' + w_B \cdot B'$$

dove i pesi standard (secondo lo standard ITU-R BT.709 per HDTV) sono:

$$w_R = 0.2126, \quad w_G = 0.7152, \quad w_B = 0.0722$$

**Interpretazione dei pesi**: l'occhio umano è molto più sensibile al verde che al rosso e al blu, quindi il verde ha un peso dominante (~71%) nel calcolo del luma.

**Forma compatta**: per un pixel con coordinate $(x, y)$, il luma è:

$$Y'(x, y) = 0.2126 \cdot R'(x, y) + 0.7152 \cdot G'(x, y) + 0.0722 \cdot B'(x, y)$$

### 2. Selezione dei Pixel più Luminosi (Reference White)

Una volta calcolato il luma per tutti i pixel dell'immagine, si procede con l'identificazione dei pixel di **reference white**.

#### Ordinamento e Selezione del Top 5%

Sia $\mathcal{P} = \{(x_1, y_1), (x_2, y_2), \ldots, (x_{M \times N}, y_{M \times N})\}$ l'insieme di tutti i pixel dell'immagine di dimensione $M \times N$.

1. Si crea una lista ordinata dei valori di luma in ordine decrescente:
   $$\{Y'_{(1)}, Y'_{(2)}, \ldots, Y'_{(M \times N)}\}$$
   dove $Y'_{(i)}$ indica l'$i$-esimo valore più alto di luma.

2. Si calcola il numero di pixel da selezionare (top 5%):
   $$n_{RW} = \lceil 0.05 \times M \times N \rceil$$
   dove $\lceil \cdot \rceil$ indica l'arrotondamento per eccesso.

3. Si definisce la **soglia di luma** per il reference white:
   $$Y'_{threshold} = Y'_{(n_{RW})}$$

4. L'insieme dei pixel di reference white è:
   $$\mathcal{P}_{RW} = \{(x, y) \in \mathcal{P} : Y'(x, y) \geq Y'_{threshold}\}$$

### 3. Verifica della Sufficienza

Prima di procedere con la normalizzazione, si verificano due condizioni:

#### Condizione 1: Numero Sufficiente di Pixel

Si verifica che il numero di pixel di reference white sia significativo:

$$|\mathcal{P}_{RW}| \geq n_{min}$$

dove $n_{min}$ è una soglia minima (tipicamente una piccola percentuale della dimensione dell'immagine, ad esempio $n_{min} = 0.01 \times M \times N$).

**Motivazione**: se ci sono troppo pochi pixel molto luminosi, potrebbero essere outlier o rumore, non rappresentativi dell'illuminazione globale.

#### Condizione 2: Colore Medio Non Simile alla Pelle

Si calcola il **colore medio** dei pixel di reference white per ciascun canale:

$$\bar{R}_{RW} = \frac{1}{|\mathcal{P}_{RW}|} \sum_{(x,y) \in \mathcal{P}_{RW}} R(x, y)$$

$$\bar{G}_{RW} = \frac{1}{|\mathcal{P}_{RW}|} \sum_{(x,y) \in \mathcal{P}_{RW}} G(x, y)$$

$$\bar{B}_{RW} = \frac{1}{|\mathcal{P}_{RW}|} \sum_{(x,y) \in \mathcal{P}_{RW}} B(x, y)$$

Si verifica poi che questo colore medio non sia simile al tono della pelle. Una possibile metrica è la **distanza euclidea** nello spazio RGB da un modello di pelle:

$$d_{skin} = \sqrt{(\bar{R}_{RW} - R_{skin})^2 + (\bar{G}_{RW} - G_{skin})^2 + (\bar{B}_{RW} - B_{skin})^2}$$

dove $(R_{skin}, G_{skin}, B_{skin})$ rappresenta un colore di riferimento per la pelle (ad esempio, $(200, 160, 140)$ in scala $[0, 255]$).

La condizione è:
$$d_{skin} > \tau_{skin}$$

dove $\tau_{skin}$ è una soglia di distanza predefinita.

**Motivazione**: se i pixel più luminosi hanno un colore simile alla pelle, potrebbero non rappresentare il "bianco" ma piuttosto zone di pelle sovraesposte, portando a distorsioni nella normalizzazione.

### 4. Normalizzazione

Se entrambe le condizioni sono soddisfatte, si procede con la **normalizzazione lineare** dell'immagine.

#### Calcolo del Livello di Grigio Medio del Reference White

Si calcola il livello di grigio medio dei pixel di reference white. Questo può essere fatto usando il luma o una media delle tre componenti:

**Opzione 1 (usando il luma)**:
$$\bar{Y}'_{RW} = \frac{1}{|\mathcal{P}_{RW}|} \sum_{(x,y) \in \mathcal{P}_{RW}} Y'(x, y)$$

**Opzione 2 (media delle componenti)**:
$$\bar{L}_{RW} = \frac{\bar{R}_{RW} + \bar{G}_{RW} + \bar{B}_{RW}}{3}$$

Utilizziamo la seconda opzione per semplicità, indicando con $\bar{L}_{RW}$ il livello medio di grigio.

#### Fattore di Scala

L'obiettivo è scalare linearmente tutti i colori in modo che $\bar{L}_{RW}$ diventi 255 (il valore massimo per RGB a 8 bit). Il **fattore di scala** è:

$$\alpha = \frac{255}{\bar{L}_{RW}}$$

#### Applicazione della Normalizzazione

Per ogni pixel $(x, y)$ dell'immagine, le nuove componenti RGB normalizzate sono:

$$R_{norm}(x, y) = \min\left(\alpha \cdot R(x, y), 255\right)$$

$$G_{norm}(x, y) = \min\left(\alpha \cdot G(x, y), 255\right)$$

$$B_{norm}(x, y) = \min\left(\alpha \cdot B(x, y), 255\right)$$

La funzione $\min(\cdot, 255)$ garantisce il **clipping** dei valori che supererebbero 255 dopo la scalatura, evitando overflow.

**Forma vettoriale**: se rappresentiamo ogni pixel come un vettore $\mathbf{c}(x, y) = [R(x, y), G(x, y), B(x, y)]^T$, la normalizzazione è:

$$\mathbf{c}_{norm}(x, y) = \min\left(\alpha \cdot \mathbf{c}(x, y), [255, 255, 255]^T\right)$$

dove il minimo è inteso componente per componente.

In pratica, si "ancora" il bianco al valore massimo e si scala linearmente tutto il resto di conseguenza, compensando variazioni globali di illuminazione.

#### 1.2 Trasformazione dello Spazio Colore (Color Space Transformation)

Questa è una fase cruciale, particolarmente importante quando si vuole identificare regioni con le stesse caratteristiche cromatiche (segmentazione o color clustering).

**Il Problema con RGB**

RGB non è uno **spazio percettivamente uniforme**. Questo significa che:
- Colori vicini nello spazio RGB (in termini di distanza euclidea tra i vettori RGB) potrebbero non essere percepiti come simili dall'occhio umano
- Colori percepiti come simili potrebbero essere rappresentati da combinazioni molto diverse di R, G e B
- La stessa resa visiva può corrispondere a diverse combinazioni di rosso, verde e blu

**Conseguenze pratiche**

Il computer non "vede" i colori come li vediamo noi. Interpreta solo i numeri che compongono le tre componenti RGB. Questo può portare a due problemi opposti:

1. **Over-segmentation (Sovra-segmentazione)**: gruppi di pixel che dal punto di vista percettivo dovrebbero appartenere alla stessa regione possono essere divisi in regioni diverse solo perché, a causa delle caratteristiche dei sensori, sono stati espressi con diverse combinazioni RGB

2. **Under-segmentation (Sotto-segmentazione)**: al contrario, pixel con valori RGB abbastanza vicini potrebbero essere considerati simili dal sistema anche se appaiono visivamente diversi

**Il Modello di Pelle (Skin Model)**

Il **skin model** è un insieme di colori simili (un cluster) all'interno dello spazio colore che rappresentano le possibili tonalità della pelle umana. Questo modello deve essere abbastanza ampio da includere tutte le possibili sfumature dovute a:
- Origine etnica
- Abbronzatura
- Condizioni di salute
- Età

**Soluzione: Spazi Colore Alternativi**

È consigliabile eseguire il rilevamento in uno spazio colore diverso da RGB, come:

- $Y,C_B,C_R$ (usato in questo algoritmo):
  - $Y$: componente di luminanza
  - $C_B$: componente di crominanza (blue-difference), proporzionale a $(B-Y)$
  - $C_R$: componente di crominanza (red-difference), proporzionale a $(R-Y)$

$$
\begin{bmatrix}
Y \\
C_B \\
C_R
\end{bmatrix}
=
\begin{bmatrix}
16 \\
128 \\
128
\end{bmatrix}
+
\frac{1}{256}
\begin{bmatrix}
65.738 & 129.057 & 25.064 \\
-37.945 & -74.494 & 112.439 \\
112.439 & -94.154 & -18.285
\end{bmatrix}
\begin{bmatrix}
R \\
G \\
B
\end{bmatrix}
$$


- $Y,U,V$:
  - $Y$: luminanza
  - $U, V$: due componenti di crominanza

Questi spazi hanno il vantaggio fondamentale di **separare le informazioni di luminosità da quelle di colore**. Questo significa che:
- La componente $Y$ cattura quanto è chiaro o scuro un pixel
- Le componenti $C_B$, $C_R$ (o $U, V$) catturano il "tono" del colore indipendentemente dalla luminosità

Questa separazione è cruciale perché il colore della pelle varia principalmente nelle componenti cromatiche, mentre la luminanza può variare enormemente per illuminazione senza che il "colore" della pelle cambi.

#### 1.3 Localizzazione Basata sul Modello di Pelle

Questa sotto-fase utilizza il modello di pelle nello spazio colore appropriato per identificare regioni candidate. Comprende due operazioni principali:

##### Segmentazione Basata sulla Varianza (Variance-based Segmentation)

La segmentazione è il processo di suddivisione di un'immagine in regioni omogenee. Il metodo più semplice è il **thresholding** (sogliatura).

**Cos'è il Thresholding?**

Il thresholding consiste nel selezionare uno o più valori di soglia (threshold) appartenenti al range dei colori possibili e usarli per dividere i pixel in classi diverse. Esistono molte varianti:
- **Fixed thresholding**: si usa sempre la stessa soglia
- **Adaptive thresholding**: la soglia varia localmente in base alle caratteristiche dell'immagine

**Esempio intuitivo**: supponiamo di avere un'immagine in scala di grigi e di voler creare una maschera binaria (bianco e nero) per separare gli oggetti dallo sfondo. Il modo più semplice è:
1. Scegliere una soglia $t$ tra 0 e 255
2. Trasformare in nero tutti i pixel con valore $< t$
3. Trasformare in bianco tutti i pixel con valore $\geq t$

**Il problema della scelta della soglia**

Quando si processano molte immagini diverse, è difficile usare soglie diverse per ciascuna, perché questo richiederebbe una pre-analisi della distribuzione dei colori per ogni immagine, aumentando il tempo di elaborazione. 

La soluzione pratica consiste nell'utilizzare una **fase di training** dove si processano numerosi esempi del problema da affrontare e si determina una soglia (o un set di soglie) che fornisce buone prestazioni nella maggior parte dei casi.

**Metodo di Otsu (Maximum Variance)**

Tra i metodi più popolari per la selezione automatica della soglia c'è il **metodo di Otsu**, basato sul concetto di massimizzazione della varianza tra classi (equivalente a minimizzare la varianza intra-classe).

**Formalizzazione matematica**:

Sia $I$ un'immagine in scala di grigi con:
- $L$ livelli di grigio: $G = [0, 1, \ldots, L-1]$
- Dimensione: $M \times N$ pixel
- $f(x,y)$: valore di grigio del pixel in posizione $(x,y)$
- $n_i$: numero di pixel con livello di grigio $i$

**Istogramma e Probabilità**

Possiamo rappresentare la distribuzione dei livelli di grigio tramite un istogramma:
- Asse x: i 256 bin (livelli di grigio da 0 a 255)
- Asse y: $n_i$ (frequenza del livello $i$)

Per rendere l'istogramma indipendente dalla dimensione dell'immagine e quindi confrontabile, dividiamo ciascuna frequenza per il numero totale di pixel, ottenendo **probabilità** invece che frequenze assolute:

$p_i = \frac{n_i}{M \times N} \quad \text{con } p_i \geq 0, \quad \sum_{i=0}^{L-1} p_i = 1$

**Assunzione fondamentale del metodo di Otsu**

Si assume che i pixel dell'immagine possano essere divisi in **due classi** $C_0$ e $C_1$ (tipicamente oggetto e sfondo, o nel nostro caso pelle e non-pelle) separate da un livello di grigio $t$ (la soglia):
- **Classe $C_0$**: pixel con livello di grigio $\leq t$ (livelli da 0 a $t$)
- **Classe $C_1$**: pixel con livello di grigio $> t$ (livelli da $t+1$ a $L-1$)

**Probabilità aggregate delle classi**

La probabilità che un pixel appartenga a ciascuna classe è data dalla somma delle probabilità dei livelli di grigio che la compongono:

$\omega_0 = \sum_{i=0}^{t} p_i, \quad \omega_1 = \sum_{i=t+1}^{L-1} p_i$

Ovviamente: $\omega_0 + \omega_1 = 1$

**Livelli di grigio medi delle classi**

Il livello medio di grigio per ciascuna classe si calcola come media pesata:

$\mu_0 = \frac{\sum_{i=0}^{t} i \cdot p_i}{\omega_0}, \quad \mu_1 = \frac{\sum_{i=t+1}^{L-1} i \cdot p_i}{\omega_1}$

Questi valori rappresentano il "centro di gravità" della distribuzione di grigio in ciascuna classe.

**Varianze delle classi**

Secondo la definizione statistica di varianza, per ciascuna classe calcoliamo quanto i valori si discostano dalla media:

$\sigma_0^2 = \frac{\sum_{i=0}^{t} (i - \mu_0)^2 \cdot p_i}{\omega_0}, \quad \sigma_1^2 = \frac{\sum_{i=t+1}^{L-1} (i - \mu_1)^2 \cdot p_i}{\omega_1}$

**Varianza intra-classe (Within-class Variance)**

La varianza intra-classe è la somma pesata delle varianze delle due classi:

$\sigma_w^2(t) = \omega_0 \cdot \sigma_0^2 + \omega_1 \cdot \sigma_1^2$

Questo valore misura quanto sono "compatte" le due classi internamente. Una varianza intra-classe bassa significa che all'interno di ciascuna classe i valori sono molto simili tra loro.

**Determinazione della soglia ottimale**

L'obiettivo del metodo di Otsu è trovare la soglia $t^*$ che minimizza la varianza intra-classe:

$$
t^* = \arg\min_{t \in [0, \ldots, L-1]} \sigma_w^2(t)
$$

**Intuizione**: vogliamo una soglia che separi l'immagine in due classi internamente omogenee (bassa varianza dentro le classi) ma ben distinte tra loro (alta varianza tra le classi). 

In pratica, si testa ogni possibile valore di soglia da 0 a $L-1$, si calcola $\sigma_w^2(t)$ per ciascuno e si sceglie il valore che dà la varianza minima.

---
$$
\textbf{Teorema (Decomposizione della varianza)}
$$

Sia $p_i$ una distribuzione discreta con media globale
$$
\mu=\sum_{i=0}^{L-1}i\,p_i,
\qquad
\sigma^2=\sum_{i=0}^{L-1}(i-\mu)^2p_i.
$$

Fissata una soglia $t$, definiamo:
$$
\omega_0=\sum_{i=0}^{t}p_i,
\quad
\omega_1=\sum_{i=t+1}^{L-1}p_i,
$$
$$
\mu_0=\frac{1}{\omega_0}\sum_{i=0}^{t}i\,p_i,
\quad
\mu_1=\frac{1}{\omega_1}\sum_{i=t+1}^{L-1}i\,p_i,
$$
$$
\sigma_0^2=\frac{1}{\omega_0}\sum_{i=0}^{t}(i-\mu_0)^2p_i,
\quad
\sigma_1^2=\frac{1}{\omega_1}\sum_{i=t+1}^{L-1}(i-\mu_1)^2p_i.
$$

La varianza intra-classe è:
$$
\sigma_w^2(t)=\omega_0\sigma_0^2+\omega_1\sigma_1^2.
$$

La varianza inter-classe è:
$$
\sigma_b^2(t)=\omega_0(\mu_0-\mu)^2+\omega_1(\mu_1-\mu)^2.
$$

$$
\textbf{Dimostrazione}
$$

Si ha:
$$
\sigma^2=\sum_{i=0}^{t}(i-\mu)^2p_i+\sum_{i=t+1}^{L-1}(i-\mu)^2p_i.
$$

Per la classe $k\in\{0,1\}$:
$$
(i-\mu)^2=(i-\mu_k)^2+2(i-\mu_k)(\mu_k-\mu)+(\mu_k-\mu)^2.
$$

Sommando su ciascuna classe e usando $\sum(i-\mu_k)p_i=0$, si ottiene:
$$
\sum_{i\in C_k}(i-\mu)^2p_i
=\omega_k\sigma_k^2+\omega_k(\mu_k-\mu)^2.
$$

Pertanto:
$$
\sigma^2
=\omega_0\sigma_0^2+\omega_1\sigma_1^2
+\omega_0(\mu_0-\mu)^2+\omega_1(\mu_1-\mu)^2
=\sigma_w^2(t)+\sigma_b^2(t).
$$

$$
\textbf{Conseguenza}
$$

Poiché $\sigma^2$ dipende solo dalla distribuzione globale $p_i$ ed è indipendente da $t$, vale:
$$
\sigma_w^2(t)=\sigma^2-\sigma_b^2(t).
$$

Quindi:
$$
\boxed{
\arg\min_t\sigma_w^2(t)\;\Longleftrightarrow\;\arg\max_t\sigma_b^2(t)
}
$$

$$
\square
$$
---

##### Identificazione delle Componenti Connesse (Connected Components)

Dopo aver applicato la segmentazione basata sulla varianza (eventualmente con soglie multiple per una segmentazione multi-livello), i pixel identificati come "tono di pelle" vengono ulteriormente elaborati.

**Segmentazione iterativa con varianza cromatica locale**

I pixel rilevati come pelle vengono segmentati iterativamente utilizzando la **varianza cromatica locale**. Questo processo raffina la segmentazione iniziale considerando non solo il valore assoluto del colore di ciascun pixel, ma anche quanto è simile ai pixel vicini.

**Definizione di Componente Connessa**

Una **componente connessa** è una regione dell'immagine con le seguenti proprietà:
- Non contiene "buchi" (è una regione continua)
- Da qualsiasi pixel della regione è possibile raggiungere qualsiasi altro pixel della stessa regione senza uscire dalla regione stessa

In termini più tecnici, due pixel appartengono alla stessa componente connessa se esiste un cammino di pixel adiacenti (secondo una relazione di vicinanza, tipicamente 4-connessione o 8-connessione) che li collega, tutti appartenenti alla regione segmentata.

**Raggruppamento delle componenti**

Le componenti connesse identificate vengono raggruppate in base a:
- **Vicinanza spaziale**: componenti vicine nello spazio dell'immagine
- **Similarità cromatica**: componenti con colori simili

Questo raggruppamento produce i **candidati volti** (face candidates).

**Operatori Morfologici**

Per ottenere regioni omogenee di buona qualità, si utilizzano **operatori morfologici** come:
- **Erosione**: riduce le regioni, eliminando piccole protuberanze e rumore
- **Dilatazione**: espande le regioni, aiutando a chiudere piccoli buchi

Questi operatori permettono di "pulire" le regioni segmentate, eliminando artefatti e rendendo i contorni più regolari.

Una volta ottenute queste regioni omogenee candidate, si può procedere alla fase di verifica attraverso la localizzazione delle caratteristiche facciali specifiche.

### Fase 2: Verifica dei Candidati tramite Rilevamento delle Caratteristiche Facciali

Questa fase prende in input i candidati volti identificati nella prima fase e li verifica cercando la presenza delle caratteristiche facciali attese: occhi, bocca e contorno del volto. Se queste caratteristiche sono presenti nella configurazione geometrica corretta, il candidato viene confermato come volto reale.

#### 2.1 Localizzazione degli Occhi (Eye Localization)

Gli occhi sono elementi distintivi cruciali per il riconoscimento facciale e presentano caratteristiche sia cromatiche che di luminanza che li rendono relativamente facili da identificare.

L'algoritmo costruisce **due mappe complementari** per localizzare gli occhi:
1. **Eye Map basata sulla crominanza** (colore)
2. **Eye Map basata sulla luminanza** (luminosità)

Queste due mappe vengono poi combinate per ottenere una localizzazione robusta.

##### Mappa di Crominanza (Chrominance Map)

**Osservazione chiave**: la regione attorno agli occhi è caratterizzata da valori particolari delle componenti cromatiche. Specificamente, si osserva che:
- La componente $C_B$ (blue-difference) tende ad essere alta
- La componente $C_R$ (red-difference) tende ad essere bassa

Questo è dovuto alla morfologia dell'occhio: esiste una concavità attorno all'occhio (orbita oculare), spesso con ombre che aumentano la componente blu/scura. Inoltre, la sclera (il bianco dell'occhio) e l'iride creano contrasti cromatici caratteristici.

**Formula della Chrominance Map**:

$$
\text{EyeMap}_C = \frac{1}{3}\left[C_B^2 + \bar{C}^2_R + \left(\frac{C_B}{C_R}\right)\right]
$$

dove:
- $\bar{C}_R = 255 - C_R$ è il complemento della componente rossa
- Tutti i valori sono normalizzati nell'intervallo $[0, 255]$

**Interpretazione**: questa formula enfatizza i pixel dove $C_B$ è alto e $C_R$ è basso, producendo valori elevati proprio nelle regioni oculari.

##### Mappa di Luminanza (Luminance Map)

**Osservazione chiave**: gli occhi contengono tipicamente sia zone chiare (sclera, riflessi sulla cornea) che zone scure (pupilla, iride in molti casi, ciglia, ombra dell'orbita). Queste variazioni di luminanza possono essere evidenziate usando **operatori morfologici**.

**Formula della Luminance Map**:

$$
\text{EyeMap}_L = \frac{Y(x,y) \oplus g_\sigma(x,y)}{Y(x,y) \ominus g_\sigma(x,y) + 1}
$$

dove:
- $Y(x,y)$ è la componente di luminanza
- $\oplus$ denota l'operatore di **dilatazione morfologica**
- $\ominus$ denota l'operatore di **erosione morfologica**
- $g_\sigma(x,y)$ è un **kernel** (tipicamente Gaussiano)

**Interpretazione degli operatori morfologici**:

- **Dilatazione** ($\oplus$): espande le regioni chiare. In pratica, per ogni pixel, il valore diventa il massimo dei valori nella vicinanza definita dall'elemento strutturante. Questo ha l'effetto di "allargare" le zone luminose e "riempire" piccoli buchi scuri

- **Erosione** ($\ominus$): riduce le regioni chiare (o equivalentemente, espande le regioni scure). Per ogni pixel, il valore diventa il minimo dei valori nella vicinanza. Questo "riduce" le zone luminose e "allarga" le zone scure

Il rapporto tra dilatazione ed erosione enfatizza le regioni con alta variabilità locale di luminanza, tipiche degli occhi dove zone chiare e scure sono ravvicinate.

Il $+1$ al denominatore serve per evitare divisioni per zero.

##### Combinazione delle Mappe e Raffinamento

Il processo completo per ottenere la localizzazione finale degli occhi è:

1. **Enhancement della Chrominance Map**: la mappa cromatica viene migliorata tramite **equalizzazione dell'istogramma** (histogram equalization). Questa è un'operazione fondamentale in image processing che redistribuisce i valori di intensità in modo da utilizzare l'intero range disponibile, aumentando il contrasto. L'obiettivo è rendere equiprobabili tutti i livelli di grigio, "spalmando" la distribuzione

2. **Combinazione tramite operatore AND**: le due mappe (cromatica e di luminanza) vengono combinate attraverso un operatore AND logico (o moltiplicazione elemento per elemento dopo normalizzazione). Questo significa che un pixel viene considerato "candidato occhio" solo se ha valori elevati in **entrambe** le mappe, rendendo la detection più robusta

3. **Post-processing**:
   - **Dilatazione**: per ampliare leggermente le regioni candidate
   - **Mascheramento**: per eliminare regioni al di fuori della zona del volto candidato
   - **Normalizzazione**: per portare i valori in un range standard e scartare altre regioni facciali (come la bocca) che potrebbero dare risposte simili, mantenendo solo le regioni più "simili a occhi"

4. **Ulteriori raffinamenti**: operazioni aggiuntive (non specificate in dettaglio nell'algoritmo) permettono di perfezionare la localizzazione, ad esempio verificando che ci siano due regioni candidate alla distanza corretta l'una dall'altra

#### 2.2 Localizzazione della Bocca (Mouth Localization)

La bocca presenta caratteristiche cromatiche distintive che la rendono identificabile, specialmente nello spazio colore $YC_BC_R$.

**Osservazione chiave**: nella regione della bocca si verificano le seguenti condizioni:
- La componente $C_R$ (red-difference) è **più alta** di $C_B$ (blue-difference), a causa del colore rossastro delle labbra
- La risposta al rapporto $\frac{C_R^2}{C_B}$ è **bassa** (perché $C_B$ è relativamente basso)
- La risposta a $C_R^2$ è **alta** (perché $C_R$ è alto)

**Formula della Mouth Map**:

$$
\text{MouthMap} = C_R^2 \cdot \left[C_R^2 - \eta \cdot \frac{C_R}{C_B}\right]^2
$$

dove il parametro $\eta$ è calcolato adattivamente in base ai valori medi osservati nella maschera del volto (foreground):

$$
\eta = 0.95 \cdot \frac{\frac{1}{n}\sum_{(x,y) \in FG} C_R^2(x,y)}{\frac{1}{n}\sum_{(x,y) \in FG} \frac{C_R(x,y)}{C_B(x,y)}}
$$

con:
- $FG$: insieme dei pixel nella maschera del volto (foreground), cioè i pixel che appartengono alla regione candidata identificata nella Fase 1
- $n$: numero di pixel nella maschera del volto
- Tutti i valori $\frac{C_R^2}{C_B}$ e $C_R^2$ sono normalizzati nell'intervallo [0, 255]

**Interpretazione**: 
- Il parametro $\eta$ viene calibrato automaticamente sulla specifica immagine/volto in esame, adattandosi alle caratteristiche cromatiche locali
- La formula della MouthMap enfatizza i pixel dove $C_R$ è alto, ma penalizza quelli dove il rapporto $\frac{C_R}{C_B}$ è troppo alto (zone troppo rosse relative al blu)
- Il coefficiente 0.95 introduce un margine di tolleranza

La mappa risultante presenta valori elevati proprio nella regione della bocca, permettendone la localizzazione.

#### 2.3 Localizzazione del Contorno Facciale (Face Contour Localization)

Questa è la fase finale di verifica, dove si conferma o si scarta definitivamente ciascun candidato volto. L'approccio è basato sull'analisi della **configurazione geometrica** delle caratteristiche facciali rilevate.

**Costruzione di Triangoli**

L'algoritmo analizza tutti i possibili triangoli che possono essere formati da:
- **Due candidati occhi** (due delle regioni identificate nella fase 2.1)
- **Un candidato bocca** (una delle regioni identificate nella fase 2.2)

Ogni triangolo rappresenta un'ipotesi di volto: i due occhi formano la base superiore e la bocca il vertice inferiore.

**Verifica di Ciascun Triangolo**

Per ogni triangolo costruito, si eseguono diverse verifiche:

1. **Analisi delle variazioni di luma e del gradiente**:
   - Si verificano le variazioni di luminanza nei blob (regioni) contenenti gli occhi e la bocca
   - Si calcola la media dell'orientamento del gradiente (direzione delle variazioni di intensità) in queste regioni
   - Queste misure devono essere coerenti con le caratteristiche attese per occhi e bocca reali

2. **Verifica della geometria del triangolo**:
   - **Proporzioni**: le distanze relative tra occhi e tra occhi e bocca devono rispettare le proporzioni tipiche di un volto umano
   - **Angoli**: gli angoli del triangolo devono essere compatibili con la configurazione facciale
   - **Simmetria**: i due occhi dovrebbero essere approssimativamente alla stessa altezza

3. **Verifica dell'orientamento**:
   - Si controlla l'orientamento del triangolo rispetto all'asse verticale
   - Si preferiscono triangoli con orientamento verticale (volti dritti) rispetto a quelli molto inclinati

4. **Presenza del contorno facciale**:
   - Si verifica che attorno al triangolo sia presente un contorno coerente con quello di un volto
   - Questo può essere fatto cercando bordi con orientamento e curvatura appropriati
   - Il contorno dovrebbe formare un'ellisse approssimativa o una forma ovale che racchiude il triangolo

**Sistema di Scoring**

A ogni triangolo che soddisfa i requisiti minimi viene assegnato un **punteggio** (score) che riflette quanto bene corrisponde a un volto reale. Il punteggio tiene conto di:
- Quanto le caratteristiche rilevate (occhi e bocca) sono "forti" (valori alti nelle rispettive mappe)
- Quanto la geometria è vicina a quella ideale
- Presenza e qualità del contorno
- **Preferenza per orientamento verticale**: triangoli con orientamento più verticale ricevono punteggi più alti
- **Simmetria**: triangoli più simmetrici sono preferiti

**Selezione Finale**

Tra tutti i triangoli analizzati, vengono selezionati come **volti rilevati** quelli con:
- Punteggio **sopra una soglia** prefissata (per eliminare candidati deboli)
- **Punteggi più alti** (se ci sono multipli candidati sovrapposti, si sceglie quello migliore)

Il risultato finale è un insieme di bounding box (rettangoli di contenimento) che racchiudono i volti rilevati, con le posizioni precise di occhi e bocca.

## Algoritmo B: Viola-Jones (2004)

L'algoritmo di Viola-Jones rappresenta una vera pietra miliare nella storia della computer vision e del riconoscimento facciale. Pubblicato nel 2004, ha rivoluzionato il campo grazie a una combinazione brillante di idee che hanno reso possibile per la prima volta il rilevamento di volti in **tempo reale** su hardware comune.

### Caratteristiche Principali e Filosofia

**Approccio**: Image-based, basato interamente su tecniche di **machine learning**

**Versatilità di applicazione**: 
Sebbene sia stato sviluppato principalmente per il rilevamento di volti, l'algoritmo è sufficientemente generale da poter essere applicato al rilevamento di:
- Volti interi
- Componenti facciali specifiche (occhi, bocca, naso) in una strategia gerarchica
- Altri oggetti rigidi o semi-rigidi

**Paradigma generale di funzionamento**

L'algoritmo richiede la creazione di un **classificatore binario** face/non-face attraverso un processo di apprendimento supervisionato:

1. **Training su esempi positivi**: si forniscono al sistema moltissime istanze della classe da identificare (volti), tipicamente migliaia di immagini di volti in diverse condizioni

2. **Training su esempi negativi**: si forniscono anche molte istanze di immagini che **non contengono** oggetti della classe ma che potrebbero causare errori (paesaggi, oggetti vari, texture che potrebbero confondere il sistema)

3. **Apprendimento delle features**: il training è progettato per estrarre automaticamente caratteristiche (features) dagli esempi e selezionare quelle più discriminanti

4. **Costruzione del modello statistico**: il modello viene costruito incrementalmente durante il training, accumulando le informazioni più rilevanti per distinguere volti da non-volti

### Gestione degli Errori e Miglioramento Iterativo

Come ogni sistema di classificazione, Viola-Jones può commettere due tipi di errori:

- **Misses (Falsi Negativi)**: un volto presente nell'immagine non viene rilevato. Questo è generalmente considerato l'errore più grave, perché significa perdere informazione

- **False Alarms (Falsi Positivi)**: viene rilevato un volto dove non c'è. Questi errori sono fastidiosi ma spesso meno critici, perché possono essere filtrati con verifiche successive

**Strategia di miglioramento**: entrambi i tipi di errore possono essere ridotti attraverso **re-training**, aggiungendo nuovi esempi che coprono i casi problematici. Se il sistema sbaglia sistematicamente su certi tipi di volti (ad esempio, volti con barba, volti di bambini, volti con occhiali), aggiungendo esempi di queste categorie nel training set si migliora la performance.

### Caratteristiche Prestazionali

Una delle innovazioni fondamentali di Viola-Jones è il trade-off intelligente tra tempo di training e tempo di detection:

- **Training molto lento**: può richiedere giorni su grandi dataset, perché deve esplorare un enorme spazio di possibili features e combinazioni

- **Detection molto veloce**: una volta addestrato, il sistema può processare immagini in tempo reale (decine di frame al secondo), rendendo possibili applicazioni pratiche come webcam, sorveglianza video, fotocamere digitali

Questo è reso possibile dalle tre idee chiave che costituiscono il cuore dell'algoritmo.

### Le Tre Idee Chiave di Viola-Jones

#### 1. Integral Images (Immagini Integrali)

Le **Integral Images** sono una rappresentazione intelligente dell'immagine che permette di calcolare somme di pixel su regioni rettangolari arbitrarie in **tempo costante**, indipendentemente dalla dimensione del rettangolo.

**Definizione**: l'integral image $II(x,y)$ in un punto $(x,y)$ è definita come la somma dei valori di tutti i pixel che si trovano sopra e a sinistra di quel punto (incluso il punto stesso):

$II(x,y) = \sum_{x' \leq x, \, y' \leq y} I(x', y')$

dove $I(x', y')$ è il valore di intensità del pixel in posizione $(x', y')$ nell'immagine originale.

**Visualizzazione**: se pensiamo all'immagine come a una griglia, $II(x,y)$ è la somma di tutti i pixel nel rettangolo che ha un angolo nell'origine $(0,0)$ e l'angolo opposto in $(x,y)$.

**Calcolo efficiente dell'Integral Image**

L'integral image può essere calcolata con un singolo passaggio sull'immagine usando la formula ricorsiva:

$II(x,y) = I(x,y) + II(x-1,y) + II(x,y-1) - II(x-1,y-1)$

Questo significa che con un'unica scansione dell'immagine (complessità $O(M \times N)$ per un'immagine $M \times N$), possiamo pre-calcolare l'integral image.

**Proprietà fondamentale: calcolo rapido di somme rettangolari**

Una volta calcolata l'integral image, possiamo calcolare la somma dei pixel in **qualsiasi rettangolo** con solo **4 accessi in memoria**, indipendentemente dalla dimensione del rettangolo.

Consideriamo un rettangolo con angoli $(x_1, y_1)$ (in alto a sinistra) e $(x_2, y_2)$ (in basso a destra). La somma dei pixel in questo rettangolo è:

$\text{Sum}_{rettangolo} = II(x_2, y_2) - II(x_1-1, y_2) - II(x_2, y_1-1) + II(x_1-1, y_1-1)$

Questa è una **operazione fondamentale** per l'efficienza di Viola-Jones, perché le features sono basate proprio su somme di pixel in regioni rettangolari.

#### 2. Boosting per la Selezione delle Features

Il numero totale di possibili features in una finestra di rilevamento è **enorme** (centinaia di migliaia). Valutarle tutte a tempo di detection sarebbe computazionalmente proibitivo.

La soluzione è usare **AdaBoost** (Adaptive Boosting), un algoritmo di machine learning che:
- Seleziona automaticamente un piccolo sottoinsieme delle features più discriminanti
- Le combina in un classificatore forte (strong classifier)
- Assegna pesi diversi alle diverse features in base alla loro importanza

Il risultato è che solo poche centinaia di features (invece di centinaia di migliaia) sono sufficienti per ottenere un'ottima performance di classificazione.

#### 3. Rilevamento Multi-Scala (Multiscale Detection)

I volti possono apparire a diverse scale nell'immagine (volti grandi vicini alla telecamera, volti piccoli lontani). Per gestire questa variabilità, Viola-Jones:

- Mantiene le features a dimensione fissa
- Scala l'immagine a diverse risoluzioni (creando una **piramide di immagini**)
- Applica lo stesso detector a ogni livello della piramide

In alternativa (equivalente matematicamente ma concettualmente diverso):
- Si può mantenere l'immagine a dimensione fissa
- Scalare le features a diverse dimensioni

### Procedura di Localizzazione: Sliding Window

La localizzazione dei volti viene effettuata attraverso il paradigma della **sliding window** (finestra scorrevole):

1. Si definisce una finestra di dimensione fissa (ad esempio, 24×24 pixel)

2. Si fa "scorrere" questa finestra su tutta l'immagine, con un certo passo (step), tipicamente con overlap parziale tra posizioni consecutive

3. Per ogni posizione della finestra, si estrae la sotto-immagine corrispondente

4. Si classificano le features estratte da questa sotto-finestra come face/non-face usando il classificatore addestrato

5. Si ripete il processo a diverse scale (ridimensionando l'immagine o le features)

Le posizioni classificate come "face" vengono memorizzate. Spesso si ottengono detection multiple sovrapposte per lo stesso volto (a scale o posizioni leggermente diverse); queste vengono poi fuse in un'unica detection attraverso algoritmi di **non-maximum suppression**.

### Haar Features: I Weak Learners

Le **Haar features** (chiamate così per analogia con le wavelets di Haar) sono il cuore del sistema di detection di Viola-Jones. Sono caratteristiche rettangolari molto semplici ma sorprendentemente efficaci.

**Definizione di base**

Una Haar feature è definita da una configurazione di regioni rettangolari bianche e nere. Il valore della feature è calcolato come:

$\text{Value} = \sum \text{pixels in white area} - \sum \text{pixels in black area}$

Cioè, si sommano i valori di intensità dei pixel nelle regioni bianche e si sottraggono i valori dei pixel nelle regioni nere.

**Tipi di Haar Features**

Viola-Jones utilizza diverse configurazioni di Haar features, tra cui:

- **Two-rectangle features** (orizzontali e verticali): due rettangoli adiacenti, uno bianco e uno nero
- **Three-rectangle features**: tre rettangoli, con quello centrale di colore opposto
- **Four-rectangle features**: quattro rettangoli disposti a scacchiera

**Motivazione intuitiva**

Queste features catturano pattern locali di variazione di intensità che sono caratteristici dei volti:
- Una feature two-rectangle verticale centrata sugli occhi cattura il contrasto tra l'area scura degli occhi e l'area più chiara delle guance
- Una feature two-rectangle orizzontale sulla fronte cattura il contrasto tra fronte (chiara) e capelli (scuri)
- Una feature three-rectangle centrata sul naso cattura il contrasto tra il naso (più chiaro) e le narici/ombre laterali (più scure)

**Applicazione e Variabilità**

Ogni feature viene applicata alla sotto-finestra in esame variando:
- **Posizione**: la feature può essere posizionata in qualsiasi punto della sotto-finestra
- **Dimensione**: la feature può essere ridimensionata (mantenendo le proporzioni)
- **Forma**: si usano diverse configurazioni di rettangoli

Questo genera un numero enorme di possibili features: per una finestra di 24×24 pixel, ci sono circa 180.000 possibili Haar features!

**Calcolo Efficiente tramite Integral Image**

Grazie all'integral image, calcolare il valore di qualsiasi Haar feature richiede solo poche operazioni aritmetiche (somme e sottrazioni), indipendentemente dalla dimensione dei rettangoli coinvolti. Questo è ciò che rende praticabile la valutazione di migliaia di features in tempo reale.

### Struttura dei Classificatori

Viola-Jones costruisce un sistema di classificazione gerarchico basato su classificatori semplici (weak classifiers) combinati in modo intelligente.

#### Weak Classifier (Classificatore Debole): Decision Stump

Il classificatore più semplice è un **decision stump**, cioè un albero di decisione con un solo nodo. Questo è il tipo di weak classifier usato in Viola-Jones.

**Funzionamento**

Supponiamo di aver già costruito $M-1$ weak classifier $\{h_m(x) : m = 1, \ldots, M-1\}$ e di voler costruire il nuovo weak classifier $h_M(x)$.

Il classificatore confronta il valore di una specifica Haar feature $z_{k^*}$ con una soglia fissa $t_{k^*}$ e assegna l'etichetta +1 (face) o -1 (non-face) di conseguenza:

$h_M(x) = \begin{cases} +1 & \text{se } z_{k^*} > t_{k^*} \\ -1 & \text{altrimenti} \end{cases}$

**Determinazione dei parametri ottimali**

Come si scelgono $z_{k^*}$ (quale Haar feature usare) e $t_{k^*}$ (quale soglia applicare)?

1. **Per ogni Haar feature** $z_k$ tra le decine/centinaia di migliaia disponibili:
   - Si testano molti possibili valori di soglia $t_k$
   - Si sceglie la soglia che **minimizza l'errore di classificazione** sui dati di training

2. **Tra tutte le features**: si sceglie quella feature $z_{k^*}$ che, con la sua soglia ottimale, produce l'**errore minimo** in assoluto

In pratica, si sta eseguendo una ricerca esaustiva nello spazio features × soglie per trovare la migliore combinazione.

**Complessità del training**: se abbiamo $M$ features candidate, $N$ esempi di training e $T$ possibili soglie da testare, la complessità computazionale dell'apprendimento è $O(MNT)$, che può essere molto elevata.

#### Strong Classifier (Classificatore Forte)

Un singolo weak classifier, basato su una sola Haar feature, ha prestazioni limitate (tipicamente solo leggermente migliori del caso casuale). La potenza di AdaBoost sta nel **combinare molti weak classifiers** in un unico classificatore forte (strong classifier) $H_M(x)$.

AdaBoost:
- Impara una sequenza di weak classifiers $h_1, h_2, \ldots, h_M$
- Assegna un peso $\alpha_m$ a ciascuno in base alla sua accuratezza
- Li combina in una decisione finale pesata

Il classificatore forte finale prende la forma:

$H_M(x) = \text{sign}\left(\sum_{m=1}^{M} \alpha_m \cdot h_m(x)\right)$

dove $\alpha_m$ sono i pesi che riflettono l'importanza di ciascun weak classifier.

**Minimizzazione dell'errore**: AdaBoost è progettato per minimizzare il limite superiore (upper bound) dell'errore di classificazione di $H_M$, garantendo che il classificatore combinato sia molto più accurato dei singoli componenti.

### Cascade di Classificatori: L'Innovazione Chiave per l'Efficienza

Anche con le ottimizzazioni viste finora, valutare centinaia di features per ogni posizione della sliding window sarebbe troppo costoso per applicazioni real-time. Viola e Jones introdussero un'innovazione brillante: la **cascade di classificatori**.

**Idea chiave**: invece di applicare immediatamente tutte le features a ogni finestra, si costruisce una **catena di classificatori di complessità crescente**. Le finestre passano attraverso questa catena in sequenza, e:

- I classificatori iniziali sono molto semplici (poche features) e veloci
- Ogni classificatore è progettato per **rigettare rapidamente** la maggior parte delle finestre che certamente non contengono volti
- Solo le finestre che superano un classificatore vengono passate al successivo
- I classificatori più avanti nella catena sono più complessi e accurati

**Struttura della cascata**:

```
Sotto-finestra → [Classificatore 1] → Reiezione immediata (maggior parte)
                        ↓ (passa)
                 [Classificatore 2] → Reiezione
                        ↓ (passa)
                 [Classificatore 3] → Reiezione
                        ↓ (passa)
                       ...
                        ↓ (passa)
                 [Classificatore N] → VOLTO RILEVATO
```

**Vantaggi della cascata**:

1. **Efficienza estrema**: la maggior parte delle sotto-finestre (quelle chiaramente non contenenti volti) viene scartata nei primi stadi con poche operazioni

2. **Focus sulle regioni difficili**: solo le regioni ambigue, che potrebbero effettivamente contenere volti, arrivano agli stadi finali più costosi

3. **Controllo del trade-off**: ogni stadio può essere calibrato indipendentemente per bilanciare detection rate e false positive rate

**Training della cascata**:

Ogni classificatore nella cascata viene addestrato in modo specifico:

- Deve avere un **detection rate molto alto** (quasi 100%, ad esempio 99.9%), per non perdere volti reali
- Può permettersi un **false positive rate relativamente alto** (ad esempio 50%), perché i falsi positivi verranno filtrati dagli stadi successivi
- Viene addestrato sui **falsi positivi degli stadi precedenti**, concentrandosi sui casi difficili

**Regolazione delle soglie**:

Ogni classificatore deve regolare la propria soglia di decisione per minimizzare i **falsi negativi** (missed detections), anche a costo di aumentare i falsi positivi. Questo perché:
- Un volto perso in uno stadio iniziale non può essere recuperato
- I falsi positivi possono essere eliminati dagli stadi successivi

**Prestazioni cumulative**:

L'effetto cumulativo è potente. Ad esempio:
- Un classificatore con 20 features può raggiungere 100% detection rate con 50% false positive rate
- Se ogni stadio della cascata ha 50% false positive rate
- Dopo 10 stadi: $0.5^{10} \approx 0.1\%$ false positive rate cumulativo
- Ma il detection rate rimane altissimo (vicino al 100%) se ogni stadio è calibrato correttamente

Nella pratica, Viola e Jones riportano che:
- Un singolo classificatore con 20 features può ottenere 100% detection rate con 10% false positive rate
- Dopo la cascata completa, il false positive rate cumulativo scende a circa 2%

### Processo Completo di Localizzazione

Ricapitolando, il processo completo di localizzazione di Viola-Jones funziona così:

1. **Pre-calcolo**: si calcola l'integral image dell'intera immagine di input (operazione veloce, un solo passaggio)

2. **Multi-scala**: si crea una piramide di immagini a diverse scale, oppure si variano le dimensioni delle features

3. **Sliding Window**: per ogni scala:
   - Si fa scorrere una finestra (tipicamente 24×24 pixel) su tutta l'immagine
   - Per ogni posizione della finestra:
     - Si inizia con il primo classificatore della cascata (poche features, molto veloce)
     - Se rigettato → si passa subito alla finestra successiva
     - Se accettato → si passa al secondo classificatore
     - Si procede attraverso la cascata
     - Solo se la finestra supera **tutti** i classificatori viene marcata come "volto rilevato"

4. **Post-processing**: 
   - Tipicamente lo stesso volto viene rilevato in posizioni e scale leggermente diverse
   - Si applica **non-maximum suppression** per fondere detection multiple e ottenere una singola bounding box per volto
   - Si possono applicare ulteriori verifiche (ad esempio, verificare rapporti d'aspetto plausibili)

**Efficienza finale**:

Il risultato è un sistema che:
- Processa la maggior parte dell'immagine con classificatori molto semplici (poche operazioni per pixel)
- Dedica risorse computazionali significative solo alle poche regioni che realmente sembrano contenere volti
- Raggiunge prestazioni real-time anche su hardware non specializzato

### Prestazioni e Impatto

Il localizzatore di Viola-Jones è stato considerato uno dei più robusti ed efficienti nello stato dell'arte per molti anni ed è ancora ampiamente utilizzato come baseline o come primo stadio in sistemi più complessi.

**Caratteristiche salienti**:

- **Training**: molto lento, può richiedere giorni su dataset di decine di migliaia di immagini. Richiede GPU o cluster di calcolo per training su larga scala

- **Localizzazione**: estremamente efficiente, real-time a 15+ frame al secondo anche su CPU comuni (al momento della pubblicazione, 2004)

- **Robustezza**: buone prestazioni su volti frontali o quasi-frontali con illuminazione ragionevole

- **Limitazioni**: prestazioni degradate su:
  - Volti molto ruotati (profilo)
  - Occlusioni significative
  - Condizioni di illuminazione estreme
  - Espressioni molto intense

**Impatto storico**:

Viola-Jones ha reso possibile:
- L'autofocus delle fotocamere digitali (rilevamento volti per messa a fuoco automatica)
- Applicazioni webcam real-time
- Primi sistemi di sorveglianza automatizzata
- Basi per tecnologie successive (tag automatico nelle foto, filtri social, ecc.)

È stato implementato in librerie standard come OpenCV (funzione `cv2.CascadeClassifier`), rendendolo accessibile a chiunque.

## Valutazione della localizzazione

Per valutare le prestazioni di un sistema di **face localization** si usano comunemente le seguenti metriche:

- **False Positives**  
  Percentuale di finestre classificate come volti che **non contengono alcun volto reale**.  
  Misura quanto il sistema tende a generare falsi allarmi.

- **Not Localized Faces**  
  Percentuale di volti presenti nell’immagine che **non vengono individuati** dal sistema.  
  Indica la capacità del metodo di rilevare tutti i volti (mancate rilevazioni).

- **C-Error (Center Error)**  
  Errore di localizzazione definito come la **distanza euclidea** tra il centro reale del volto e quello stimato dal sistema, **normalizzata** rispetto alla somma degli assi dell’ellisse che contiene il volto.  
  Fornisce una misura continua della precisione della localizzazione.

## Approcci Recenti e Prospettive Future

Negli ultimi anni, il campo della localizzazione e del riconoscimento facciale ha visto progressi straordinari grazie all'avvento del deep learning.

### "Localizing Parts of Faces Using a Consensus of Exemplars"

Belhumeur et al. (2013) hanno proposto un approccio basato su **consensus of exemplars** (consenso di esemplari) che migliora la localizzazione di parti specifiche del volto.

**Idea centrale**: invece di apprendere un modello parametrico unico, si mantiene un vasto database di esempi annotati (exemplar) con distribuzioni specifiche di landmark facciali (punti caratteristici come angoli degli occhi, punta del naso, angoli della bocca).

**Funzionamento**:
- Quando arriva una nuova immagine, si confronta con gli exemplar nel database
- Si identificano gli exemplar più simili
- Le posizioni dei landmark vengono inferite tramite un "voto" pesato degli exemplar simili
- Il consenso tra multiple predizioni aumenta la robustezza

**Vantaggi**:
- Non richiede un modello esplicito della variabilità del volto
- Può gestire casi atipici se presenti nel database di exemplar
- Robusto a variazioni non previste durante il training

### Approcci Deep Learning

Gli approcci basati su reti neurali profonde hanno rivoluzionato il campo a partire dal 2015 circa.

**"From facial parts responses to face detection: A deep learning approach"** (Yang et al., 2015) rappresenta uno dei primi lavori significativi in questa direzione.

**Caratteristiche degli approcci deep**:

- **Meccanismo chiave**: invece di features hand-crafted (progettate manualmente) come le Haar features, le reti neurali apprendono automaticamente rappresentazioni gerarchiche dei dati

- **Scoring della probabilità di volto**: si basa sulle risposte di una rete neurale profonda a parti facciali locali, combinando informazioni a diversi livelli di astrazione

- **Partness maps** (mappe di "presenza di parti"): la rete genera mappe di risposta che indicano quanto è probabile che in ogni posizione dell'immagine sia presente una parte facciale (occhio, naso, bocca)

- **Full image processing**: un vantaggio importante è che queste mappe vengono generate sull'immagine completa in un unico forward pass della rete, senza necessità di rilevamento preliminare del volto o sliding window esplicite

- **End-to-end learning**: l'intero sistema può essere addestrato end-to-end, ottimizzando direttamente l'obiettivo finale (localizzazione accurata) invece di ottimizzare passi intermedi separatamente

**Vantaggi del deep learning**:
- Accuratezza superiore, specialmente in condizioni difficili
- Robustezza a variazioni estreme di posa, illuminazione, occlusione
- Capacità di generalizzare a volti mai visti
- Possibilità di joint learning (apprendere simultaneamente detection, localizzazione e riconoscimento)

**Sfide**:
- Richiede dataset molto grandi (milioni di immagini)
- Training computazionalmente intensivo (richiede GPU potenti)
- Modelli più complessi e meno interpretabili
- Possibili bias se i dati di training non sono bilanciati

## Strumenti Moderni per la Detection

Oggi abbiamo a disposizione diverse librerie e framework che rendono il riconoscimento facciale accessibile anche a chi non è un esperto di machine learning.

**dlib** offre due approcci complementari. Il primo usa HOG (Histogram of Gradients) combinato con una SVM lineare: è veloce ed efficiente, funziona bene con volti grandi e frontali, ma fatica quando il volto è piccolo, ruotato o parzialmente coperto. Il secondo è un rilevatore CNN basato su Max-Margin Object Detection, molto più robusto e capace di gestire angolazioni diverse, condizioni di luce difficili e occlusioni. Una volta rilevato il volto, dlib può anche identificare 68 punti di riferimento facciali, permettendo analisi dettagliate della geometria del viso.

**MediaPipe**, sviluppato da Google, rappresenta un'altra soluzione moderna. Può processare sia immagini singole che stream video continui, rilevando i volti e identificando punti chiave come occhi, punta del naso, bocca e i tragion (i punti dove l'orecchio si attacca alla testa). È progettato per essere veloce ed efficiente, ideale per applicazioni mobile e real-time.

**YOLO** (You Only Look Once) merita una menzione particolare. Anche se nato come architettura generale per il riconoscimento di oggetti, è stato adattato con successo anche per il rilevamento di volti, portando l'approccio "guarda una volta sola" anche in questo dominio.

## Il Percorso Evolutivo

Guardando indietro, possiamo vedere un'evoluzione chiara. Negli anni '90 e 2000 dominavano i metodi feature-based, che richiedevano una profonda conoscenza del dominio per progettare le caratteristiche giuste da estrarre. Nel decennio successivo, Viola-Jones e simili hanno rappresentato un compromesso intelligente tra efficienza computazionale e accuratezza. Dal 2010 in poi, il deep learning ha portato a sistemi che raggiungono prestazioni quasi umane, e in alcuni casi le superano.


## Conclusioni e Direzioni Future

La localizzazione e il riconoscimento facciale hanno fatto progressi straordinari negli ultimi decenni, passando da sistemi sperimentali funzionanti solo in condizioni controllate a tecnologie robuste utilizzate quotidianamente da miliardi di persone.

**Evoluzione degli approcci**:
- Dai metodi feature-based (anni '90-2000) che richiedevano expertise del dominio
- Ai metodi basati su machine learning classico come Viola-Jones (2000-2010) che bilanciano efficienza e accuratezza
- Ai moderni approcci deep learning (2010-presente) che raggiungono prestazioni quasi-umane

**Sfide ancora aperte**:
- Equità e bias: garantire che i sistemi funzionino bene per tutte le etnie, età, generi
- Privacy e consenso: bilanciare utilità e diritti individuali
- Robustezza ad attacchi adversarial: difendersi da tentativi deliberati di ingannare i sistemi
- Riconoscimento in condizioni estreme: occlusioni massive, pose estreme, invecchiamento significativo

**Applicazioni emergenti**:
- Autenticazione biometrica ubiqua
- Analisi delle emozioni e affective computing
- Accessibilità per persone con disabilità
- Realtà aumentata e virtuale
- Medicina (diagnosi di patologie da caratteristiche facciali)

La ricerca continua, spinta sia dalle sfide tecniche ancora aperte che dalle nuove applicazioni emergenti, sempre con l'attenzione necessaria alle implicazioni etiche e sociali di queste tecnologie potenti.