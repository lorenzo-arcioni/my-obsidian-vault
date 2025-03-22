# Contratti forward e futures

## Introduzione
I **contratti forward** e i **futures** sono strumenti finanziari derivati utilizzati per gestire il rischio associato alle fluttuazioni dei prezzi di beni, valute o altri asset. Questi contratti permettono di fissare oggi il prezzo di un bene che verrà scambiato in una data futura, offrendo protezione contro le variazioni di mercato.

---

## 1. Contratti forward

### Definizione
Un **contratto forward** è un accordo tra due parti (A e B) in cui:
- **B** si impegna a consegnare un bene (ad esempio, valuta, materie prime, azioni) a una data futura $T$ (data di maturità) a un prezzo $F$ (prezzo di consegna) fissato oggi.
- **A** si impegna ad acquistare il bene al prezzo $F$ alla data $T$.

### Esempio
Supponiamo che un'industria americana debba pagare una fattura in Euro all'inizio di marzo 2004. Per proteggersi dalle fluttuazioni del cambio Euro/USD, l'azienda acquista un contratto forward con:
- **Prezzo di consegna**: $F = 1.2462$ USD/Euro,
- **Data di maturità**: $T = 4$ marzo 2004.

Se il cambio Euro/USD alla data di maturità sarà superiore a $1.2462$, l'azienda avrà guadagnato; se sarà inferiore, avrà perso. In ogni caso, si sarà garantita da oscillazioni impreviste.

### Nomenclatura
- **Data di maturità ($T$)**: Data in cui il contratto viene eseguito.
- **Prezzo di consegna ($F$)**: Prezzo fissato oggi per la transazione futura.
- **Prezzo forward**: Prezzo corrente del contratto forward. All'emissione, coincide con $F$.
- **Prezzo spot ($S_t$)**: Prezzo corrente del bene sottostante.

### Posizioni
- **Posizione lunga**: Chi acquista il contratto forward (A) si assume l'obbligo di acquistare il bene a $F$.
- **Posizione corta**: Chi vende il contratto forward (B) si assume l'obbligo di consegnare il bene a $F$.

### Considerazioni
1. **Nessun esborso iniziale**: Entrare in un contratto forward non richiede un pagamento iniziale.
2. **Non regolamentati**: I contratti forward non sono scambiati in borsa e sono soggetti a rischio di controparte.

---

## 2. Contratti futures

### Definizione
I **contratti futures** sono simili ai forward, ma sono regolamentati e scambiati in borsa. Le principali differenze sono:
- **Regolamentazione**: I futures sono standardizzati e soggetti a regole precise.
- **Margini**: Le parti devono depositare garanzie (margini) su conti speciali per coprire eventuali perdite.

### Esempio
Un contratto future sull'Euro potrebbe prevedere:
- **Prezzo di consegna**: $F = 1.2500$ USD/Euro,
- **Data di maturità**: $T = 4$ marzo 2004,
- **Margini**: Le parti depositano garanzie per coprire fluttuazioni di prezzo.

---

## 3. Prezzo di consegna e arbitraggio

### Formula del prezzo di consegna
In assenza di arbitraggio, il prezzo di consegna $F$ di un contratto forward è:
$$
F = S_0 \cdot e^{rT}
$$
dove:
- $S_0$ è il prezzo spot del bene al tempo $t = 0$,
- $r$ è il tasso di interesse istantaneo,
- $T$ è la durata del contratto.

### Dimostrazione
Se $F < S_0 \cdot e^{rT}$, un arbitraggista potrebbe:
1. Vendere allo scoperto il bene al prezzo $S_0$,
2. Investire $S_0$ in banca al tasso $r$,
3. Acquistare un contratto forward a $F$.

Alla scadenza $T$:
- Ritira $S_0 \cdot e^{rT}$ dalla banca,
- Acquista il bene a $F$ e lo restituisce per coprire la vendita allo scoperto,
- Realizza un profitto $S_0 \cdot e^{rT} - F > 0$.

Se $F > S_0 \cdot e^{rT}$, l'arbitraggio è possibile in direzione opposta.

---

## 4. Considerazioni finali

### Vantaggi
- **Protezione dal rischio**: I contratti forward e futures permettono di fissare prezzi futuri, riducendo l'incertezza.
- **Liquidità**: I futures sono facilmente negoziabili in borsa.

### Svantaggi
- **Rischio di controparte**: Nei forward, c'è il rischio che una delle parti non adempia agli obblighi.
- **Margini**: I futures richiedono depositi di garanzia, che possono limitare la liquidità.

---

## Conclusione
I **contratti forward** e **futures** sono strumenti essenziali per la gestione del rischio finanziario. Comprendere il loro funzionamento e le implicazioni pratiche è fondamentale per gli operatori di mercato. Nel prossimo file, esploreremo le **opzioni**, un altro tipo di strumento derivato.