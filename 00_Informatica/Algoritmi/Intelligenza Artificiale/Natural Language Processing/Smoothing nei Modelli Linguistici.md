# Smoothing nei Modelli Linguistici  

## Introduzione  
Lo **smoothing** è una tecnica fondamentale per gestire il problema dei **dati sparsi** nei modelli di linguaggio. Senza smoothing:  
- Gli **n-grammi non osservati** nel training ricevono probabilità zero, portando a **perplessità infinita** durante il test.  
- Il modello non può generalizzare a sequenze plausibili ma mai viste.  

L'idea è **ridistribuire la massa di probabilità** dagli n-grammi frequenti a quelli rari o assenti ("Rubare ai ricchi per dare ai poveri").  

## Tecniche Principali  

### 1. **Laplace (Add-One) Smoothing**  
**Formula (Unigrammi):**  
$$
P_{\text{Laplace}}(w_i) = \frac{c(w_i) + 1}{N + V}
$$  
- $c(w_i)$: conteggio della parola $w_i$.  
- $N$: numero totale di token nel corpus.  
- $V$: dimensione del vocabolario.  

**Formula generale per n-grammi**:  
Per un n-gramma $w_1, w_2, \dots, w_n$:  
$$
P_{\text{Laplace}}(w_n | w_1, \dots, w_{n-1}) = \frac{c(w_1, \dots, w_n) + 1}{c(w_1, \dots, w_{n-1}) + V}
$$  
dove $c(w_1, \dots, w_{n-1})$ è il conteggio del contesto $(w_1, \dots, w_{n-1})$.

**Ridistribuzione dei conteggi**:  
I conteggi originali vengono riconvertiti per mantenere la coerenza:  
$$
c^*(w_1, \dots, w_n) = \frac{(c(w_1, \dots, w_n) + 1) \cdot c(w_1, \dots, w_{n-1})}{c(w_1, \dots, w_{n-1}) + V}
$$  

**Esempio**:  
Se $N=1000$ e $V=500$, un bigramma "gatto felice" con $c=3$ (e contesto "gatto" che appare 10 volte):  
$$
P_{\text{Laplace}} = \frac{3 + 1}{10 + 500} = \frac{4}{510} \approx 0.0078
$$  
Conteggio ridistribuito:  
$$
c^* = \frac{(3 + 1) \cdot 10}{10 + 500} = \frac{40}{510} \approx 0.078
$$

**Problema**:  
- Sovrastima degli eventi rari per $V$ grandi (es. $V=10^5$). Per un bigramma mai visto "gatto volante", con contesto "gatto" ($c=10$):  
$$
P_{\text{Laplace}} = \frac{0 + 1}{10 + 500} = \frac{1}{510} \approx 0.00196.
$$

### 2. **Good-Turing Smoothing**  
Stima la probabilità degli n-grammi mai visti usando la frequenza dei **singoletti** (n-grammi con conteggio 1):  
$$
P_{\text{GT}} = \frac{N_1}{N}
$$  
- $N_1$: numero di n-grammi osservati una volta.  

### 3. **Interpolazione Lineare**  
Combina stime da n-grammi di ordine diverso (es. trigrammi, bigrammi, unigrammi):  
$$
P_{\text{interp}}(w_i|w_{i-1}) = \lambda_1 P_{\text{trigram}} + \lambda_2 P_{\text{bigram}} + \lambda_3 P_{\text{unigram}}
$$  
con $\lambda_1 + \lambda_2 + \lambda_3 = 1$.  

### 4. **Kneser-Ney (Stato dell'Arte)**  
Usa **sconti** e probabilità di continuazione:  
$$
P_{\text{KN}}(w_i|w_{i-1}) = \frac{\max(c(w_{i-1}, w_i) - d, 0)}{c(w_{i-1})} + \lambda(w_{i-1}) \cdot P_{\text{cont}}(w_i)
$$  
- $d$: sconto (es. 0.75).  
- $P_{\text{cont}}(w_i)$: misura in quanti contesti $w_i$ appare.  

**Perché funziona:**  
- Penalizza parole comuni in contesti specifici (es. "Francisco" dopo "San").  

## Confronto  
| Tecnica           | Vantaggi                         | Svantaggi               |  
|-------------------|----------------------------------|-------------------------|  
| Laplace           | Semplice da implementare         | Poco accurato per $V$ grandi |  
| Good-Turing       | Buono per corpus piccoli         | Difficile per n-grammi alti |  
| Kneser-Ney        | Massima accuratezza              | Computazionalmente costoso |  

## Applicazione del Laplace Smoothing al BERP (Berkeley Restaurant Project)

Ricordiamo [[The Berkeley Restaurant Project|l'introduzione al BERP]], dove abbiamo realizzato la tabella di frequenze dei bigrammi:

|            | $<s>$          | i   | want | to  | eat | chinese | food | lunch | spend | $</s>$         |
|------------|----------------|-----|------|-----|-----|---------|------|-------|-------|----------------|
| **$<s>$**      | –              | $c(i_{<s>})$  | $c(want_{<s>})$  | $c(to_{<s>})$  | $c(eat_{<s>})$  | $c(chinese_{<s>})$  | $c(food_{<s>})$  | $c(lunch_{<s>})$  | $c(spend_{<s>})$  | $c(<s>_{</s>})$  |
| **i**      | $c(i_{<s>})$     | 5   | 827  | 0   | 9   | 0       | 0    | 0     | 2     | $c(i_{</s>})$    |
| **want**   | $c(w_{<s>})$     | 2   | 0    | 608 | 1   | 6       | 6    | 5     | 1     | $c(w_{</s>})$    |
| **to**     | $c(t_{<s>})$     | 2   | 0    | 4   | 686 | 2       | 0    | 6     | 211   | $c(t_{</s>})$    |
| **eat**    | $c(e_{<s>})$     | 0   | 0    | 2   | 0   | 16      | 2    | 42    | 0     | $c(e_{</s>})$    |
| **chinese**| $c(c_{<s>})$     | 1   | 0    | 0   | 0   | 0       | 82   | 1     | 0     | $c(c_{</s>})$    |
| **food**   | $c(f_{<s>})$     | 15  | 0    | 15  | 0   | 1       | 4    | 0     | 0     | $c(f_{</s>})$    |
| **lunch**  | $c(l_{<s>})$     | 2   | 0    | 0   | 0   | 0       | 1    | 0     | 0     | $c(l_{</s>})$    |
| **spend**  | $c(s_{<s>})$     | 1   | 0    | 1   | 0   | 0       | 0    | 0     | 0     | $c(s_{</s>})$    |

Chiameremo questa matrice $\mathbf{B}$.

E riportiamo anche il vettore delle frequenze degli unigrammi:

|        | $<s>$ | i    | want | to   | eat  | chinese | food | lunch | spend | $</s>$ |
|--------|-----|------|------|------|------|---------|------|-------|-------|------|
| Count  | $N$   | 2533 | 927  | 2417 | 746  | 158     | 1093 | 341   | 278   | $N$    |

Chiameremo questo vettore $\mathbf{u}$.

### 1. Aggiunta del Contatore per il Laplace Smoothing

Per applicare il Laplace smoothing, aggiungiamo 1 a ciascuna cella della matrice (eccetto le celle “–” relative ai token di inizio/fine sequenza):

|            | $<s>$          | i   | want | to  | eat | chinese | food | lunch | spend | $</s>$         |
|------------|----------------|-----|------|-----|-----|---------|------|-------|-------|----------------|
| **$<s>$**      | 1              | $c(i_{<s>})$  | $c(want_{<s>})$  | $c(to_{<s>})$  | $c(eat_{<s>})$  | $c(chinese_{<s>})$  | $c(food_{<s>})$  | $c(lunch_{<s>})$  | $c(spend_{<s>})$  | $c(<s>_{</s>})$ |
| **i**      | $c(i_{<s>})$     | 6   | 828  | 1   | 10  | 1       | 1    | 1     | 3     | $c(i_{</s>})$    |
| **want**   | $c(w_{<s>})$     | 3   | 1    | 609 | 2   | 7       | 7    | 6     | 2     | $c(w_{</s>})$    |
| **to**     | $c(t_{<s>})$     | 3   | 1    | 5   | 687 | 3       | 1    | 7     | 212   | $c(t_{</s>})$    |
| **eat**    | $c(e_{<s>})$     | 1   | 1    | 3   | 1   | 17      | 3    | 43    | 1     | $c(e_{</s>})$    |
| **chinese**| $c(c_{<s>})$     | 2   | 1    | 1   | 1   | 1       | 83   | 2     | 1     | $c(c_{</s>})$    |
| **food**   | $c(f_{<s>})$     | 16  | 1    | 16  | 1   | 2       | 5    | 1     | 1     | $c(f_{</s>})$    |
| **lunch**  | $c(l_{<s>})$     | 3   | 1    | 1   | 1   | 1       | 2    | 1     | 1     | $c(l_{</s>})$    |
| **spend**  | $c(s_{<s>})$     | 2   | 1    | 2   | 1   | 1       | 1    | 1     | 1     | $c(s_{</s>})$    |

### 2. Calcolo delle Probabilità Smoothing

Per ogni bigramma $(w_{n-1}, w_n)$ il Laplace smoothing prevede:

$$
\mathbb P(w_n \mid w_{n-1}) = \frac{c(w_{n-1}, w_n) + 1}{c(w_{n-1}) + V}
$$

dove:
- $c(w_{n-1}, w_n)$ è il conteggio (già incrementato di 1) per il bigramma;
- $c(w_{n-1})$ è il totale dei conteggi per il contesto $w_{n-1}$ (ottenibile dal vettore delle frequenze degli unigrammi $\mathbf{u}$);
- $V$ è la dimensione del vocabolario (in questo caso, $V=1446$).

**Esempio di Calcolo:**

Supponiamo di voler calcolare la probabilità condizionata del bigramma ("i", "want").  
Dalla riga relativa a "i" abbiamo:
- Valore incrementato per ("i", "want") = 828  
- Totale dei conteggi per il contesto "i":  
  $$
  c("i") = \mathbf u_i = 2533.
  $$

Quindi:

$$
\mathbb P(\text{"want"} \mid \text{"i"}) = \frac{\overbrace{828}^{827+1}}{2533 + 1446} \approx 0.21.
$$

e quindi la probabilità $\mathbb P("i", "want") = \mathbb P(\text{"want"} \mid \text{"i"}) \cdot \mathbb P("i")$.

### 3. Costruzione della Matrice di Probabilità Smoothed $\mathbf{B^*}$

Una volta applicata la formula per ogni cella (per ogni bigramma), la matrice $\mathbf{B^*}$ conterrà le probabilità smoothed:


## Conclusione  
Lo smoothing è essenziale per modelli linguistici robusti. **Kneser-Ney** è la tecnica più avanzata, mentre **Laplace** è utile per prototipazione. La scelta dipende da:  
1. Dimensione del corpus.  
2. Risorse computazionali.  
3. Trade-off accuratezza/complessità.  