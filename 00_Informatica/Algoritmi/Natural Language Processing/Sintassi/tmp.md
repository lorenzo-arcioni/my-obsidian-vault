### 🔹 Strategia

Per ogni indice $i = 0$ a $n-1$ (dove $n$ è la lunghezza della frase), eseguiamo due fasi:

---

### 🧩 Fase 1 — parola singola $w_i$

- Consideriamo la **sottostringa di lunghezza 1** $w_i$
- Per ogni regola terminale della grammatica:
  $$
  A \rightarrow w_i
  $$
  se $w_i$ è il terminale a destra, allora aggiungiamo $A$ in:
  $$
  table[i][i+1] \gets table[i][i+1] \cup \{A\}
  $$

✨ Questa fase classifica ogni parola singola nella sua possibile **categoria grammaticale**.

---

### 🧱 Fase 2 — sottostringhe più lunghe che terminano in $w_i$

- Per ogni lunghezza $\ell = 2$ fino a $i+1$:
  - Consideriamo la sottostringa:
    $$
    w_{i - \ell + 1} \dots w_i
    $$
    - Questa sottostringa corrisponde a:
      $$
      table[i - \ell + 1][i+1]
      $$
  - Per ogni punto di divisione interno $k$ con:
    $$
    i - \ell + 1 < k < i+1
    $$
    analizziamo le due sottostringhe:
    $$
    table[i - \ell + 1][k], \quad table[k][i+1]
    $$
    - Per ogni regola binaria della grammatica:
      $$
      A \rightarrow B\,C
      $$
      se $B \in table[i - \ell + 1][k]$ e $C \in table[k][i+1]$, allora:
      $$
      A \in table[i - \ell + 1][i+1]
      $$

🧠 In pratica, a ogni passo combiniamo **strutture più piccole** già calcolate, fino a costruire tutte le sottostrutture sintattiche che terminano in $w_i$.
