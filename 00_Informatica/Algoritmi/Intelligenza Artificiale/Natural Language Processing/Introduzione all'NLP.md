# **Parole, Corpora e Normalizzazione: Concetti Base**

L'elaborazione del linguaggio naturale (NLP) si basa su concetti fondamentali come **corpora**, **parole** e **normalizzazione**. Comprendere queste nozioni è essenziale per pre-elaborare i dati e costruire modelli linguistici efficaci.


## **1. Corpus (pl. Corpora)**  
Un **corpus** è una raccolta strutturata e digitale di testi o discorsi, spesso utilizzata per analisi linguistiche o per addestrare modelli NLP.  

### **Caratteristiche principali**
- **Strutturato**: Organizzato secondo criteri specifici (es. testi scritti vs. parlati).  
- **Digitale**: Formato leggibile da un computer per l'elaborazione automatica.  
- **Annotato (opzionale)**: Alcuni corpora contengono metadati come parti del discorso (*POS tagging*), analisi sintattica o entità nominate (*NER*).  

### **Esempi di corpora noti**
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

### **Utilizzo dei corpora**
- **Addestramento di modelli linguistici** (es. Word2Vec, BERT).  
- **Studio della frequenza delle parole** per identificare termini comuni e rari.  
- **Analisi del contesto d'uso** di parole e frasi in lingue diverse.  


## **2. Utterance (Enunciato)**  
Un **utterance** è un'unità di discorso parlato, spesso diversa dal testo scritto perché riflette le caratteristiche spontanee del linguaggio orale.  

### **Caratteristiche del linguaggio parlato**
- **Disfluenze**: Interruzioni naturali del discorso come pause e esitazioni.  
  - *Esempio*: "I do **uh** mainly business data processing."  
- **Ripetizioni**: Riformulazioni di parole per correggersi o enfatizzare un punto.  
  - *Esempio*: "I do **main- mainly** business data processing."  
- **Elisioni**: Omessa articolazione di alcune parole o sillabe.  
  - *Esempio*: "Gonna" invece di "Going to".  

### **Esempio di differenza tra testo scritto e parlato**
| Tipo di testo  | Esempio |
|---------------|---------|
| **Testo scritto** | "I do mainly business data processing." |
| **Discorso reale (utterance)** | "I do uh main- mainly business data processing." |

### **Applicazioni dell'analisi degli enunciati**
- **Riconoscimento vocale**: Modelli NLP per il riconoscimento automatico del parlato devono gestire disfluenze e variazioni fonetiche.  
- **Analisi della spontaneità nel linguaggio**: Utile in studi di linguistica computazionale.  


## **3. Parola: Definizione Contestuale**  
Il concetto di **parola** in NLP non è sempre univoco e dipende dal contesto di analisi.

### **Sfide nella definizione di una parola**
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


## **4. Tokenizzazione: Metodi Avanzati**  
### **Byte-Pair Encoding (BPE)**  
Algoritmo per gestire parole rare o sconosciute attraverso fusioni iterative:  
1. **Fase 1**: Inizia con un vocabolario di caratteri singoli.  
2. **Fase 2**: Unisce progressivamente le coppie di caratteri più frequenti.  
3. **Esempio**:  
   - Corpus iniziale: ["low", "lower", "newest", "wider", "new"]  
   - Dopo fusioni: ["lo", "w", "er", "new", "est"] (gestisce "low" e "newest").  

**Processo di Token Learner**:  
- **Passo 1**: Conta le coppie di simboli adiacenti (es. "e" e "r" → "er").  
- **Passo 2**: Sostituisce tutte le occorrenze della coppia nel corpus.  
- **Passo 3**: Ripete fino a ottenere un vocabolario ottimale.  

**Token Parser**:  
- Applica le regole apprese al testo di test.  
- Esempio: "newer" → ["new", "er"] se "er" è una fusione precedentemente appresa.  

> **Vantaggio**: Ideale per lingue con morfologia complessa o testi informali (social media).  


## **5. Normalizzazione del Testo**  
Processo di standardizzazione del testo per ridurre la complessità.  

### **Metodi Principali**  
1. **Case Folding**  
   - Conversione di tutto il testo in minuscolo.  
   - *Esempio*: "Woodchuck" → "woodchuck".  
   - **Limitazioni**: Perde informazioni su nomi propri e acronimi.  

2. **Lemmatizzazione**  
   - Riduzione delle parole alla forma base (**lemma**) considerando il contesto.  
   - *Esempio*: "running" → "run", "better" → "good" (aggettivo).  
   - **Strumenti**: Basati su dizionari linguistici (es. SpaCy, NLTK).  

3. **Stemming**  
   - Rimozione approssimativa di affissi senza contesto.  
   - **Porter Stemmer**:  
     - "caresses" → "caress", "ponies" → "poni".  
   - **Confronto con Lemmatizzazione**: Più veloce ma meno accurato.  


## **6. Segmentazione delle Frasi**  
Identificazione dei confini tra frasi in un testo.  

### **Strategie**  
1. **Punteggiatura**  
   - Punti esclamativi/interrogativi → Confini chiari.  
   - Punti ambigui: "Mr. Smith left at 5 p.m. He..." → Due frasi.  

2. **Dizionari di Abbreviazioni**  
   - Liste predefinite ("Dr.", "Inc.") per evitare errori.  

3. **Modelli ML**  
   - Addestrati per distinguere abbreviazioni da punti finali.  

### **Esempio con Stanford CoreNLP**  
- **Input**: "Mr. Smith arrived at 5 p.m. He greeted everyone."  
- **Output**: ["Mr. Smith arrived at 5 p.m.", "He greeted everyone."]  


> **Etichette**: #NLP #Tokenizzazione #Corpora #Normalizzazione  
> **Collegamenti**: [[Elaborazione del Testo]], [[Modelli Linguistici]], [[Strumenti NLP]]  

**Risorse**:  
- [Speech and Language Processing (Jurafsky & Martin)](https://web.stanford.edu/~jurafsky/slp3/)  
- [Byte-Pair Encoding Paper (Sennrich et al.)](https://arxiv.org/abs/1508.07909)  
- [Porter Stemmer Algorithm](https://tartarus.org/martin/PorterStemmer/)  