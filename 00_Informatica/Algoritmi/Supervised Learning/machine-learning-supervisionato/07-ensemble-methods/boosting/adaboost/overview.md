# AdaBoost: Overview

## Introduzione

**AdaBoost** (Adaptive Boosting) è un algoritmo di boosting proposto da Yoav Freund e Robert Schapire nel 1996. È uno degli algoritmi di machine learning più influenti e rappresenta un punto di svolta nella teoria e pratica del boosting.

## Il Problema

Supponiamo di avere:
- Un training set: $(x_1, y_1), \ldots, (x_N, y_N)$ dove $y_i \in \{0, 1\}$ (classificazione binaria)
- Accesso a un **weak learner**  (algoritmo di apprendimento debole)

Un **weak learner** è un algoritmo che, data una distribuzione sui dati, produce un'ipotesi con accuratezza leggermente migliore del caso (errore $\epsilon < 1/2$).

**Domanda centrale**: Come possiamo combinare molteplici ipotesi deboli per ottenere un'ipotesi forte con accuratezza arbitrariamente alta?

## L'Idea Principale

AdaBoost risolve questo problema attraverso un processo iterativo:

1. **Inizializzazione**: Assegna peso uniforme a tutti gli esempi del training set

2. **Iterazione** (per $t = 1, \ldots, T$):
   - Addestra un weak learner sulla distribuzione corrente di pesi
   - Ricevi un'ipotesi debole $h_t$ con errore $\epsilon_t$
   - **Aumenta** il peso degli esempi classificati erroneamente
   - **Diminuisci** il peso degli esempi classificati correttamente

3. **Combinazione**: L'ipotesi finale è un voto pesato delle $T$ ipotesi deboli

### Intuizione

L'idea chiave è il **focus adattivo** sugli esempi difficili:
- Ad ogni iterazione, il weak learner è "costretto" a concentrarsi sugli esempi che i learner precedenti hanno sbagliato
- Gli esempi facili (classificati correttamente da subito) ricevono peso decrescente
- Gli esempi difficili (classificati erroneamente ripetutamente) ricevono peso crescente
- Questo processo adattivo è ciò che rende AdaBoost "adaptive"

## Caratteristiche Distintive

### 1. Nessuna Conoscenza a Priori
A differenza di algoritmi precedenti (come boost-by-majority), AdaBoost **non richiede** di conoscere in anticipo l'accuratezza del weak learner. L'algoritmo si adatta automaticamente alle performance effettive di ogni ipotesi debole.

### 2. Sfruttamento Completo delle Ipotesi
L'errore finale dipende dall'accuratezza di **tutte** le ipotesi deboli, non solo dalla peggiore. Se alcune ipotesi sono molto accurate, questo migliora il bound finale:

$$\epsilon_{final} \leq 2^T \prod_{t=1}^T \sqrt{\epsilon_t(1-\epsilon_t)}$$

### 3. Convergenza Esponenziale
Se ogni weak learner ha errore $\epsilon_t = 1/2 - \gamma_t$ (con $\gamma_t > 0$), l'errore di training decade esponenzialmente:

$$\epsilon_{final} \leq \exp\left(-2\sum_{t=1}^T \gamma_t^2\right)$$

Questo significa che con poche iterazioni si può ottenere errore arbitrariamente piccolo sul training set.

## Connessione con Altri Concetti

AdaBoost ha una sorprendente connessione "duale" con il problema di **on-line allocation** (algoritmo Hedge):

| On-line Allocation | AdaBoost |
|-------------------|----------|
| Strategie | Esempi di training |
| Trial | Ipotesi deboli |
| Loss piccola = strategia buona | Loss piccola = esempio difficile |

Questa connessione permette di derivare AdaBoost applicando tecniche di **multiplicative weight update** dal contesto dell'on-line learning.

## Vantaggi Pratici

1. **Semplicità**: Facile da implementare e usare
2. **Flessibilità**: Funziona con qualsiasi weak learner
3. **Performance**: Spesso ottiene accuratezza eccellente in pratica
4. **Resistenza a overfitting**: Sorprendentemente, continua a migliorare anche dopo centinaia di iterazioni

## Limitazioni

1. **Sensibilità al rumore**: Gli esempi con label errate ricevono peso crescente
2. **Requisito base**: Richiede che il weak learner produca ipotesi con $\epsilon < 1/2$ su ogni distribuzione
3. **Problema binario**: La versione base funziona solo per classificazione binaria (esistono estensioni per multi-classe e regressione)
