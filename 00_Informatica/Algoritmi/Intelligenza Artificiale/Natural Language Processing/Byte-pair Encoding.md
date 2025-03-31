# Byte-Pair Encoding (BPE): Algoritmo e Esempio Pratico  
Il **Byte-Pair Encoding** (BPE) è un algoritmo di tokenizzazione sub-lessicale ampiamente utilizzato in NLP per ridurre le dimensioni del vocabolario e gestire parole rare o non viste. Si basa sulla fusione iterativa delle coppie di caratteri/sottoparole più frequenti in un corpus.  

---

## **Algoritmo BPE in Pseudocodice**  
**Input**:  
- `C`: Corpus suddiviso in token iniziali (es. caratteri o parole).  
- `k`: Numero di fusioni da eseguire.  

**Output**:  
- `V`: Vocabolario finale con token sub-lessicali.  

**Passaggi**:  

1. **Inizializzazione del vocabolario**:  
   - Suddividi ogni parola nel corpus in caratteri individuali.  
   - Aggiungi un simbolo speciale `_` (spesso usato per indicare la fine di una parola).  
   - `V` ← Insieme di tutti i caratteri unici presenti in `C`.  

2. **Iterazione per `k` fusioni**:  
   Per `i` da 1 a `k`:  
   - **Calcola le frequenze delle coppie adiacenti**:  
     Conta tutte le coppie di token consecutivi nel corpus.  
   - **Seleziona la coppia più frequente**:  
     Sia `(tL, tR)` la coppia con la massima frequenza.  
   - **Crea un nuovo token**:  
     `tNEW` ← `tL + tR` (concatenazione dei due token).  
   - **Aggiorna il vocabolario**:  
     `V` ← `V ∪ {tNEW}`.  
   - **Modifica il corpus**:  
     Sostituisci ogni occorrenza di `tL` seguito da `tR` con `tNEW` in tutte le parole.  

3. **Restituisci** `V`.  

$$
\usepackage{algorithm}
\usepackage{algpseudocode}
\begin{algorithmic}[1]
\Require Corpus $C$ (token iniziali), numero di fusioni $k$
\Ensure Vocabolario $V$ (token sub-lessicali)
\Statex

\Procedure{BPE}{$C, k$}
    \State Inizializza $V$ come insieme di caratteri unici in $C$ 
    \State Aggiungi il simbolo speciale \_ a $V$ \Comment{Delimitatore di fine parola}
    \State Suddividi ogni parola in $C$ in caratteri singoli + \_

    \For{$i \gets 1$ \textbf{to} $k$}
        \State Calcola frequenze di tutte le coppie adiacenti $(t_L, t_R)$ in $C$
        \State Scegli la coppia $(t_L, t_R)$ con frequenza massima
        \State Crea nuovo token $t_{\text{NEW}} \gets t_L \oplus t_R$ \Comment{Concatenazione}
        \State $V \gets V \cup \{t_{\text{NEW}}\}$
        \State Sostituisci ogni occorrenza di $t_L$ $t_R$ con $t_{\text{NEW}}$ in $C$
    \EndFor
    
    \State \Return $V$
\EndProcedure
\end{algorithmic}
$$
---

## **Esempio Pratico dal Corpus Fornito**  
### **Dati Iniziali**  
**Corpus** (con frequenze delle parole):  