# Introduzione alla Blockchain

## L'Evoluzione dei Sistemi di Scambio

### Prima della Moneta: Il Baratto

Prima dell'invenzione della moneta, gli esseri umani si affidavano al baratto per scambiare beni e servizi. Immaginiamo tre persone: Alice vuole un attrezzo, Bob vuole cibo, e Carol vuole medicine. In un sistema di baratto puro, possono scambiare i loro beni in modo che tutti siano soddisfatti. Tuttavia, questo sistema richiede un coordinamento complesso: tutti devono incontrarsi fisicamente e trovare una coincidenza di bisogni. Se Alice ha medicine ma vuole un attrezzo, deve trovare qualcuno che abbia un attrezzo e voglia medicine. Questo limita enormemente le possibilità di scambio.

### Il Sistema Basato sul Credito

Un'evoluzione del baratto è il sistema basato sul credito. In questo scenario, Alice ha medicine, Bob ha un attrezzo, e Carol ha cibo. Alice vuole l'attrezzo di Bob, Bob vuole il cibo di Carol, e Carol vuole le medicine di Alice. Alice e Bob possono scambiare direttamente: Bob dà l'attrezzo ad Alice, e Alice contrae un debito che salderà in futuro. Successivamente, quando Alice incontra Carol, può scambiare le sue medicine per il cibo di Carol, e poi tornare da Bob con il cibo per saldare il debito.

Questo sistema è più flessibile del baratto puro, ma presenta problemi significativi:
- Assumiamo che tutti gli oggetti abbiano lo stesso valore, il che raramente è vero nella realtà
- C'è il rischio che qualcuno non saldi mai il debito, lasciando l'altra parte senza compenso

### L'Arrivo del Denaro Contante

Il denaro contante risolve tutti questi problemi in modo elegante:
- Gli scambi possono avvenire in qualsiasi ordine, senza necessità di coincidenza di bisogni
- Gli oggetti possono avere valori diversi, rappresentati da diverse quantità di denaro
- Offre un livello più alto di privacy rispetto ai sistemi di credito
- Le transazioni possono avvenire offline, senza intermediari

Tuttavia, i sistemi basati sul contante hanno anche i loro svantaggi:
- Devono essere "avviati" da qualcuno o qualcosa (bootstrap)
- È necessaria un'autorità che garantisca il valore rappresentato dal denaro (tipicamente i governi)

### I Pagamenti Online: Carte di Credito

Con l'avvento di Internet, sono emersi nuovi sistemi di pagamento. Le carte di credito online richiedono un intermediario: devi fornire i dettagli della tua carta al commerciante, oppure aggiungere un altro intermediario come PayPal. In questo caso, sia il commerciante che il cliente devono utilizzare lo stesso intermediario.

Le carte di credito online presentano caratteristiche particolari:
- Il cliente può contestare un addebito o avviare un chargeback
- Non c'è anonimato nelle transazioni
- È sempre necessario un intermediario fidato

### Il Problema del Denaro Digitale

L'idea dietro il denaro online è avere una valuta che possa essere spesa con gli stessi vantaggi di un sistema cash. Possiamo utilizzare una banconota virtuale: chi possiede la banconota virtuale può riscattarla presso chi l'ha emessa. Ma chi crea la banconota virtuale? Il creatore può firmare la banconota, così sappiamo a chi dobbiamo pagare, ma l'emittente non è più anonimo.

Qui emerge un problema fondamentale del mondo digitale: quanto è difficile creare una copia perfetta della banconota? Nel mondo digitale, è estremamente facile. Si crea la "macchina dei soldi infiniti".

Per risolvere questo problema, possiamo:
1. Allegare un ID a ogni banconota e tracciarlo in un registro
2. Verificare con l'emittente della banconota che non stiamo usando una copia
3. Introdurre un'autorità centrale che garantisca per l'emittente

Ma questo ci riporta ai problemi delle autorità centralizzate.

### I Problemi delle Autorità Centralizzate

Le autorità centralizzate presentano diverse problematiche:
- Possono censurare le transazioni a loro discrezione
- Sia l'emittente che il cliente devono fidarsi o concordare sulla stessa autorità centrale
- Comportano costi di transazione, perché le autorità centrali devono essere pagate per il loro lavoro
- Le transazioni possono essere annullate o invertite
- Non garantiscono anonimato

### La Soluzione: Il Registro Distribuito (Distributed Ledger)

Un registro distribuito risolve i problemi delle autorità centralizzate offrendo:
- **Nessun intermediario**: le transazioni avvengono direttamente tra le parti
- **Resistenza alla censura**: nessuna singola entità può bloccare le transazioni
- **Digitale e senza confini**: funziona ovunque ci sia una connessione Internet
- **Transazioni pseudonime**: maggiore privacy rispetto ai sistemi tradizionali
- **Commissioni potenzialmente più basse**: senza intermediari costosi
- **Transazioni relativamente veloci**: anche se la velocità varia

## Cos'è la Blockchain

La blockchain è una tecnologia rivoluzionaria che rappresenta un nuovo modo di conservare e gestire informazioni in modo distribuito. Immagina un grande libro contabile che invece di essere custodito in un unico luogo sicuro, come una banca o un ufficio governativo, viene copiato e distribuito a migliaia di computer in tutto il mondo. Ogni computer nella rete, chiamato nodo, mantiene una copia identica di questo libro contabile.

La bellezza di questo sistema è che non esiste un'autorità centrale che controlla il registro. Non c'è una banca, non c'è un governo, non c'è un'azienda che può decidere quali transazioni sono valide e quali no. Tutto è gestito collettivamente dalla rete stessa.

### Il Principio Fondamentale: Aggiungere Sì, Modificare No

L'obiettivo principale della blockchain è garantire due cose apparentemente contrastanti ma fondamentali. Da un lato, vogliamo che chiunque nella rete possa aggiungere nuove informazioni al registro. Questo garantisce che il sistema sia aperto e accessibile a tutti, senza discriminazioni. Dall'altro lato, vogliamo essere assolutamente certi che nessuno possa mai modificare o cancellare informazioni già registrate. Una volta che qualcosa è scritto nella blockchain, deve rimanere lì per sempre, immutabile e inalterabile.

Questa caratteristica è ciò che rende i sistemi basati su blockchain affidabili. Se potessi modificare il registro per far sparire una transazione, potresti spendere gli stessi fondi più volte. Ma grazie alla natura immutabile della blockchain, questo è praticamente impossibile.

### La Blockchain: Una Catena di Blocchi

Il nome "blockchain" deriva proprio da questa struttura: è una catena di blocchi. Ogni blocco è collegato al blocco precedente, formando una catena ininterrotta che va dal primissimo blocco fino al blocco più recente che viene creato in questo momento.

Questo collegamento tra blocchi è ciò che rende la blockchain così sicura. Ogni blocco contiene un riferimento crittografico al blocco precedente. Se qualcuno tentasse di modificare una transazione in un vecchio blocco, questo cambierebbe il riferimento, che a sua volta invaliderebbe tutti i blocchi successivi. È come cercare di modificare un anello in una catena metallica: non puoi farlo senza rompere l'intera catena.

La blockchain cresce costantemente, con nuovi blocchi aggiunti regolarmente.

## Centralizzato vs Decentralizzato vs Distribuito

È importante distinguere tra questi tre concetti:

**Centralizzato**: Una singola autorità centrale (server, nodo o organizzazione) controlla tutta l'elaborazione dei dati e il processo decisionale.

**Decentralizzato**: Più nodi indipendenti prendono decisioni o forniscono servizi senza un'unica autorità centrale. Ogni nodo può operare autonomamente mentre coopera con gli altri.

**Distribuito**: Una collezione di computer indipendenti che appare agli utenti come un singolo sistema, spesso condividendo compiti e risorse.

Le blockchain sono solitamente politicamente decentralizzate e architetturalmente distribuite. Questo significa che non c'è un'autorità centrale che controlla la rete (decentralizzazione politica), ma il sistema è composto da molti computer che lavorano insieme (distribuzione architettonica).

## Le Sfide dei Sistemi Distribuiti

Come disse Leslie Lamport, pioniere dell'informatica distribuita: "Un sistema distribuito è uno in cui il guasto di un computer di cui non sapevi nemmeno l'esistenza può rendere il tuo computer inutilizzabile."

In un sistema distribuito non puoi fare assunzioni su:
- **Temporizzazione**: i messaggi possono essere ritardati, riordinati o persi
- **Affidabilità della rete**: i collegamenti possono fallire o recuperare in modo imprevedibile
- **Disponibilità dei nodi**: qualsiasi processo o macchina può crashare o riavviarsi in qualsiasi momento
- **Stato globale**: nessun nodo ha mai una visione perfettamente aggiornata dell'intero sistema
- **Orologi**: gli orologi fisici si sfasano; non puoi assumere che il tempo sia perfettamente sincronizzato

Per apprezzare davvero l'ingegnosità del design delle blockchain, dobbiamo capire quanto sia difficile far funzionare un sistema distribuito. In un sistema centralizzato, come il server di una banca, tutto è più semplice. C'è un unico computer che conosce lo stato esatto di tutti i conti in ogni momento. Se due persone provano a fare transazioni contemporaneamente, il server può decidere un ordine preciso.

Ma in un sistema distribuito, non ci sono garanzie su niente. I messaggi che viaggiano attraverso Internet possono essere ritardati di secondi o anche minuti. Possono arrivare in un ordine diverso da quello in cui sono stati inviati. In casi estremi, possono addirittura andare persi completamente.

La rete stessa è inaffidabile. I collegamenti tra i nodi possono fallire improvvisamente e poi recuperare in modo imprevedibile. Un nodo potrebbe essere perfettamente connesso a una parte della rete ma completamente isolato da un'altra parte, creando quella che viene chiamata una "partizione di rete".

I nodi stessi possono crashare, riavviarsi, o semplicemente spegnersi. Un nodo potrebbe essere online quando un blocco viene creato e offline quando viene creato il blocco successivo. Non c'è modo di sapere con certezza quali nodi sono operativi in un dato momento.

Inoltre, nessun nodo ha mai una visione perfettamente aggiornata dell'intero sistema. Quando pensi di sapere quali transazioni sono nel mempool di altri nodi, quelle informazioni sono già obsolete perché nel frattempo sono arrivate nuove transazioni. È come cercare di fotografare qualcosa che si muove molto velocemente: l'immagine che ottieni è sempre un po' sfocata e arretrata nel tempo.

Infine, c'è il problema degli orologi. Potresti pensare che ogni computer abbia un orologio preciso e che quindi sia facile determinare l'ordine temporale degli eventi. Ma in realtà, gli orologi dei computer si sfasano costantemente. Anche con i protocolli di sincronizzazione dell'ora, possono esserci differenze di secondi o anche minuti tra diversi computer. E in un sistema dove le transazioni avvengono in millisecondi, questo è un problema enorme.

Queste limitazioni rendono il consenso distribuito un problema estremamente difficile.

## Il Problema del Consenso Distribuito

Uno dei problemi più difficili in informatica è raggiungere il consenso in un sistema distribuito. Quando hai molti computer che non si fidano l'uno dell'altro, che potrebbero essere malevoli, che potrebbero ricevere messaggi in momenti diversi, e che non hanno un orologio perfettamente sincronizzato, come fai a far sì che tutti concordino su un'unica versione della verità?

Nelle blockchain, questo problema è amplificato dal fatto che non c'è un'autorità centrale. Non possiamo dire "lasciamo che il nodo della Banca Centrale decida quali transazioni sono valide". Tutti i nodi devono essere trattati allo stesso modo, e devono raggiungere un accordo attraverso un processo puramente algoritmico.

### Le Due Proprietà Fondamentali

Un protocollo di consenso distribuito deve garantire due cose fondamentali. Prima di tutto, tutti i nodi onesti devono alla fine concordare sullo stesso valore, sulla stessa versione della blockchain. Non possiamo avere una situazione in cui metà della rete pensa che una transazione sia valida e l'altra metà pensa che non lo sia. Questo porterebbe al caos e renderebbe il sistema inutilizzabile.

La seconda proprietà è che il valore su cui tutti concordano deve provenire da un nodo onesto. Non possiamo permettere che un nodo malevolo convinca l'intera rete ad accettare una versione falsa della blockchain che contiene transazioni fraudolente.

## Oltre Bitcoin: L'Ecosistema delle Criptovalute

### Altcoin: Non Solo Bitcoin

Oltre a Bitcoin esistono centinaia di altre blockchain. Alcune delle più note sono: Ethereum, Solana, Tron, Dogecoin, e BNB Smart Chain.

Un **coin** è la valuta nativa di una blockchain, la valuta che alimenta la blockchain stessa. Il termine **altcoin** si riferisce a tutte le monete alternative a Bitcoin (letteralmente "not Bitcoin").

Alcune blockchain permettono agli utenti di creare pezzi di codice (smart contract) ed eseguirli sulla blockchain. Gli utenti possono sviluppare e creare nuove valute, comunemente chiamate **token**.

### NFT - Token Non Fungibili

Gli NFT (Non-Fungible Token) rappresentano asset digitali unici e non intercambiabili, a differenza delle criptovalute tradizionali dove ogni unità è identica a un'altra. Gli NFT sono utilizzati per rappresentare proprietà di arte digitale, oggetti da collezione, e altri beni unici.

### DeFi - Finanza Decentralizzata

La DeFi (Decentralized Finance) rappresenta un movimento per ricreare servizi finanziari tradizionali (prestiti, trading, assicurazioni) su blockchain senza intermediari centralizzati. Attraverso smart contract, gli utenti possono prestare, prendere in prestito, e scambiare asset in modo completamente automatizzato e senza fiducia.

### Ho Davvero Bisogno di una Blockchain?

Prima di decidere di utilizzare una blockchain per un progetto, è importante chiedersi se sia davvero necessaria. Una blockchain è utile quando:
- Serve un database condiviso tra più parti che non si fidano completamente l'una dell'altra
- È necessaria immutabilità e trasparenza delle transazioni
- Si vuole eliminare la necessità di un intermediario centrale
- La decentralizzazione è un requisito fondamentale

Se invece hai bisogno semplicemente di un database controllato da una singola entità, o se le parti coinvolte si fidano l'una dell'altra, una blockchain potrebbe essere una soluzione eccessivamente complessa e costosa.

## Conclusione: Un Sistema Senza Fiducia

Quello che rende le blockchain davvero rivoluzionarie non è tanto la tecnologia in sé, quanto ciò che quella tecnologia permette di realizzare: sistemi che funzionano senza bisogno di fiducia.

In tutti i sistemi tradizionali, devi fidarti di qualcuno: della tua banca, della banca del destinatario, delle società di carte di credito, degli intermediari che processano i pagamenti. Devi fidarti che non perderanno i tuoi soldi, che non ti imporranno commissioni eccessive, che non ti negheranno l'accesso ai tuoi fondi, che non congeleranno il tuo conto senza motivo.

Le blockchain eliminano questo bisogno di fiducia. Non devi fidarti di nessun singolo individuo o organizzazione. Invece, ti fidi della matematica, della crittografia, e del fatto che la maggior parte delle persone nella rete agisce secondo il proprio interesse economico razionale, che coincide con il mantenimento della sicurezza del sistema.

Questo è un esperimento senza precedenti in economia, informatica, e organizzazione sociale, dove il potere non è concentrato in nessun punto singolo, dove nessuno può essere escluso, e dove le regole sono applicate automaticamente dal codice piuttosto che dall'arbitrio umano.