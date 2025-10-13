# Le Funzioni Hash e le loro Applicazioni in Crittografia e Bitcoin

## Definizione di Hash

Una funzione hash è una funzione computazionalmente efficiente che mappa stringhe binarie di lunghezza arbitraria a stringhe binarie di lunghezza fissa, chiamate hash-values (valori hash).

L'hashing è un metodo di applicazione di una funzione hash crittografica ai dati, che calcola un output relativamente unico (chiamato message digest, o semplicemente digest) per un input di quasi qualsiasi dimensione.

## Esempi di Hash con SHA-256

SHA-256 è una delle funzioni hash più utilizzate in Bitcoin e nella crittografia moderna. Ecco alcuni esempi concreti che dimostrano come anche piccole variazioni nell'input producano output completamente diversi:

- `H("Bitcoin") = b4056df6691f8dc72e56302ddad345d65fead3ead9299609a826e2344eb63aa4`
- `H("bitcoin") = 6b88c087247aa2f07ee1c5956b8e1a9f4c7f892a70e324f1bb3d161e05ca107b`
- `H("1") = 6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b`
- `H("2") = d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35`

Come si può notare, anche una piccola variazione nell'input (come la capitalizzazione di una singola lettera tra "Bitcoin" e "bitcoin") produce un hash completamente diverso e apparentemente casuale. Questa proprietà è nota come "effetto valanga" e rende le funzioni hash particolarmente utili per applicazioni crittografiche.

## Proprietà delle Funzioni Hash

### Proprietà Generali

Le funzioni hash hanno tre proprietà fondamentali che le caratterizzano:

1. **L'input può essere una stringa di qualsiasi dimensione**: Non ci sono limiti pratici alla lunghezza dei dati che possono essere processati. Puoi fare l'hash di un singolo byte o di un file di diversi gigabyte.

2. **Produce un output di dimensione fissa**: Indipendentemente dalla dimensione dell'input (che sia 1 byte o 1 terabyte), l'output ha sempre la stessa lunghezza. Per SHA-256, l'output è sempre di 256 bit (32 byte).

3. **È computazionalmente efficiente**: Il calcolo dell'hash è rapido e richiede risorse computazionali ragionevoli. Anche su hardware modesto è possibile calcolare migliaia o milioni di hash al secondo.

### Proprietà Crittografiche

Le funzioni hash crittografiche devono possedere tre proprietà aggiuntive fondamentali che le rendono sicure per applicazioni critiche:

1. **Collision-resistance** (Resistenza alle collisioni)
2. **Hiding** (Nascondimento)
3. **Puzzle-friendliness** (Adattabilità ai puzzle)

Esaminiamo ora ciascuna di queste proprietà in dettaglio.

## Collision-Resistance (Resistenza alle Collisioni)

### Definizione

Una funzione hash H è detta collision-resistant se è impossibile (in pratica, computazionalmente infeasible) trovare due valori, x e y, tali che x ≠ y, eppure H(x) = H(y).

Questa proprietà vuole garantire che nessuno possa trovare un caso in cui due diversi valori di input per la funzione hash producano lo stesso valore di output.

### Il Caso che Vogliamo Evitare

È fondamentale comprendere un aspetto teorico importante: "nessuno può trovare una collisione" è molto diverso dal dire che "non esistono collisioni". 

In realtà, per il principio del cassetto (pigeonhole principle), le collisioni esistono matematicamente e necessariamente. Consideriamo questo: se abbiamo infiniti possibili input (o anche solo 2^257 input possibili) e un numero finito di possibili output (2^256 per SHA-256), necessariamente alcuni input diversi produrranno lo stesso output. È matematicamente impossibile che sia altrimenti.

Tuttavia, la sicurezza della funzione hash sta nel fatto che trovare queste collisioni deve essere praticamente impossibile con le risorse computazionali disponibili oggi e nel futuro prevedibile. È come cercare un ago in un pagliaio delle dimensioni dell'universo conosciuto.

### La Difficoltà di Trovare una Collisione

Per comprendere quanto sia difficile trovare una collisione in una funzione hash come SHA-256, consideriamo alcuni confronti concreti e tangibili:

#### Mining di Bitcoin: Un Riferimento di Potenza Computazionale

I miner di Bitcoin, nel loro insieme, eseguono circa 2^80 operazioni di hash ogni ora. Questo rappresenta una quantità stupefacente di potenza computazionale. Questi miner utilizzano hardware specializzato chiamato ASIC (Application-Specific Integrated Circuits), progettato specificamente per eseguire operazioni di hashing il più velocemente ed efficientemente possibile.

Per mettere questo in prospettiva, consideriamo alcuni dei migliori ASIC per Bitcoin mining disponibili nel 2025:
- Antminer S21 Pro: circa 234 TH/s (terahash al secondo)
- Whatsminer M60S: circa 200 TH/s
- Avalon A1466: circa 150 TH/s

Un terahash al secondo significa 1.000.000.000.000 (un trilione) di calcoli di hash ogni secondo. E ci sono centinaia di migliaia di questi dispositivi in funzione in tutto il mondo, 24 ore al giorno, 7 giorni alla settimana.

#### Confronto con il Gratta e Vinci

La probabilità di trovare una collisione SHA-256 è enormemente più bassa della probabilità di vincere al Gratta e Vinci. 

Mentre vincere un premio importante al Gratta e Vinci può avere probabilità nell'ordine di 1 su qualche milione (ad esempio, 1 su 5.000.000 per certi biglietti), trovare una collisione SHA-256 avrebbe una probabilità nell'ordine di 1 su 2^256.

Per dare un'idea di quanto sia grande questo numero: 2^256 è approssimativamente 1.15 × 10^77, cioè un numero con 77 cifre decimali. Per confronto, si stima che ci siano circa 10^80 atomi nell'universo osservabile. Trovare una collisione SHA-256 è statisticamente più improbabile che scegliere casualmente un atomo specifico dall'intero universo!

#### Tempi Astronomici

Se prendessimo tutta la potenza di calcolo attualmente dedicata al mining di Bitcoin in tutto il mondo e la dedicassimo invece alla ricerca di collisioni SHA-256, quanto tempo ci vorrebbe?

Con la potenza di calcolo attuale (circa 2^80 hash all'ora), per esplorare tutto lo spazio 2^256 servirebbero 2^176 ore. Questo equivale a circa:
- 10^50 anni
- 10.000.000.000.000.000.000.000.000.000.000.000.000.000 anni

Per dare un contesto: l'età dell'universo è circa 13.8 miliardi di anni (1.38 × 10^10 anni). Il tempo necessario per trovare una collisione SHA-256 è più lungo dell'età dell'universo di un fattore di circa 10^40!

Anche assumendo che la potenza computazionale raddoppi ogni due anni (Legge di Moore), servirebbero comunque miliardi di anni per avere una possibilità ragionevole di trovare una collisione.

### Implicazioni Pratiche

Questa estrema difficoltà nel trovare collisioni è ciò che rende SHA-256 sicuro per:
- Verificare l'integrità dei file (se due file hanno lo stesso hash, possiamo essere praticamente certi che siano identici)
- Creare firme digitali
- Costruire blockchain (dove modificare un blocco passato richiederebbe trovare collisioni)
- Creare commitments crittografici

## Hiding (Nascondimento)

### Definizione Formale

Una funzione hash H ha la proprietà di hiding se: quando un valore secreto r è scelto da una distribuzione di probabilità che ha alta min-entropy, allora dato H(r||x) è infeasible (impossibile in pratica) trovare x.

Dove r||x rappresenta r concatenato con x (cioè, r seguito da x come un'unica stringa).

### Cos'è la Min-Entropy?

In teoria dell'informazione, la min-entropy è una misura di quanto prevedibile sia un risultato. Un'alta min-entropy cattura l'idea intuitiva che la distribuzione (cioè la variabile casuale) sia molto dispersa, molto "sparsa". 

Immaginiamo di lanciare una moneta:
- Una moneta **equa** ha alta min-entropy: non possiamo prevedere il risultato
- Una moneta **truccata** che esce sempre testa ha min-entropy zero: il risultato è completamente prevedibile

Per la proprietà di hiding, abbiamo bisogno che r sia scelto da una distribuzione con alta min-entropy, cioè che sia veramente imprevedibile.

### Spiegazione Intuitiva

In altre parole, la proprietà di hiding ci dice: se ci viene dato l'output della funzione hash H(r||x) = y, non c'è modo computazionalmente fattibile di capire quale fosse l'input x, assumendo che r sia stato scelto in modo sufficientemente casuale.

Questa proprietà è fondamentale perché ci permette di "nascondere" informazioni: possiamo pubblicare l'hash di un valore senza rivelare il valore stesso.

### Esempio Dettagliato: Testa o Croce

Vediamo un esempio pratico e dettagliato per capire sia il problema che la soluzione.

#### Scenario Iniziale

Alice sta giocando a testa o croce. Il gioco funziona così:
1. Alice lancia una moneta
2. Eve deve indovinare il risultato prima che Alice lo riveli
3. Poi Alice rivela il risultato e verifica se Eve ha indovinato correttamente

Ma c'è un problema di fiducia: Eve potrebbe non fidarsi che Alice non cambi il risultato dopo aver sentito la sua previsione. Come possiamo rendere il gioco equo e a prova di imbroglio?

#### Tentativo 1: Usare l'Hash (Senza Nascondimento)

Alice ha un'idea: invece di rivelare direttamente il risultato, rivelerà solo l'hash del risultato.

1. Alice lancia la moneta
2. Alice calcola:
   - Se è testa: H(testa) = a
   - Se è croce: H(croce) = b
3. Alice invia ad Eve solo l'hash (a oppure b)
4. Eve fa la sua previsione
5. Alice rivela il risultato originale
6. Eve può verificare che H(risultato) corrisponda all'hash ricevuto

**Il problema con questo approccio:**

Se Eve conosce la funzione hash (e dovrebbe conoscerla, altrimenti non può verificare) e conosce l'insieme dei possibili output (testa o croce), può semplicemente pre-calcolare tutti i possibili hash:

```
H(testa) = a
H(croce) = b
```

Quando riceve l'hash da Alice, Eve può semplicemente confrontarlo con i suoi hash pre-calcolati:
- Se riceve "a", sa che è testa
- Se riceve "b", sa che è croce

Eve può facilmente capire il risultato del lancio della moneta prima ancora di fare la sua "previsione", rendendo il gioco inutile!

Questo accade perché l'insieme dei possibili input {testa, croce} è molto piccolo e ha bassa min-entropy. Non è "disperso" - ci sono solo due possibilità.

#### Soluzione: Concatenazione con un Valore Casuale (Nonce)

È possibile nascondere un input che non è molto disperso concatenandolo con un altro input che è molto disperso. Ecco come:

1. **Alice genera un nonce casuale**: Alice sceglie un numero casuale r molto grande, per esempio un numero di 256 bit. Questo r ha alta min-entropy perché è stato scelto casualmente da un insieme enorme (2^256 possibilità).

2. **Alice concatena il risultato con il nonce**: Alice calcola:
   - Se testa: H(testa || r) = s
   - Se croce: H(croce || r) = s
   
3. **Alice invia l'hash ad Eve**: Eve riceve l's' ma non può determinare se era testa o croce

4. **Perché Eve non può più imbrogliare?** 
   - Anche se Eve sa che i possibili input sono {testa, croce}, non conosce r
   - Per pre-calcolare gli hash, dovrebbe calcolare:
     - H(testa || r) per ogni possibile valore di r
     - H(croce || r) per ogni possibile valore di r
   - Ma ci sono 2^256 possibili valori di r!
   - Anche con la potenza computazionale di tutti i Bitcoin miner del mondo, ci vorrebbero miliardi di anni

5. **Eve fa la sua previsione**: Senza poter determinare il risultato, Eve deve fare una vera previsione

6. **Alice rivela tutto**: Dopo che Eve ha fatto la sua previsione, Alice rivela sia il risultato (testa o croce) che il nonce r

7. **Verifica**: Eve può ora verificare che H(risultato || r) = s, confermando che Alice non ha imbrogliato

### Applicazioni Pratiche della Proprietà di Hiding

Questa proprietà è utilizzata in molti contesti:
- **Commitments**: Come vedremo nella prossima sezione
- **Password hashing**: Le password sono spesso concatenate con un "salt" (equivalente del nostro nonce r) prima di essere hashate
- **Blockchain**: Le transazioni possono essere "nascoste" usando tecniche simili
- **Zero-knowledge proofs**: Dove si vuole provare la conoscenza di qualcosa senza rivelarlo

## Applicazione: Commitments (Impegni Crittografici)

### Obiettivo

Permettere a una parte di fissare un valore in modo che sia sia **binding** (vincolante - il valore non può essere cambiato successivamente) che **hiding** (nascosto - il valore non viene rivelato finché non viene intenzionalmente aperto).

### Motivazione e Contesto

Nella vita quotidiana ci sono molte situazioni dove vorremmo poter "impegnarci" su qualcosa senza rivelarlo immediatamente. Alcuni esempi:
- Fare una previsione su un evento futuro senza rivelare la previsione
- Partecipare a un'asta sigillata dove tutti fanno un'offerta senza conoscere le offerte degli altri
- Giocare a poker online dove devi "pescare" una carta senza che gli altri vedano quale
- Votazioni elettroniche dove il voto deve rimanere segreto ma verificabile

In tutti questi casi, abbiamo bisogno di un meccanismo che ci permetta di "bloccare" un valore in modo verificabile, senza rivelarlo.

### Come Funziona il Protocollo di Commitment

Un protocollo di commitment mira a permettere a una parte di impegnarsi su un valore in modo tale che:

1. **Hiding (Nascondimento)**: Il valore rimane nascosto finché la parte non sceglie di rivelarlo. Anche osservando il commitment, nessuno può determinare quale sia il valore sottostante.

2. **Binding (Vincolante)**: Il protocollo deve essere vincolante, assicurando che chi si impegna non possa cambiare il valore dopo che l'impegno è stato fatto. Una volta creato il commitment, sei "legato" a quel valore.

Per raggiungere questo, il protocollo genera una prova verificabile di impegno che convince il verificatore della sua validità senza rivelare il valore sottostante.

### Caso d'Uso Dettagliato: Schema di Previsione dei Risultati a Prova di Imbroglio

Vediamo un esempio concreto e dettagliato.

**Scenario**: Sono un appassionato di calcio e voglio prevedere il risultato di una partita importante (diciamo, la finale del campionato). Voglio dimostrare le mie capacità predittive, ma non voglio rivelare la mia previsione prima che la partita inizi (altrimenti non sarebbe impressionante). Allo stesso tempo, tu vuoi essere sicuro che io non possa cambiare la mia previsione dopo aver visto il risultato.

**Requisiti del sistema**:
1. Io devo poter fare una previsione che rimane segreta fino alla fine della partita (hiding)
2. Tu devi avere la garanzia che io non possa cambiare la mia previsione dopo che la partita è finita (binding)
3. Dopo la partita, deve essere possibile verificare che la mia previsione rivelata corrisponda a quella originale

**Protocollo passo-passo**:

**Fase 1: Creazione del Commitment (Prima della partita)**

1. Scrivo la mia previsione, ad esempio: "Roma vincerà 2-1"
2. Genero un nonce casuale, ad esempio: r = "8f3e9a7c2b1d..."  (un numero casuale molto grande)
3. Calcolo il commitment:
   ```
   commitment = H("Roma vincerà 2-1" || "8f3e9a7c2b1d...")
   commitment = "3f7a2e9c8d1b4f6a..."
   ```
4. Invio a te solo il commitment: "3f7a2e9c8d1b4f6a..."

A questo punto:
- Tu hai il commitment ma non puoi determinare quale sia la mia previsione (hiding)
- Io non posso cambiare la mia previsione perché il commitment è già stato inviato e registrato (binding)

**Fase 2: La Partita si Svolge**

La partita si gioca e termina con un risultato, diciamo Roma vince 2-1.

**Fase 3: Apertura del Commitment (Dopo la partita)**

1. Rivelo la mia previsione originale: "Roma vincerà 2-1"
2. Rivelo il nonce che ho usato: r = "8f3e9a7c2b1d..."
3. Tu puoi ora verificare:
   ```
   H("Roma vincerà 2-1" || "8f3e9a7c2b1d...") = "3f7a2e9c8d1b4f6a..."
   ```
4. Se il calcolo corrisponde al commitment che ti avevo dato prima, allora la verifica ha successo

**Cosa succede se provo a imbrogliare?**

Supponiamo che la partita finisca 3-0 per la Roma e io cerchi di imbrogliare:

Scenario A: Cerco di cambiare solo la previsione
- Dico: "In realtà avevo previsto Roma vince 3-0"
- Uso lo stesso nonce: r = "8f3e9a7c2b1d..."
- Calcoli: H("Roma vincerà 3-0" || "8f3e9a7c2b1d...") = "7c2f4e1a9d3b8e5c..."
- Questo NON corrisponde al commitment originale "3f7a2e9c8d1b4f6a..."
- L'imbroglio viene rilevato!

Scenario B: Cerco di trovare un nonce diverso che funzioni
- Dico: "In realtà avevo previsto Roma vince 3-0"  
- Cerco di trovare un nonce r' tale che: H("Roma vincerà 3-0" || r') = "3f7a2e9c8d1b4f6a..."
- Ma questo richiederebbe trovare una second preimage, che come abbiamo visto è computazionalmente impossibile
- L'imbroglio viene rilevato perché non posso trovare un nonce appropriato!

### Le Funzioni di un Commitment Scheme

Un commitment scheme consiste di due funzioni matematiche:

#### La Funzione di Commitment
```
com := commit(msg, nonce)
```

**Input**:
- `msg`: Il messaggio (o valore) a cui vogliamo impegnarci
- `nonce`: Un valore casuale segreto (deve avere alta min-entropy)

**Output**:
- `com`: Il commitment, cioè l'hash di msg e nonce concatenati

**Implementazione tipica**:
```
commit(msg, nonce) = H(msg || nonce)
```

Dove H è una funzione hash crittografica come SHA-256.

#### La Funzione di Verifica
```
verify(com, msg, nonce) → {true, false}
```

**Input**:
- `com`: Il commitment da verificare
- `msg`: Il messaggio rivelato
- `nonce`: Il nonce rivelato

**Output**:
- `true` se `com == commit(msg, nonce)`
- `false` altrimenti

**Implementazione**:
```
verify(com, msg, nonce):
    return com == H(msg || nonce)
```

### Proprietà di Sicurezza Richieste

Per essere sicuro, un commitment scheme deve soddisfare due proprietà fondamentali:

#### 1. Hiding (Nascondimento)

**Definizione formale**: Dato com, è computazionalmente infeasible trovare msg.

**Cosa significa**: Anche se un attaccante ha il commitment, non può determinare quale sia il messaggio originale. Il commitment non "perde" informazioni sul messaggio.

**Perché è garantita**: Questa proprietà è garantita dalla proprietà di hiding della funzione hash. Dato H(msg || nonce), non si può determinare msg (assumendo che nonce abbia alta min-entropy).

**Esempio pratico**: Nel nostro esempio della previsione calcistica, anche se hai il commitment "3f7a2e9c8d1b4f6a...", non puoi determinare quale fosse la mia previsione. Potresti provare a calcolare l'hash di tutte le possibili previsioni, ma senza conoscere il nonce, ogni previsione richiederebbe testare 2^256 possibili nonce.

#### 2. Binding (Vincolante)

**Definizione formale**: È computazionalmente infeasible trovare due coppie (msg, nonce) e (msg', nonce') tali che:
- msg ≠ msg' (i messaggi sono diversi)
- commit(msg, nonce) == commit(msg', nonce') (ma producono lo stesso commitment)

**Cosa significa**: Una volta creato un commitment per un messaggio, non puoi "aprirlo" in modo valido con un messaggio diverso. Sei "vincolato" al messaggio originale.

**Perché è garantita**: Questa proprietà è garantita dalla proprietà di collision-resistance della funzione hash. Se potessi trovare due coppie diverse che producono lo stesso commitment, avresti trovato una collisione in H, che abbiamo visto essere computazionalmente impossibile.

**Esempio pratico**: Nel nostro esempio, dopo aver inviato il commitment "3f7a2e9c8d1b4f6a...", non posso trovare una previsione diversa e un nonce diverso che producano lo stesso commitment. Sono vincolato alla mia previsione originale.

### Applicazioni Reali dei Commitment Schemes

I commitment schemes hanno numerose applicazioni pratiche:

1. **Aste sigillate**: Tutti i partecipanti inviano commitments delle loro offerte, poi tutti rivelano simultaneamente

2. **Votazioni elettroniche**: Gli elettori creano commitments dei loro voti, garantendo che il voto sia fissato ma segreto fino al conteggio

3. **Giochi online**: Per implementare giochi di carte o dadi in modo dimostrabilmente equo

4. **Protocolli di sicurezza**: Come building block per protocolli più complessi come zero-knowledge proofs

5. **Contratti intelligenti**: Per implementare reveal schemes su blockchain

6. **Lotterie verificabili**: Per garantire che i numeri estratti non siano manipolati

## Puzzle-Friendliness (Adattabilità ai Puzzle)

### Definizione Formale

Una funzione hash H è puzzle-friendly se per ogni possibile valore di output n-bit y, se k è scelto da una distribuzione con alta min-entropy, allora è computazionalmente infeasible trovare x tale che H(k||x) = y in un tempo significativamente più breve di quello che richiederebbe provare tutti i possibili valori di x.

### Spiegazione Intuitiva

In altre parole: se qualcuno vuole che la funzione hash produca un particolare valore di output y (un "target" specifico), è molto difficile trovare un input che colpisca esattamente quel target.

Non esiste una "scorciatoia" o un "trucco" per trovare l'input giusto. L'unico modo è provare tanti input diversi finché non si trova quello che produce l'output desiderato (brute force search).

Questa proprietà è chiamata "puzzle-friendly" perché rende possibile creare "puzzle" crittografici: sfide matematiche dove la soluzione richiede lavoro computazionale dimostrabile.

### Search Puzzle (Puzzle di Ricerca)

Un search puzzle è definito da tre componenti:

#### Componenti del Puzzle

1. **Una funzione hash, H**: Ad esempio, SHA-256

2. **Un puzzle-ID (id)**: Un valore scelto da una distribuzione con alta min-entropy. Questo valore è pubblico e noto a tutti.

3. **Un insieme target Y**: Un sottoinsieme dello spazio degli output. Per esempio, potremmo definire Y come "tutti gli hash che iniziano con 20 zeri".

#### Obiettivo

Trovare un valore x (chiamato "soluzione" o "nonce") tale che:
```
H(id || x) ∈ Y
```

Cioè, quando concateni l'id con x e calcoli l'hash, il risultato deve cadere nell'insieme target Y.

### Proprietà Fondamentale

Se un search puzzle è puzzle-friendly, questo implica che **non c'è una strategia di risoluzione per questo puzzle che sia molto migliore del semplicemente provare valori casuali di x**.

In altre parole:
- Non puoi "calcolare" direttamente la soluzione
- Non puoi usare la matematica per "lavorare all'indietro" dall'output desiderato all'input
- L'unico modo è il trial and error: prova x = 0, poi x = 1, poi x = 2, ecc.

### Esempio Concreto: Mining di Bitcoin

Il mining di Bitcoin è probabilmente l'esempio più noto e su larga scala di search puzzle:

#### Il Puzzle del Mining

**Componenti**:
- **H**: SHA-256 (applicato due volte)
- **id**: L'header del blocco (che include riferimento al blocco precedente, timestamp, merkle root delle transazioni)
- **Y**: Tutti gli hash minori di un certo target (un numero che determina la difficoltà)

**Obiettivo**: Trovare un nonce tale che:
```
SHA-256(SHA-256(header || nonce)) < target
```

**Come funziona**:
1. Un miner costruisce un blocco di transazioni
2. Crea l'header del blocco (questo è l'id del puzzle)
3. Prova diversi nonce: 0, 1, 2, 3, ...
4. Per ogni nonce, calcola l'hash e verifica se è minore del target
5. Se trova un nonce che funziona, ha "risolto" il blocco e può trasmetterlo alla rete
6. Riceve una ricompensa in bitcoin

**Perché è puzzle-friendly**:
- Non c'è modo di "calcolare" quale nonce funzionerà
- L'unico modo è provare miliardi di nonce fino a trovarne uno che funziona
- Questo richiede lavoro computazionale reale e verificabile
- Altri nodi possono facilmente verificare che la soluzione è corretta (basta calcolare l'hash una volta)

#### Numeri Reali del Mining

Per dare un'idea della scala:
- **Difficoltà attuale** (2024-2025): Circa 70-80 trilioni
- **Hash rate della rete**: Circa 500-600 EH/s (exahash al secondo)
  - Cioè 500.000.000.000.000.000.000 hash al secondo!
- **Tempo medio per trovare un blocco**: 10 minuti
- **Numero di tentativi per blocco**: Circa 300.000.000.000.000.000.000 (300 quintilioni)

Questo significa che in media servono centinaia di quintilioni di tentativi prima di trovare un nonce valido. Questo è possibile solo perché migliaia di miner in tutto il mondo lavorano simultaneamente sul problema.

### Applicazione: Hashcash - Anti Spam Filter

Prima ancora del mining di Bitcoin, i puzzle crittografici sono stati proposti come soluzione al problema dello spam nelle email. Il sistema si chiama Hashcash ed è stato inventato da Adam Back nel 1997.

#### Il Problema dello Spam

Inviare email è (quasi) gratuito. Questo rende redditizio per gli spammer inviare milioni di email spam:
- Costo per email: quasi zero
- Se anche solo lo 0.001% risponde: profitto!

Come possiamo rendere più costoso inviare spam senza danneggiare gli utenti normali?

#### La Soluzione: Proof of Work per Email

Hashcash richiede che il mittente di un'email dimostri di aver speso una certa quantità di lavoro computazionale per inviare quell'email.

**Come funziona**:

1. **Il mittente genera un puzzle crittografico**: Prima di inviare l'email, il client del mittente deve trovare un nonce tale che:
   ```
   H(email_header || nonce) < target
   ```
   
   Dove email_header include:
   - Indirizzo del destinatario
   - Timestamp
   - Altre informazioni dell'email

2. **Il client calcola la soluzione**: Il software email del mittente prova diversi nonce fino a trovarne uno che funziona. Questo potrebbe richiedere:
   - Per difficoltà bassa: pochi secondi
   - Per difficoltà media: 10-20 secondi
   - Per difficoltà alta: alcuni minuti

3. **Il nonce viene incluso nell'email**: La soluzione (il nonce trovato) viene aggiunta all'header dell'email

4. **Il server del destinatario verifica la soluzione**: Quando riceve l'email, il server calcola:
   ```
   H(email_header || nonce_ricevuto)
   ```
   
   E verifica che il risultato sia minore del target richiesto.

5. **Accettazione o rifiuto**:
   - Se la verifica ha successo: l'email viene accettata
   - Se la verifica fallisce: l'email viene rifiutata come potenziale spam

**Perché funziona contro lo spam**:

- **Per utenti normali**: Spendere 10-20 secondi per inviare un'email è accettabile. Se invii 20 email al giorno, sono 5-10 minuti di lavoro computazionale totale.

- **Per spammer**: Se vuoi inviare 1 milione di email:
  - Con 10 secondi per email: servirebbero 10.000.000 di secondi
  - Che equivalgono a circa 115 giorni di calcolo continuo
  - Anche con computer molto potenti, i costi hardware ed energetici diventano proibitivi

**Vantaggi del sistema**:
- Non richiede sistemi di pagamento o registrazione
- È completamente decentralizzato
- La verifica è istantanea (molto più veloce della generazione)
- Aumenta il costo dello spam mantenendo l'email accessibile per tutti

**Limitazioni**:
- Non è mai stato adottato su larga scala
- Alcuni utenti potrebbero trovare fastidioso il ritardo
- Non funziona bene su dispositivi con poca potenza di calcolo (smartphone vecchi, ecc.)

Nonostante non sia stato adottato per le email, il concetto di Hashcash è diventato fondamentale per Bitcoin, dove è usato come meccanismo di consenso (Proof of Work).

## SHA-256: La Funzione Hash di Bitcoin

SHA-256 (Secure Hash Algorithm 256-bit) è la funzione hash principalmente utilizzata in Bitcoin. È stata progettata dalla NSA (National Security Agency) e pubblicata dal NIST (National Institute of Standards and Technology) nel 2001.

### Perché SHA-256?

Satoshi Nakamoto scelse SHA-256 per Bitcoin per diverse ragioni:
1. **Standard industriale**: Era (ed è) ampiamente usato e studiato
2. **Ben testato**: Anni di analisi crittografica senza vulnerabilità significative
3. **Performance**: Buon bilanciamento tra sicurezza e velocità
4. **Disponibilità**: Implementazioni disponibili in molti linguaggi di programmazione

### Architettura di SHA-256

Come funzione hash sottostante, SHA-256 utilizza una funzione hash chiamata **compression function** (funzione di compressione).

#### Caratteristiche della Compression Function

- **Dimensione input**: 768 bit (96 byte)
  - 256 bit dal blocco precedente
  - 512 bit di nuovo input
- **Dimensione output**: 256 bit (32 byte)

La compression function è il "mattone" fondamentale che viene usato ripetutamente per costruire l'intera funzione SHA-256.

### La Trasformata di Merkle-Damgård

SHA-256 utilizza la trasformata di Merkle-Damgård per convertire una funzione di compressione collision-resistant a lunghezza fissa in una funzione hash che accetta input di lunghezza arbitraria.

Questa è un'intuizione brillante: se abbiamo una funzione di compressione che:
- Funziona solo su input di dimensione fissa
- È collision-resistant

Possiamo usarla per costruire una funzione hash che:
- Funziona su input di qualsiasi dimensione
- Mantiene la collision-resistance

#### Come Funziona la Trasformata di Merkle-Damgård

Consideriamo una compression function con:
- Lunghezza input totale = m bit
- Lunghezza output = n bit
- Lunghezza del blocco di nuovo input = m - n bit

**Processo passo-passo**:

1. **Padding dell'input**: Il messaggio originale viene "padding" (riempito) per rendere la sua lunghezza un multiplo di (m - n). Il padding include anche la lunghezza del messaggio originale.

2. **Divisione in blocchi**: L'input, dopo il padding, viene diviso in blocchi di lunghezza (m - n) bit ciascuno. Se l'input ha lunghezza totale L bit, avremo k = L / (m - n) blocchi.

3. **Inizializzazione**: Viene inizializzato un vettore di inizializzazione (IV) con lunghezza n bit. Questo è un valore costante specificato nello standard SHA-256.

4. **Iterazione**: Per ogni blocco:
   - Prendi l'output del passo precedente (o l'IV per il primo blocco)
   - Concatenalo con il blocco corrente di input
   - Passa questi (m bit totali) nella compression function
   - Ottieni n bit di output
   - Questo output diventa l'input per il passo successivo

5. **Output finale**: L'output dell'ultima iterazione è l'hash finale del messaggio.

**Rappresentazione visiva**:

```
Input: [Messaggio di lunghezza arbitraria]
       ↓
[Padding e divisione in blocchi]
       ↓
Blocco₁  Blocco₂  Blocco₃  ...  Bloccoₖ

IV (256 bit)
  ↓
  → [Compression] ← Blocco₁
       ↓
       → [Compression] ← Blocco₂
            ↓
            → [Compression] ← Blocco₃
                 ↓
                 ...
                      ↓
                      → [Compression] ← Bloccoₖ
                           ↓
                      Hash finale (256 bit)
```

#### Esempio Numerico con SHA-256

Per SHA-256 specificamente:
- m = 768 bit (input totale della compression function)
- n = 256 bit (output della compression function)
- Dimensione blocco = m - n = 512 bit

Quindi:
1. Il messaggio viene diviso in blocchi da 512 bit
2. Ogni blocco viene processato insieme ai 256 bit di output precedente
3. Il risultato è sempre 256 bit

**Esempio concreto**:

Supponiamo di voler calcolare SHA-256("Hello World"):
1. "Hello World" in ASCII è 88 bit (11 caratteri × 8 bit)
2. Viene fatto padding fino a 512 bit (includendo la lunghezza)
3. Abbiamo quindi 1 solo blocco da 512 bit
4. Questo viene processato con l'IV
5. Risultato: un hash di 256 bit

Se invece avessimo un messaggio di 1000 bit:
1. Viene fatto padding per arrivare a 1024 bit
2. Vengono creati 2 blocchi da 512 bit ciascuno
3. Il primo blocco viene processato con l'IV → output₁
4. Il secondo blocco viene processato con output₁ → hash finale

#### Proprietà della Trasformata di Merkle-Damgård

**Teorema fondamentale**: Se la compression function è collision-resistant, allora anche la funzione hash risultante (SHA-256) è collision-resistant.

**Dimostrazione intuitiva**: 
- Supponiamo di aver trovato una collisione in SHA-256: due messaggi diversi M₁ e M₂ che producono lo stesso hash
- Possiamo "tracciare indietro" il calcolo blocco per blocco
- Ad un certo punto, deve esserci un blocco dove gli input alla compression function sono diversi ma gli output sono uguali
- Questo sarebbe una collisione nella compression function
- Ma abbiamo assunto che la compression function sia collision-resistant!
- Contraddizione → SHA-256 è collision-resistant

Questa è la potenza della costruzione Merkle-Damgård: ci permette di "trasferire" le proprietà di sicurezza dalla compression function all'intera funzione hash.

## Hash Pointer (Puntatore Hash)

### Definizione

Un hash pointer è una struttura dati che combina due elementi:
1. **Un puntatore**: Indica dove qualche informazione è memorizzata (ad esempio, l'indirizzo di memoria o la posizione in un file)
2. **Un hash crittografico**: L'hash dell'informazione puntata

### Differenza con i Puntatori Normali

**Puntatore normale**:
- Ti dice DOVE si trova l'informazione
- Ti permette di recuperare l'informazione
- NON ti dice se l'informazione è cambiata

**Hash pointer**:
- Ti dice DOVE si trova l'informazione (come un puntatore normale)
- Ti permette di recuperare l'informazione (come un puntatore normale)
- Ti permette anche di VERIFICARE che l'informazione non sia cambiata

### Come Funziona la Verifica

1. **Memorizzazione**: Quando memorizzi un hash pointer, salvi:
   - Il puntatore P all'informazione
   - L'hash H = hash(informazione)

2. **Recupero e verifica**: Quando vuoi recuperare l'informazione:
   - Usi il puntatore P per ottenere l'informazione
   - Calcoli l'hash della informazione recuperata: H' = hash(informazione recuperata)
   - Confronti: H' == H?
   - Se corrispondono: l'informazione non è stata modificata
   - Se non corrispondono: l'informazione è stata alterata

### Esempio Pratico

Immaginiamo un sistema di backup:

```python
# Salvataggio
dati = "Contenuto importante del file"
posizione = salva_su_disco(dati)  # Restituisce un puntatore
hash_dati = SHA256(dati)

hash_pointer = {
    'posizione': posizione,
    'hash': hash_dati
}

# Recupero (dopo qualche tempo)
dati_recuperati = leggi_da_disco(hash_pointer['posizione'])
hash_recuperato = SHA256(dati_recuperati)

if hash_recuperato == hash_pointer['hash']:
    print("Dati integri!")
else:
    print("ATTENZIONE: I dati sono stati modificati!")
```

### Vantaggi degli Hash Pointer

1. **Integrità dei dati**: Puoi rilevare qualsiasi modifica ai dati
2. **Efficienza**: L'hash è piccolo (256 bit per SHA-256) indipendentemente dalla dimensione dei dati
3. **Tamper-evident**: Qualsiasi manomissione è immediatamente rilevabile
4. **Building block per strutture dati complesse**: Blockchain, Merkle trees, ecc.

## Applicazione: Message Digest (Digest del Messaggio)

### Scenario Completo

Alice è una ricercatrice che lavora a un importante progetto. Ha un file molto grande (diciamo, 10 GB di dati sperimentali) e vuole caricarlo su un servizio di cloud storage per averlo sempre disponibile e come backup.

### Il Problema

Alice è preoccupata per diverse cose:
1. **Corruzione dei dati**: E se durante il caricamento o lo storage qualche bit venisse corrotto?
2. **Manomissione dolosa**: E se il service provider (o un hacker che compromette il provider) modificasse i suoi dati?
3. **Errori del provider**: E se il provider perdesse parte dei dati o li mescolasse con quelli di altri utenti?

Come può Alice essere sicura che, quando scarica i dati in futuro, sono esattamente gli stessi dati che aveva caricato?

### La Soluzione: Message Digest

Alice può usare le funzioni hash per creare un "digest" (riassunto crittografico) dei suoi dati.

#### Fase 1: Prima del Caricamento

1. **Alice calcola l'hash del file**:
   ```
   H(file_dati.dat) = digest
   ```
   
   Per esempio:
   ```
   digest = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
   ```

2. **Alice memorizza il digest localmente**: Questo è un valore di soli 256 bit (32 byte), piccolissimo rispetto ai 10 GB del file originale. Può:
   - Scriverlo su un pezzo di carta
   - Salvarlo su una chiavetta USB
   - Annotarlo nel suo quaderno di laboratorio
   - Memorizzarlo in un password manager

3. **Alice carica il file sul cloud**: Il file di 10 GB viene caricato sul servizio di storage.

#### Fase 2: Quando Alice Ha Bisogno del File

Settimane, mesi o anni dopo, Alice ha bisogno di accedere ai suoi dati:

1. **Alice scarica il file dal cloud**:
   ```
   file_scaricato.dat (10 GB)
   ```

2. **Alice calcola l'hash del file scaricato**:
   ```
   H(file_scaricato.dat) = digest_scaricato
   ```

3. **Alice confronta i due digest**:
   ```
   digest_scaricato == digest_originale?
   ```

4. **Interpretazione del risultato**:
   - **Se corrispondono**: Alice può essere sicura (con probabilità 1 - 2^-256, cioè praticamente certezza assoluta) che il file è esattamente lo stesso che aveva caricato. Ogni singolo bit è identico.
   
   - **Se NON corrispondono**: Qualcosa è cambiato. Potrebbe essere:
     - Corruzione durante il download
     - Modifica da parte del provider
     - Attacco informatico
     - Errore del sistema di storage
     
     Alice sa con certezza che il file non è più affidabile.

### Vantaggi di Questo Approccio

1. **Efficienza di storage**: 
   - File originale: 10 GB
   - Digest da memorizzare: 32 byte
   - Fattore di riduzione: circa 300 miliardi!

2. **Velocità di verifica**:
   - Calcolare SHA-256 di 10 GB: pochi minuti su un computer moderno
   - Confrontare due hash: istantaneo

3. **Certezza matematica**:
   - Se i digest corrispondono, i file sono identici con certezza praticamente assoluta
   - Se differiscono, i file sono sicuramente diversi

4. **Applicabilità universale**:
   - Funziona per file di qualsiasi dimensione
   - Funziona per qualsiasi tipo di dato (documenti, immagini, video, database, ecc.)

### Estensioni e Varianti

#### Verifica di Integrità di Download

Molti siti web che offrono download di software forniscono anche gli hash dei file:

```
ubuntu-22.04-desktop-amd64.iso
SHA256: a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd
```

L'utente può:
1. Scaricare il file .iso
2. Calcolare il SHA-256 del file scaricato
3. Confrontare con l'hash pubblicato sul sito
4. Se corrispondono: il download è completo e non corrotto

#### Deduplicazione nel Cloud Storage

Servizi come Dropbox usano gli hash per la deduplicazione:
- Se due utenti caricano lo stesso file, viene memorizzato una sola volta
- Il sistema riconosce che è lo stesso file confrontando gli hash
- Risparmio di storage per il provider
- Upload più veloci per gli utenti (se il file esiste già, non serve caricarlo)

#### Git e Version Control

Git usa hash (SHA-1, stanno migrando a SHA-256) per identificare:
- Ogni commit
- Ogni versione di ogni file
- La storia completa del repository

Due repository con lo stesso hash del commit principale sono matematicamente garantiti essere identici.

## Applicazione: Blockchain

### Cos'è una Blockchain con Hash Pointer

Una blockchain è una lista collegata (linked list) costruita con hash pointer invece di puntatori normali.

**Lista collegata normale**:
```
[Dati₁] → [Dati₂] → [Dati₃] → [Dati₄]
```

**Blockchain (lista collegata con hash pointer)**:
```
[Dati₁ | H₁] ← [Dati₂ | H₂] ← [Dati₃ | H₃] ← [Dati₄]
```

Dove:
- H₁ = hash(Dati₁)
- H₂ = hash(Dati₂ || H₁)  
- H₃ = hash(Dati₃ || H₂)
- Ogni blocco include l'hash del blocco precedente

### Vantaggi della Blockchain

Una blockchain è una struttura dati log (registro) che:
1. **Memorizza dati**: Può contenere qualsiasi tipo di informazione
2. **Permette append**: Possiamo aggiungere nuovi dati alla fine
3. **Rileva manomissioni**: Se qualcuno altera dati che sono più indietro nel log, lo rileveremo immediatamente

### Come Funziona la Rilevazione delle Manomissioni

Vediamo in dettaglio come la blockchain rileva i tentativi di manomissione.

#### Struttura Normale (Non Manomessa)

Immaginiamo una blockchain con 4 blocchi:

```
Blocco 1                    Blocco 2                    Blocco 3                    Blocco 4
┌────────────┐             ┌────────────┐             ┌────────────┐             ┌────────────┐
│ Dati:      │             │ Dati:      │             │ Dati:      │             │ Dati:      │
│ "Alice     │             │ "Bob       │             │ "Carol     │             │ "Dave      │
│ →Bob: 10"  │             │ →Carol: 5" │             │ →Dave: 3"  │             │ →Alice: 2" │
│            │             │            │             │            │             │            │
│ Hash Prev: │             │ Hash Prev: │             │ Hash Prev: │             │ Hash Prev: │
│ 0000...    │◄────────────│ a1b2c3...  │◄────────────│ d4e5f6...  │◄────────────│ g7h8i9...  │
└────────────┘             └────────────┘             └────────────┘             └────────────┘

▲
Hash Head = j0k1l2... (hash del Blocco 4)
```

Alice memorizza solo `Hash Head = j0k1l2...`

#### Scenario di Attacco: Qualcuno Manomette il Blocco 2

Un attaccante vuole cambiare la transazione nel Blocco 2 da "Bob→Carol: 5" a "Bob→Attacker: 5":

**Passo 1: Modifica del Blocco 2**

```
Blocco 2 (MODIFICATO)
┌────────────┐
│ Dati:      │
│ "Bob       │
│ →Attacker: │  ← MODIFICATO!
│  5"        │
│            │
│ Hash Prev: │
│ a1b2c3...  │
└────────────┘
```

**Passo 2: L'Hash Pointer nel Blocco 3 Non Corrisponde Più**

Il Blocco 3 contiene ancora il vecchio hash del Blocco 2:
```
Hash memorizzato in Blocco 3: d4e5f6...
Hash calcolato del Blocco 2 modificato: x9y8z7...

d4e5f6... ≠ x9y8z7...  ← MISMATCH RILEVATO!
```

**Passo 3: Propagazione dell'Errore**

L'errore si propaga:

```
Blocco 2 (modificato)     Blocco 3                  Blocco 4
┌────────────┐           ┌────────────┐           ┌────────────┐
│ Dati:      │           │ Dati:      │           │ Dati:      │
│ "Bob       │           │ "Carol     │           │ "Dave      │
│ →Attacker: │           │ →Dave: 3"  │           │ →Alice: 2" │
│  5"        │           │            │           │            │
│            │           │ Hash Prev: │           │ Hash Prev: │
│ Hash Prev: │◄─────X────│ d4e5f6...  │◄─────X────│ g7h8i9...  │
│ a1b2c3...  │   ERRORE! └────────────┘   ERRORE! └────────────┘
└────────────┘                ▲                         ▲
     ▲                   Hash non                  Hash non
Hash reale              corrisponde!              corrisponde!
x9y8z7...
```

**Passo 4: Rilevazione Finale**

Quando verifichiamo la blockchain partendo dalla testa:

```
Hash Head memorizzato: j0k1l2...
Hash Head calcolato: w5v4u3...

j0k1l2... ≠ w5v4u3...  ← LA MANOMISSIONE È RILEVATA!
```

#### Tentativo Sofisticato: L'Attaccante Cerca di Ricalcolare Tutto

Un attaccante intelligente potrebbe pensare: "Modificherò il Blocco 2 e poi ricalcolerò tutti gli hash successivi!"

1. Modifica il Blocco 2
2. Calcola il nuovo hash del Blocco 2: x9y8z7...
3. Aggiorna il hash nel Blocco 3 con x9y8z7...
4. Ricalcola l'hash del Blocco 3: m3n2o1...
5. Aggiorna il hash nel Blocco 4 con m3n2o1...
6. Ricalcola l'hash del Blocco 4: p6q5r4...

Ma c'è un problema: **Alice ha memorizzato l'hash originale della testa (j0k1l2...)**

Quando Alice verifica:
```
Hash Head memorizzato da Alice: j0k1l2...
Hash Head calcolato sulla blockchain modificata: p6q5r4...

j0k1l2... ≠ p6q5r4...  ← MANOMISSIONE RILEVATA!
```

### La Potenza della Testa della Blockchain

Così, ricordando semplicemente il singolo hash pointer della testa della blockchain, abbiamo essenzialmente ricordato un hash tamper-evident (a prova di manomissione) dell'intera lista.

**Efficienza incredibile**:
- Blockchain di 1 GB di dati
- Migliaia di transazioni
- Anni di storia

**Tutto verificabile con**:
- 32 byte (l'hash della testa)
- Alcuni minuti di calcolo

Basta memorizzare un singolo valore di 256 bit (32 byte) per poter verificare l'integrità di un'intera catena di blocchi contenenti potenzialmente terabyte di dati!

### Blockchain in Bitcoin

In Bitcoin, la blockchain funziona esattamente così:
1. Ogni blocco contiene transazioni
2. Ogni blocco include l'hash del blocco precedente
3. I miner mantengono la testa della blockchain
4. Qualsiasi tentativo di modificare una vecchia transazione viene immediatamente rilevato
5. Più blocchi vengono aggiunti dopo un blocco, più diventa difficile modificarlo

**Profondità di conferma**: In Bitcoin, si aspettano tipicamente 6 blocchi di conferma. Questo significa:
- Per modificare una transazione a 6 blocchi di profondità
- L'attaccante dovrebbe ricalcolare 6 blocchi
- Ogni blocco richiede circa 10 minuti di lavoro computazionale di TUTTA la rete
- Costo stimato: centinaia di milioni di dollari in elettricità e hardware

Questo rende la blockchain di Bitcoin incredibilmente sicura.

## Applicazione: Merkle Tree

### Struttura di un Merkle Tree

Un Merkle Tree è un albero binario dove:
- **I dati sono nelle foglie** dell'albero (al livello più basso)
- **I nodi interni sono costituiti da coppie di hash pointer**, uno per ciascun figlio
- **La radice** contiene un hash che rappresenta crittograficamente l'intero albero

### Costruzione di un Merkle Tree

Vediamo come costruire un Merkle Tree passo-passo con un esempio di 8 transazioni.

#### Livello 0: Le Foglie (I Dati)

```
TX₁    TX₂    TX₃    TX₄    TX₅    TX₆    TX₇    TX₈
"A→B:  "B→C:  "C→D:  "D→A:  "E→F:  "F→G:  "G→H:  "H→E:
 10"    5"     3"     2"     8"     4"     6"     1"
```

#### Livello 1: Hash delle Foglie

Calcoliamo l'hash di ogni transazione:

```
H₁=H(TX₁)  H₂=H(TX₂)  H₃=H(TX₃)  H₄=H(TX₄)  H₅=H(TX₅)  H₆=H(TX₆)  H₇=H(TX₇)  H₈=H(TX₈)
```

#### Livello 2: Combinazione a Coppie

Combiniamo gli hash a coppie:

```
H₁₂ = H(H₁||H₂)    H₃₄ = H(H₃||H₄)    H₅₆ = H(H₅||H₆)    H₇₈ = H(H₇||H₈)
```

#### Livello 3: Ulteriore Combinazione

```
H₁₂₃₄ = H(H₁₂||H₃₄)                   H₅₆₇₈ = H(H₅₆||H₇₈)
```

#### Livello 4: La Radice (Merkle Root)

```
Merkle Root = H(H₁₂₃₄||H₅₆₇₈)
```

### Visualizzazione Completa del Merkle Tree

```
                         Merkle Root
                      H(H₁₂₃₄||H₅₆₇₈)
                      /              \
                     /                \
              H₁₂₃₄                    H₅₆₇₈
          H(H₁₂||H₃₄) ← Dobbiamo passare qui
            /      \                  
           /        \                
        H₁₂          H₃₄ ← Questo è un sibling necessario
     H(H₁||H₂)   H(H₃||H₄) ← Dobbiamo passare qui
      /   \       /   \       
     /     \     /     \     
    H₁    H₂   H₃ ← Partenza    H₄ ← Questo è un sibling necessario
   H(TX₁)H(TX₂)H(TX₃)H(TX₄)
    |     |     |     |     
   TX₁   TX₂   TX₃   TX₄   
               ↑
          Vogliamo provare
          che questa TX
          è nell'albero
```

**Passo 2: Identificare i Sibling Necessari**

Per provare che TX₃ è nell'albero, ho bisogno di fornire:
- TX₃ stessa
- H₄ (sibling di H₃)
- H₁₂ (sibling di H₃₄)
- H₅₆₇₈ (sibling di H₁₂₃₄)

Totale: 1 transazione + 3 hash = circa 100 byte (assumendo transazione piccola)

**Passo 3: Verifica**

Il verificatore (che conosce il Merkle Root corretto) può:

1. Calcolare H₃ = H(TX₃)
2. Combinare con H₄ (fornito): H₃₄ = H(H₃||H₄)
3. Combinare con H₁₂ (fornito): H₁₂₃₄ = H(H₁₂||H₃₄)
4. Combinare con H₅₆₇₈ (fornito): Root_calcolato = H(H₁₂₃₄||H₅₆₇₈)
5. Verificare: Root_calcolato == Merkle_Root_conosciuto?

Se corrispondono: TX₃ è definitivamente nell'albero!

#### Efficienza della Proof of Membership

**Per un albero con n foglie**:
- Numero di hash necessari: log₂(n)
- Dimensione dei dati da trasmettere: circa 32 × log₂(n) byte

**Esempi concreti**:

| Numero di Transazioni | Hash Necessari | Byte da Trasmettere |
|------------------------|----------------|---------------------|
| 1,000                  | 10             | 320 byte            |
| 1,000,000              | 20             | 640 byte            |
| 1,000,000,000          | 30             | 960 byte            |

Incredibile efficienza! Anche con un miliardo di transazioni, serve meno di 1 KB per provare l'appartenenza!

### Applicazione in Bitcoin: Simplified Payment Verification (SPV)

I wallet Bitcoin "light" (SPV wallet) usano i Merkle Tree per verificare transazioni senza scaricare l'intera blockchain:

1. **Il wallet SPV scarica solo gli header dei blocchi** (80 byte ciascuno)
2. **Quando riceve una transazione**, chiede una Merkle proof
3. **Verifica la proof** usando solo il Merkle root nell'header
4. **Risultato**: Può verificare transazioni con solo megabyte di dati invece di centinaia di gigabyte

**Esempio pratico**:
- Blockchain completa: 500 GB
- Solo header: 50 MB
- Verifica di una transazione: 1 KB di Merkle proof

Questo permette ai dispositivi mobili di usare Bitcoin senza dover scaricare e memorizzare centinaia di gigabyte!

### Proof of Non-Membership (Prova di Non-Appartenenza)

Provare che qualcosa NON è in un Merkle Tree è più complicato. Con un normale Merkle Tree, non si può fare efficientemente.

#### La Soluzione: Sorted Merkle Tree

Un **sorted Merkle tree** è un Merkle tree dove i blocchi (le foglie) sono ordinati secondo qualche funzione di ordinamento (tipicamente lessicografico).

**Esempio con transazioni ordinate per indirizzo del destinatario**:

```
Foglie ordinate:
TX_A (a Alice)
TX_B (a Bob)
TX_D (a Dave)
TX_E (a Eve)
TX_F (a Frank)
```

#### Come Funziona la Proof of Non-Membership

Supponiamo di voler provare che NON esiste una transazione a Carol.

**Passo 1: Identificare dove Carol dovrebbe essere**

Se Carol fosse nell'albero, dovrebbe essere tra Bob e Dave (ordine alfabetico):

```
TX_A (a Alice)
TX_B (a Bob)
[Qui dovrebbe essere Carol se esistesse]
TX_D (a Dave)
TX_E (a Eve)
```

**Passo 2: Fornire Proof of Membership per Bob e Dave**

Fornisci:
- Merkle proof che TX_B è nell'albero
- Merkle proof che TX_D è nell'albero
- Dimostra che TX_B e TX_D sono consecutivi (nessuna transazione in mezzo)

**Passo 3: Verifica**

Il verificatore:
1. Verifica che TX_B è nell'albero (usando la Merkle proof)
2. Verifica che TX_D è nell'albero (usando la Merkle proof)
3. Verifica che nell'ordinamento, B viene immediatamente prima di D
4. Conclusione: Non esiste nessuna transazione a Carol nell'albero

#### Esempio Dettagliato

Immaginiamo un Sorted Merkle Tree con transazioni:

```
                    Root
                  /      \
               /            \
            H_AB              H_DE
           /    \            /    \
          /      \          /      \
        H_A      H_B      H_D      H_E
        |        |        |        |
      TX_A     TX_B     TX_D     TX_E
     (Alice)  (Bob)   (Dave)   (Eve)
```

Per provare che Carol non è nell'albero:

**Dati forniti**:
1. TX_B completa: "Pagamento a Bob: 5 BTC"
2. TX_D completa: "Pagamento a Dave: 3 BTC"
3. Merkle proof per TX_B: [H_A, H_DE]
4. Merkle proof per TX_D: [H_E, H_AB]
5. Indicazione che Bob e Dave sono consecutivi nell'ordinamento

**Verifica**:
```
# Verifica TX_B
H_B = H(TX_B)
H_AB = H(H_A || H_B)  # Usando H_A dalla proof
Root_calc_1 = H(H_AB || H_DE)  # Usando H_DE dalla proof

# Verifica TX_D  
H_D = H(TX_D)
H_DE = H(H_D || H_E)  # Usando H_E dalla proof
Root_calc_2 = H(H_AB || H_DE)  # Usando H_AB dalla proof

# Verifica ordine
Bob < Carol < Dave (alfabeticamente)
Bob e Dave sono consecutivi nell'albero

# Conclusione
Se Root_calc_1 == Root_calc_2 == Root_conosciuto:
    Carol NON è nell'albero (provato!)
```

### Applicazioni dei Sorted Merkle Trees

1. **Certificate Transparency**: Provare che un certificato SSL NON è stato emesso
2. **Blockchain transparency**: Provare che una transazione NON è avvenuta
3. **Database verificabili**: Provare che un record NON esiste
4. **Audit logs**: Provare che un evento NON è stato registrato

## Attacchi di Collisione su P2SH in Bitcoin

Tutti gli indirizzi basati su funzioni hash sono teoricamente vulnerabili a un attaccante che trova indipendentemente lo stesso input che ha prodotto l'output della funzione hash (commitment).

### Background: Cos'è P2SH

P2SH (Pay to Script Hash) è un tipo di indirizzo Bitcoin dove:
- Il ricevente crea uno script (redeem script) che specifica le condizioni per spendere
- L'hash dello script viene usato come indirizzo
- Per spendere, bisogna fornire lo script originale e soddisfarne le condizioni

**Esempio**: Script multisig 2-of-3
```
Redeem script = "Richiedi 2 firme su 3 chiavi pubbliche: PubKey_A, PubKey_B, PubKey_C"
Hash = HASH160(redeem_script) = 20 byte
Indirizzo = base58check(hash) = "3ABC..."
```

### Tipi di Attacchi

#### 1. Preimage Attack (Attacco di Preimmagine)

**Definizione**: Dato un hash H, trovare QUALSIASI input x tale che hash(x) = H.

**Nel contesto di Bitcoin**:
- Un attaccante vede l'indirizzo P2SH di qualcuno
- Cerca di trovare uno script che produce lo stesso hash
- Se ci riesce, conosce uno script che può spendere quei fondi

**Probabilità di successo**: 
- Per HASH160 (160 bit): 1 su 2^160
- Per SHA256 (256 bit): 1 su 2^256

**Esempio numerico**:
- 2^160 ≈ 1.46 × 10^48
- Con 1 trilione (10^12) di tentativi al secondo
- Servirebbero 1.46 × 10^36 secondi
- Cioè circa 4.6 × 10^28 anni

**Conclusione**: Praticamente impossibile con la tecnologia attuale e prevedibile.

#### 2. Second Preimage Attack (Attacco di Seconda Preimmagine)

**Definizione**: Dato un input x₁ e il suo hash H = hash(x₁), trovare un input diverso x₂ tale che hash(x₂) = H.

**Nel contesto di Bitcoin**:
- Alice ha creato un redeem script specifico
- Un attaccante cerca di trovare un redeem script DIVERSO che produce lo stesso hash
- Se ci riesce, può creare condizioni di spesa diverse

**Differenza con Preimage Attack**: 
- Preimage: non conosci l'input originale
- Second Preimage: conosci l'input originale, cerchi un'alternativa

**Probabilità di successo**:
Per indirizzi creati interamente da una singola parte, la probabilità è anche circa 1 su 2^160 per HASH160.

**Conclusione**: Anche questo è praticamente impossibile.

#### 3. Collision Attack (Attacco di Collisione) - IL PROBLEMA REALE

**Definizione**: Trovare DUE input qualsiasi x₁ e x₂ (con x₁ ≠ x₂) tali che hash(x₁) = hash(x₂).

**La Differenza Critica**: 
- Preimage/Second Preimage: Devi trovare un input specifico
- Collision: Puoi scegliere ENTRAMBI gli input liberamente

**Perché questo è più facile**: Birthday Paradox!

##### Birthday Paradox Spiegato

Domanda: In una stanza, quante persone servono prima che sia probabile (>50%) che due condividano lo stesso compleanno?

**Intuizione sbagliata**: 183 persone (metà di 365)
**Risposta corretta**: Solo 23 persone!

**Perché?** Con 23 persone, ci sono:
- 23 × 22 / 2 = 253 coppie possibili
- Ogni coppia ha probabilità 1/365 di condividere il compleanno
- Con 253 tentativi, la probabilità supera il 50%

##### Applicazione alle Funzioni Hash

Per una funzione hash con output di n bit:
- **Preimage Attack**: Servono circa 2^n tentativi
- **Collision Attack**: Servono circa 2^(n/2) tentativi

Per HASH160 (160 bit):
- **Preimage**: 2^160 ≈ 10^48 tentativi
- **Collision**: 2^80 ≈ 10^24 tentativi

**Differenza enorme**: 10^24 volte più facile!

#### Collision Attack su P2SH: Scenario Pratico

**Setup**: Alice, Bob e Carol vogliono creare un indirizzo multisig 2-of-3.

**Protocollo onesto**:
1. Alice genera e condivide la sua chiave pubblica
2. Bob genera e condivide la sua chiave pubblica  
3. Carol genera e condivide la sua chiave pubblica
4. Creano insieme: `Script = "2-of-3 multisig: PubKey_Alice, PubKey_Bob, PubKey_Carol"`
5. Calcolano: `Address = HASH160(Script)`

**Attacco da parte di Carol**:

Carol è l'ultima a condividere la sua chiave. Può fare questo:

**Fase 1: Preparazione (prima di conoscere le chiavi di Alice e Bob)**

Carol genera miliardi di coppie di chiavi e le memorizza:
```
Coppia 1: PubKey_C1, PrivKey_C1
Coppia 2: PubKey_C2, PrivKey_C2
...
Coppia 2^40: PubKey_C(2^40), PrivKey_C(2^40)
```

**Fase 2: Dopo aver ricevuto le chiavi di Alice e Bob**

Ora Carol sa PubKey_Alice e PubKey_Bob. Può fare:

1. Per ogni sua chiave pubblica candidata PubKey_Ci:
   - Crea Script_onesto_i = "2-of-3: PubKey_Alice, PubKey_Bob, PubKey_Ci"
   - Calcola Hash_onesto_i = HASH160(Script_onesto_i)

2. Contemporaneamente, crea script malevoli:
   - Script_malevolo_j = "1-of-1: PubKey_Carol_Master"
   - (Uno script che solo Carol può spendere!)
   - Calcola Hash_malevolo_j = HASH160(Script_malevolo_j)

3. Cerca una collisione:
   - Cerca i, j tale che Hash_onesto_i == Hash_malevolo_j

**Fase 3: Sfruttamento**

Se Carol trova una collisione:
- Condivide PubKey_Ci con Alice e Bob
- Tutti creano l'indirizzo basato su Script_onesto_i
- Alice e Bob pensano di avere un multisig sicuro
- Ma Carol sa che Script_malevolo_j produce lo stesso hash!
- Quando arrivano fondi a quell'indirizzo, Carol può spenderli da sola usando Script_malevolo_j

#### Numeri Reali: Quanto è Pratico Questo Attacco?

**Contesto**: All'inizio del 2023, tutti i miner di Bitcoin combinati eseguono circa 2^80 hash ogni ora.

**Costo dell'attacco di collisione su HASH160**:
- Servono circa 2^80 hash
- Con la potenza di tutti i Bitcoin miner: circa 1 ora di calcolo
- Costo stimato: milioni di dollari in elettricità e hardware

**Chi potrebbe permetterselo?**:
- Stati nazionali
- Grandi organizzazioni criminali
- Fondi di investimento che gestiscono miliardi in Bitcoin

**Quando diventa profittevole?**:
Se l'indirizzo multisig conterrà più Bitcoin del costo dell'attacco, l'attacco diventa razionale economicamente.

**Esempi reali**:
- Exchanges che gestiscono cold storage multisig
- Custodial services con grandi quantità di Bitcoin
- Tesorerie di aziende che tengono Bitcoin

### Confronto tra i Tre Tipi di Attacco

| Tipo di Attacco | Complessità per HASH160 | Fattibile? | Note |
|-----------------|-------------------------|------------|------|
| Preimage | 2^160 | No | Richiederebbe più energia dell'universo |
| Second Preimage | 2^160 | No | Stesso ordine di grandezza |
| Collision | 2^80 | Forse | Possibile con risorse enormi ma esistenti |

### La Soluzione: Hash Più Lunghi

Ci sono protocolli crittografici ben consolidati per prevenire gli attacchi di collisione, ma una soluzione semplice che non richiede alcuna conoscenza speciale da parte degli sviluppatori di wallet è semplicemente **utilizzare una funzione hash più forte**.

#### Segwit e gli Indirizzi Moderni

Gli aggiornamenti successivi a Bitcoin hanno introdotto nuovi tipi di indirizzi:

**Indirizzi Segwit v0 (P2WPKH)**:
- Usano SHA256 senza RIPEMD160
- Output: 256 bit (32 byte)
- Resistenza alle collisioni: 2^128

**Indirizzi Taproot (P2TR)**:
- Usano Schnorr signatures con curve points
- Output: 256 bit (32 byte)
- Resistenza alle collisioni: 2^128

#### Quanto Tempo per Attaccare 2^128?

Con tutta la potenza di calcolo dei Bitcoin miner attuali (2^80 hash/ora):

```
Tempo = 2^128 / 2^80 hash/ora
      = 2^48 ore
      = 2.8 × 10^14 ore
      = 3.2 × 10^10 anni
      = 32 miliardi di anni
```

Per contesto:
- Età dell'universo: 13.8 miliardi di anni
- 32 miliardi di anni è oltre il doppio dell'età dell'universo!

Anche assumendo che la potenza computazionale raddoppi ogni 2 anni (Legge di Moore):
- Dopo 96 anni (48 raddoppi): 2^48 volte più veloce
- Servirebbe comunque 2^80 / 2^48 = 2^32 ore = circa 500 milioni di anni

### Raccomandazioni

Sebbene non si creda che ci sia alcuna minaccia immediata per chiunque crei nuovi indirizzi P2SH, gli sviluppatori di Bitcoin raccomandano:

1. **Per nuovi wallet**: Usare esclusivamente indirizzi segwit nativi (bech32/bech32m)
   - P2WPKH per single-sig
   - P2WSH per multisig
   - P2TR per Taproot

2. **Per wallet esistenti**: Migrare gradualmente a indirizzi più sicuri

3. **Per servizi critici** (exchanges, custodian): 
   - Priorità massima alla migrazione
   - Non usare P2SH per nuovi indirizzi

4. **Per utenti finali**: Scegliere wallet che supportano indirizzi moderni

Questa strategia elimina gli attacchi di collisione sugli indirizzi come preoccupazione per i prossimi decenni, anche con progressi nell'hardware computazionale.

## Conclusione: L'Importanza delle Funzioni Hash

Le funzioni hash crittografiche sono uno strumento fondamentale della crittografia moderna e della tecnologia blockchain. Le loro tre proprietà critiche - collision-resistance, hiding e puzzle-friendliness - le rendono perfette per un'ampia gamma di applicazioni:

### Applicazioni Riassunte

1. **Integrità dei Dati**:
   - Verificare che file non siano stati modificati
   - Message digest per cloud storage
   - Verifica di download software

2. **Commitments Crittografici**:
   - Impegni vincolanti ma nascosti
   - Aste sigillate
   - Votazioni elettroniche
   - Giochi online equi

3. **Proof of Work**:
   - Bitcoin mining
   - Consenso distribuito
   - Anti-spam (Hashcash)

4. **Strutture Dati Verificabili**:
   - Blockchain (immutabilità tamper-evident)
   - Merkle Trees (prove di appartenenza efficienti)
   - Git version control
   - Certificate transparency

5. **Sicurezza degli Indirizzi**:
   - Indirizzi Bitcoin compatti
   - Protezione della privacy
   - Resistenza agli attacchi (con hash adeguatamente lunghi)

### Lezioni Chiave

1. **La sicurezza è proporzionale alla lunghezza dell'hash**:
   - 160 bit: Vulnerabile a collision attacks con risorse significative
   - 256 bit: Sicuro contro tutti gli attacchi noti per decenni

2. **Gli attacchi di collisione sono più facili dei preimage attacks**:
   - Birthday paradox: riduce la complessità da 2^n a 2^(n/2)
   - Importante considerare quando l'attaccante può influenzare l'input

3. **L'efficienza delle prove è straordinaria**:
   - Merkle Trees: log(n) invece di n
   - Permette verifiche leggere (SPV wallets)
   - Abilita scaling e usabilità

4. **La teoria deve incontrare la pratica**:
   - Non basta che le collisioni siano rare matematicamente
   - Devono essere praticamente impossibili con risorse reali
   - I progressi tecnologici devono essere anticipati

### Riflessione Finale

La comprensione profonda di come funzionano le funzioni hash e delle loro applicazioni è essenziale per:
- Comprendere come Bitcoin garantisce sicurezza
- Progettare sistemi crittografici sicuri
- Valutare i rischi di sicurezza
- Apprezzare l'eleganza delle soluzioni crittografiche moderne

Le funzioni hash sono un esempio perfetto di come la matematica pura si traduca in tecnologia pratica che alimenta miliardi di dollari di valore e abilita nuove forme di fiducia distribuita senza autorità centrali.₇₈
          H(H₁₂||H₃₄)              H(H₅₆||H₇₈)
            /      \                  /      \
           /        \                /        \
        H₁₂          H₃₄          H₅₆          H₇₈
     H(H₁||H₂)   H(H₃||H₄)   H(H₅||H₆)   H(H₇||H₈)
      /   \       /   \       /   \       /   \
     /     \     /     \     /     \     /     \
    H₁    H₂   H₃    H₄   H₅    H₆   H₇    H₈
   H(TX₁)H(TX₂)H(TX₃)H(TX₄)H(TX₅)H(TX₆)H(TX₇)H(TX₈)
    |     |     |     |     |     |     |     |
   TX₁   TX₂   TX₃   TX₄   TX₅   TX₆   TX₇   TX₈
```

### Merkle Root in Bitcoin

In Bitcoin, ogni blocco contiene centinaia o migliaia di transazioni. Invece di includere tutte queste transazioni nell'header del blocco (che renderebbe l'header enorme), viene incluso solo il Merkle root.

**Header del blocco Bitcoin** (80 byte totali):
- Versione (4 byte)
- Hash del blocco precedente (32 byte)
- **Merkle root** (32 byte) ← Qui!
- Timestamp (4 byte)
- Difficulty target (4 byte)
- Nonce (4 byte)

Il Merkle root di soli 32 byte rappresenta crittograficamente tutte le transazioni nel blocco (che potrebbero essere megabyte di dati)!

### Proof of Membership (Prova di Appartenenza)

Questa è una delle applicazioni più potenti dei Merkle Tree: possiamo provare efficientemente che un dato specifico è presente nell'albero.

#### Il Problema

Immagina di avere un Merkle Tree con 1 milione di transazioni. Vuoi provare a qualcuno che una specifica transazione (diciamo TX₃₇₂,₅₄₁) è inclusa nell'albero.

**Approccio naive**: Inviare tutte le 1.000.000 di transazioni
- Estremamente inefficiente
- Richiede gigabyte di dati
- Lento da trasmettere e verificare

**Approccio con Merkle Tree**: Inviare solo log₂(1.000.000) ≈ 20 hash
- Estremamente efficiente
- Richiede solo 640 byte (20 × 32 byte)
- Veloce da trasmettere e verificare

#### Come Funziona la Proof of Membership

Supponiamo di voler provare che TX₃ è nell'albero. Abbiamo bisogno di:

1. **La transazione stessa**: TX₃
2. **Il Merkle path**: Gli hash dei "fratelli" lungo il percorso dalla foglia alla radice

**Passo 1: Identificare il Path**

```
                         Merkle Root ← Destinazione
                      H(H₁₂₃₄||H₅₆₇₈)
                      /              \
                     /                \
              H₁₂₃₄                    H₅₆# Le Funzioni Hash e le loro Applicazioni in Crittografia e Bitcoin

## Definizione di Hash

Una funzione hash è una funzione computazionalmente efficiente che mappa stringhe binarie di lunghezza arbitraria a stringhe binarie di lunghezza fissa, chiamate hash-values (valori hash).

L'hashing è un metodo di applicazione di una funzione hash crittografica ai dati, che calcola un output relativamente unico (chiamato message digest, o semplicemente digest) per un input di quasi qualsiasi dimensione.

## Esempi di Hash con SHA-256

SHA-256 è una delle funzioni hash più utilizzate in Bitcoin e nella crittografia moderna. Ecco alcuni esempi concreti che dimostrano come anche piccole variazioni nell'input producano output completamente diversi:

- `H("Bitcoin") = b4056df6691f8dc72e56302ddad345d65fead3ead9299609a826e2344eb63aa4`
- `H("bitcoin") = 6b88c087247aa2f07ee1c5956b8e1a9f4c7f892a70e324f1bb3d161e05ca107b`
- `H("1") = 6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b`
- `H("2") = d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35`

Come si può notare, anche una piccola variazione nell'input (come la capitalizzazione di una singola lettera tra "Bitcoin" e "bitcoin") produce un hash completamente diverso e apparentemente casuale. Questa proprietà è nota come "effetto valanga" e rende le funzioni hash particolarmente utili per applicazioni crittografiche.

## Proprietà delle Funzioni Hash

### Proprietà Generali

Le funzioni hash hanno tre proprietà fondamentali che le caratterizzano:

1. **L'input può essere una stringa di qualsiasi dimensione**: Non ci sono limiti pratici alla lunghezza dei dati che possono essere processati. Puoi fare l'hash di un singolo byte o di un file di diversi gigabyte.

2. **Produce un output di dimensione fissa**: Indipendentemente dalla dimensione dell'input (che sia 1 byte o 1 terabyte), l'output ha sempre la stessa lunghezza. Per SHA-256, l'output è sempre di 256 bit (32 byte).

3. **È computazionalmente efficiente**: Il calcolo dell'hash è rapido e richiede risorse computazionali ragionevoli. Anche su hardware modesto è possibile calcolare migliaia o milioni di hash al secondo.

### Proprietà Crittografiche

Le funzioni hash crittografiche devono possedere tre proprietà aggiuntive fondamentali che le rendono sicure per applicazioni critiche:

1. **Collision-resistance** (Resistenza alle collisioni)
2. **Hiding** (Nascondimento)
3. **Puzzle-friendliness** (Adattabilità ai puzzle)

Esaminiamo ora ciascuna di queste proprietà in dettaglio.

## Collision-Resistance (Resistenza alle Collisioni)

### Definizione

Una funzione hash H è detta collision-resistant se è impossibile (in pratica, computazionalmente infeasible) trovare due valori, x e y, tali che x ≠ y, eppure H(x) = H(y).

Questa proprietà vuole garantire che nessuno possa trovare un caso in cui due diversi valori di input per la funzione hash producano lo stesso valore di output.

### Il Caso che Vogliamo Evitare

È fondamentale comprendere un aspetto teorico importante: "nessuno può trovare una collisione" è molto diverso dal dire che "non esistono collisioni". 

In realtà, per il principio del cassetto (pigeonhole principle), le collisioni esistono matematicamente e necessariamente. Consideriamo questo: se abbiamo infiniti possibili input (o anche solo 2^257 input possibili) e un numero finito di possibili output (2^256 per SHA-256), necessariamente alcuni input diversi produrranno lo stesso output. È matematicamente impossibile che sia altrimenti.

Tuttavia, la sicurezza della funzione hash sta nel fatto che trovare queste collisioni deve essere praticamente impossibile con le risorse computazionali disponibili oggi e nel futuro prevedibile. È come cercare un ago in un pagliaio delle dimensioni dell'universo conosciuto.

### La Difficoltà di Trovare una Collisione

Per comprendere quanto sia difficile trovare una collisione in una funzione hash come SHA-256, consideriamo alcuni confronti concreti e tangibili:

#### Mining di Bitcoin: Un Riferimento di Potenza Computazionale

I miner di Bitcoin, nel loro insieme, eseguono circa 2^80 operazioni di hash ogni ora. Questo rappresenta una quantità stupefacente di potenza computazionale. Questi miner utilizzano hardware specializzato chiamato ASIC (Application-Specific Integrated Circuits), progettato specificamente per eseguire operazioni di hashing il più velocemente ed efficientemente possibile.

Per mettere questo in prospettiva, consideriamo alcuni dei migliori ASIC per Bitcoin mining disponibili nel 2025:
- Antminer S21 Pro: circa 234 TH/s (terahash al secondo)
- Whatsminer M60S: circa 200 TH/s
- Avalon A1466: circa 150 TH/s

Un terahash al secondo significa 1.000.000.000.000 (un trilione) di calcoli di hash ogni secondo. E ci sono centinaia di migliaia di questi dispositivi in funzione in tutto il mondo, 24 ore al giorno, 7 giorni alla settimana.

#### Confronto con il Gratta e Vinci

La probabilità di trovare una collisione SHA-256 è enormemente più bassa della probabilità di vincere al Gratta e Vinci. 

Mentre vincere un premio importante al Gratta e Vinci può avere probabilità nell'ordine di 1 su qualche milione (ad esempio, 1 su 5.000.000 per certi biglietti), trovare una collisione SHA-256 avrebbe una probabilità nell'ordine di 1 su 2^256.

Per dare un'idea di quanto sia grande questo numero: 2^256 è approssimativamente 1.15 × 10^77, cioè un numero con 77 cifre decimali. Per confronto, si stima che ci siano circa 10^80 atomi nell'universo osservabile. Trovare una collisione SHA-256 è statisticamente più improbabile che scegliere casualmente un atomo specifico dall'intero universo!

#### Tempi Astronomici

Se prendessimo tutta la potenza di calcolo attualmente dedicata al mining di Bitcoin in tutto il mondo e la dedicassimo invece alla ricerca di collisioni SHA-256, quanto tempo ci vorrebbe?

Con la potenza di calcolo attuale (circa 2^80 hash all'ora), per esplorare tutto lo spazio 2^256 servirebbero 2^176 ore. Questo equivale a circa:
- 10^50 anni
- 10.000.000.000.000.000.000.000.000.000.000.000.000.000 anni

Per dare un contesto: l'età dell'universo è circa 13.8 miliardi di anni (1.38 × 10^10 anni). Il tempo necessario per trovare una collisione SHA-256 è più lungo dell'età dell'universo di un fattore di circa 10^40!

Anche assumendo che la potenza computazionale raddoppi ogni due anni (Legge di Moore), servirebbero comunque miliardi di anni per avere una possibilità ragionevole di trovare una collisione.

### Implicazioni Pratiche

Questa estrema difficoltà nel trovare collisioni è ciò che rende SHA-256 sicuro per:
- Verificare l'integrità dei file (se due file hanno lo stesso hash, possiamo essere praticamente certi che siano identici)
- Creare firme digitali
- Costruire blockchain (dove modificare un blocco passato richiederebbe trovare collisioni)
- Creare commitments crittografici

## Hiding (Nascondimento)

### Definizione Formale

Una funzione hash H ha la proprietà di hiding se: quando un valore secreto r è scelto da una distribuzione di probabilità che ha alta min-entropy, allora dato H(r||x) è infeasible (impossibile in pratica) trovare x.

Dove r||x rappresenta r concatenato con x (cioè, r seguito da x come un'unica stringa).

### Cos'è la Min-Entropy?

In teoria dell'informazione, la min-entropy è una misura di quanto prevedibile sia un risultato. Un'alta min-entropy cattura l'idea intuitiva che la distribuzione (cioè la variabile casuale) sia molto dispersa, molto "sparsa". 

Immaginiamo di lanciare una moneta:
- Una moneta **equa** ha alta min-entropy: non possiamo prevedere il risultato
- Una moneta **truccata** che esce sempre testa ha min-entropy zero: il risultato è completamente prevedibile

Per la proprietà di hiding, abbiamo bisogno che r sia scelto da una distribuzione con alta min-entropy, cioè che sia veramente imprevedibile.

### Spiegazione Intuitiva

In altre parole, la proprietà di hiding ci dice: se ci viene dato l'output della funzione hash H(r||x) = y, non c'è modo computazionalmente fattibile di capire quale fosse l'input x, assumendo che r sia stato scelto in modo sufficientemente casuale.

Questa proprietà è fondamentale perché ci permette di "nascondere" informazioni: possiamo pubblicare l'hash di un valore senza rivelare il valore stesso.

### Esempio Dettagliato: Testa o Croce

Vediamo un esempio pratico e dettagliato per capire sia il problema che la soluzione.

#### Scenario Iniziale

Alice sta giocando a testa o croce. Il gioco funziona così:
1. Alice lancia una moneta
2. Eve deve indovinare il risultato prima che Alice lo riveli
3. Poi Alice rivela il risultato e verifica se Eve ha indovinato correttamente

Ma c'è un problema di fiducia: Eve potrebbe non fidarsi che Alice non cambi il risultato dopo aver sentito la sua previsione. Come possiamo rendere il gioco equo e a prova di imbroglio?

#### Tentativo 1: Usare l'Hash (Senza Nascondimento)

Alice ha un'idea: invece di rivelare direttamente il risultato, rivelerà solo l'hash del risultato.

1. Alice lancia la moneta
2. Alice calcola:
   - Se è testa: H(testa) = a
   - Se è croce: H(croce) = b
3. Alice invia ad Eve solo l'hash (a oppure b)
4. Eve fa la sua previsione
5. Alice rivela il risultato originale
6. Eve può verificare che H(risultato) corrisponda all'hash ricevuto

**Il problema con questo approccio:**

Se Eve conosce la funzione hash (e dovrebbe conoscerla, altrimenti non può verificare) e conosce l'insieme dei possibili output (testa o croce), può semplicemente pre-calcolare tutti i possibili hash:

```
H(testa) = a
H(croce) = b
```

Quando riceve l'hash da Alice, Eve può semplicemente confrontarlo con i suoi hash pre-calcolati:
- Se riceve "a", sa che è testa
- Se riceve "b", sa che è croce

Eve può facilmente capire il risultato del lancio della moneta prima ancora di fare la sua "previsione", rendendo il gioco inutile!

Questo accade perché l'insieme dei possibili input {testa, croce} è molto piccolo e ha bassa min-entropy. Non è "disperso" - ci sono solo due possibilità.

#### Soluzione: Concatenazione con un Valore Casuale (Nonce)

È possibile nascondere un input che non è molto disperso concatenandolo con un altro input che è molto disperso. Ecco come:

1. **Alice genera un nonce casuale**: Alice sceglie un numero casuale r molto grande, per esempio un numero di 256 bit. Questo r ha alta min-entropy perché è stato scelto casualmente da un insieme enorme (2^256 possibilità).

2. **Alice concatena il risultato con il nonce**: Alice calcola:
   - Se testa: H(testa || r) = s
   - Se croce: H(croce || r) = s
   
3. **Alice invia l'hash ad Eve**: Eve riceve l's' ma non può determinare se era testa o croce

4. **Perché Eve non può più imbrogliare?** 
   - Anche se Eve sa che i possibili input sono {testa, croce}, non conosce r
   - Per pre-calcolare gli hash, dovrebbe calcolare:
     - H(testa || r) per ogni possibile valore di r
     - H(croce || r) per ogni possibile valore di r
   - Ma ci sono 2^256 possibili valori di r!
   - Anche con la potenza computazionale di tutti i Bitcoin miner del mondo, ci vorrebbero miliardi di anni

5. **Eve fa la sua previsione**: Senza poter determinare il risultato, Eve deve fare una vera previsione

6. **Alice rivela tutto**: Dopo che Eve ha fatto la sua previsione, Alice rivela sia il risultato (testa o croce) che il nonce r

7. **Verifica**: Eve può ora verificare che H(risultato || r) = s, confermando che Alice non ha imbrogliato

### Applicazioni Pratiche della Proprietà di Hiding

Questa proprietà è utilizzata in molti contesti:
- **Commitments**: Come vedremo nella prossima sezione
- **Password hashing**: Le password sono spesso concatenate con un "salt" (equivalente del nostro nonce r) prima di essere hashate
- **Blockchain**: Le transazioni possono essere "nascoste" usando tecniche simili
- **Zero-knowledge proofs**: Dove si vuole provare la conoscenza di qualcosa senza rivelarlo

## Applicazione: Commitments (Impegni Crittografici)

### Obiettivo

Permettere a una parte di fissare un valore in modo che sia sia **binding** (vincolante - il valore non può essere cambiato successivamente) che **hiding** (nascosto - il valore non viene rivelato finché non viene intenzionalmente aperto).

### Motivazione e Contesto

Nella vita quotidiana ci sono molte situazioni dove vorremmo poter "impegnarci" su qualcosa senza rivelarlo immediatamente. Alcuni esempi:
- Fare una previsione su un evento futuro senza rivelare la previsione
- Partecipare a un'asta sigillata dove tutti fanno un'offerta senza conoscere le offerte degli altri
- Giocare a poker online dove devi "pescare" una carta senza che gli altri vedano quale
- Votazioni elettroniche dove il voto deve rimanere segreto ma verificabile

In tutti questi casi, abbiamo bisogno di un meccanismo che ci permetta di "bloccare" un valore in modo verificabile, senza rivelarlo.

### Come Funziona il Protocollo di Commitment

Un protocollo di commitment mira a permettere a una parte di impegnarsi su un valore in modo tale che:

1. **Hiding (Nascondimento)**: Il valore rimane nascosto finché la parte non sceglie di rivelarlo. Anche osservando il commitment, nessuno può determinare quale sia il valore sottostante.

2. **Binding (Vincolante)**: Il protocollo deve essere vincolante, assicurando che chi si impegna non possa cambiare il valore dopo che l'impegno è stato fatto. Una volta creato il commitment, sei "legato" a quel valore.

Per raggiungere questo, il protocollo genera una prova verificabile di impegno che convince il verificatore della sua validità senza rivelare il valore sottostante.

### Caso d'Uso Dettagliato: Schema di Previsione dei Risultati a Prova di Imbroglio

Vediamo un esempio concreto e dettagliato.

**Scenario**: Sono un appassionato di calcio e voglio prevedere il risultato di una partita importante (diciamo, la finale del campionato). Voglio dimostrare le mie capacità predittive, ma non voglio rivelare la mia previsione prima che la partita inizi (altrimenti non sarebbe impressionante). Allo stesso tempo, tu vuoi essere sicuro che io non possa cambiare la mia previsione dopo aver visto il risultato.

**Requisiti del sistema**:
1. Io devo poter fare una previsione che rimane segreta fino alla fine della partita (hiding)
2. Tu devi avere la garanzia che io non possa cambiare la mia previsione dopo che la partita è finita (binding)
3. Dopo la partita, deve essere possibile verificare che la mia previsione rivelata corrisponda a quella originale

**Protocollo passo-passo**:

**Fase 1: Creazione del Commitment (Prima della partita)**

1. Scrivo la mia previsione, ad esempio: "Roma vincerà 2-1"
2. Genero un nonce casuale, ad esempio: r = "8f3e9a7c2b1d..."  (un numero casuale molto grande)
3. Calcolo il commitment:
   ```
   commitment = H("Roma vincerà 2-1" || "8f3e9a7c2b1d...")
   commitment = "3f7a2e9c8d1b4f6a..."
   ```
4. Invio a te solo il commitment: "3f7a2e9c8d1b4f6a..."

A questo punto:
- Tu hai il commitment ma non puoi determinare quale sia la mia previsione (hiding)
- Io non posso cambiare la mia previsione perché il commitment è già stato inviato e registrato (binding)

**Fase 2: La Partita si Svolge**

La partita si gioca e termina con un risultato, diciamo Roma vince 2-1.

**Fase 3: Apertura del Commitment (Dopo la partita)**

1. Rivelo la mia previsione originale: "Roma vincerà 2-1"
2. Rivelo il nonce che ho usato: r = "8f3e9a7c2b1d..."
3. Tu puoi ora verificare:
   ```
   H("Roma vincerà 2-1" || "8f3e9a7c2b1d...") = "3f7a2e9c8d1b4f6a..."
   ```
4. Se il calcolo corrisponde al commitment che ti avevo dato prima, allora la verifica ha successo

**Cosa succede se provo a imbrogliare?**

Supponiamo che la partita finisca 3-0 per la Roma e io cerchi di imbrogliare:

Scenario A: Cerco di cambiare solo la previsione
- Dico: "In realtà avevo previsto Roma vince 3-0"
- Uso lo stesso nonce: r = "8f3e9a7c2b1d..."
- Calcoli: H("Roma vincerà 3-0" || "8f3e9a7c2b1d...") = "7c2f4e1a9d3b8e5c..."
- Questo NON corrisponde al commitment originale "3f7a2e9c8d1b4f6a..."
- L'imbroglio viene rilevato!

Scenario B: Cerco di trovare un nonce diverso che funzioni
- Dico: "In realtà avevo previsto Roma vince 3-0"  
- Cerco di trovare un nonce r' tale che: H("Roma vincerà 3-0" || r') = "3f7a2e9c8d1b4f6a..."
- Ma questo richiederebbe trovare una second preimage, che come abbiamo visto è computazionalmente impossibile
- L'imbroglio viene rilevato perché non posso trovare un nonce appropriato!

### Le Funzioni di un Commitment Scheme

Un commitment scheme consiste di due funzioni matematiche:

#### La Funzione di Commitment
```
com := commit(msg, nonce)
```

**Input**:
- `msg`: Il messaggio (o valore) a cui vogliamo impegnarci
- `nonce`: Un valore casuale segreto (deve avere alta min-entropy)

**Output**:
- `com`: Il commitment, cioè l'hash di msg e nonce concatenati

**Implementazione tipica**:
```
commit(msg, nonce) = H(msg || nonce)
```

Dove H è una funzione hash crittografica come SHA-256.

#### La Funzione di Verifica
```
verify(com, msg, nonce) → {true, false}
```

**Input**:
- `com`: Il commitment da verificare
- `msg`: Il messaggio rivelato
- `nonce`: Il nonce rivelato

**Output**:
- `true` se `com == commit(msg, nonce)`
- `false` altrimenti

**Implementazione**:
```
verify(com, msg, nonce):
    return com == H(msg || nonce)
```

### Proprietà di Sicurezza Richieste

Per essere sicuro, un commitment scheme deve soddisfare due proprietà fondamentali:

#### 1. Hiding (Nascondimento)

**Definizione formale**: Dato com, è computazionalmente infeasible trovare msg.

**Cosa significa**: Anche se un attaccante ha il commitment, non può determinare quale sia il messaggio originale. Il commitment non "perde" informazioni sul messaggio.

**Perché è garantita**: Questa proprietà è garantita dalla proprietà di hiding della funzione hash. Dato H(msg || nonce), non si può determinare msg (assumendo che nonce abbia alta min-entropy).

**Esempio pratico**: Nel nostro esempio della previsione calcistica, anche se hai il commitment "3f7a2e9c8d1b4f6a...", non puoi determinare quale fosse la mia previsione. Potresti provare a calcolare l'hash di tutte le possibili previsioni, ma senza conoscere il nonce, ogni previsione richiederebbe testare 2^256 possibili nonce.

#### 2. Binding (Vincolante)

**Definizione formale**: È computazionalmente infeasible trovare due coppie (msg, nonce) e (msg', nonce') tali che:
- msg ≠ msg' (i messaggi sono diversi)
- commit(msg, nonce) == commit(msg', nonce') (ma producono lo stesso commitment)

**Cosa significa**: Una volta creato un commitment per un messaggio, non puoi "aprirlo" in modo valido con un messaggio diverso. Sei "vincolato" al messaggio originale.

**Perché è garantita**: Questa proprietà è garantita dalla proprietà di collision-resistance della funzione hash. Se potessi trovare due coppie diverse che producono lo stesso commitment, avresti trovato una collisione in H, che abbiamo visto essere computazionalmente impossibile.

**Esempio pratico**: Nel nostro esempio, dopo aver inviato il commitment "3f7a2e9c8d1b4f6a...", non posso trovare una previsione diversa e un nonce diverso che producano lo stesso commitment. Sono vincolato alla mia previsione originale.

### Applicazioni Reali dei Commitment Schemes

I commitment schemes hanno numerose applicazioni pratiche:

1. **Aste sigillate**: Tutti i partecipanti inviano commitments delle loro offerte, poi tutti rivelano simultaneamente

2. **Votazioni elettroniche**: Gli elettori creano commitments dei loro voti, garantendo che il voto sia fissato ma segreto fino al conteggio

3. **Giochi online**: Per implementare giochi di carte o dadi in modo dimostrabilmente equo

4. **Protocolli di sicurezza**: Come building block per protocolli più complessi come zero-knowledge proofs

5. **Contratti intelligenti**: Per implementare reveal schemes su blockchain

6. **Lotterie verificabili**: Per garantire che i numeri estratti non siano manipolati

## Puzzle-Friendliness (Adattabilità ai Puzzle)

### Definizione Formale

Una funzione hash H è puzzle-friendly se per ogni possibile valore di output n-bit y, se k è scelto da una distribuzione con alta min-entropy, allora è computazionalmente infeasible trovare x tale che H(k||x) = y in un tempo significativamente più breve di quello che richiederebbe provare tutti i possibili valori di x.

### Spiegazione Intuitiva

In altre parole: se qualcuno vuole che la funzione hash produca un particolare valore di output y (un "target" specifico), è molto difficile trovare un input che colpisca esattamente quel target.

Non esiste una "scorciatoia" o un "trucco" per trovare l'input giusto. L'unico modo è provare tanti input diversi finché non si trova quello che produce l'output desiderato (brute force search).

Questa proprietà è chiamata "puzzle-friendly" perché rende possibile creare "puzzle" crittografici: sfide matematiche dove la soluzione richiede lavoro computazionale dimostrabile.

### Search Puzzle (Puzzle di Ricerca)

Un search puzzle è definito da tre componenti:

#### Componenti del Puzzle

1. **Una funzione hash, H**: Ad esempio, SHA-256

2. **Un puzzle-ID (id)**: Un valore scelto da una distribuzione con alta min-entropy. Questo valore è pubblico e noto a tutti.

3. **Un insieme target Y**: Un sottoinsieme dello spazio degli output. Per esempio, potremmo definire Y come "tutti gli hash che iniziano con 20 zeri".

#### Obiettivo

Trovare un valore x (chiamato "soluzione" o "nonce") tale che:
```
H(id || x) ∈ Y
```

Cioè, quando concateni l'id con x e calcoli l'hash, il risultato deve cadere nell'insieme target Y.

### Proprietà Fondamentale

Se un search puzzle è puzzle-friendly, questo implica che **non c'è una strategia di risoluzione per questo puzzle che sia molto migliore del semplicemente provare valori casuali di x**.

In altre parole:
- Non puoi "calcolare" direttamente la soluzione
- Non puoi usare la matematica per "lavorare all'indietro" dall'output desiderato all'input
- L'unico modo è il trial and error: prova x = 0, poi x = 1, poi x = 2, ecc.

### Esempio Concreto: Mining di Bitcoin

Il mining di Bitcoin è probabilmente l'esempio più noto e su larga scala di search puzzle:

#### Il Puzzle del Mining

**Componenti**:
- **H**: SHA-256 (applicato due volte)
- **id**: L'header del blocco (che include riferimento al blocco precedente, timestamp, merkle root delle transazioni)
- **Y**: Tutti gli hash minori di un certo target (un numero che determina la difficoltà)

**Obiettivo**: Trovare un nonce tale che:
```
SHA-256(SHA-256(header || nonce)) < target
```

**Come funziona**:
1. Un miner costruisce un blocco di transazioni
2. Crea l'header del blocco (questo è l'id del puzzle)
3. Prova diversi nonce: 0, 1, 2, 3, ...
4. Per ogni nonce, calcola l'hash e verifica se è minore del target
5. Se trova un nonce che funziona, ha "risolto" il blocco e può trasmetterlo alla rete
6. Riceve una ricompensa in bitcoin

**Perché è puzzle-friendly**:
- Non c'è modo di "calcolare" quale nonce funzionerà
- L'unico modo è provare miliardi di nonce fino a trovarne uno che funziona
- Questo richiede lavoro computazionale reale e verificabile
- Altri nodi possono facilmente verificare che la soluzione è corretta (basta calcolare l'hash una volta)

#### Numeri Reali del Mining

Per dare un'idea della scala:
- **Difficoltà attuale** (2024-2025): Circa 70-80 trilioni
- **Hash rate della rete**: Circa 500-600 EH/s (exahash al secondo)
  - Cioè 500.000.000.000.000.000.000 hash al secondo!
- **Tempo medio per trovare un blocco**: 10 minuti
- **Numero di tentativi per blocco**: Circa 300.000.000.000.000.000.000 (300 quintilioni)

Questo significa che in media servono centinaia di quintilioni di tentativi prima di trovare un nonce valido. Questo è possibile solo perché migliaia di miner in tutto il mondo lavorano simultaneamente sul problema.

### Applicazione: Hashcash - Anti Spam Filter

Prima ancora del mining di Bitcoin, i puzzle crittografici sono stati proposti come soluzione al problema dello spam nelle email. Il sistema si chiama Hashcash ed è stato inventato da Adam Back nel 1997.

#### Il Problema dello Spam

Inviare email è (quasi) gratuito. Questo rende redditizio per gli spammer inviare milioni di email spam:
- Costo per email: quasi zero
- Se anche solo lo 0.001% risponde: profitto!

Come possiamo rendere più costoso inviare spam senza danneggiare gli utenti normali?

#### La Soluzione: Proof of Work per Email

Hashcash richiede che il mittente di un'email dimostri di aver speso una certa quantità di lavoro computazionale per inviare quell'email.

**Come funziona**:

1. **Il mittente genera un puzzle crittografico**: Prima di inviare l'email, il client del mittente deve trovare un nonce tale che:
   ```
   H(email_header || nonce) < target
   ```
   
   Dove email_header include:
   - Indirizzo del destinatario
   - Timestamp
   - Altre informazioni dell'email

2. **Il client calcola la soluzione**: Il software email del mittente prova diversi nonce fino a trovarne uno che funziona. Questo potrebbe richiedere:
   - Per difficoltà bassa: pochi secondi
   - Per difficoltà media: 10-20 secondi
   - Per difficoltà alta: alcuni minuti

3. **Il nonce viene incluso nell'email**: La soluzione (il nonce trovato) viene aggiunta all'header dell'email

4. **Il server del destinatario verifica la soluzione**: Quando riceve l'email, il server calcola:
   ```
   H(email_header || nonce_ricevuto)
   ```
   
   E verifica che il risultato sia minore del target richiesto.

5. **Accettazione o rifiuto**:
   - Se la verifica ha successo: l'email viene accettata
   - Se la verifica fallisce: l'email viene rifiutata come potenziale spam

**Perché funziona contro lo spam**:

- **Per utenti normali**: Spendere 10-20 secondi per inviare un'email è accettabile. Se invii 20 email al giorno, sono 5-10 minuti di lavoro computazionale totale.

- **Per spammer**: Se vuoi inviare 1 milione di email:
  - Con 10 secondi per email: servirebbero 10.000.000 di secondi
  - Che equivalgono a circa 115 giorni di calcolo continuo
  - Anche con computer molto potenti, i costi hardware ed energetici diventano proibitivi

**Vantaggi del sistema**:
- Non richiede sistemi di pagamento o registrazione
- È completamente decentralizzato
- La verifica è istantanea (molto più veloce della generazione)
- Aumenta il costo dello spam mantenendo l'email accessibile per tutti

**Limitazioni**:
- Non è mai stato adottato su larga scala
- Alcuni utenti potrebbero trovare fastidioso il ritardo
- Non funziona bene su dispositivi con poca potenza di calcolo (smartphone vecchi, ecc.)

Nonostante non sia stato adottato per le email, il concetto di Hashcash è diventato fondamentale per Bitcoin, dove è usato come meccanismo di consenso (Proof of Work).

## SHA-256: La Funzione Hash di Bitcoin

SHA-256 (Secure Hash Algorithm 256-bit) è la funzione hash principalmente utilizzata in Bitcoin. È stata progettata dalla NSA (National Security Agency) e pubblicata dal NIST (National Institute of Standards and Technology) nel 2001.

### Perché SHA-256?

Satoshi Nakamoto scelse SHA-256 per Bitcoin per diverse ragioni:
1. **Standard industriale**: Era (ed è) ampiamente usato e studiato
2. **Ben testato**: Anni di analisi crittografica senza vulnerabilità significative
3. **Performance**: Buon bilanciamento tra sicurezza e velocità
4. **Disponibilità**: Implementazioni disponibili in molti linguaggi di programmazione

### Architettura di SHA-256

Come funzione hash sottostante, SHA-256 utilizza una funzione hash chiamata **compression function** (funzione di compressione).

#### Caratteristiche della Compression Function

- **Dimensione input**: 768 bit (96 byte)
  - 256 bit dal blocco precedente
  - 512 bit di nuovo input
- **Dimensione output**: 256 bit (32 byte)

La compression function è il "mattone" fondamentale che viene usato ripetutamente per costruire l'intera funzione SHA-256.

### La Trasformata di Merkle-Damgård

SHA-256 utilizza la trasformata di Merkle-Damgård per convertire una funzione di compressione collision-resistant a lunghezza fissa in una funzione hash che accetta input di lunghezza arbitraria.

Questa è un'intuizione brillante: se abbiamo una funzione di compressione che:
- Funziona solo su input di dimensione fissa
- È collision-resistant

Possiamo usarla per costruire una funzione hash che:
- Funziona su input di qualsiasi dimensione
- Mantiene la collision-resistance

#### Come Funziona la Trasformata di Merkle-Damgård

Consideriamo una compression function con:
- Lunghezza input totale = m bit
- Lunghezza output = n bit
- Lunghezza del blocco di nuovo input = m - n bit

**Processo passo-passo**:

1. **Padding dell'input**: Il messaggio originale viene "padding" (riempito) per rendere la sua lunghezza un multiplo di (m - n). Il padding include anche la lunghezza del messaggio originale.

2. **Divisione in blocchi**: L'input, dopo il padding, viene diviso in blocchi di lunghezza (m - n) bit ciascuno. Se l'input ha lunghezza totale L bit, avremo k = L / (m - n) blocchi.

3. **Inizializzazione**: Viene inizializzato un vettore di inizializzazione (IV) con lunghezza n bit. Questo è un valore costante specificato nello standard SHA-256.

4. **Iterazione**: Per ogni blocco:
   - Prendi l'output del passo precedente (o l'IV per il primo blocco)
   - Concatenalo con il blocco corrente di input
   - Passa questi (m bit totali) nella compression function
   - Ottieni n bit di output
   - Questo output diventa l'input per il passo successivo

5. **Output finale**: L'output dell'ultima iterazione è l'hash finale del messaggio.

**Rappresentazione visiva**:

```
Input: [Messaggio di lunghezza arbitraria]
       ↓
[Padding e divisione in blocchi]
       ↓
Blocco₁  Blocco₂  Blocco₃  ...  Bloccoₖ

IV (256 bit)
  ↓
  → [Compression] ← Blocco₁
       ↓
       → [Compression] ← Blocco₂
            ↓
            → [Compression] ← Blocco₃
                 ↓
                 ...
                      ↓
                      → [Compression] ← Bloccoₖ
                           ↓
                      Hash finale (256 bit)
```

#### Esempio Numerico con SHA-256

Per SHA-256 specificamente:
- m = 768 bit (input totale della compression function)
- n = 256 bit (output della compression function)
- Dimensione blocco = m - n = 512 bit

Quindi:
1. Il messaggio viene diviso in blocchi da 512 bit
2. Ogni blocco viene processato insieme ai 256 bit di output precedente
3. Il risultato è sempre 256 bit

**Esempio concreto**:

Supponiamo di voler calcolare SHA-256("Hello World"):
1. "Hello World" in ASCII è 88 bit (11 caratteri × 8 bit)
2. Viene fatto padding fino a 512 bit (includendo la lunghezza)
3. Abbiamo quindi 1 solo blocco da 512 bit
4. Questo viene processato con l'IV
5. Risultato: un hash di 256 bit

Se invece avessimo un messaggio di 1000 bit:
1. Viene fatto padding per arrivare a 1024 bit
2. Vengono creati 2 blocchi da 512 bit ciascuno
3. Il primo blocco viene processato con l'IV → output₁
4. Il secondo blocco viene processato con output₁ → hash finale

#### Proprietà della Trasformata di Merkle-Damgård

**Teorema fondamentale**: Se la compression function è collision-resistant, allora anche la funzione hash risultante (SHA-256) è collision-resistant.

**Dimostrazione intuitiva**: 
- Supponiamo di aver trovato una collisione in SHA-256: due messaggi diversi M₁ e M₂ che producono lo stesso hash
- Possiamo "tracciare indietro" il calcolo blocco per blocco
- Ad un certo punto, deve esserci un blocco dove gli input alla compression function sono diversi ma gli output sono uguali
- Questo sarebbe una collisione nella compression function
- Ma abbiamo assunto che la compression function sia collision-resistant!
- Contraddizione → SHA-256 è collision-resistant

Questa è la potenza della costruzione Merkle-Damgård: ci permette di "trasferire" le proprietà di sicurezza dalla compression function all'intera funzione hash.

## Hash Pointer (Puntatore Hash)

### Definizione

Un hash pointer è una struttura dati che combina due elementi:
1. **Un puntatore**: Indica dove qualche informazione è memorizzata (ad esempio, l'indirizzo di memoria o la posizione in un file)
2. **Un hash crittografico**: L'hash dell'informazione puntata

### Differenza con i Puntatori Normali

**Puntatore normale**:
- Ti dice DOVE si trova l'informazione
- Ti permette di recuperare l'informazione
- NON ti dice se l'informazione è cambiata

**Hash pointer**:
- Ti dice DOVE si trova l'informazione (come un puntatore normale)
- Ti permette di recuperare l'informazione (come un puntatore normale)
- Ti permette anche di VERIFICARE che l'informazione non sia cambiata

### Come Funziona la Verifica

1. **Memorizzazione**: Quando memorizzi un hash pointer, salvi:
   - Il puntatore P all'informazione
   - L'hash H = hash(informazione)

2. **Recupero e verifica**: Quando vuoi recuperare l'informazione:
   - Usi il puntatore P per ottenere l'informazione
   - Calcoli l'hash della informazione recuperata: H' = hash(informazione recuperata)
   - Confronti: H' == H?
   - Se corrispondono: l'informazione non è stata modificata
   - Se non corrispondono: l'informazione è stata alterata

### Esempio Pratico

Immaginiamo un sistema di backup:

```python
# Salvataggio
dati = "Contenuto importante del file"
posizione = salva_su_disco(dati)  # Restituisce un puntatore
hash_dati = SHA256(dati)

hash_pointer = {
    'posizione': posizione,
    'hash': hash_dati
}

# Recupero (dopo qualche tempo)
dati_recuperati = leggi_da_disco(hash_pointer['posizione'])
hash_recuperato = SHA256(dati_recuperati)

if hash_recuperato == hash_pointer['hash']:
    print("Dati integri!")
else:
    print("ATTENZIONE: I dati sono stati modificati!")
```

### Vantaggi degli Hash Pointer

1. **Integrità dei dati**: Puoi rilevare qualsiasi modifica ai dati
2. **Efficienza**: L'hash è piccolo (256 bit per SHA-256) indipendentemente dalla dimensione dei dati
3. **Tamper-evident**: Qualsiasi manomissione è immediatamente rilevabile
4. **Building block per strutture dati complesse**: Blockchain, Merkle trees, ecc.

## Applicazione: Message Digest (Digest del Messaggio)

### Scenario Completo

Alice è una ricercatrice che lavora a un importante progetto. Ha un file molto grande (diciamo, 10 GB di dati sperimentali) e vuole caricarlo su un servizio di cloud storage per averlo sempre disponibile e come backup.

### Il Problema

Alice è preoccupata per diverse cose:
1. **Corruzione dei dati**: E se durante il caricamento o lo storage qualche bit venisse corrotto?
2. **Manomissione dolosa**: E se il service provider (o un hacker che compromette il provider) modificasse i suoi dati?
3. **Errori del provider**: E se il provider perdesse parte dei dati o li mescolasse con quelli di altri utenti?

Come può Alice essere sicura che, quando scarica i dati in futuro, sono esattamente gli stessi dati che aveva caricato?

### La Soluzione: Message Digest

Alice può usare le funzioni hash per creare un "digest" (riassunto crittografico) dei suoi dati.

#### Fase 1: Prima del Caricamento

1. **Alice calcola l'hash del file**:
   ```
   H(file_dati.dat) = digest
   ```
   
   Per esempio:
   ```
   digest = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
   ```

2. **Alice memorizza il digest localmente**: Questo è un valore di soli 256 bit (32 byte), piccolissimo rispetto ai 10 GB del file originale. Può:
   - Scriverlo su un pezzo di carta
   - Salvarlo su una chiavetta USB
   - Annotarlo nel suo quaderno di laboratorio
   - Memorizzarlo in un password manager

3. **Alice carica il file sul cloud**: Il file di 10 GB viene caricato sul servizio di storage.

#### Fase 2: Quando Alice Ha Bisogno del File

Settimane, mesi o anni dopo, Alice ha bisogno di accedere ai suoi dati:

1. **Alice scarica il file dal cloud**:
   ```
   file_scaricato.dat (10 GB)
   ```

2. **Alice calcola l'hash del file scaricato**:
   ```
   H(file_scaricato.dat) = digest_scaricato
   ```

3. **Alice confronta i due digest**:
   ```
   digest_scaricato == digest_originale?
   ```

4. **Interpretazione del risultato**:
   - **Se corrispondono**: Alice può essere sicura (con probabilità 1 - 2^-256, cioè praticamente certezza assoluta) che il file è esattamente lo stesso che aveva caricato. Ogni singolo bit è identico.
   
   - **Se NON corrispondono**: Qualcosa è cambiato. Potrebbe essere:
     - Corruzione durante il download
     - Modifica da parte del provider
     - Attacco informatico
     - Errore del sistema di storage
     
     Alice sa con certezza che il file non è più affidabile.

### Vantaggi di Questo Approccio

1. **Efficienza di storage**: 
   - File originale: 10 GB
   - Digest da memorizzare: 32 byte
   - Fattore di riduzione: circa 300 miliardi!

2. **Velocità di verifica**:
   - Calcolare SHA-256 di 10 GB: pochi minuti su un computer moderno
   - Confrontare due hash: istantaneo

3. **Certezza matematica**:
   - Se i digest corrispondono, i file sono identici con certezza praticamente assoluta
   - Se differiscono, i file sono sicuramente diversi

4. **Applicabilità universale**:
   - Funziona per file di qualsiasi dimensione
   - Funziona per qualsiasi tipo di dato (documenti, immagini, video, database, ecc.)

### Estensioni e Varianti

#### Verifica di Integrità di Download

Molti siti web che offrono download di software forniscono anche gli hash dei file:

```
ubuntu-22.04-desktop-amd64.iso
SHA256: a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd
```

L'utente può:
1. Scaricare il file .iso
2. Calcolare il SHA-256 del file scaricato
3. Confrontare con l'hash pubblicato sul sito
4. Se corrispondono: il download è completo e non corrotto

#### Deduplicazione nel Cloud Storage

Servizi come Dropbox usano gli hash per la deduplicazione:
- Se due utenti caricano lo stesso file, viene memorizzato una sola volta
- Il sistema riconosce che è lo stesso file confrontando gli hash
- Risparmio di storage per il provider
- Upload più veloci per gli utenti (se il file esiste già, non serve caricarlo)

#### Git e Version Control

Git usa hash (SHA-1, stanno migrando a SHA-256) per identificare:
- Ogni commit
- Ogni versione di ogni file
- La storia completa del repository

Due repository con lo stesso hash del commit principale sono matematicamente garantiti essere identici.

## Applicazione: Blockchain

### Cos'è una Blockchain con Hash Pointer

Una blockchain è una lista collegata (linked list) costruita con hash pointer invece di puntatori normali.

**Lista collegata normale**:
```
[Dati₁] → [Dati₂] → [Dati₃] → [Dati₄]
```

**Blockchain (lista collegata con hash pointer)**:
```
[Dati₁ | H₁] ← [Dati₂ | H₂] ← [Dati₃ | H₃] ← [Dati₄]
```

Dove:
- H₁ = hash(Dati₁)
- H₂ = hash(Dati₂ || H₁)  
- H₃ = hash(Dati₃ || H₂)
- Ogni blocco include l'hash del blocco precedente

### Vantaggi della Blockchain

Una blockchain è una struttura dati log (registro) che:
1. **Memorizza dati**: Può contenere qualsiasi tipo di informazione
2. **Permette append**: Possiamo aggiungere nuovi dati alla fine
3. **Rileva manomissioni**: Se qualcuno altera dati che sono più indietro nel log, lo rileveremo immediatamente

### Come Funziona la Rilevazione delle Manomissioni

Vediamo in dettaglio come la blockchain rileva i tentativi di manomissione.

#### Struttura Normale (Non Manomessa)

Immaginiamo una blockchain con 4 blocchi:

```
Blocco 1                    Blocco 2                    Blocco 3                    Blocco 4
┌────────────┐             ┌────────────┐             ┌────────────┐             ┌────────────┐
│ Dati:      │             │ Dati:      │             │ Dati:      │             │ Dati:      │
│ "Alice     │             │ "Bob       │             │ "Carol     │             │ "Dave      │
│ →Bob: 10"  │             │ →Carol: 5" │             │ →Dave: 3"  │             │ →Alice: 2" │
│            │             │            │             │            │             │            │
│ Hash Prev: │             │ Hash Prev: │             │ Hash Prev: │             │ Hash Prev: │
│ 0000...    │◄────────────│ a1b2c3...  │◄────────────│ d4e5f6...  │◄────────────│ g7h8i9...  │
└────────────┘             └────────────┘             └────────────┘             └────────────┘
     ▲