# Automi a Stati Finiti (FSA)

## Definizione Formale
Un automa a stati finiti è una **quintupla** $(Q, \Sigma, \delta, q_0, A)$, dove:
- **$Q$**: Insieme finito di stati (es. $q_0, q_1, q_2$).
- **$\Sigma$**: Alfabeto (simboli consentiti, es. $\{a, b, l\}$).
- **$\delta$**: Funzione di transizione $\delta(q, x) \rightarrow q'$. Definisce come l'automa passa da uno stato $q$ a $q'$ leggendo il simbolo $x$.
- **$q_0$**: Stato iniziale (es. $q_0$).
- **$A$**: Insieme di stati accettanti/finali (es. $\{q_4\}$).

---

## Esempio: Il "Linguaggio delle Pecore"
### Descrizione
- **Linguaggio $L_{\text{sheep}}$**: Stringhe che iniziano con "b", seguite da almeno due "a", e terminano con "!" (es. "baa!", "baaaaa!", ...).
- **Regex corrispondente**: `/baa+!/`.

### Automa Corrispondente
```tikz
\usepackage{tikz}
\usetikzlibrary{automata, positioning, arrows.meta}
\begin{document}
\begin{tikzpicture}[
    node distance=3cm, 
    scale=1.5,
    every state/.style={minimum size=1.2cm},
    auto
]
    \node[state, initial] (q0) {$q_0$};
    \node[state, right=of q0] (q1) {$q_1$};
    \node[state, right=of q1] (q2) {$q_2$};
    \node[state, right=of q2] (q3) {$q_3$};
    \node[state, accepting, right=of q3] (q4) {$q_4$};
    
    \path[->, >=Stealth]
    (q0) edge node[above] {b} (q1)
    (q1) edge node[above] {a} (q2)
    (q2) edge node[above] {a} (q3)
    (q3) edge[loop above] node {a} ()
          edge node[above] {!} (q4);
\end{tikzpicture}
\end{document}
```

### Tabella di Transizione
| Stato | $b$      | $a$      | $!$      |
|-------|----------|----------|----------|
| $q_0$ | $q_1$    | -        | -        |
| $q_1$ | -        | $q_2$    | -        |
| $q_2$ | -        | $q_3$    | -        |
| $q_3$ | -        | $q_3$    | $q_4$    |
| $q_4$ | -        | -        | -        |

---

## Funzionamento di un FSA
### Processo di Riconoscimento
1. **Input**: "baaa!"
   - $q_0 \xrightarrow{b} q_1 \xrightarrow{a} q_2 \xrightarrow{a} q_3 \xrightarrow{a} q_3 \xrightarrow{!} q_4$ → **Accettata**.
2. **Input**: "ba!"
   - $q_0 \xrightarrow{b} q_1 \xrightarrow{a} q_2$ → Esaurimento input in stato non finale → **Rifiutata**.

---

## Accettatori vs. Generatori
- **Accettatori**: Verificano se una stringa appartiene al linguaggio.
- **Generatori**: Producono tutte le stringhe valide.  
**Esempio generato**:  
```tikz
\usepackage{tikz}
\usetikzlibrary{automata, positioning, arrows.meta}
\begin{document}
\begin{tikzpicture}[
    node distance=3cm, 
    scale=1.5,
    every state/.style={minimum size=1.2cm},
    highlight/.style={red, thick}
]
    \node[state, initial] (start) {$q_0$};
    \node[state, right=of start] (q1) {$q_1$};
    \node[state, right=of q1] (q2) {$q_2$};
    \node[state, right=of q2] (q3) {$q_3$};
    \node[state, accepting, right=of q3] (end) {$q_4$};
    
    \path[->, >=Stealth, highlight]
    (start) edge node {b} (q1)
    (q1) edge node {a} (q2)
    (q2) edge node {a} (q3)
    (q3) edge[loop above] node {a} ()
          edge node {!} (end);
\end{tikzpicture}
\end{document}
```

---

## Relazione tra Regex e FSA
### Equivalenze
| Operazione Regex      | Operazione FSA                  |
|-----------------------|---------------------------------|
| `RE1\|RE2` (Unione)     | FSA che accetta $L_1 \cup L_2$ |
| `RE1RE2` (Concatenazione)| FSA che accetta $L_1L_2$     |
| `RE*` (Kleene Star)   | FSA con loop per ripetizioni    |

**Esempio**: Regex `(a|b)*c`  
```tikz
\usepackage{tikz}
\usetikzlibrary{automata, positioning, arrows.meta}
\begin{document}
\begin{tikzpicture}[
    node distance=4cm, 
    scale=1.5,
    every state/.style={minimum size=1.2cm}
]
    \node[state, initial] (q0) {$q_0$};
    \node[state, accepting, right=of q0] (q1) {$q_1$};
    
    \path[->, >=Stealth]
    (q0) edge[loop above] node {a, b} ()
         edge node[above] {c} (q1);
\end{tikzpicture}
\end{document}
```

---

## Esercizio Guidato
### Dati
- $L_1 = \\{\text{nlp}, \text{nat\_lang\_proc}\\}$
- $L_2 = \\{\text{\_is\_cool}\\}$
- $L_3 = L_1L_2^*$

### Soluzione
**FSA per $L_3$**:  
```tikz
\usepackage{tikz}
\usetikzlibrary{automata, positioning, arrows.meta}
\begin{document}
\begin{tikzpicture}[
    node distance=2.5cm, 
    scale=1.5,
    every state/.style={minimum size=1.2cm}
]
    \node[state, initial] (start) {$q_0$};
    \node[state, above right=of start] (nlp) {$q_1$};
    \node[state, below right=of start] (nat) {$q_2$};
    \node[state, accepting, right=4cm of start] (loop) {$q_3$};
    
    \path[->, >=Stealth]
    (start) edge node[above left] {nlp} (nlp)
            edge node[below left] {nat\_lang\_proc} (nat)
    (nlp) edge node[above] {$\epsilon$} (loop)
    (nat) edge node[below] {$\epsilon$} (loop)
    (loop) edge[loop right] node {\_is\_cool} ();
\end{tikzpicture}
\end{document}
```

---

## Applicazioni in NLP
### Tokenizzazione
```tikz
\usepackage{tikz}
\usetikzlibrary{automata, positioning, arrows.meta}

\begin{document}
\begin{tikzpicture}[
    node distance=2.5cm, 
    scale=1.5,
    every state/.style={minimum size=1.2cm}
]
    \node[state, initial] (start) {$q_0$};
    \node[state, accepting, right=of start] (word) {$q_1$};
    \node[state, accepting, below=of start] (num) {$q_2$};
    
    \path[->, >=Stealth]
    (start) edge[loop above] node {Lettere} ()
            edge node[right] {Cifre} (num)
            edge node[above] {Simboli} (word);
\end{tikzpicture}
\end{document}
```

---

> **Etichette**: #FSA #Regex #LinguaggiFormali  
> **Collegamenti**: [[Espressioni Regolari]], [[Teoria degli Automi]]  
> **Risorse**:  
> - [Speech and Language Processing (Jurafsky & Martin)](https://web.stanford.edu/~jurafsky/slp3/)  
> - [Simulatore FSA Online](https://ivanzuzak.info/noam/webapps/fsm_simulator/)