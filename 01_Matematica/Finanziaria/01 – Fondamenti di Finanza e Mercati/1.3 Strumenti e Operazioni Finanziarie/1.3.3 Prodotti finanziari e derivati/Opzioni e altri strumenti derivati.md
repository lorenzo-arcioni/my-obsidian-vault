# Opzioni e altri strumenti derivati

## Introduzione
Le **opzioni** sono strumenti finanziari derivati che conferiscono al detentore il diritto (ma non l'obbligo) di acquistare o vendere un bene sottostante a un prezzo prefissato (strike) entro una data specifica (maturità). Esistono due tipi principali di opzioni: le **call** (diritto di acquisto) e le **put** (diritto di vendita).

---

## 1. Opzioni call e put

### Definizione
- **Call**: Un'opzione call dà al detentore il diritto di acquistare il bene sottostante al prezzo di esercizio $K$ alla data di maturità $T$.
- **Put**: Un'opzione put dà al detentore il diritto di vendere il bene sottostante al prezzo di esercizio $K$ alla data di maturità $T$.

### Esempio
Il 16 gennaio 2004, un'opzione call sull'Euro con:
- **Prezzo di esercizio**: $K = 1.26$ USD/Euro,
- **Maturità**: $T = 4$ marzo 2004,
- **Prezzo dell'opzione**: $0.017$ USD.

Se il cambio Euro/USD alla maturità è superiore a $1.26$, il detentore eserciterà l'opzione, acquistando Euro a $1.26$ USD. Se è inferiore, l'opzione non verrà esercitata.

---

## 2. Payoff delle opzioni

### Call europea
Il **payoff** di una call europea alla maturità $T$ è:
$$
C_T = (S_T - K)^+ = \max(S_T - K, 0)
$$
dove $S_T$ è il prezzo del sottostante alla maturità.

### Put europea
Il **payoff** di una put europea alla maturità $T$ è:
$$
P_T = (K - S_T)^+ = \max(K - S_T, 0)
$$

### Grafici
- **Call**: Il payoff è illimitato e cresce linearmente con $S_T$ per $S_T > K$.
- **Put**: Il payoff è limitato e massimo quando $S_T = 0$.

---

## 3. Opzioni americane

### Definizione
Le **opzioni americane** possono essere esercitate in qualsiasi momento tra l'emissione e la maturità, a differenza delle opzioni europee, che possono essere esercitate solo alla maturità.

### Esempio
Un'opzione call americana su un'azione con:
- **Prezzo di esercizio**: $K = 40$ Euro,
- **Maturità**: $T = 4$ aprile 2004,
- **Prezzo dell'opzione**: $2$ Euro.

Se il prezzo dell'azione supera $40$ Euro prima della maturità, il detentore può esercitare l'opzione e realizzare un profitto.

---

## 4. Utilizzo delle opzioni

### Copertura del rischio
Le opzioni sono utilizzate per proteggersi da fluttuazioni di prezzo. Ad esempio, un'azienda può acquistare una call per garantirsi un prezzo massimo di acquisto.

### Speculazione
Le opzioni possono essere utilizzate per scommettere sull'andamento dei prezzi. Tuttavia, le speculazioni sulle opzioni sono ad alto rischio, con possibilità di grandi guadagni ma anche di perdite totali.

---

## 5. Considerazioni finali

### Vantaggi
- **Flessibilità**: Le opzioni offrono diverse strategie di investimento e copertura.
- **Leverage**: Con un piccolo investimento, è possibile controllare un grande valore sottostante.

### Svantaggi
- **Rischio elevato**: Le opzioni possono portare a perdite significative.
- **Complessità**: Richiedono una buona comprensione dei mercati finanziari.

---

## Conclusione
Le **opzioni** sono strumenti potenti per la gestione del rischio e la speculazione. Comprendere il loro funzionamento e le implicazioni pratiche è essenziale per gli investitori. Nel prossimo file, esploreremo ulteriori dettagli sui **derivati** e il loro ruolo nei mercati finanziari.