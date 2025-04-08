# Interpolazione Lineare nei Modelli Linguistici

L'interpolazione lineare è una tecnica utilizzata per affrontare il problema degli $n$-grammi a frequenza zero. Se stiamo cercando di calcolare $P(w_n \mid w_{n-2}\, w_{n-1})$ e non abbiamo esempi per il trigramma $w_{n-2}\, w_{n-1}\, w_n$, possiamo stimarne la probabilità utilizzando quella del bigramma $P(w_n \mid w_{n-1})$. Analogamente, se non disponiamo di conteggi per il bigramma, possiamo ricorrere alla probabilità dell'unigramma $P(w_n)$. In altre parole, talvolta utilizzare meno contesto può aiutarci a generalizzare in modo più efficace per quei contesti di cui il modello ha appreso meno.

## Interpolazione Lineare

La maniera più comune per sfruttare questa gerarchia di $n$-grammi è definita **interpolazione**: una nuova probabilità viene calcolata combinando (pesando e sommando) le probabilità ottenute dai trigrammi, bigrammi e unigrammi.

### Interpolazione Lineare Semplice

In un'interpolazione lineare semplice, le probabilità dei modelli di ordine inferiore vengono combinate linearmente. La stima della probabilità del trigramma viene espressa come:

$$
\hat{P}(w_n \mid w_{n-2}\, w_{n-1}) = \lambda_1\, P(w_n) + \lambda_2\, P(w_n \mid w_{n-1}) + \lambda_3\, P(w_n \mid w_{n-2}\, w_{n-1})
$$

dove i pesi $\lambda_1$, $\lambda_2$ e $\lambda_3$ devono soddisfare la condizione:

$$
\lambda_1 + \lambda_2 + \lambda_3 = 1.
$$

Questo rende l'equazione equivalente a una media pesata.

### Interpolazione Lineare Condizionata sul Contesto

In una versione leggermente più sofisticata, ogni peso $\lambda_i$ viene calcolato condizionando sul contesto (le due parole precedenti). In questo modo, se i conteggi per un particolare bigramma sono particolarmente affidabili, il modello assegna un peso maggiore ai trigrammi basati su di esso. La formula diventa:

$$
\hat{P}(w_n \mid w_{n-2}\, w_{n-1}) = \lambda_1(w_{n-2}^{n-1})\, P(w_n) + \lambda_2(w_{n-2}^{n-1})\, P(w_n \mid w_{n-1}) + \lambda_3(w_{n-2}^{n-1})\, P(w_n \mid w_{n-2}\, w_{n-1})
$$

dove $\lambda_1(\cdot)$, $\lambda_2(\cdot)$ e $\lambda_3(\cdot)$ sono funzioni del contesto $w_{n-2}\, w_{n-1}$.

*Ricordiamo che $w_{n-2}^{n-1} = w_{n-2}\, w_{n-1}$*.

## Apprendimento dei Pesi $\lambda_i$

I valori dei pesi $\lambda_i$ sono generalmente appresi da un **corpus di validazione** (detto anche corpus "held-out" o di tuning). Il procedimento è il seguente:

- **Fissare le probabilità degli $n$-grammi:** Vengono calcolate sulle sole parti del corpus di training.
- **Ottimizzare i pesi:** Si cercano i valori dei $\lambda_i$ che massimizzano la probabilità del corpus di validazione, ovvero:

  - Si fissa il modello (le probabilità degli $n$-grammi) calcolato dal training set.
  - Si utilizzano algoritmi come l'**EM (Expectation-Maximization)** per trovare i valori $\lambda_i$ ottimali che, una volta inseriti in una formula come quella sopra, danno il massimo della verosimiglianza al corpus di tuning.

Questo approccio permette di apprendere in modo efficace quanto peso assegnare a ciascun ordine di $n$-grammi, garantendo al contempo una migliore generalizzazione per eventi rari o mai osservati.

Per determinare i pesi ottimali $\lambda_i$, si ricorre a tecniche di ottimizzazione che massimizzano la probabilità (verosimiglianza) di un **corpus di validazione** rispetto al modello interpolato. 

### Obiettivo: Massimizzare la Verosimiglianza

L’obiettivo è trovare i pesi $\lambda_1, \lambda_2, \lambda_3$ tali che:

$$
\lambda_1 + \lambda_2 + \lambda_3 = 1 \quad \text{e} \quad \lambda_i \geq 0
$$

e che massimizzano la log-verosimiglianza del corpus di validazione (held-out set):

$$
\mathcal{L}(\boldsymbol{\lambda}) = \sum_{\text{trigrammi } w_{n-2}^{n}} c(w_{n-2}^{n}) \cdot \log\left( \lambda_1\, P(w_n) + \lambda_2\, P(w_n \mid w_{n-1}) + \lambda_3\, P(w_n \mid w_{n-2}\, w_{n-1}) \right)
$$

dove $c(w_{n-2}^{n})$ è la frequenza del trigramma nel corpus di validazione.

### Vincoli

L'ottimizzazione deve rispettare:
- $\lambda_1 + \lambda_2 + \lambda_3 = 1$
- $\lambda_i \geq 0$ per ogni $i$

### Tecniche di Ottimizzazione

#### 1. Grid Search
Metodo semplice ma computazionalmente costoso:
- Si esplora uno spazio discreto di valori $\lambda_i$ che soddisfano i vincoli.
- Si calcola la verosimiglianza per ciascuna combinazione.
- Si sceglie la combinazione con log-verosimiglianza massima.

#### 2. Algoritmo EM (Expectation-Maximization)

L'EM è un metodo iterativo che converge verso un massimo locale della verosimiglianza. Nel contesto dell'interpolazione:

**E-step:**  
Per ogni trigramma osservato, calcolare la responsabilità (cioè la probabilità che ciascun modello abbia generato il trigramma):

$$
r_i(w_{n-2}^{n}) = \frac{\lambda_i\, P_i(w_n \mid \cdot)}{\sum_{j=1}^{3} \lambda_j\, P_j(w_n \mid \cdot)}
$$

**M-step:**  
Aggiornare ciascun $\lambda_i$:

$$
\lambda_i^{(t+1)} = \frac{\sum_{w_{n-2}^{n}} c(w_{n-2}^{n})\, r_i(w_{n-2}^{n})}{\sum_{w_{n-2}^{n}} c(w_{n-2}^{n})}
$$

Iterare fino a convergenza.

#### 3. Ottimizzazione Vincolata (es. Lagrangiana)

Si può anche porre il problema come ottimizzazione vincolata:

- **Funzione obiettivo:** $\mathcal{L}(\boldsymbol{\lambda})$ come sopra
- **Vincoli:** 
  - $\lambda_1 + \lambda_2 + \lambda_3 = 1$
  - $\lambda_i \geq 0$

Questo si risolve tramite:
- **Metodo dei moltiplicatori di Lagrange**
- **Algoritmi di programmazione convessa** (es. `scipy.optimize.minimize` con vincoli)

### Output

L’ottimizzazione fornisce i pesi $\lambda_i$ da usare nel modello interpolato, migliorando l’accuratezza predittiva del modello linguistico sui dati non visti.



## Considerazioni Finali

L'interpolazione lineare consente di:
- Combinare le informazioni provenienti da diverse granualità di contesto.
- Mitigare il problema degli $n$-grammi a frequenza zero sfruttando le stime di ordine inferiore.
- Personalizzare l'importanza dei diversi ordini di $n$-grammi in base alla qualità e alla quantità dei dati disponibili, mediante l'apprendimento dei pesi $\lambda_i$ da un corpus di validazione.

Questa tecnica rappresenta una strategia fondamentale nella modellazione del linguaggio, in particolare per applicazioni in cui la robustezza e la generalizzazione sono cruciali.