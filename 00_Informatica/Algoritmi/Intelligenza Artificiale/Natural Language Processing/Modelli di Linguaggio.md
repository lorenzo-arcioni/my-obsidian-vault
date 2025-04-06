# Modelli di Linguaggio

I modelli di linguaggio sono sistemi di intelligenza artificiale addestrati per comprendere, generare e manipolare il linguaggio umano. Utilizzano architetture avanzate (come i **[[Transformers|transformers]]**) per prevedere sequenze di parole o caratteri basandosi sul contesto. In particolare, sono distribuzioni probabilistiche sulle sequenze di parole, che permettono di prevedere il prossimo token in base al contesto precedente.

Per un approfondimento sui linguaggi, [[Gerarchia di Chomsky|qui]].

## Perché Distribuzioni Probabilistiche?

### Limiti delle Grammatiche Formali
- **Modelli "Binari"**:  
  Le grammatiche formali (es. regolari, context-free) definiscono regole rigide per determinare se una frase è *legal* o meno in una lingua (approccio **0/1**).  
  → **Problema**: Il linguaggio naturale è ambiguo, flessibile e dipendente dal contesto.  
  Esempio: *"Leggo un libro sul volo"* può essere interpretato in modo diverso (lettura *su* un argomento vs. lettura *fisicamente sopra* un oggetto).

### Vantaggi dei Modelli Probabilistici
1. **Gestione dell'incertezza**:  
   Assegnano una **probabilità** a ogni frase/stringa, riflettendo la sua "naturalezza" o plausibilità nel contesto reale.  
   → Utile per: disambiguazione, ranking di ipotesi, generazione fluida.

2. **Adattabilità al mondo reale**:  
   - Modellano variazioni linguistiche (dialetti, errori ortografici, slang).  
   - Tengono conto di correlazioni statistiche tra parole (es. *"caffè"* → alta probabilità di *"bere"* o *"tazzina"*).

3. **Fondamento per NLP moderno**:  
   Consentono di:  
   - Addestrare modelli su corpora non perfetti (es. web text con rumore).  
   - Ottimizzare task come traduzione o riconoscimento vocale tramite massimizzazione della likelihood.

> 📊 **Esempio Pratico**:  
> Un modello probabilistico può assegnare:  
> - P(*"Il gatto corre sul tetto"*) = 0.85  
> - P(*"Il tetto corre sul gatto"*) = 0.02  
> Pur essendo entrambe frasi *sintatticamente corrette*, la probabilità riflette la plausibilità semantica.

### Confronto Chiave
| **Approccio**         | Grammatiche Formali         | Modelli Probabilistici      |
|------------------------|-----------------------------|-----------------------------|
| **Output**             | Binario (accetta/rigetta)   | Probabilità continua        |
| **Flessibilità**       | Bassa (regole fisse)        | Alta (apprendimento dati)   |
| **Gestione Ambiguità** | Limitata                    | Ottimizzata                 |
| **Use Case**           | Compilatori, parser semplici| NLP, generazione testo      |

Prima di proseguire, è bene aver compreso a pieno le [[Basi di Probabilità]].

## Previsione Probabilistica del completamento delle frasi
Un modello linguistico supporta la previsione del completamento di una frase:
- **Esempi**:
  - *Please turn off your cell _____*
  - *Your program does not ______*
  - I sistemi di input predittivo possono indovinare ciò che stai scrivendo e suggerire opzioni di completamento.

### Approccio statistico alla previsione delle parole
L'obiettivo è prevedere la parola successiva in una frase o correggere un errore ortografico utilizzando **probabilità condizionate** basate sul contesto precedente.

**Definizioni**:

- $w$: una data parola.

- $\mathbb{P}(w_1, \ldots, w_n)$: rappresenta la **probabilità congiunta** dell’intera sequenza di parole $(w_1, w_2, \dots, w_n)$, ovvero la probabilità di ottenere proprio questa specifica sequenza di parole in un dato contesto (per esempio, un modello di linguaggio).
- $\mathbb P(w_n | w_1, w_2, ..., w_{n-1})$: è la probabilità che, data la sequenza di parole $w_1, \ldots, w_{n-1}$ (già presenti nel contesto), la prossima parola sia $w_n$.

**Esempio**: Se consideriamo una frase come *"oggi piove molto"*, la probabilità congiunta $\mathbb{P}(\text{"oggi"}, \text{"piove"}, \text{"molto"})$ indica quanto questa sequenza sia comune nel linguaggio naturale.

**Esempio**: Se consideriamo una frase come *"the pen is on the"*, la probabilità che la prossima parola sia "table" è $\mathbb P("table" | "the", "pen", "is", "on")$.

### Stima delle frequenze relative
Per stimare queste probabilità su un **corpus molto ampio**:
1. **Probabilità congiunta** (sequenza completa). Si conta il numero totale di parole $N$:
   $$\mathbb P(w_1, ..., w_n) = \frac{\text{Conteggio della sequenza } w_1, ..., w_n}{\text{Conteggio della sequenza } w_1, ..., w_{n-1}} = \frac{C(w_1, ..., w_n)}{N}$$
2. **Probabilità condizionata** (parola successiva). Si conta quante volte una sequenza specifica occorre:
   $$\mathbb P(w_n | w_1, ..., w_{n-1}) = \frac{\text{Conteggio della sequenza } w_1, ..., w_n}{\text{Conteggio della sequenza } w_1, ..., w_{n-1}} = \frac{C(w_1, ..., w_{n-1}, w_n)}{C(w_1, ..., w_{n-1})}$$
   Questo metodo è chiamato **stima della frequenza relativa**.

### Vantaggi e svantaggi della stima a frequenza relativa
**Vantaggi**:
- La stima a frequenza relativa è una *Stima di Massima Verosimiglianza (MLE)*:
  - Dato un modello, l'MLE produce la probabilità massima ottenibile dai dati disponibili.

**Svantaggi**:
- Richiede un corpus **ESTREMAMENTE GRANDE** per stime accurate.
- Computazionalmente impraticabile per sequenze lunghe o contesti complessi.

Ci serve un modo più efficiente per stimare $\mathbb{P}(w_1, \ldots, w_n)$.

### $N$-grams models

L'idea alla base dei modelli N-grams è **semplificare il calcolo delle probabilità linguistiche** evitando di considerare l'intera storia del contesto. Si utilizza invece un'approssimazione basata sulla **proprietà di Markov**:

> "La probabilità di una parola dipende solo dalle ultime $N-1$ parole precedenti"

**Formula generale**:
$$\mathbb P(w_n | w_1, ..., w_{n-1}) \approx P(w_n | w_{n-N+1}, ..., w_{n-1})$$

Utilizziamo l'indice $N-1$ perché $N$ rappresenta il numero di parole considerate, ma dato che una è l'$n$-esima (quella che dobbiamo predire), dobbiamo considerare il contesto precedente di $N-1$ parole. 

Questo significa che per predire la prossima parola $w_n$, ci basiamo sulle $N-1$ precedenti, ovvero $w_{n-N+1}, ..., w_{n-1}$. Che intuitivamente ha senso, in quanto la parola $w_n$ sarà molto più fortemente influenzata dalle precedenti più vicine che da quelle più distanti.

Quindi, grazie alla **proprietà di Markov**, abbiamo che 

$$
\mathbb{P}(w_1, \ldots, w_n) \approx \prod_{k=1}^n \mathbb P(w_k \mid w_{k-N+1}, \ldots, w_{k-1})
$$

Qui stiamo approssimando la probabilità congiunta usando un'ipotesi di dipendenza limitata. 

Cosa significa questa espressione?  
- Si tratta di un **prodotto** di probabilità condizionate.  
- Ogni termine $\mathbb{P}(w_k \mid w_{k-N+1}, \ldots, w_{k-1})$ rappresenta **la probabilità che la parola $w_k$ appaia, dato il contesto delle $N-1$ parole precedenti**.  
- Stiamo assumendo che la probabilità di una parola dipenda solo dalle ultime $N-1$ parole, e non dall'intera sequenza precedente.  

**Interpretazione intuitiva**:  
- Invece di considerare tutta la sequenza passata, **usiamo solo una finestra di dimensione $N-1$** per predire la parola successiva.  
- Questo semplifica i calcoli e rende il modello computazionalmente gestibile.  

**Esempio** (modello bigramma, $N=2$):  
Se vogliamo stimare la probabilità di *"oggi piove molto"*, e assumiamo che ogni parola dipenda solo dalla precedente (**modello bigramma**), la formula diventa:  

$$
\mathbb{P}(\text{"oggi"}, \text{"piove"}, \text{"molto"}) \approx \mathbb{P}(\text{"oggi"}) \cdot \mathbb{P}(\text{"piove"} \mid \text{"oggi"}) \cdot \mathbb{P}(\text{"molto"} \mid \text{"piove"})
$$

- **$\mathbb{P}(\text{"oggi"})$**: probabilità che inizi la frase con "oggi".  
- **$\mathbb{P}(\text{"piove"} \mid \text{"oggi"})$**: probabilità che "piove" segua "oggi".  
- **$\mathbb{P}(\text{"molto"} \mid \text{"piove"})$**: probabilità che "molto" segua "piove".  

In un **modello trigramma** ($N=3$), invece, avremmo:  

$$
\mathbb{P}(\text{"oggi"}, \text{"piove"}, \text{"molto"}) \approx \mathbb{P}(\text{"oggi"}) \cdot \mathbb{P}(\text{"piove"} \mid \text{"oggi"}) \cdot \mathbb{P}(\text{"molto"} \mid \text{"oggi"}, \text{"piove"})
$$

Qui, ogni parola dipende **da entrambe le precedenti**, anziché solo dall'ultima.  

### Perché questa approssimazione?
- **Motivazione computazionale**: Calcolare la probabilità esatta di una sequenza lunga è **impraticabile** perché: 
  - Se il nostro vocabolario ha, per esempio, **20.000 parole**, allora una sequenza di 5 parole può teoricamente assumere $20.000^5 = 3.2 \times 10^{23}$ combinazioni possibili! Questo significa che per stimare accuratamente tutte le probabilità congiunte necessarie, dovremmo raccogliere un **enorme numero di esempi** per coprire tutte le possibili frasi. Con questa approssimazione, invece, **riduciamo drasticamente la complessità**, poiché stimiamo ogni parola solo in base a un numero **limitato** di parole precedenti.  
- **Motivazione linguistica**: In molti casi il contesto rilevante è **localizzato** (es. in italiano "fare ___ colazione" richiede quasi sempre "la") e molti costrutti grammaticali si basano solo su "poche" parole precedenti. Questo significa che la **proprietà di Markov** funziona bene per stimare le probabilità linguistiche.

### Differenze nei valori di $N$

Un aspetto fondamentale nei modelli basati su n-grammi è la scelta del valore di $N$. Questo parametro determina quante parole precedenti vengono considerate nel calcolo della probabilità di una parola successiva.  

- **Un valore più grande di $N$ implica che:**  
  - Il modello ha **più informazioni sul contesto**, poiché considera una finestra più ampia di parole precedenti.  
  - Questo porta a una **maggiore capacità discriminativa**, cioè il modello è più preciso nel prevedere la parola successiva in base a un contesto più dettagliato.  
  - Tuttavia, **cresce il problema della scarsità dei dati** (*data sparseness*):  
    - Le combinazioni di parole diventano più numerose, quindi molte sequenze potrebbero non comparire mai nel dataset di addestramento.  
    - Questo porta a difficoltà nella stima delle probabilità, poiché alcuni n-grammi potrebbero avere conteggi molto bassi o addirittura nulli.  

- **Un valore più piccolo di $N$ implica che:**  
  - Il modello ha **meno precisione**, poiché considera un contesto più limitato.  
  - Tuttavia, ci sono **più esempi nel dataset** che corrispondono a ciascun n-gramma.  
  - Questo rende le **stime probabilistiche più affidabili**, poiché è meno probabile che ci siano sequenze con frequenza nulla.  

In pratica, c'è un **compromesso** nella scelta di $N$:  
- Un valore più grande di $N$ aiuta a catturare meglio la struttura del linguaggio ma aumenta il rischio di dati insufficienti.  
- Un valore più piccolo riduce la precisione ma garantisce un modello più stabile e generalizzabile.  

Per affrontare il problema della scarsità dei dati nei modelli con $N$ elevato, si utilizzano tecniche come **smoothing**, **backoff** e **modelli neurali** come le reti ricorrenti (*RNN*) o i Transformer.

### Riassumendo
I modelli **N-gram** approssimano la probabilità di sequenze di parole utilizzando contesti limitati di $N-1$ parole precedenti.  Se consideriamo una sequenza di parole $w_{1}^n = w_1, w_2, ..., w_n$ con $n$ parole, abbiamo:
- **Regola della catena delle probabilità**:  
  $$
  P(w_1^n) = \prod_{k=1}^n P(w_k \mid w_1^{k-1})
  $$  
  Calcola la probabilità di una frase scomponendola in probabilità condizionate di ogni parola dato l'intero contesto precedente.  

- **Approssimazioni**:  
  - **Bigramma** ($N=2$): Considera solo la parola precedente:  
    $$
    P(w_1^n) = \prod_{k=1}^n P(w_k \mid w_{k-1})
    $$  
  - **N-gramma** ($N$ generico): Utilizza le ultime $N-1$ parole:  
    $$
    P(w_1^n) = \prod_{k=1}^n P(w_k \mid w_{k-N+1}^{k-1})
    $$  

#### Stima delle Probabilità con Frequenze Relative  
Le probabilità condizionate si stimano dai conteggi delle sequenze nel corpus:  
- **Bigramma**:  
  $$
  P(w_n \mid w_{n-1}) = \frac{C(w_{n-1}w_n)}{C(w_{n-1})}
  $$  
  Esempio: Se "cane" appare 100 volte e "cane abbaia" 30 volte, $P(\text{abbaia} \mid \text{cane}) = 0.3$.  

- **N-gramma**:  
  $$
  P(w_n \mid w_{n-N+1}^{n-1}) = \frac{C(w_{n-N+1}^{n-1}w_n)}{C(w_{n-N+1}^{n-1})}
  $$  
  Esempio: Per un trigramma ($N=3$), $P(\text{mangia} \mid \text{il, cane}) = \frac{C(\text{il cane mangia})}{C(\text{il cane})}$.  

Questo approccio si basa sulla **frequenza relativa** delle sequenze, rendendolo semplice ma sensibile alla sparsità dei dati per $N$ elevati. 

This [[The Berkeley Restourant Project (BERP) Corpus]] is an exercise for you!

### Legge di Zipf

#### Introduzione
La **Legge di Zipf** (dal linguista George Kingsley Zipf, 1902-1950) è un principio empirico che descrive la relazione tra la frequenza di un elemento e la sua posizione ("rango") in una lista ordinata. Nella linguistica, stabilisce che:

> "La frequenza di una parola è inversamente proporzionale al suo rango."

Il **rango** ($r$) di una parola è la sua posizione in una lista ordinata per frequenza decrescente.

#### Formulazione Matematica
Per un corpus testuale, la legge è espressa come:

$$
f(r) = \frac{C}{r^s}
$$

Dove:
- $f(r)$: frequenza della parola di rango $r$
- $C$: costante di normalizzazione
- $s$: esponente caratteristico (≈1 per molte lingue naturali)

In termini semplificati:
- La parola più frequente ($r=1$) occorrerà circa 2 volte più spesso della seconda ($r=2$), 3 volte più spesso della terza ($r=3$), ecc.

#### Esempi Pratici

| Rango | Parola (Inglese) | Frequenza Relativa |
|-------|------------------|--------------------|
| 1     | the              | 7%                 |
| 2     | of               | 3.5%               |
| 3     | and              | 2.3%               |
| 10    | they             | 0.7%               |

<img src="/home/lorenzo/Documenti/GitHub/my-obsidian-vault/images/Zipf's_law_on_War_and_Peace.png" alt="Zipf's law on War and Peace" width="80%" style="display: block; margin-left: auto; margin-right: auto; align: center">

*Figura 1: Nelle lingue, in generale, si osserva la presenza di un piccolo numero di parole con frequenza elevata (rango piu basso) e un grande numero di parole con frequenza bassa (rango piu alto).*

#### Applicazioni
La legge si osserva in:
1. **Linguistica**: distribuzione parole nei testi
2. **Demografia**: dimensione delle città
3. **Informatica**: frequenza accessi a pagine web
4. **Economia**: distribuzione del reddito

#### Limiti
- Funziona meglio su grandi dataset
- L'esponente $s$ può variare tra 0.8-1.2
- Non spiega il "perché" del fenomeno

$$
\begin{aligned}
\text{Per } s=1: \quad &f(r) \propto \frac{1}{r} \\
& \sum_{r=1}^{\infty} \frac{1}{r} \to \infty \quad (\text{Serie armonica divergente})
\end{aligned}
$$

#### Curiosità
Lo stesso Zipf paragonò il fenomeno al "principio del minimo sforzo" in natura. Studi recenti lo collegano a:
- Dinamiche di ottimizzazione
- Processi stocastici
- Auto-organizzazione critica

## Limiti e Problematiche

I modelli linguistici basati su n-grammi presentano diverse limitazioni intrinseche:

### 1. Sparse Data e Zero Probability
- **N-grammi non osservati**:  
  Sequenze plausibili ma assenti nel training set ricevono probabilità zero:  
  $$P(w_n | w_{n-N+1}, ..., w_{n-1}) = 0 \quad \text{se } C(w_{n-N+1}, ..., w_n) = 0$$  
  → **Impatto**:  
  - Frasi valide nel test set ottengono perplexity infinita.  
  - Impossibilità di generalizzare a combinazioni non viste (es. *"cane mangia kiwi"*).  
  > *Soluzione*: Tecniche di smoothing (approfondite in dettaglio [[Smoothing nei Modelli Linguistici|qui]]).

### 2. Finestra Contestuale Limitata
- **Dipendenza da N fissato**:
  Con un modello basato su n-gram, il contesto considerato è limitato a $N-1$ parole.
  - Con N=3 (trigrammi), il modello ignora parole oltre le ultime 2:  
    *"Ieri ho visitato il museo egizio che ___"* → Il contesto rilevante ("museo") potrebbe essere troppo lontano.  
  - **Esempio**: In *"La ragazza con gli occhiali da sole che ___"*, la scelta di "indossava" vs "rompe" dipende da "occhiali", non dalle ultime 2 parole ("che" e "sole").

### 3. Incapacità di Modellare Strutture Complesse
- **Dipendenza dall'ordine locale**:  
  Non catturano fenomeni linguistici che richiedono memoria a lungo termine:  
  - Accordi verbali: *"Le donne che hanno ___"* (richiede accordo plurale)  
  - Riferimenti anaforici: *"Marco disse a Luca di comprare il pane. Poi ___ uscì"* (chi uscì?)

- **Ambiguità lessicale**:  
  Non distinguono significati multipli in base al contesto globale:  
  $$P(\text{bank} | \text{river}) ≈ P(\text{bank} | \text{money})$$  
  (manca comprensione semantica di "bank" come "sponda" vs "banca").

### 4. Overhead Computazionale
- **Crescita esponenziale dello spazio**:  
  Per un vocabolario di 50k parole:  
  - Bigrammi: $50k^2 = 2.5$ miliardi di parametri  
  - Trigrammi: $50k^3 = 125$ trilioni di parametri  
  → **Problema**: Memorizzazione e query inefficienti anche per N moderati.

    → **Soluzione**: Utilizzare tecniche di compressione (es. Huffman coding) e pruning.

### 5. Sensibilità al Corpus di Training
- **Bias statistici**:  
  Riproducono stereotipi presenti nei dati:  
  - *"L'infermiere ___"* → Probabilità alta per "lei" (se il corpus ha prevalenza femminile nel ruolo)  
  - *"Il CEO di successo ___"* → Associazioni di genere/culturali distorte  

- **Out-Of-Vocabulary (OOV)**:  
  Parole nuove (slang, nomi propri, errori) non presenti nel training set vengono gestite male:  
  $$
  \mathbb P(\text{"Il nuovo NFT"}) = 0 \quad \text{se "NFT" non è nel vocabolario}
  $$

### 6. Apprendimento Superficiale
- **Modellano correlazioni, non causalità**:  
  Apprendono pattern statistici senza comprensione logica:  
  - *"Se piove, prendo l'ombrello"* → Alta probabilità  
  - *"Se prendo l'ombrello, piove"* → Probabilità simile (manca relazione causale)  

- **Assenza di world knowledge**:  
  Non integrano informazioni esterne:  
  $$P(\text{"Roma"} | \text{"La capitale d'Italia è"}) = 0$$  
  Anche se "Roma" è l'unica risposta corretta, il modello assegna probabilità basate solo sui bigrammi/trigrammi osservati.

## Argomenti Collegati
- [[Valutazione dei Modelli di Linguaggio]]
- [[Smoothing nei Modelli Linguistici]]
- [[Pruning e Compressione nei Modelli NLP]]
- [[Bias e Fairness nell'Elaborazione del Linguaggio Naturale]]

## Conclusione
I modelli linguistici basati su n-gram hanno rappresentato una tappa fondamentale nello sviluppo dell'NLP, ma presentano notevoli limitazioni: dalla gestione della sparsenza e del problema degli n-grammi non osservati, alla finestra contestuale limitata e alla difficoltà nel modellare strutture linguistiche complesse. Inoltre, l'esponenziale crescita dello spazio delle combinazioni e la sensibilità ai bias del corpus di training evidenziano il bisogno di approcci più sofisticati. Questi limiti hanno favorito l'evoluzione verso modelli neurali e architetture transformer, capaci di integrare contesto e conoscenza semantica in maniera più efficace, aprendo la strada a progressi significativi nel campo dell'elaborazione del linguaggio naturale.
