# 🧠 Algoritmo di Cocke-Kasami-Younger (CKY)

L'algoritmo **Cocke-Kasami-Younger (CKY)** è una tecnica di parsing fondamentale nel campo dell'elaborazione del linguaggio naturale e dell'analisi sintattica. Si tratta di un approccio **bottom-up** che sfrutta la **programmazione dinamica** per verificare se una frase (cioè una sequenza di parole) può essere generata da una grammatica **libera dal contesto**, a condizione che quest’ultima sia espressa in **Forma Normale di Chomsky (CNF)**.

## 📌 Cos'è la Forma Normale di Chomsky?

Una [[Grammatiche Formali|grammatica]] è in **Forma Normale di Chomsky** quando tutte le sue produzioni rispettano uno dei seguenti due schemi:
- $A \rightarrow BC$ dove $A$, $B$, e $C$ sono non-terminali (con $B$ e $C$ che non sono il simbolo iniziale).
- $A \rightarrow a$ dove $a$ è un terminale, ovvero una parola del vocabolario.

Questa forma consente di semplificare il parsing grazie a una struttura uniforme delle regole.

## 📐 Struttura della tabella di parsing

Per analizzare una frase composta da $n$ parole, l'algoritmo utilizza una **tabella triangolare superiore** (una matrice concettuale) di dimensioni $(n+1) \times (n+1)$, chiamata $table$.

- Ogni cella $table[i][j]$ contiene **l'insieme dei simboli non-terminali** che possono generare la sottostringa compresa tra le posizioni $i$ e $j$ (esclusa $j$).
- La cella più in alto a sinistra, $table[0][n]$, rappresenta la frase intera.
- Se il simbolo iniziale della grammatica $S$ è presente in $table[0][n]$, allora la frase può essere generata dalla grammatica.

### Esempio
Consideriamo la frase: "John loves Mary". Supponiamo di avere la seguente grammatica in CNF:

$$
\begin{align*}
S  &\rightarrow NP \ VP \\
NP &\rightarrow John \mid Mary \\
VP &\rightarrow VP NP\\
V  &\rightarrow loves
\end{align*}
$$


La tabella $table$ di dimensione $4 \times 4$ (poiché $n = 3$) sarà:

|       | 0   | 1        | 2        | 3   |
|-------|-----|----------|----------|-----|
| **0** |     | {NP}     |          | {S} |
| **1** |     |          | {V}      | {VP}|
| **2** |     |          |          | {NP}|
| **3** |     |          |          |     |

- $table[0][1] = \{NP\}$ perché $NP \rightarrow John$.
- $table[1][2] = \{V\}$ perché $V \rightarrow loves$.
- $table[2][3] = \{NP\}$ perché $NP \rightarrow Mary$.
- $table[1][3] = \{VP\}$ perché $V \in table[1][2]$ e $NP \in table[2][3]$ con la regola $VP \rightarrow V\ NP$.
- $table[0][3] = \{S\}$ perché $NP \in table[0][1]$ e $VP \in table[1][3]$ con la regola $S \rightarrow NP\ VP$.

Dato che $table[0][3] = \{S\}$, la frase puo essere generata dalla grammatica.

## 💡 Meccanismo di base: costruzione delle strutture sintattiche

L’algoritmo si basa su un principio di composizione: se una regola grammaticale afferma che $A \rightarrow B\ C$, e se riusciamo a suddividere una sottostringa in due parti tali che:
- $B$ genera la prima parte, cioè $B \in table[i][k]$
- $C$ genera la seconda parte, cioè $C \in table[k][j]$

allora possiamo concludere che:
- $A$ genera l’intera sottostringa, quindi $A \in table[i][j]$

Questo approccio è ripetuto per tutte le possibili partizioni della frase, permettendo la costruzione incrementale delle strutture sintattiche.

## 📋 Procedura di riempimento della tabella

1. **Inizializzazione (lunghezza 1)**: Per ogni parola nella frase, si aggiungono i non-terminali che possono generare direttamente quella parola (tramite regole del tipo $A \rightarrow a$).
2. **Espansione (lunghezze maggiori)**: Si analizzano sottostringhe di lunghezza crescente, esaminando tutte le possibili partizioni in due sottosequenze contigue. Per ogni partizione, si cercano coppie di simboli non-terminali già presenti nella tabella che possano essere combinate secondo le regole della grammatica.

Questo processo è eseguito in maniera bottom-up, iniziando dalle sottostringhe più piccole e costruendo via via strutture più complesse.

## 🔁 Pseudocodice dell'algoritmo CKY

Di seguito è riportato uno pseudocodice che illustra il funzionamento dell'algoritmo CKY. L'input è una lista di parole `words` e una grammatica in CNF, mentre l'output è una tabella $table$ che descrive come la frase può essere derivata.

$$
\begin{array}{l}
\textbf{function } \text{CKY-Parse(words, grammar)} \rightarrow \text{return table} \\[1em]
\qquad \textbf{for } j = 1 \text{ to } \texttt{length(words)} \text{ do} \\
\qquad \quad \textbf{for all rules } A \rightarrow \texttt{words}[j] \text{ in grammar do} \\
\qquad \quad\quad \texttt{table}[j-1][j] \leftarrow \texttt{table}[j-1][j] \cup \{A\} \\[1em]
\qquad 
\qquad \textbf{for } i = n - 2 \text{ down to } 0 \text{ do} \\
\qquad \quad \textbf{for } j = i + 2 \text{ to } n \text{ do} \\
\qquad \quad\quad \textbf{for } k = i + 1 \text{ to } j - 1 \text{ do} \\
\qquad \quad\quad\quad \textbf{for all rules } A \rightarrow B\ C \text{ in grammar do} \\
\qquad \quad\quad\quad\quad \textbf{if } B \in \texttt{table}[i][k] \text{ and } C \in \texttt{table}[k][j] \text{ then} \\
\qquad \quad\quad\quad\quad\quad \texttt{table}[i][j] \leftarrow \texttt{table}[i][j] \cup \{A\} \\[1em]
\qquad 
\qquad \textbf{return } \texttt{table}
\end{array}
$$

## Esempio

## ✅ Conclusione

L’algoritmo CKY rappresenta un approccio sistematico e rigoroso per determinare la **derivabilità di una frase** da una grammatica in CNF. Grazie all’uso della programmazione dinamica, consente di evitare ridondanze computazionali, garantendo una complessità polinomiale di $O(n^3 \cdot |G|)$, dove $n$ è la lunghezza della frase e $|G|$ è il numero di regole della grammatica.
