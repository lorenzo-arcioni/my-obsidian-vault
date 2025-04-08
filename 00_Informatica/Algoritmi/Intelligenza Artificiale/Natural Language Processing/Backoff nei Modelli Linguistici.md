---
aliases: [Modelli di Backoff, Stupid Backoff, Katz Backoff]
tags: [nlp, modelli-linguistici, smoothing]
---

# Modelli di Backoff nella Modellazione Linguistica con $N$-grammi

## Panoramica
I modelli di backoff sono un'alternativa all'[[Interpolazione Lineare|interpolazione]] per gestire dati sparsi nei modelli linguistici basati su $n$-grammi. A differenza dell'interpolazione (che combina le probabilità di tutti gli ordini di $n$-grammi), il backoff utilizza $n$-grammi di ordine inferiore **solo quando i conteggi di ordine superiore sono zero**. Due varianti principali sono lo **Stupid Backoff** e il **Katz Backoff**.

## 1. Backoff vs Interpolazione
| Caratteristica          | Interpolazione                        | Backoff                                  |
|-------------------------|----------------------------------------|------------------------------------------|
| **Strategia**           | Combina tutti gli ordini di $n$-grammi   | Usa ordini inferiori solo se necessario   |
| **Massa Probabilistica**| Richiede pesatura                     | Richiede sconto (tranne Stupid Backoff)  |
| **Complessità**         | Computazionalmente pesante             | Ricorsione semplice                      |
| **Validità Teorica**    | Distribuzione vera                     | Stupid Backoff non è distribuzione vera  |

## 2. Stupid Backoff (Brants et al., 2007)

### Idea Generale
- **Non basato su probabilità**: Il metodo sacrifica la normalizzazione della distribuzione a favore della semplicità computazionale.
- **Nessun sconto sui conteggi**: Gli $n$-grammi di ordine superiore usano i conteggi originali.
- **Peso fisso nel backoff**: Se non viene trovato un $n$-gramma con conteggio positivo, si applica un peso costante (es. $\lambda = 0.4$) per passare al modello di ordine inferiore.

### La Formula
Per un modello $N$-grammi:
$$
S(w_i | w^{i-1}_{i-N+1}) =
\begin{cases}
\frac{\text{count}(w_{i-N+1}^{i-1})}{\text{count}(w^{i-1}_{i-N+1})} & \text{se } \text{count}(w_{i-N+1}^{i-1}) > 0, \\
\lambda \cdot S(w_i | w_{i-N+2}^{i-1}) & \text{altrimenti.}
\end{cases}
$$

Notiamo che, non essendo una probabilità, utilizziamo una funzione $\mathbb S$ invece della $\mathbb P$.

### Esempio Pratico

Testo: `"I love natural language processing"`

Supponiamo di avere i seguenti conteggi:
- $\text{count}(\text{"natural language processing"}) = 2$
- $\text{count}(\text{"natural language"}) = 5$
- $\text{count}(\text{"language processing"}) = 3$
- $\text{count}(\text{"language"}) = 10$
- $\text{count}(\text{"processing"}) = 4$
- Totale parole = 1000
- $\lambda = 0.4$

Calcoliamo $S(\text{"processing"} | \text{"natural language"})$, abbiamo principalmente 3 casi:

1. **Trigramma presente**:
   $$
   S(\text{"processing"} | \text{"natural language"}) = \frac{2}{5} = 0.4
   $$

2. **Trigramma assente**:
   Supponiamo che il trigramma manchi. Allora passiamo al bigramma:
   $$
   S(\text{"processing"} | \text{"natural language"}) = \lambda \cdot \mathbb S(\text{"processing"} | \text{"language"}) = 0.4 \cdot \frac{3}{10} = 0.4 \cdot 0.3 = 0.12
   $$

3. **Anche il bigramma è assente?**  
   Si fa backoff all’unigramma:
   $$
    S(\text{"processing"} | \text{"natural language"}) = \lambda \cdot (\lambda \cdot \mathbb S(\text{"processing"})) = \lambda^2 \cdot \mathbb S(\text{"processing"}) = (0.4)^2 \cdot \frac{4}{1000} = 0.00064
   $$

### Perché "Stupid"?
- **Non normalizzato**: La somma $\sum S(w_i | \text{contesto})$ non equivale a 1, venendo così considerato un metodo di pseudo-probabilità.
- **Efficienza computazionale**: È particolarmente adatto per task su larga scala (ad esempio, nei modelli di Google) grazie alla sua semplicità.


## 3. Katz Backoff (Katz, 1987)

### Idea Generale
- **Sconto dei conteggi**: Riserva una parte della massa probabilistica per eventi non osservati, riducendo i conteggi osservati (es. con Good-Turing discounting).
- **Retrocessione condizionata**: Si applica il backoff solo se il conteggio dell'$n$-gramma è zero.
- **Distribuzione di probabilità valida**: Garantisce $0 \leq P_{\text{Katz}}(w_i | \text{contesto}) \leq 1$ e la somma di $P_{\text{Katz}}(w_i | \text{contesto})$ su tutti i $w_i$ è 1.

> In altre parole, se si utilizza una stima MLE e $P_{\text{Katz}}(w_i | \text{contesto}) = 0$, viene definita:
> $$
> P_{\text{Katz}}(w_i | \text{contesto}) = \alpha \cdot P_{\text{Katz}}(w_i | \text{contesto ridotto}),
> $$
> dove $\alpha$ è il peso di backoff.

### La Formula
Per un modello $N$-grammi:
$$
P_{\text{Katz}}(w_i | w_{i-N+1}^{i-1}) =
\begin{cases}
P^*(w_i | w^{i-1}_{i-N+1}) & \text{se } \text{count}(w^{i-1}_{i-N+1}) > 0, \\
\alpha(w^{i-1}_{i-N+1}) \cdot P_{\text{Katz}}(w_i | w^{i-1}_{i-N+2}) & \text{altrimenti.}
\end{cases}
$$

### Componenti Fondamentali

1. **Probabilità Scontata ($P^*$)**  
   Utilizza tecniche come il **Good-Turing discounting** per ridurre il conteggio:
   $$
   P^*(w_i | \text{contesto}) = \frac{\text{count}(\text{contesto}, w_i) - d}{\text{count}(\text{contesto})},
   $$
   dove $d$ è uno sconto (ad es. $d = \frac{n_1}{n_1 + 2n_2}$, con $n_k$ il numero di $n$-grammi con conteggio $k$).

2. **Peso di Backoff ($\alpha$)**  
   Per mantenere la massa di probabilità totale:
   $$
   \alpha(\text{contesto}) = \frac{1 - \sum_{w_i \in \text{visti}} P^*(w_i | \text{contesto})}{1 - \sum_{w_i \in \text{visti}} P_{\text{Katz}}(w_i | \text{contesto ridotto})}.
   $$

### Esempio Pratico

#### 1. Probabilità Scontata ($P^*$)
Usiamo Good-Turing:

Supponiamo:
- $\text{count}(\text{"natural language processing"}) = 2$
- $\text{count}(\text{"natural language"}) = 5$
- Sconto $d = 0.5$

Allora:
$$
P^*(\text{"processing"} | \text{"natural language"}) =
\frac{2 - 0.5}{5} = \frac{1.5}{5} = 0.3
$$

#### 2. Peso di Backoff ($\alpha$)

Supponiamo:
- Sono stati osservati 3 parole diverse dopo “natural language” con:
  - $P^*(\text{"processing"}) = 0.3$
  - $P^*(\text{"generation"}) = 0.2$
  - $P^*(\text{"understanding"}) = 0.1$
  - Totale $\sum P^* = 0.6$

- E i corrispondenti backoff al bigramma danno:
  - $P_{\text{Katz}}(\text{"processing"} | \text{"language"}) = 0.2$
  - $P_{\text{Katz}}(\text{"generation"} | \text{"language"}) = 0.1$
  - $P_{\text{Katz}}(\text{"understanding"} | \text{"language"}) = 0.1$
  - Totale $\sum = 0.4$

Allora:
$$
\alpha(\text{"natural language"}) = \frac{1 - 0.6}{1 - 0.4} = \frac{0.4}{0.6} \approx 0.667
$$

#### Backoff Finale

Supponiamo che $\text{count}(\text{"natural language processing"}) = 0$, allora:
$$
P_{\text{Katz}}(\text{"processing"} | \text{"natural language"}) = \alpha(\text{"natural language"}) \cdot P_{\text{Katz}}(\text{"processing"} | \text{"language"}) = 0.667 \cdot 0.2 = 0.133
$$

## 4. Dettagli Matematici e Parametri

### Peso nel Stupid Backoff
- **Esempio**  
  Con $\lambda = 0.4$, per passare da trigrammi a bigrammi:
  $$
  S(w_i | w_{i-2}, w_{i-1}) = 0.4 \cdot \frac{\text{count}(w_{i-1}, w_i)}{\text{count}(w_{i-1})}.
  $$

### Sconto nel Katz Backoff (Good-Turing)
- **Esempio**  
  Supponiamo di avere 10 trigrammi con conteggio 1 e 5 trigrammi con conteggio 2; la massa riservata per i trigrammi non osservati si può approssimare con:
  $$
  \frac{n_1}{\text{Totale trigrammi}} = \frac{10}{\text{Totale trigrammi}}.
  $$


## 5. Confronto tra i Metodi di Backoff

| **Caratteristica**        | **Stupid Backoff**                           | **Katz Backoff**                           |
|---------------------------|----------------------------------------------|--------------------------------------------|
| **Validità Teorica**      | No (si ottengono pseudo-probabilità)         | Sì (garantisce una distribuzione valida)   |
| **Metodo di Sconto**      | Nessuno (si usano i conteggi originali)       | Applica sconti (es. Good-Turing)             |
| **Applicazioni**          | Task su larga scala, alta velocità            | Situazioni in cui è necessaria precisione      |
| **Implementazione**       | Semplice (peso fisso $\lambda$)             | Più complessa (calcolo di $\alpha$ e sconti)|

## 6. Conclusione

Il backoff rappresenta una soluzione efficace per gestire la sparsità dei dati nei modelli linguistici basati su nn-grammi, bilanciando complessità computazionale e accuratezza teorica.

- **Stupid Backoff** si distingue per la semplicità e l’efficienza, rendendolo ideale per applicazioni su larga scala (es. motori di ricerca) dove la velocità è prioritaria. Tuttavia, la mancata normalizzazione lo rende inadatto a contesti che richiedono distribuzioni di probabilità rigorose.

- **Katz Backoff**, grazie allo sconto probabilistico e al calcolo del peso $\alpha$, garantisce una distribuzione valida, sacrificando parte dell’efficienza computazionale. È preferibile in scenari dove la precisione teorica è critica, come nella generazione di testo o nel calcolo di perplexity.

La scelta tra i due metodi dipende dagli obiettivi specifici:

- Priorità alla velocità e scalabilità: Optare per Stupid Backoff con $\lambda$ fisso.

- Priorità alla correttezza statistica: Utilizzare Katz Backoff con sconti come Good-Turing.

In ultima analisi, entrambi i metodi evidenziano un principio fondamentale nella modellazione linguistica: l’equilibrio tra flessibilità e rigore matematico, cruciale per affrontare le sfide poste dai dati sparsi e dal trade-off bias-varianza.
