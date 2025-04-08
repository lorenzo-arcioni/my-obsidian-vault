# The Berkeley Restaurant Project (BERP) Corpus

## Descrizione Generale
Il **BERP** (Berkeley Restaurant Project) è un corpus utilizzato nell'ambito del **Natural Language Processing (NLP)**, in particolare per modellare e analizzare il linguaggio in contesti legati al cibo e alla ristorazione.  
Il corpus contiene query poste dagli utenti, per esempio:  
- *I’m looking for Cantonese food*  
- *I’d like to eat dinner someplace nearby*  
- *Tell me about Chez Panisse*  
- *I’m looking for a good place to eat breakfast*  

Questo dataset è impiegato per sviluppare modelli probabilistici del linguaggio, permettendo di stimare la probabilità di frasi, analizzare le frequenze delle parole (unigrammi) e le associazioni tra di esse (bigrammi).

## Modellazione Probabilistica con N-grammi

### Calcolo della Probabilità con il Modello Bigram
Assumendo l'indipendenza dei bigrammi (Markov Property) e applicando la regola della catena, la probabilità di una frase viene approssimata moltiplicando le probabilità condizionali dei singoli bigrammi.  
Per esempio, per la frase modificata:
$$
P(\langle s \rangle\text{I want Chinese food}) \approx P(I|\langle s \rangle) \cdot P(want|I) \cdot P(Chinese|want) \cdot P(food|Chinese) \cdot P(\langle /s \rangle|food)
$$

## Tabelle di Conteggio

Le tabelle di conteggio sono utilizzate per calcolare le probabilità dei bigrammi e degli unigrammi. Scegliamo ora solo alcune (nella realtà vanno scelte tutte) parole (unigrams, vettore $\mathbf u$) e le coppie di parole (bigrams, matrice $\mathbf B$), e contiamo il numero di volte che appaiono nel corpus.

Le parole selezionate sono:

- `<s>` (inizio frase)
- `i`
- `want`
- `to`
- `eat`
- `chinese`
- `food`
- `lunch`
- `spend`
- `</s>` (fine frase)

### Conteggio degli Unigrammi

|       | $\langle s \rangle$  | i    | want | to   | eat | chinese | food | lunch | spend | $\langle /s \rangle$ |
|-------|------|------|------|------|-----|---------|------|--------|--------|-------|
|Count  | 8566 | 2816 | 1038 | 2711 | 829 | 193     | 1242 | 392    | 310    | 8566  |


Chiameremo questo vettore $\mathbf{u}$.

### Conteggio dei Bigrammi

In questa tabella, includiamo `<s>` come riga iniziale e `</s>` come colonna finale:

|          | $\langle s \rangle$ | i    | want | to   | eat  | chinese | food | lunch | spend | $\langle /s \rangle$ |
|----------|-----|------|------|------|------|---------|------|--------|--------|-------|
| **$\langle s \rangle$**      | 0   | 1922 | 4    | 32   | 4    | 10      | 4    | 39     | 1      | 0     |
| **i**        | 0   | 1    | 908  | 0    | 12   | 0       | 0    | 0      | 2      | 0     |
| **want**     | 0   | 2    | 0    | 673  | 0    | 7       | 6    | 6      | 1      | 2     |
| **to**       | 0   | 0    | 0    | 2    | 753  | 3       | 0    | 6      | 233    | 3     |
| **eat**      | 0   | 0    | 0    | 0    | 0    | 16      | 2    | 52     | 0      | 10    |
| **chinese**  | 0   | 4    | 0    | 0    | 0    | 0       | 99   | 1      | 0      | 10    |
| **food**     | 0   | 14   | 0    | 13   | 0    | 0       | 0    | 0      | 0      | 806   |
| **lunch**    | 0   | 1    | 0    | 0    | 0    | 0       | 1    | 0      | 0      | 221   |
| **spend**    | 0   | 0    | 0    | 1    | 0    | 0       | 0    | 0      | 0      | 8     |
| **$\langle /s \rangle$**   | 0   | 0    | 0    | 0    | 0    | 0       | 0    | 0      | 0      | 0     |


Chiameremo questa matrice $\mathbf{B}$.

### Probabilità dei Bigrammi (conteggio normalizzato)

Per ottenere le probabilità dei bigrammi, si divide il conteggio del bigramma per il conteggio dell'unigramma del prefisso. Ad esempio, per il bigramma "i want" abbiamo:

$$
P(\text{want} \mid \text{i}) = \frac{908}{2816} \approx 0.32
$$

La matrice normalizzata $\mathbf{N}$ (contenente le probabilità) sarà strutturata in modo analogo, includendo le colonne e righe per `<s>` e `</s>`:

|            | $\langle s \rangle$   | i         | want     | to       | eat      | chinese  | food     | lunch    | spend    | $\langle /s \rangle$  |
|------------|---------|-----------|----------|----------|----------|----------|----------|----------|----------|---------|
| **$\langle s \rangle$**  | 0.0     | 0.224375  | 0.000467 | 0.003736 | 0.000467 | 0.001167 | 0.000467 | 0.004553 | 0.000117 | 0.000000 |
| **i**      | 0.0     | 0.000355  | 0.322443 | 0.000000 | 0.004261 | 0.000000 | 0.000000 | 0.000000 | 0.000710 | 0.000000 |
| **want**   | 0.0     | 0.001927  | 0.000000 | 0.648362 | 0.000000 | 0.006744 | 0.005780 | 0.005780 | 0.000963 | 0.001927 |
| **to**     | 0.0     | 0.000000  | 0.000000 | 0.000738 | 0.277757 | 0.001107 | 0.000000 | 0.002213 | 0.085946 | 0.001107 |
| **eat**    | 0.0     | 0.000000  | 0.000000 | 0.000000 | 0.000000 | 0.019300 | 0.002413 | 0.062726 | 0.000000 | 0.012063 |
| **chinese**| 0.0     | 0.020725  | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.512953 | 0.005181 | 0.000000 | 0.051813 |
| **food**   | 0.0     | 0.011272  | 0.000000 | 0.010467 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.648953 |
| **lunch**  | 0.0     | 0.002551  | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.002551 | 0.000000 | 0.000000 | 0.563776 |
| **spend**  | 0.0     | 0.000000  | 0.000000 | 0.003226 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.025806 |
| **$\langle /s \rangle$** | 0.0     | 0.000000  | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 | 0.000000 |


*Nota:* I token `<s>` e `</s>` sono inclusi solo nelle matrici normalizzate per evidenziare la probabilità di inizio e fine frase.

Questa matrice $\mathbf N$ è ottenuta semplicemente calcolando:
$$
\mathbf N_{ij} = \frac{\mathbf B_{ij}}{\mathbf u_i}
$$

## Calcolo della Probabilità di Frasi Specifiche

Per stimare la probabilità di una frase con un modello bigramma, si moltiplicano le probabilità condizionali dei bigrammi, includendo i token di inizio (`<s>`) e fine (`</s>`). In generale, per una frase:
$$
\text{frase} = \langle s \rangle \; w_1 \; w_2 \; \dots \; w_n \; \langle /s \rangle
$$
la probabilità stimata è:
$$
P(\text{frase}) = P(w_1 \mid \langle s \rangle) \cdot P(w_2 \mid w_1) \cdots P(\langle /s \rangle \mid w_n)
$$

### Frase: "I want Chinese food"

Utilizziamo i valori aggiornati dalla matrice per stimare la probabilità (trasformando sempre le lettere in lower case):

- $P(i \mid \langle s \rangle) = 0.224375$  
- $P(want \mid i) = 0.322443$  
- $P(chinese \mid want) = 0.006744$  
- $P(food \mid chinese) = 0.512953$  
- $P(\langle /s \rangle \mid food) = 0.648953$  

La probabilità della frase è:
$$
\begin{aligned}
P(\langle s \rangle\, i\, want\, chinese\, food\, \langle /s \rangle) &= P(i \mid \langle s \rangle) \cdot P(want \mid i) \cdot P(chinese \mid want) \\
&\quad \cdot P(food \mid chinese) \cdot P(\langle /s \rangle \mid food) \\
&= 0.224375 \cdot 0.322443 \cdot 0.006744 \cdot 0.512953 \cdot 0.648953 \\
&\approx 0.000162
\end{aligned}
$$

## Conclusioni: Cosa Ci Insegnano gli N-grammi

Nonostante la semplicità, i modelli basati su N-grammi riescono a catturare informazioni interessanti riguardo al linguaggio:

- **Fatti Linguistici:**  
  - $P(English \mid want) = 0$, che rappresenta un problema, in quanto non compare nel corpus il bigramma "*want English*".
  - $P(Chinese \mid want) \approx 0.0067$  
  - $P(to \mid want)$ (valore elevato nei dati originali)

- **Conoscenza del Mondo:**  
  - $P(eat \mid to) \approx 0.2778$ (da altri esempi)  
  - $P(food \mid to) \approx 0$ (in certi casi)

- **Sintassi:**  
  - $P(want \mid spend) = 0$  
  - $P(I \mid \langle s \rangle) \approx 0.2244$

- **Discorso:**  
  Le probabilità riflettono le relazioni contestuali e il flusso del discorso, evidenziando come alcuni bigrammi siano molto probabili (come quelli che iniziano con `<s>`) mentre altri risultano meno frequenti o addirittura impossibili.

## Laplace Smoothing

Applichiamo ora il Laplace Smoothing alla matrice di conteggio dei bigrammi per risolvere il problema dei bigrammi non osservati nel corpus, che hanno come probabilità 0.

### 1. Aggiunta del Contatore per il Laplace Smoothing

Per applicare il Laplace smoothing, aggiungiamo 1 a ciascuna cella della matrice $\mathbf{B}$:

|                  | $\langle s \rangle$ | i    | want | to   | eat  | chinese | food | lunch | spend | $\langle /s \rangle$ |
|------------------|---------------------|------|------|------|------|---------|------|--------|--------|-----------------------|
| **$\langle s \rangle$**    | 1   | 1923 | 5    | 33   | 5    | 11      | 5    | 40     | 2      | 1     |
| **i**            | 1   | 2    | 909  | 1    | 13   | 1       | 1    | 1      | 3      | 1     |
| **want**         | 1   | 3    | 1    | 674  | 1    | 8       | 7    | 7      | 2      | 3     |
| **to**           | 1   | 1    | 1    | 3    | 754  | 4       | 1    | 7      | 234    | 4     |
| **eat**          | 1   | 1    | 1    | 1    | 1    | 17      | 3    | 53     | 1      | 11    |
| **chinese**      | 1   | 5    | 1    | 1    | 1    | 1       | 100  | 2      | 1      | 11    |
| **food**         | 1   | 15   | 1    | 14   | 1    | 1       | 1    | 1      | 1      | 807   |
| **lunch**        | 1   | 2    | 1    | 1    | 1    | 1       | 2    | 1      | 1      | 222   |
| **spend**        | 1   | 1    | 1    | 2    | 1    | 1       | 1    | 1      | 1      | 9     |
| **$\langle /s \rangle$** | 1   | 1    | 1    | 1    | 1    | 1       | 1    | 1      | 1      | 1     |

### 2. Calcolo delle Probabilità Smoothing

Per ogni bigramma $(w_{n-1}, w_n)$ il Laplace smoothing prevede:

$$
\mathbb P(w_n \mid w_{n-1}) = \frac{c(w_{n-1}, w_n) + 1}{c(w_{n-1}) + V}
$$

dove:
- $c(w_{n-1}, w_n)$ è il conteggio (già incrementato di 1) per il bigramma;
- $c(w_{n-1})$ è il totale dei conteggi per il contesto $w_{n-1}$ (ottenibile dal vettore delle frequenze degli unigrammi $\mathbf{u}$);
- $V$ è la dimensione del vocabolario (in questo caso, $V=1997$).

**Esempio di Calcolo:**

Supponiamo di voler calcolare la probabilità condizionata del bigramma ("i", "want").  
Dalla riga relativa a "i" abbiamo:
- Valore incrementato per ("i", "want") = 908  
- Totale dei conteggi per il contesto "i":  
  $$
  c("i") = \mathbf u_i = 2816.
  $$

Quindi:

$$
\mathbb P(\text{"want"} \mid \text{"i"}) = \frac{\overbrace{909}^{908+1}}{2816 + 1997} \approx 0.19.
$$

e quindi la probabilità $\mathbb P("i", "want") = \mathbb P(\text{"want"} \mid \text{"i"}) \cdot \mathbb P("i")$.

### 3. Costruzione della Matrice di Probabilità Smoothed $\mathbf{B^*}$

Una volta applicata la formula per ogni cella (per ogni bigramma), la matrice $\mathbf{B^*}$ conterrà le probabilità smoothed:



## Conclusione

Questa è una breve panoramica sul corpus BERP e sulle tecniche di modellazione del linguaggio basate sugli N-grammi, che evidenzia come questi metodi possano essere utilizzati per valutare e interpretare la probabilità di frasi in linguaggio naturale.