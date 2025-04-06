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
Assumendo l'indipendenza dei bigrammi e applicando la regola della catena, la probabilità di una frase viene approssimata moltiplicando le probabilità condizionali dei singoli bigrammi.  
Per esempio, per la frase modificata:
$$
P(\text{I want Chinese food}) \approx P(I|<s>) \cdot P(want|I) \cdot P(Chinese|want) \cdot P(food|Chinese)
$$

## Tabelle di Conteggio

### Conteggio degli Unigrammi

|       | $<s>$  | i    | want | to   | eat | chinese | food | lunch | spend | $</s>$ |
|-------|------|------|------|------|-----|---------|------|--------|--------|-------|
|Count  | 8566 | 2816 | 1038 | 2711 | 829 | 193     | 1242 | 392    | 310    | 8566  |


Chiameremo questo vettore $\mathbf{u}$.

### Conteggio dei Bigrammi

In questa tabella, includiamo `<s>` come riga iniziale e `</s>` come colonna finale:

|          | $<s>$ | i    | want | to   | eat  | chinese | food | lunch | spend | $</s>$ |
|----------|-----|------|------|------|------|---------|------|--------|--------|-------|
| **<s>**      | 0   | 1922 | 4    | 32   | 4    | 10      | 4    | 39     | 1      | 0     |
| **i**        | 0   | 1    | 908  | 0    | 12   | 0       | 0    | 0      | 2      | 0     |
| **want**     | 0   | 2    | 0    | 673  | 0    | 7       | 6    | 6      | 1      | 2     |
| **to**       | 0   | 0    | 0    | 2    | 753  | 3       | 0    | 6      | 233    | 3     |
| **eat**      | 0   | 0    | 0    | 0    | 0    | 16      | 2    | 52     | 0      | 10    |
| **chinese**  | 0   | 4    | 0    | 0    | 0    | 0       | 99   | 1      | 0      | 10    |
| **food**     | 0   | 14   | 0    | 13   | 0    | 0       | 0    | 0      | 0      | 806   |
| **lunch**    | 0   | 1    | 0    | 0    | 0    | 0       | 1    | 0      | 0      | 221   |
| **spend**    | 0   | 0    | 0    | 1    | 0    | 0       | 0    | 0      | 0      | 8     |
| **$</s>$**   | 0   | 0    | 0    | 0    | 0    | 0       | 0    | 0      | 0      | 0     |


Chiameremo questa matrice $\mathbf{B}$.

### Probabilità dei Bigrammi (conteggio normalizzato)

Per ottenere le probabilità dei bigrammi, si divide il conteggio del bigramma per il conteggio dell'unigramma del prefisso. Ad esempio, per il bigramma "i want" abbiamo:

$$
P(\text{want} \mid \text{i}) = \frac{827}{2533} \approx 0.33
$$

La matrice normalizzata $\mathbf{N}$ (contenente le probabilità) sarà strutturata in modo analogo, includendo le colonne e righe per `<s>` e `</s>`:

|            |   $<s>$   |   i    |  want  |   to   |  eat   | chinese |  food  | lunch  | spend  |  $</s>$  |
|------------|---------|--------|--------|--------|--------|---------|--------|--------|--------|--------|
| **$<s>$**  | 0.000494| 0.949161 | 0.002468| 0.016288| 0.002468| 0.005429| 0.002468| 0.019743| 0.000987| 0.000494 |
| **i**      | 0.001072| 0.002144 | 0.974277| 0.001072| 0.013934| 0.001072| 0.001072| 0.001072| 0.003215| 0.001072 |
| **want**   | 0.001414| 0.004243 | 0.001414| 0.953324| 0.001414| 0.011315| 0.009901| 0.009901| 0.002829| 0.004243 |
| **to**     | 0.000990| 0.000990 | 0.000990| 0.002970| 0.746535| 0.003960| 0.000990| 0.006931| 0.231683| 0.003960 |
| **eat**    | 0.011111| 0.011111 | 0.011111| 0.011111| 0.011111| 0.188889| 0.033333| 0.588889| 0.011111| 0.122222 |
| **chinese**|0.008065| 0.040323 | 0.008065| 0.008065| 0.008065| 0.008065| 0.806452| 0.016129| 0.008065| 0.088710 |
| **food**   | 0.001186| 0.017794 | 0.001186| 0.016607| 0.001186| 0.001186| 0.001186| 0.001186| 0.001186| 0.957295 |
| **lunch**  | 0.004292| 0.008584 | 0.004292| 0.004292| 0.004292| 0.004292| 0.008584| 0.004292| 0.004292| 0.952790 |
| **spend**  | 0.052632| 0.052632 | 0.052632| 0.105263| 0.052632| 0.052632| 0.052632| 0.052632| 0.052632| 0.473684 |
| **$</s>$** | 0.100000| 0.100000 | 0.100000| 0.100000| 0.100000| 0.100000| 0.100000| 0.100000| 0.100000| 0.100000 |

*Nota:* I token `<s>` e `</s>` sono inclusi solo nelle matrici normalizzate per evidenziare la probabilità di inizio e fine frase.

Questa matrice $\mathbf N$ è ottenuta semplicemente calcolando:
$$
\mathbf N_{ij} = \frac{\mathbf B_{ij}}{\mathbf u_i}
$$

## Calcolo della Probabilità di Frasi Specifiche

Per stimare la probabilità di una frase con un modello bigramma, si moltiplicano le probabilità condizionali dei bigrammi, includendo i token di inizio (`<s>`) e fine (`</s>`). In generale, per una frase:
$$
\text{frase} = \text{<s>} \; w_1 \; w_2 \; \dots \; w_n \; \text{</s>}
$$
la probabilità stimata è:
$$
P(\text{frase}) = P(w_1 \mid \text{<s>}) \cdot P(w_2 \mid w_1) \cdots P(</s> \mid w_n)
$$

### Frase: "I want English food"

Poiché il token "English" non compare nei dati, $P("English")=0$. Quindi:
- $P(I \mid \text{<s>}) = \frac{1922}{8566} \approx 0.2244$
- $P(want \mid I) = \frac{908}{2816} \approx 0.3224$
- $P(\text{English} \mid want) \approx 0$
- $P(food \mid \text{English}) \approx 0$
- $P(</s> \mid food) = \frac{806}{1242} \approx 0.6481$

Pertanto, la probabilità stimata della frase:
$$
\begin{aligned}
P(\text{<s> I want English food </s>}) &\approx P(I \mid \text{<s>}) \cdot P(want \mid I) \cdot P(\text{English} \mid want) \\
&\quad \cdot P(food \mid \text{English}) \cdot P(</s> \mid food) \\
&= 0.2244 \cdot 0.3224 \cdot 0 \cdot 0 \cdot 0.6481 \\
&= 0
\end{aligned}
$$

### Frase: "I want Chinese food"

Utilizziamo i valori aggiornati dalle tabelle per stimare la probabilità:
- $P(I \mid \text{<s>}) = \frac{1922}{8566} \approx 0.2244$
- $P(want \mid I) = \frac{908}{2816} \approx 0.3224$
- $P(chinese \mid want) = \frac{7}{1038} \approx 0.0067$
- $P(food \mid chinese) = \frac{99}{193} \approx 0.5130$
- $P(</s> \mid food) = \frac{806}{1242} \approx 0.6481$

La probabilità della frase è:
$$
\begin{aligned}
P(\text{<s> I want Chinese food </s>}) &= P(I \mid \text{<s>}) \cdot P(want \mid I) \cdot P(chinese \mid want) \\
&\quad \cdot P(food \mid chinese) \cdot P(</s> \mid food) \\
&\approx 0.2244 \cdot 0.3224 \cdot 0.0067 \cdot 0.5130 \cdot 0.6481 \\
&\approx 0.00016
\end{aligned}
$$

## Conclusioni: Cosa Ci Insegnano gli N-grammi

Nonostante la semplicità, i modelli basati su N-grammi riescono a catturare informazioni interessanti riguardo al linguaggio:

- **Fatti Linguistici:**  
  - $P(\text{English} \mid want) \approx 0.0011$  
  - $P(\text{Chinese} \mid want) \approx 0.0067$  
  - $P(to \mid want)$ (valore elevato nei dati originali)

- **Conoscenza del Mondo:**  
  - $P(eat \mid to) \approx 0.2778$ (da altri esempi)  
  - $P(food \mid to) \approx 0$ (in certi casi)

- **Sintassi:**  
  - $P(want \mid spend) = 0$  
  - $P(I \mid \text{<s>}) \approx 0.2244$

- **Discorso:**  
  Le probabilità riflettono le relazioni contestuali e il flusso del discorso, evidenziando come alcuni bigrammi siano molto probabili (come quelli che iniziano con `<s>`) mentre altri risultano meno frequenti o addirittura impossibili.


## Conclusione

Questa è una breve panoramica sul corpus BERP e sulle tecniche di modellazione del linguaggio basate sugli N-grammi, che evidenzia come questi metodi possano essere utilizzati per valutare e interpretare la probabilità di frasi in linguaggio naturale.