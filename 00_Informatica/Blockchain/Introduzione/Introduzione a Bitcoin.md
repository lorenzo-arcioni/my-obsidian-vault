# Introduzione a Bitcoin

## La Storia di Bitcoin

### L'Inizio

Bitcoin è nato da un paper pubblicato il 18 agosto 2008 da una persona o gruppo sotto lo pseudonimo di *Satoshi Nakamoto*. Il primo blocco (Genesis Block) fu minato il 3 gennaio 2009, e la prima transazione avvenne il 12 gennaio 2009.

### Bitcoin Pizza Day

Il 22 maggio 2010 avvenne la prima transazione commerciale conosciuta utilizzando bitcoin: il programmatore Laszlo Hanyecz comprò due pizze di Papà John's per 10.000 bitcoin. Questa data viene ora celebrata come "Bitcoin Pizza Day". A prezzi attuali, quei 10.000 bitcoin varrebbero centinaia di milioni di dollari, rendendo quelle le pizze più costose della storia!

## La Blockchain di Bitcoin

Nel contesto di Bitcoin, la blockchain registra tutte le transazioni che sono mai state effettuate nella rete. La bellezza di questo sistema è che non esiste un'autorità centrale che controlla il registro. Non c'è una banca, non c'è un governo, non c'è un'azienda che può decidere quali transazioni sono valide e quali no. Tutto è gestito collettivamente dalla rete stessa.

Questa caratteristica è ciò che rende Bitcoin affidabile come sistema di pagamento. Se potessi modificare il registro per far sparire una transazione, potresti spendere gli stessi bitcoin più volte. Ma grazie alla natura immutabile della blockchain, questo è praticamente impossibile.

## Le Transazioni: Il Cuore del Sistema

Una transazione in Bitcoin è concettualmente molto semplice: è il trasferimento di una certa quantità di bitcoin da un account (chiamato indirizzo) a un altro. Quando vuoi inviare bitcoin a qualcuno, stai essenzialmente creando un messaggio che dice "Io, proprietario dell'indirizzo A, voglio trasferire X bitcoin all'indirizzo B".

### La Firma Digitale: La Tua Prova di Proprietà

Ma come fa la rete a sapere che sei davvero tu il proprietario di quei bitcoin? Qui entra in gioco la firma digitale. Ogni transazione deve essere firmata digitalmente dal proprietario dei fondi che vengono trasferiti. La firma digitale è l'equivalente moderno e crittografico della tua firma su un documento cartaceo, ma infinitamente più sicura.

Una firma digitale ha due proprietà straordinarie che la rendono perfetta per questo scopo. Prima di tutto, solo tu puoi creare la tua firma digitale, perché per farlo hai bisogno di una **chiave privata** che solo tu possiedi. È come avere l'unica copia di una chiave che apre un particolare lucchetto. Tuttavia, una volta che hai creato la firma, chiunque può verificare che sia autentica. Non hanno bisogno di conoscere la tua chiave privata per verificare che la firma sia valida, proprio come chiunque può riconoscere la tua firma su un documento senza dover sapere esattamente come muovi la mano quando firmi.

La seconda proprietà fondamentale è che la firma è indissolubilmente legata al documento specifico che stai firmando. Non puoi prendere una firma che hai fatto per una transazione e riutilizzarla per un'altra. Ogni transazione ha la sua firma unica, che verifica esattamente quella specifica operazione e nessun'altra.

### L'Analogia dell'Assegno Bancario

Per capire meglio come funziona una transazione Bitcoin, possiamo fare un'analogia con un assegno bancario tradizionale. Quando scrivi un assegno, includi diverse informazioni: chi sta dando i soldi (tu), chi deve riceverli (il beneficiario), quanto denaro deve essere trasferito, la data, e infine la tua firma. Un assegno non trasferisce immediatamente il denaro. È solo una promessa, un'istruzione che deve ancora essere elaborata.

Ecco cosa succede con un assegno: lo dai a qualcuno, quella persona lo porta alla sua banca, la sua banca contatta la tua banca usando l'assegno come prova, la tua banca verifica che tu abbia abbastanza soldi sul conto, e solo allora il denaro viene effettivamente trasferito. Se non hai abbastanza soldi, l'assegno viene respinto (rimbalza).

Una transazione Bitcoin funziona in modo molto simile. Crei la transazione con tutte le informazioni necessarie e la firmi digitalmente. Ma il trasferimento non è immediato. La transazione deve essere verificata dalla rete, deve essere inclusa in un blocco, e solo allora viene considerata confermata. Se provi a spendere bitcoin che non possiedi, la rete "rifiuterà" la transazione.

## Come le Transazioni si Propagano nella Rete

Immagina di lanciare un sasso in uno stagno. Le onde si propagano in tutte le direzioni, raggiungendo ogni punto della superficie dell'acqua. Qualcosa di simile accade quando crei una transazione Bitcoin.

Quando completi una transazione, il tuo software Bitcoin la invia a uno o più nodi della rete con cui sei connesso. Questi nodi ricevono la tua transazione, la verificano rapidamente per assicurarsi che sia formattata correttamente, e poi la inoltrano a tutti gli altri nodi con cui sono connessi. Questi nodi a loro volta fanno lo stesso, e così via. In pochissimo tempo, la tua transazione si è propagata attraverso l'intera rete mondiale di Bitcoin, raggiungendo potenzialmente migliaia di nodi in tutto il mondo.

Questo meccanismo si chiama **broadcasting peer-to-peer**, e significa che non esiste un server centrale che gestisce la distribuzione delle informazioni. Ogni nodo è allo stesso livello degli altri, e collabora alla diffusione delle transazioni. È un sistema estremamente resiliente perché non ha punti di fallimento singoli (SPF - Single Point of Failure). Se un nodo si spegne o viene attaccato, la rete continua a funzionare perfettamente attraverso tutti gli altri nodi.

### Il Mempool: La Sala d'Attesa delle Transazioni

Quando un nodo riceve una nuova transazione, non la aggiunge immediatamente alla blockchain. Prima, la inserisce in una zona di memoria temporanea chiamata **mempool**, che è l'abbreviazione di "memory pool" (pool di memoria). Puoi pensare al mempool come a una sala d'attesa in un ufficio postale. Le transazioni arrivano, vengono controllate per assicurarsi che siano valide, e poi aspettano il loro turno per essere elaborate.

Ogni nodo nella rete Bitcoin mantiene il proprio mempool. Questo significa che il mempool del tuo nodo potrebbe essere leggermente diverso dal mempool di un altro nodo dall'altra parte del mondo, perché le transazioni arrivano in momenti leggermente diversi a causa dei ritardi nella rete. Ma in generale, i mempool di tutti i nodi tendono a contenere più o meno le stesse transazioni.

Il mempool solleva diverse questioni fondamentali che devono essere risolte:
- In che ordine dovrebbero essere processate le transazioni?
- Se migliaia di transazioni arrivano più o meno nello stesso momento, quale dovrebbe essere elaborata per prima?
- Chi decide quali transazioni possono essere incluse nella blockchain e quali devono aspettare o essere rifiutate?

Queste domande ci portano a uno degli aspetti più interessanti e importanti di Bitcoin: il meccanismo del consenso e del mining.

## Le Commissioni: Il Costo di Usare la Rete

Un aspetto che sorprende molte persone quando iniziano a usare Bitcoin è che le transazioni non sono gratuite. Per far sì che la tua transazione venga inclusa nella blockchain, devi pagare una commissione. Ma questa commissione funziona in modo molto diverso da come funzionano le commissioni bancarie tradizionali.

In una banca, quando fai un bonifico, la commissione di solito dipende dall'importo che stai trasferendo. Trasferire mille euro potrebbe costare di più che trasferire cento euro. Ma in Bitcoin, l'importo che trasferisci è completamente irrilevante per quanto riguarda la commissione. Potresti trasferire un singolo bitcoin o mille bitcoin, e la commissione potrebbe essere esattamente la stessa.

Ciò che determina la commissione in Bitcoin è la dimensione fisica della transazione, misurata in byte. Una transazione più complessa, che magari coinvolge molti input diversi (come se stessi pagando con tante monete e banconote diverse), occupa più spazio e quindi costa di più. La commissione viene espressa in satoshi per byte, dove un satoshi è la più piccola unità di Bitcoin (un centomilionesimo di bitcoin).

### L'Asta per lo Spazio nei Blocchi

Ma c'è un'altra dimensione nelle commissioni Bitcoin che le rende ancora più interessanti: il sistema funziona come un'asta continua. Ogni blocco nella blockchain ha una dimensione limitata, il che significa che può contenere solo un numero finito di transazioni. Quando molte persone vogliono fare transazioni contemporaneamente, si crea congestione, proprio come il traffico su un'autostrada nelle ore di punta.

In questa situazione, i miner (i nodi che creano i blocchi, di cui parleremo tra poco) devono scegliere quali transazioni includere nel blocco successivo. Naturalmente, scelgono le transazioni che pagano le commissioni più alte, perché quelle commissioni vanno direttamente a loro come compenso per il loro lavoro.

Questo crea un mercato dinamico per lo spazio nei blocchi. Quando la rete è tranquilla e ci sono poche transazioni, puoi pagare una commissione molto bassa e la tua transazione verrà comunque inclusa rapidamente. Ma quando la rete è congestionata, devi competere con altre persone offrendo commissioni più alte. Se offri una commissione troppo bassa durante un periodo di alta congestione, la tua transazione potrebbe rimanere bloccata nel mempool per ore, giorni, o addirittura per sempre, finché non decidi di aumentare la commissione o la rete si libera.

Questo sistema può sembrare strano a prima vista, ma ha una sua logica economica. Garantisce che lo spazio limitato nei blocchi venga allocato a chi ne ha più bisogno in quel momento, cioè a chi è disposto a pagare di più per una conferma rapida.

## I Blocchi: Contenitori di Transazioni

Abbiamo parlato molto di transazioni, ma ora dobbiamo capire come queste transazioni vengono organizzate e fissate permanentemente nella blockchain. Qui entrano in gioco i blocchi.

Un blocco è essenzialmente un contenitore di transazioni. Invece di aggiungere le transazioni alla blockchain una alla volta, vengono raggruppate insieme in blocchi. Ogni blocco ha una dimensione massima fissa, attualmente di circa un megabyte (con alcune estensioni tecniche che possono aumentare leggermente questa dimensione). Questo limite di dimensione significa che ogni blocco può contenere solo un certo numero di transazioni, tipicamente tra 2000 e 3000, a seconda di quanto sono grandi le singole transazioni.

La blockchain cresce costantemente, con un nuovo blocco aggiunto circa ogni dieci minuti. Al momento della scrittura, la blockchain di Bitcoin contiene centinaia di migliaia di blocchi e continua a crescere senza sosta.

## I Nodi: I Custodi della Blockchain

Per far funzionare questa rete distribuita, servono computer che fanno girare il software Bitcoin. Questi computer sono chiamati nodi, e ne esistono di due tipi principali, ognuno con un ruolo specifico nel mantenere la rete sicura e funzionante.

### Nodi Client: I Verificatori

I nodi client, anche chiamati full nodes (nodi completi), sono la spina dorsale della rete Bitcoin. Questi nodi scaricano e conservano una copia completa dell'intera blockchain, che attualmente occupa diverse centinaia di gigabyte di spazio su disco. Potrebbe sembrare uno spreco di spazio, ma questa ridondanza è ciò che rende Bitcoin così resistente alla censura e agli attacchi.

Il compito principale di un nodo client è verificare. Quando riceve una nuova transazione, il nodo verifica che sia valida: controlla che la firma digitale sia corretta, che i bitcoin che si stanno cercando di spendere esistano davvero e non siano già stati spesi, e che la transazione rispetti tutte le altre regole del protocollo Bitcoin. Se anche solo una di queste verifiche fallisce, il nodo rifiuta la transazione e non la propaga agli altri nodi.

Lo stesso accade con i blocchi. Quando un nodo riceve un nuovo blocco, esegue una serie completa di verifiche. Controlla tutte le transazioni nel blocco, verifica che il blocco sia collegato correttamente alla catena, e si assicura che rispetti tutte le regole di consenso. Solo se tutte queste verifiche passano, il nodo aggiunge il blocco alla sua copia della blockchain.

Questi nodi sono fondamentali per la decentralizzazione di Bitcoin. Più nodi client ci sono nella rete, più la rete è distribuita e resistente. Se un governo o un'azienda volesse censurare Bitcoin o cambiarne le regole, dovrebbe convincere o forzare la maggior parte dei nodi a seguire le sue direttive, il che è praticamente impossibile quando ci sono migliaia di nodi indipendenti sparsi in tutto il mondo.

### Nodi Mining: I Creatori di Blocchi

I nodi mining sono un tipo speciale di nodi client che, oltre a fare tutto ciò che fa un nodo normale, hanno un compito aggiuntivo cruciale: creano nuovi blocchi. Questi nodi raccolgono transazioni dal loro mempool, le organizzano in un blocco candidato, e poi competono tra loro per avere il diritto di aggiungere quel blocco alla blockchain.

Questa competizione è il cuore del meccanismo di consenso di Bitcoin e richiede un'enorme quantità di potenza computazionale. I miner devono risolvere un complesso puzzle matematico, e il primo che lo risolve vince il diritto di proporre il blocco successivo. Questo processo richiede hardware specializzato chiamato ASIC (Application-Specific Integrated Circuits), che sono computer progettati specificamente per fare mining di Bitcoin e nient'altro.

Il mining non è solo un modo per aggiungere blocchi alla blockchain. È anche il meccanismo attraverso cui vengono creati nuovi bitcoin e distribuiti nella rete. È come se i miner fossero minatori d'oro digitale, che spendono energia elettrica e potenza di calcolo nella speranza di trovare nuovi bitcoin.

## Come Bitcoin Raggiunge il Consenso

Bitcoin risolve il problema del consenso distribuito attraverso un processo che può sembrare quasi magico nella sua semplicità. Ecco come funziona in termini semplificati.

Prima di tutto, tutte le nuove transazioni vengono trasmesse a tutti i nodi della rete. Ogni nodo le raccoglie nel suo mempool e le verifica indipendentemente. Poi, ogni nodo mining seleziona un insieme di transazioni dal suo mempool e le organizza in un blocco candidato.

A questo punto entra in gioco la parte magica: in ogni round (cioè circa ogni dieci minuti), un nodo viene selezionato casualmente per avere il diritto di proporre il blocco successivo. Questo nodo trasmette il suo blocco a tutti gli altri nodi della rete.

Gli altri nodi ricevono questo blocco e lo esaminano attentamente. Verificano che tutte le transazioni nel blocco siano valide: che i bitcoin che vengono spesi non siano già stati spesi prima, che tutte le firme digitali siano corrette, che le commissioni siano calcolate correttamente, e così via. Se tutto è in ordine, accettano il blocco e lo aggiungono alla loro copia della blockchain.

Ma come esprimono questa accettazione? In un modo molto elegante: quando iniziano a lavorare sul blocco successivo, includono un riferimento crittografico al blocco che hanno appena accettato. È come dire "io accetto questo blocco come valido, e sto costruendo sopra di esso". Con il passare del tempo, blocco dopo blocco, questa accettazione diventa sempre più forte, perché sempre più blocchi vengono costruiti sopra quello originale.

## Gli Incentivi: Perché i Miner Partecipano

A questo punto potresti chiederti: perché qualcuno dovrebbe spendere soldi per comprare hardware costoso e pagare enormi bollette elettriche per fare mining di Bitcoin? La risposta sta nel sistema di incentivi ingegnosamente progettato che è incorporato nel protocollo.

Quando un miner riesce a creare un blocco valido e viene accettato dalla rete, riceve una ricompensa in bitcoin. Questa ricompensa ha due componenti. La prima è chiamata block reward o ricompensa del blocco. È una quantità fissa di bitcoin appena creati, che vengono letteralmente generati dal nulla e assegnati al miner vincitore. Attualmente, questa ricompensa è di 3.125 bitcoin per blocco.

Questa block reward non è costante nel tempo. Ogni 210.000 blocchi (circa ogni quattro anni), la ricompensa viene dimezzata in un evento chiamato "halving". Quando Bitcoin è stato lanciato nel 2009, la ricompensa era di 50 bitcoin per blocco. È stata dimezzata a 25 nel 2012, poi a 12.5 nel 2016, poi a 6.25 nel 2020, e più recentemente a 3.125. Continuerà a dimezzarsi fino a raggiungere zero intorno all'anno 2140.

Questo meccanismo di dimezzamento garantisce che il numero totale di bitcoin che verrà mai creato sia limitato. Non potranno mai esistere più di 21 milioni di bitcoin. Questa scarsità programmata è una delle ragioni per cui molte persone vedono Bitcoin come una forma di "oro digitale".

La seconda componente della ricompensa del miner sono le commissioni delle transazioni. Come abbiamo discusso prima, ogni transazione include una commissione. Tutte le commissioni delle transazioni incluse in un blocco vanno al miner che ha creato quel blocco. Attualmente, le commissioni rappresentano una piccola frazione della ricompensa totale dei miner, ma nel futuro, quando la block reward diventerà sempre più piccola e alla fine raggiungerà zero, le commissioni diventeranno la principale fonte di reddito per i miner.

Questo sistema di incentivi è cruciale per la sicurezza di Bitcoin. I miner spendono risorse reali (elettricità, hardware) per proteggere la rete, e in cambio ricevono bitcoin. Più prezioso diventa il bitcoin, più i miner sono incentivati a proteggere la rete, il che a sua volta rende il bitcoin più sicuro e quindi potenzialmente più prezioso. È un circolo virtuoso.

## I Fork: Quando la Blockchain si Divide

Nonostante tutto il lavoro che abbiamo fatto per raggiungere il consenso, a volte la blockchain si divide temporaneamente. Questo si chiama fork, che in italiano significa "forcella" o "biforcazione", e il nome descrive perfettamente ciò che accade: la catena si divide in due rami.

### Come si Forma un Fork

Ricorda che i blocchi dovrebbero essere creati circa ogni dieci minuti. Ma questo è solo una media. A volte un blocco viene trovato dopo cinque minuti, a volte dopo quindici. E in rari casi, due miner possono risolvere il puzzle quasi contemporaneamente, diciamo entro pochi secondi l'uno dall'altro.

Quando questo accade, entrambi i miner trasmettono il loro blocco alla rete. Ma a causa dei ritardi nella propagazione delle informazioni attraverso Internet, alcuni nodi ricevono prima il blocco del miner A, mentre altri nodi ricevono prima il blocco del miner B.

Ora la rete si trova in uno stato ambiguo. Alcuni nodi pensano che il blocco A sia il blocco valido più recente e iniziano a costruire il blocco successivo sopra di esso. Altri nodi pensano che sia il blocco B e costruiscono sopra quello. La blockchain si è divisa in due versioni concorrenti, due "realtà alternative" della storia delle transazioni.

Questo potrebbe sembrare disastroso, ma in realtà è un problema temporaneo che Bitcoin risolve automaticamente attraverso una regola semplice ma efficace.

### La Regola della Catena più Lunga

Bitcoin segue quella che viene chiamata "longest chain rule", cioè la regola della catena più lunga. L'idea è semplice: quando esistono due versioni concorrenti della blockchain, i nodi considerano valida quella più lunga, cioè quella con più lavoro computazionale incorporato.

Ecco come funziona in pratica. Dopo che il fork si è formato, i miner continuano a lavorare sui loro blocchi successivi. Alcuni stanno costruendo sopra il blocco A, altri sopra il blocco B. Ma prima o poi, uno dei due rami troverà il blocco successivo prima dell'altro. Supponiamo che sia il ramo A a trovarlo per primo.

Ora il ramo A ha due blocchi (A e il successivo) mentre il ramo B ha solo un blocco. Secondo la regola della catena più lunga, il ramo A diventa la versione ufficiale della blockchain. Quando i nodi che stavano lavorando sul ramo B ricevono la notizia che il ramo A è più lungo, abbandonano il loro lavoro e passano al ramo A.

Il blocco B e tutte le transazioni che conteneva vengono scartati. Il blocco B diventa quello che viene chiamato un "blocco orfano", un blocco che è stato creato ma non è mai diventato parte della blockchain ufficiale. Le transazioni che erano nel blocco B tornano nel mempool e aspettano di essere incluse in un blocco futuro.

### Le Implicazioni dei Fork

Questa situazione solleva una questione importante: se un blocco può essere scartato, significa che le transazioni che conteneva possono essere perse? Tecnicamente sì, anche se è raro. La maggior parte delle transazioni nel blocco scartato verranno semplicemente incluse nel blocco successivo. Ma in teoria, alcune potrebbero essere perse, specialmente se erano in conflitto con transazioni nel ramo vincente.

Questo è il motivo per cui quando ricevi un pagamento in Bitcoin, non dovresti considerarlo definitivo immediatamente. La convenzione è aspettare che diversi blocchi siano costruiti sopra il blocco che contiene la tua transazione. Ogni nuovo blocco rende esponenzialmente più difficile che il fork venga ribaltato. Dopo sei blocchi (circa un'ora), una transazione è considerata praticamente irreversibile per tutti gli scopi pratici.

I fork dimostrano anche la natura probabilistica della sicurezza di Bitcoin. Non c'è un momento preciso in cui una transazione passa da "non confermata" a "confermata con certezza assoluta". C'è invece un gradiente continuo di certezza che aumenta con ogni nuovo blocco. Questo è molto diverso dal sistema bancario tradizionale, dove una transazione è o completamente confermata o completamente rifiutata, senza vie di mezzo.

## Conclusione: Un Sistema Senza Fiducia

Quello che rende Bitcoin davvero rivoluzionario non è tanto la tecnologia in sé, quanto ciò che quella tecnologia permette di realizzare: un sistema di pagamento che funziona senza bisogno di fiducia.

In tutti i sistemi di pagamento tradizionali, devi fidarti di qualcuno: della tua banca, della banca del destinatario, delle società di carte di credito, degli intermediari che processano i pagamenti. Devi fidarti che non perderanno i tuoi soldi, che non ti imporranno commissioni eccessive, che non ti negheranno l'accesso ai tuoi fondi, che non congeleranno il tuo conto senza motivo.

Bitcoin elimina questo bisogno di fiducia. Non devi fidarti di nessun singolo individuo o organizzazione. Invece, ti fidi della matematica, della crittografia, e del fatto che la maggior parte delle persone nella rete agisce secondo il proprio interesse economico razionale, che coincide con il mantenimento della sicurezza del sistema.

Questo è ciò che Satoshi Nakamoto ha realizzato con Bitcoin: un sistema veramente distribuito, dove il potere non è concentrato in nessun punto singolo, dove nessuno può essere escluso, e dove le regole sono applicate automaticamente dal codice piuttosto che dall'arbitrio umano. È un esperimento senza precedenti in economia, informatica, e organizzazione sociale, che continua a evolversi e a sorprenderci più di quindici anni dopo la sua creazione.