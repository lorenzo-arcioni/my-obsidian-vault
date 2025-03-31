# Parole, Corpora e Normalizzazione: Concetti Base

L'elaborazione del linguaggio naturale (NLP) si basa su concetti fondamentali come **corpora**, **parole** e **normalizzazione**. Comprendere queste nozioni è essenziale per pre-elaborare i dati e costruire modelli linguistici efficaci. Questi concetti caratterizzano sia i **rule-based systems** sia i modelli che si basano sulla **machine/deep learning**.

## 1. Corpus (pl. Corpora)
Un **corpus** è una raccolta strutturata e digitale di testi o discorsi, spesso utilizzata per analisi linguistiche o per addestrare modelli NLP.  

### Caratteristiche principali
- **Strutturato**: Organizzato secondo criteri specifici (es. testi scritti vs. parlati).  
- **Digitale**: Formato leggibile da un computer per l'elaborazione automatica.  
- **Annotato (opzionale)**: Alcuni corpora contengono metadati come parti del discorso (*POS tagging*), analisi sintattica o entità nominate (*NER*).  

### Esempi di corpora noti
1. **British National Corpus (BNC)**  
   - Contiene circa **100 milioni di parole** tratte da giornali, testi accademici e conversazioni.  
   - Usato per analisi lessicali, studio delle collocazioni e modellazione linguistica.  

2. **Corpus of Contemporary American English (COCA)**  
   - Include testi dal **1990 a oggi** da fonti come TV, riviste e siti web.  
   - Consente di analizzare come il linguaggio evolve nel tempo.  

3. **Penn Treebank**  
   - Corpus annotato con strutture sintattiche usato per il training di modelli NLP avanzati.  

4. **Google Books Ngram**  
   - Raccolta di milioni di libri, utile per studiare trend linguistici su scala storica.  

### Utilizzo dei corpora
- **Addestramento di modelli linguistici** (es. Word2Vec, BERT).  
- **Studio della frequenza delle parole** per identificare termini comuni e rari.  
- **Analisi del contesto d'uso** di parole e frasi in lingue diverse.  

## 2. Utterance (Enunciato)
Un **utterance** è un'unità di discorso parlato, spesso diversa dal testo scritto perché riflette le caratteristiche spontanee del linguaggio orale.  

### Caratteristiche del linguaggio parlato
- **Disfluenze**: Interruzioni naturali del discorso come pause e esitazioni.  
  - *Esempio*: "I do **uh** mainly business data processing."  
- **Ripetizioni**: Riformulazioni di parole per correggersi o enfatizzare un punto.  
  - *Esempio*: "I do **main- mainly** business data processing."  
- **Elisioni**: Omessa articolazione di alcune parole o sillabe.  
  - *Esempio*: "Gonna" invece di "Going to".  

### Esempio di differenza tra testo scritto e parlato
| Tipo di testo  | Esempio |
|---------------|---------|
| **Testo scritto** | "I do mainly business data processing." |
| **Discorso reale (utterance)** | "I do uh main- mainly business data processing." |

### Applicazioni dell'analisi degli enunciati
- **Riconoscimento vocale**: Modelli NLP per il riconoscimento automatico del parlato devono gestire disfluenze e variazioni fonetiche.  
- **Analisi della spontaneità nel linguaggio**: Utile in studi di linguistica computazionale.  

## 3. Parola: Definizione Contestuale  
Il concetto di **parola** in NLP non è sempre univoco e dipende dal contesto di analisi.  

### Definizioni Fondamentali  
- **Lemma**: Insieme di forme lessicali con la stessa radice, stessa categoria grammaticale principale e stesso significato.  
- **Wordform (Forma Parola)**: Forma completa di una parola, inclusi flessioni e derivazioni (es. "corre", "correrà").  
- **Word Types (Tipi di Parola)**: Insieme delle parole distinte in un corpus. La dimensione del vocabolario \( |V| \) rappresenta il numero di tipi.  
- **Word Tokens (Token di Parola)**: Occorrenze effettive delle parole nel testo. \( N \) indica il numero totale di token.  

### Sfide nella definizione di una parola  
1. **Punteggiatura**  
   - "gatto." e "gatto" sono lo stesso token?  
   - Alcuni modelli considerano il punto un token separato, altri lo uniscono alla parola.  
2. **Maiuscole/minuscole**  
   - "Roma" (nome proprio) vs. "roma" (nome comune per un tipo di fiore).  
   - La distinzione può essere fondamentale nel riconoscimento delle entità nominate (NER).  
3. **Contrazioni**  
   - "can't" può essere considerato:  
     - Un **unico token**.  
     - Due **token distinti**: "can" e "not".  
   - La scelta dipende dal metodo di tokenizzazione usato.  
4. **Ambiguità nelle Forme**  
   - **Parole composte**: "Hewlett-Packard" → due token o uno?  
   - **Clitici**: "what’re" → "what are", "L'ensemble" → "Le" + "ensemble"?  
   - **Numeri e date**: Formati multipli (es. "01/02/2024" vs. "1 febbraio 2024").  

## 4. Tokenizzazione e segmentazione  
La segmentazione del testo in unità significative (token) è un passo fondamentale della pre-elaborazione NLP.  

### Metodi Comuni  
- **Tokenizzazione basata su spazi** → "Il cane corre" → `["Il", "cane", "corre"]`.  
- **Rimozione della punteggiatura** → "Ciao, come stai?" → `["Ciao", "come", "stai"]`.  
- **Standard Penn Treebank**:  
  - Separa i clitici ("doesn’t" → "does" + "n’t").  
  - Mantiene le parole hyphenate unite (es. "state-of-the-art").  
  - Separa tutta la punteggiatura (es. "," e "?" come token singoli).  

### Lingue con Spaziatura Complessa  
- **Cinese e Giapponese**:  
  - Non utilizzano spazi tra le parole (es. "莎拉波娃现在居住在美国东南部的佛罗里达。").  
  - La tokenizzazione richiede modelli specifici per identificare i confini delle parole.  

### Tokenizzazione Avanzata  
- **[[Byte-Pair Encoding]] (BPE)**:  
  - Usato in GPT e BERT per gestire sottoparole.  
  - **Fasi**:  
    1. Parte da un vocabolario di caratteri singoli.  
    2. Unisce gradualmente le coppie di simboli più frequenti (es. "A" + "B" → "AB").  
    3. Ripete il processo per \( k \) volte, creando token complessi (es. "ri-cor-da-re").  

### Sfide Specifiche  
- **Espressioni multi-parola**: "San Francisco" → uno o due token?  
- **Varianti ortografiche**: "lowercase" vs. "lower-case" vs. "lower case".  
- **Riconoscimento di entità nominate**: Influenza la scelta di unire o separare token (es. "New York").  

### Tokenizzazione: Ulteriori Problemi  
- **Parole con apostrofo**: "Finland’s capital" → "Finland", "Finlands", o "Finland’s"?  
- **Decisioni contestuali**:  
  - "co-education" → un singolo token.  
  - "State of the art" → segmentazione in base al contesto.  
- **Clitici complessi**:  
  - Francese: "L'ensemble" → "L’" + "ensemble" o token unico?  
  - Tedesco: parole composte lunghe (es. "Lebensversicherungsgesellschaftsangestellter").  

### Implementazione Pratica  
- **Espressioni regolari**: Metodo comune per tokenizzazione deterministica.  
- **Strumenti avanzati**:  
  - **Token Learner**: Identifica pattern ricorrenti nel testo.  
  - **Token Parser**: Applica regole apprese per suddividere il testo.

## Normalizzazione del Testo  
Prima dell'elaborazione del linguaggio naturale, un testo deve essere normalizzato attraverso:  
1. **Tokenizzazione**: Suddivisione del testo in token.  
2. **Formattazione uniforme**: Standardizzazione di maiuscole/minuscole, punteggiatura, ecc.  
3. **Segmentazione delle frasi**: Identificazione dei confini tra frasi.  

**Etichette**: #NLP #Tokenizzazione #Corpora  
**Collegamenti**: [[Elaborazione del Testo]], [[Espressioni Regolari]], [[Modelli Linguistici]]