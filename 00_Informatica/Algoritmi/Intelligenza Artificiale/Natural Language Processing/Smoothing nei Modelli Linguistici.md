# Smoothing nei Modelli Linguistici  

## Introduzione  
Lo **smoothing** è una tecnica fondamentale per gestire il problema dei **dati sparsi** nei modelli di linguaggio. Senza smoothing:  
- Gli **n-grammi non osservati** nel training ricevono probabilità zero, portando a **perplessità infinita** durante il test.  
- Il modello non può generalizzare a sequenze plausibili ma mai viste.  

L'idea è **ridistribuire la massa di probabilità** dagli n-grammi frequenti a quelli rari o assenti ("Rubare ai ricchi per dare ai poveri").  

## Tecniche Principali  

### 1. **Laplace (Add-One) Smoothing**  
Il Laplace Smoothing, noto anche come add-one smoothing, è una tecnica usata nei modelli di linguaggio probabilistici per gestire il problema degli zeri nelle stime di probabilità. Nei modelli basati su n-grammi, ad esempio, capita spesso che alcune combinazioni di parole non compaiano mai nel corpus di addestramento. Senza smoothing, queste combinazioni avrebbero probabilità pari a zero, il che può compromettere gravemente la generazione o la valutazione di frasi.

Il Laplace Smoothing risolve questo problema aggiungendo 1 al conteggio di ogni possibile n-gramma. In pratica, anche gli n-grammi mai visti ottengono un conteggio minimo, evitando probabilità nulle. 

Sebbene semplice ed efficace per corpus piccoli, il Laplace Smoothing tende a sovrastimare la probabilità degli eventi rari, penalizzando quelli frequenti. Per questo motivo, in applicazioni avanzate si preferiscono metodi più sofisticati come Good-Turing o Kneser-Ney smoothing. Tuttavia, il Laplace rimane una base utile per comprendere il concetto di smoothing nei modelli di linguaggio.

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


## Conclusione  
Lo smoothing è essenziale per modelli linguistici robusti. **Kneser-Ney** è la tecnica più avanzata, mentre **Laplace** è utile per prototipazione. La scelta dipende da:  
1. Dimensione del corpus.  
2. Risorse computazionali.  
3. Trade-off accuratezza/complessità.  