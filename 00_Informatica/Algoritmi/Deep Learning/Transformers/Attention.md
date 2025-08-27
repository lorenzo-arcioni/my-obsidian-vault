# Il Meccanismo di Attention: Una Guida Completa

## Introduzione e Intuizione

Il meccanismo di **attention** rappresenta una delle innovazioni più rivoluzionarie nel deep learning moderno. Per comprenderne l'importanza, partiamo da un'osservazione semplice ma profonda: quando leggiamo una frase complessa, non prestiamo la stessa attenzione a tutte le parole. Alcune sono cruciali per il significato, altre sono accessorie. Il nostro cervello è straordinariamente bravo a identificare dinamicamente dove focalizzare l'attenzione.

Consideriamo questa frase: *"Il gatto nero del vicino ha mangiato il pesce rosso che nuotava nella boccia."* Quando cerchiamo di capire "chi ha mangiato cosa", la nostra attenzione si focalizza principalmente su "gatto", "ha mangiato" e "pesce", mentre parole come "del" o "che" ricevono meno attenzione diretta, pur contribuendo alla comprensione strutturale.

Questa capacità di **attenzione selettiva** è esattamente quello che l'attention mechanism cerca di replicare artificialmente. L'idea è permettere a ogni elemento (una parola/un token) di una sequenza di "guardare" tutti gli altri elementi, decidendo dinamicamente a quali prestare maggiore attenzione per costruire la propria rappresentazione.

## I Problemi delle Architetture Precedenti

Per apprezzare pienamente l'innovazione dell'attention, dobbiamo comprendere le limitazioni che affliggevano i modelli precedenti, in particolare le Reti Neurali Ricorrenti (RNN) e le loro varianti come LSTM e GRU.
### Il Bottleneck Sequenziale

Le RNN processano le sequenze in modo strettamente sequenziale: per comprendere la parola in posizione $t$, il modello deve aver elaborato tutte le parole dalle posizioni $1$ a $t-1$. Questo approccio, seppur intuitivo, presenta problemi fondamentali.

Immaginiamo di dover tradurre una frase lunga dal tedesco all'inglese. In tedesco, il verbo principale spesso appare alla fine della frase. Una RNN deve "ricordare" tutte le informazioni accumulate dall'inizio della frase fino al verbo finale, mantenendo questa informazione in un singolo vettore di stato nascosto. È come cercare di ricordare una lista della spesa sempre più lunga senza poterla scrivere: prima o poi alcune informazioni si perdono.

Matematicamente, questo si manifesta nel problema del **vanishing gradient**: l'informazione delle parole iniziali deve "viaggiare" attraverso molti passaggi computazionali per raggiungere le posizioni finali, e durante questo viaggio si degrada progressivamente. Se abbiamo una sequenza di lunghezza $T$, il gradiente che deve propagare dalla fine all'inizio viene moltiplicato $T$ volte per i pesi della rete. Se questi pesi hanno norma minore di 1, il gradiente si riduce esponenzialmente.

### L'Impossibilità di Parallelizzazione

Un secondo problema cruciale è l'impossibilità di parallelizzare il calcolo. Per calcolare l'output in posizione $t$, dobbiamo necessariamente aver calcolato gli output in tutte le posizioni precedenti. Questo rende l'addestramento estremamente lento, specialmente su sequenze lunghe e con l'hardware moderno che è ottimizzato per calcoli paralleli.

## L'Intuizione dell'Attention: Una Media Pesata Intelligente

L'attention risolve questi problemi attraverso un cambio di paradigma radicale. Invece di processare sequenzialmente, permette a ogni elemento di "guardare" direttamente tutti gli altri elementi della sequenza.

### Un Esempio Concreto

Consideriamo la frase: *"La chiave è sul tavolo nella cucina."* Supponiamo di voler determinare la rappresentazione della parola "chiave". Un meccanismo di attention permetterebbe a "chiave" di guardare direttamente tutte le altre parole e decidere quanto ciascuna sia rilevante:

- "La": bassa rilevanza (articolo generico)
- "è": media rilevanza (connette il soggetto al resto)
- "sul": alta rilevanza (preposizione che indica posizione)
- "tavolo": altissima rilevanza (oggetto su cui si trova la chiave)
- "nella": media rilevanza (ulteriore specificazione di posizione)
- "cucina": alta rilevanza (luogo specifico)

La rappresentazione finale di "chiave" sarebbe una combinazione pesata di tutte queste informazioni, con pesi proporzionali alla rilevanza.

### Codifica delle Parole: da One-Hot a Embedding

Per poter applicare meccanismi di attention sui testi, dobbiamo prima rappresentare le parole in forma numerica. Due approcci principali sono il **one-hot encoding** e gli **embedding**.

#### One-Hot Encoding

- Supponiamo di avere un vocabolario con $V$ parole distinte.  
- Ogni parola $w_i$ viene rappresentata come un vettore sparso $\mathbf{e}_i \in \mathbb{R}^V$, con un unico elemento pari a 1 nella posizione corrispondente all’indice della parola nel vocabolario:

$$
\mathbf{e}_j = [0, 0, \dots, 1, \dots, 0]
$$

- Questo metodo è semplice e diretto, ma presenta alcuni svantaggi:

  1. La dimensione dei vettori cresce rapidamente con il vocabolario.  
  2. Non cattura la **similarità semantica**: parole come "cane" e "gatto" risultano ortogonali, anche se semanticamente vicine, e parole come "divano" e "topo" risultano ortogonali anche se semanticamente distanti.  
  3. Non permette generalizzazione: ogni parola è completamente indipendente dalle altre.  

#### Embedding

Per superare questi limiti, si utilizzano i **[[Dense Word Embeddings]]**:

- Ogni parola $w_j$ viene rappresentata da un vettore **denso** $\mathbf{x}_j \in \mathbb{R}^d$, con $d \ll V$.  
- Gli embedding vengono **appresi** dal modello durante il training, in modo che parole semanticamente simili abbiano rappresentazioni vicine nello spazio degli embeddings:

$$
\mathbf{x}_1, \mathbf{x}_2, \dots, \mathbf{x}_N \in \mathbb{R}^d
$$

- Questi vettori densi sono la rappresentazione numerica di partenza per il **meccanismo di attention**: a differenza dei one-hot, gli embedding permettono di catturare relazioni semantiche e di ridurre drasticamente la dimensionalità.

### Formulazione Matematica

Consideriamo $N$ parole (token) in input, ognuna rappresentata da un embedding di dimensione $d$.

L’idea alla base della self-attention è quella di calcolare, per ciascun token, una **combinazione pesata** di tutti gli altri token della sequenza.  
In altre parole, ogni output è una media pesata adattiva dei vettori di input.

#### Definizione dei Value

Per ciascun token $\mathbf{x}_j \in \mathbb{R}^d$, costruiamo un **value vector** $\mathbf{v}_j \in \mathbb{R}^{d_v}$ tramite una trasformazione lineare:

$$
\mathbf{v}_j = \mathbf{W}_v \mathbf{x}_j + \mathbf{b}_v
\quad\text{con}\quad 
\mathbf{W}_v \in \mathbb{R}^{d_v \times d}, \; \mathbf{b}_v \in \mathbb{R}^{d_v}.
$$

dove $W_v$ e $b_v$ sono matrici di pesi e bias appresi nel training e $d_v$ indica la dimensione dei value vectors.

#### Self-Attention come combinazione pesata

Il vettore di output corrispondente alla posizione $j$ è una combinazione lineare di tutti i value $\mathbf{v}_1, \dots, \mathbf{v}_N$, pesata dai coefficienti di attenzione $a_{ij}$:

$$
\mathbf{sa}_j[\mathbf x_1, \dots, \mathbf x_N] =\mathbf{y}_j = \sum_{i=1}^N a_{ij} \,\mathbf{v}_i
$$

dove $a_{ij}$ indica **quanto l’output in posizione $j$ presta attenzione all’input in posizione $i$**. Vedremo tra poco la definizione di $a_{ij}$.

#### Vincoli sui pesi di attenzione

I pesi $a_{ij}$ hanno due proprietà fondamentali:

- **Non negatività:**  
  $a_{ij} \geq 0 \quad \forall i,j$
- **Normalizzazione:**  
  $\sum_{i=1}^N a_{ij} = 1 \quad \forall j$

Queste condizioni garantiscono che $\mathbf{y}_j$ sia una **combinazione convessa** dei value $\mathbf{v}_i$, rendendo il modello stabile e interpretabile.

<img src="../../../../images/attention-mechanism.png" alt="Self-Attention" style="display: block; margin-left: auto; margin-right: auto;">

<br>

**Figura 1 – La self-attention come instradamento (routing).**  
Il meccanismo di self-attention prende in input $N$ vettori $\mathbf{x}_1, \ldots, \mathbf{x}_N \in \mathbb{R}^d$  
(qui $N = 3$ e $d = 4$) e li processa separatamente per calcolare $N$ vettori *value*.  

L’output $n$-esimo $\mathbf{sa}_n[\mathbf{x}_1, \ldots, \mathbf{x}_N]$ (scritto in breve come $\mathbf{sa}_n[x_\bullet]$)  
viene quindi calcolato come una **somma pesata** dei $N$ vettori *value*, dove i pesi sono positivi e sommano a uno.  

- **(a)** L’output $\mathbf{sa}_1[x_\bullet]$ è calcolato come  
  $a[x_1, x_1] = 0.1$ volte il primo vettore *value*,  
  $a[x_2, x_1] = 0.3$ volte il secondo vettore *value*,  
  e $a[x_3, x_1] = 0.6$ volte il terzo vettore *value*.  

- **(b)** L’output $\mathbf{sa}_2[x_\bullet]$ è calcolato nello stesso modo,  
  ma con pesi pari a 0.5, 0.2 e 0.3.  

- **(c)** Il calcolo dell’output $\mathbf{sa}_3[x_\bullet]$ utilizza ancora pesi diversi.  

In sintesi, ciascun output può essere visto come un **instradamento differente dei $N$ vettori value**.

#### Interpretazione

La self-attention può quindi essere vista come un **meccanismo di instradamento (routing)**:  
ogni output $\mathbf{y}_j$ è costruito mescolando i value $\mathbf{v}_i$ in proporzioni determinate dai pesi $a_{ij}$.  

Nelle sezioni successive vedremo come vengono calcolati in pratica questi pesi $a_{ij}$ utilizzando le **query** e le **key**, e come questo porti alla definizione della **dot-product self-attention**.

La vera innovazione sta nel modo in cui vengono calcolati i pesi $a_{ij}$. Non sono fissi o predeterminati, ma vengono calcolati **dinamicamente** in base al contenuto effettivo della sequenza.

## Query, Key e Value: I Tre Ruoli Fondamentali

Una delle intuizioni più brillanti dell'**attention mechanism** è la divisione di ogni elemento della sequenza in tre ruoli distinti, ispirati dai sistemi di *information retrieval* come i motori di ricerca.

### Il Concetto di Query

La **query** $\mathbf{q}_i \in \mathbb{R}^{d_k}$ rappresenta "cosa sta cercando" l'elemento in posizione $i$. È una domanda posta in forma vettoriale. Quando calcoliamo la rappresentazione di "chiave" nel nostro esempio precedente, la query potrebbe essere interpretata come "Sto cercando informazioni che mi aiutino a capire dove mi trovo e cosa mi circonda".

Matematicamente, la query viene ottenuta attraverso una trasformazione lineare dell'input originale:

$$\mathbf{q}_i = \mathbf{W}_q \mathbf{x}_i + \mathbf{b}_q$$

dove $\mathbf{W}_q \in \mathbb{R}^{d_k \times d}$ è una matrice di pesi apprendibili e $\mathbf{b}_q \in \mathbb{R}^{d_k}$ è un vettore di bias. La dimensione $d_k$ (dimensione delle query e key) può essere diversa da $d$ (dimensione dell'input).

L’effetto della dimensione $d_k$ sull’apprendimento è legato alla **granularità delle relazioni** che il modello riesce a cogliere:

- **$d_k$ piccolo** → il modello riesce a rappresentare solo poche caratteristiche.  
  Questo porta ad un’attenzione più semplice e focalizzata, ma con rischio di perdere dettagli.  

- **$d_k$ grande** → il modello ha accesso a molte più informazioni.  
  Questo aumenta la capacità rappresentativa, ma può introdurre ridondanza e maggior costo computazionale.  

Quindi $d_k$ non è scelto a caso, ma rappresenta un compromesso tra **espressività**, **stabilità numerica** e **efficienza**.  
Per questo nei transformer standard si utilizza la regola:

$$
d_k = \frac{d}{h}
$$

dove:
- $d$ = dimensione dell’embedding di input  
- $h$ = numero di [[Multi-head Attention|teste di attenzione]].

### Il Concetto di Key

La **key** $\mathbf{k}_j$ rappresenta "cosa può offrire" l'elemento in posizione $j$. È una sorta di "biglietto da visita" che descrive il tipo di informazione disponibile in quella posizione. Tornando al nostro esempio, la key di "tavola" potrebbe essere interpretata come "Sono un oggetto fisico, posso fornire informazioni su posizione e supporto di altri oggetti".

$$\mathbf{k}_j = \mathbf{W}_k \mathbf{x}_j + \mathbf{b}_k$$

dove $\mathbf{W}_k \in \mathbb{R}^{d_k \times d}$ e $\mathbf{b}_k \in \mathbb{R}^{d_k}$ sono i parametri per la trasformazione delle key.

### Il Concetto di Value

Il **value** $\mathbf{v}_j$ rappresenta "il contenuto informativo effettivo" dell'elemento in posizione $j$. Una volta che abbiamo deciso di prestare attenzione a un elemento (attraverso la compatibilità query-key), il value è ciò che effettivamente "prendiamo" da quell'elemento.

$$\mathbf{v}_j = \mathbf{W}_v \mathbf{x}_j + \mathbf{b}_v$$

dove $\mathbf{W}_v \in \mathbb{R}^{d_v \times d}$ e $\mathbf{b}_v \in \mathbb{R}^{d_v}$ sono i parametri per la trasformazione dei value. Notate che $d_v$ (dimensione dei value) può essere diversa sia da $d$ che da $d_k$.

### Perché Tre Trasformazioni Separate?

La separazione in query, key e value non è arbitraria ma serve scopi precisi e ha profonde implicazioni teoriche:

**Decoupling semantico**: La compatibilità (determinata da query e key) è separata dal contenuto (determinato dai value). Questo permette al modello di dire "So che devo prestare attenzione a questa posizione" (alta compatibilità query-key) indipendentemente da "Cosa prendo effettivamente da questa posizione" (value).

**Flessibilità rappresentazionale**: Ogni trasformazione può specializzarsi nel catturare aspetti diversi dell'informazione. Le query possono imparare a rappresentare "bisogni informativi", le key possono rappresentare "capacità informative", e i value possono rappresentare "contenuti informativi".

**Controllo dimensionale**: Permettere dimensioni diverse ottimizza l'efficienza computazionale. Tipicamente $d_k$ è più piccolo di $d$ per rendere più efficiente il calcolo delle similarità.

## Dot-Product Attention: Il Cuore del Meccanismo

### Calcolo della Compatibilità

Il cuore dell'**attention mechanism** è il calcolo della compatibilità tra query e key attraverso il **prodotto scalare**:

$$\text{score}(\mathbf{q}_i, \mathbf{k}_j) = \mathbf{q}_i^T \mathbf{k}_j = \sum_{l=1}^{d_k} q_{i,l} \cdot k_{j,l}$$

Questa scelta del prodotto scalare non è casuale ma ha solide motivazioni matematiche e computazionali. Il prodotto scalare misura la proiezione di un vettore sull'altro, catturando così quanto due vettori "puntino nella stessa direzione" nello spazio delle caratteristiche.

Se consideriamo vettori normalizzati, il prodotto scalare diventa il **coseno dell'angolo** tra i vettori, fornendo una misura di similarità geometrica intuitiva. Vettori paralleli (stessa direzione) hanno prodotto scalare massimo, vettori ortogonali hanno prodotto scalare zero, vettori opposti hanno prodotto scalare minimo.

### Il Problema dello Scaling e la Sua Soluzione

Quando le dimensioni dei vettori query e key diventano grandi, i prodotti scalari possono assumere valori molto grandi in magnitudine. Questo crea problemi significativi per la funzione softmax che viene applicata successivamente.

Per comprendere il problema, consideriamo la funzione softmax:

$$\text{softmax}(\mathbf{z})_i = \frac{e^{z_i}}{\sum_{j=1}^{N} e^{z_j}}$$

Se gli elementi di $\mathbf{z}$ sono molto grandi, la funzione esponenziale li amplifica enormemente, causando due problemi:

1. **Saturazione**: La softmax si concentra quasi tutto il peso su un singolo elemento, perdendo la capacità di distribuire l'attenzione
2. **Instabilità numerica**: Valori molto grandi possono causare overflow nell'esponenziale

### Analisi Teorica dello Scaling Factor

Per risolvere questo problema, introduciamo un fattore di scala $\sqrt{d_k}$:

$$\text{score}(\mathbf{q}_i, \mathbf{k}_j) = \frac{\mathbf{q}_i^T \mathbf{k}_j}{\sqrt{d_k}}$$

La giustificazione teorica è elegante. Assumiamo che le componenti delle query e key siano variabili aleatorie indipendenti con media zero e varianza unitaria. Il prodotto scalare è:

$$\mathbf{q}^T \mathbf{k} = \sum_{l=1}^{d_k} q_l k_l$$

La varianza di questa somma è:

$$\text{Var}(\mathbf{q}^T \mathbf{k}) = \text{Var}\left(\sum_{l=1}^{d_k} q_l k_l\right) = \sum_{l=1}^{d_k} \text{Var}(q_l k_l)$$

Poiché $q_l$ e $k_l$ sono indipendenti con varianza unitaria:

$$\text{Var}(q_l k_l) = \text{Var}(q_l) \text{Var}(k_l) = 1 \cdot 1 = 1$$

Quindi:

$$\text{Var}(\mathbf{q}^T \mathbf{k}) = d_k$$

Dividendo per $\sqrt{d_k}$, otteniamo:

$$\text{Var}\left(\frac{\mathbf{q}^T \mathbf{k}}{\sqrt{d_k}}\right) = \frac{d_k}{d_k} = 1$$

Questo mantiene la varianza dei punteggi costante, indipendentemente dalla dimensionalità, stabilizzando il comportamento della softmax.

### La Softmax: Competizione e Normalizzazione

I punteggi scalati vengono trasformati in pesi probabilistici attraverso la softmax:

$$a_{ij} = \frac{\exp\left(\frac{\mathbf{q}_i^T \mathbf{k}_j}{\sqrt{d_k}}\right)}{\sum_{l=1}^{N} \exp\left(\frac{\mathbf{q}_i^T \mathbf{k}_l}{\sqrt{d_k}}\right)}$$

La softmax ha proprietà cruciali per l'attention:

**Competizione**: I pesi "competono" tra loro. Se un punteggio aumenta, gli altri diminuiscono automaticamente per mantenere la somma pari a 1. Questo crea un meccanismo di **competizione soft** dove l'attenzione si concentra sui punteggi più alti.

**Differenziabilità**: È completamente differenziabile, permettendo l'addestramento end-to-end tramite backpropagation.

**Interpretabilità**: I pesi risultanti possono essere interpretati come probabilità, fornendo insight su dove il modello sta "guardando".

## Formulazione Matriciale e Implementazione

### Efficienza Computazionale

Per implementare efficientemente l'attention, utilizziamo operazioni matriciali che sfruttano l'hardware moderno ottimizzato per il calcolo parallelo.

Organizziamo tutti gli input in una matrice $\mathbf{X} \in \mathbb{R}^{N \times d}$ dove ogni riga è un elemento della sequenza. Le matrici di query, key e value diventano:

$$\mathbf{Q} = \mathbf{X}\mathbf{W}_q^T + \mathbf{1}\mathbf{b}_q^T \in \mathbb{R}^{N \times d_k}$$
$$\mathbf{K} = \mathbf{X}\mathbf{W}_k^T + \mathbf{1}\mathbf{b}_k^T \in \mathbb{R}^{N \times d_k}$$
$$\mathbf{V} = \mathbf{X}\mathbf{W}_v^T + \mathbf{1}\mathbf{b}_v^T \in \mathbb{R}^{N \times d_v}$$

dove $\mathbf{1} \in \mathbb{R}^{N \times 1}$ è un vettore di tutti 1.

### La Formula Completa

L'intero meccanismo di attention si riduce a una singola operazione matriciale:

$$\text{Attention}(\mathbf{Q}, \mathbf{K}, \mathbf{V}) = \text{softmax}\left(\frac{\mathbf{Q}\mathbf{K}^T}{\sqrt{d_k}}\right)\mathbf{V}$$

Analizziamo i passaggi:

1. **$\mathbf{Q}\mathbf{K}^T$**: Calcola tutti i prodotti scalari query-key simultaneamente, risultando in una matrice $N \times N$ dove l'elemento $(i,j)$ è $\mathbf{q}_i^T \mathbf{k}_j$

2. **Divisione per $\sqrt{d_k}$**: Applica lo scaling factor elemento per elemento

3. **Softmax**: Normalizza ogni riga della matrice (ogni riga corrisponde alle attention weights per una query)

4. **Moltiplicazione per $\mathbf{V}$**: Calcola la combinazione pesata dei value per ogni posizione

## Self-Attention: Il Dialogo Interno della Sequenza

### Definizione e Significato

Nel **self-attention**, tutte le query, key e value provengono dalla stessa sequenza di input. Questo significa che ogni elemento della sequenza può prestare attenzione a tutti gli altri elementi, incluso se stesso.

Matematicamente:
$$\mathbf{Q} = \mathbf{K} = \mathbf{V} = \mathbf{X}$$

(dopo le rispettive trasformazioni lineari).

### Un Esempio Dettagliato

Consideriamo la frase: *"Il gatto caccia il topo."* Nel self-attention, ogni parola può prestare attenzione a tutte le altre:

- **"gatto"** potrebbe prestare molta attenzione a "caccia" (relazione soggetto-verbo) e "topo" (relazione semantica predatore-preda)
- **"caccia"** potrebbe prestare attenzione a "gatto" (chi fa l'azione) e "topo" (oggetto dell'azione)
- **"topo"** potrebbe prestare attenzione a "caccia" e "gatto" per comprendere il suo ruolo nella situazione

Questo crea rappresentazioni **contestuali**: la rappresentazione di ogni parola incorpora informazioni da tutte le altre parole nella frase.

### Vantaggi del Self-Attention

**Cattura di dipendenze a lungo raggio**: Due parole distanti nella sequenza possono interagire direttamente senza passaggi intermedi.

**Parallelizzazione completa**: Tutti i calcoli possono essere eseguiti simultaneamente, non c'è dipendenza sequenziale.

**Flessibilità**: Il modello impara automaticamente quali relazioni sono importanti, senza assumzioni a priori sulla struttura linguistica.

## Implementazione in Python

Vediamo ora un'implementazione pratica del meccanismo di self-attention:

```python
import torch
from torch import nn
import torch.nn.functional as F
import math

class BasicSelfAttention(nn.Module):
    def __init__(self, d_model, d_k=None):
        super().__init__()
        if d_k is None:
            d_k = d_model
        
        self.d_k = d_k
        self.d_model = d_model
        
        # Trasformazioni lineari per query, key e value
        self.query = nn.Linear(d_model, d_k, bias=False)
        self.key = nn.Linear(d_model, d_k, bias=False)
        self.value = nn.Linear(d_model, d_model, bias=False)
    
    def forward(self, x):
        # x ha shape (batch_size, seq_len, d_model)
        batch_size, seq_len, d_model = x.size()
        
        # Calcola query, key e value
        Q = self.query(x)  # (batch_size, seq_len, d_k)
        K = self.key(x)    # (batch_size, seq_len, d_k)
        V = self.value(x)  # (batch_size, seq_len, d_model)
        
        # Calcola i punteggi di attention
        scores = torch.matmul(Q, K.transpose(-2, -1)) / math.sqrt(self.d_k)
        # scores ha shape (batch_size, seq_len, seq_len)
        
        # Applica softmax per ottenere i pesi
        attention_weights = F.softmax(scores, dij-1)
        
        # Calcola l'output pesato
        output = torch.matmul(attention_weights, V)
        
        return output, attention_weights

# Esempio di utilizzo
d_model = 512
seq_len = 10
batch_size = 2

# Dati di input casuali
x = torch.randn(batch_size, seq_len, d_model)

# Crea il modello
attention = BasicSelfAttention(d_model)

# Forward pass
output, weights = attention(x)

print(f"Input shape: {x.shape}")
print(f"Output shape: {output.shape}")
print(f"Attention weights shape: {weights.shape}")

# Visualizza i pesi di attention per il primo esempio del batch
import matplotlib.pyplot as plt
plt.figure(figsize=(8, 6))
plt.imshow(weights[0].detach().numpy(), cmap='Blues')
plt.title('Attention Weights Heatmap')
plt.xlabel('Key positions')
plt.ylabel('Query positions')
plt.colorbar()
plt.show()
```

### Spiegazione del Codice

La classe `BasicSelfAttention` implementa il meccanismo fondamentale:

**Inizializzazione**: Definiamo tre trasformazioni lineari per query, key e value. La dimensione delle key e query (`d_k`) può essere diversa dalla dimensione del modello per efficienza.

**Forward pass**:
1. Trasformiamo l'input nelle matrici Q, K, V
2. Calcoliamo i punteggi come $\mathbf{Q}\mathbf{K}^T / \sqrt{d_k}$
3. Applichiamo softmax per ottenere i pesi di attention
4. Calcoliamo l'output finale come combinazione pesata dei value

## Complessità Computazionale e Considerazioni Pratiche

### Analisi della Complessità

La complessità computazionale del self-attention è dominata da due operazioni principali:

**Calcolo di $\mathbf{Q}\mathbf{K}^T$**: Richiede $O(N^2 d_k)$ operazioni, dove $N$ è la lunghezza della sequenza.

**Calcolo dell'output**: La moltiplicazione dei pesi per i value richiede $O(N^2 d_v)$ operazioni.

La **complessità totale** è quindi $O(N^2 d)$ dove $d = \max(d_k, d_v)$.

### Confronto con le RNN

Le RNN hanno complessità $O(N d^2)$ per layer, che sembra migliore per $N < d$. Tuttavia, il vantaggio cruciale dell'attention è la **parallelizzazione**: mentre le RNN richiedono $O(N)$ operazioni sequenziali, l'attention richiede solo $O(1)$.

### Limitazioni Pratiche

**Consumo di memoria**: La matrice di attention $N \times N$ può diventare proibitivamente grande per sequenze lunghe. Per $N = 10000$, abbiamo 100 milioni di elementi.

**Scaling quadratico**: Il tempo di calcolo cresce quadraticamente con la lunghezza della sequenza, limitando l'applicabilità a documenti molto lunghi.

## Proprietà Matematiche e Interpretazione

### Interpretazione Geometrica

L'attention può essere vista come un meccanismo che "mescola" i vettori di input in modo intelligente. Ogni output è un punto nel convex hull dei vettori di input, con la posizione determinata dai pesi di attention.

Geometricamente, se i value sono punti nello spazio, l'attention calcola un "centro di massa" pesato di questi punti per ogni query.

### Connessioni con la Teoria dell'Informazione

I pesi di attention possono essere interpretati come una distribuzione di probabilità condizionale:

$$P(\text{prestare attenzione alla posizione } j | \text{query in posizione } i) = a_{ij}$$

L'output è quindi il valore atteso dei value sotto questa distribuzione. Questo collega l'attention alla teoria dell'informazione e ai modelli probabilistici.

### Invarianze e Simmetrie

Il meccanismo di attention ha alcune proprietà di invarianza interessanti:

**Permutation equivariance**: Se permuti gli input, gli output vengono permutati allo stesso modo (senza positional encoding).

**Scale invariance**: Moltiplicare tutti gli input per una costante non cambia i pesi di attention (grazie alla normalizzazione softmax).

## Conclusioni

Il meccanismo di attention ha rivoluzionato il deep learning fornendo un modo elegante e efficace per catturare relazioni complesse in sequenze di dati. La sua capacità di permettere interazioni dirette tra elementi distanti, mantenendo al contempo la parallelizzazione completa, lo ha reso la base per i Transformer e, di conseguenza, per i modelli linguistici moderni.

L'intuizione fondamentale - permettere a ogni elemento di "prestare attenzione" a tutti gli altri elementi - è semplice ma potente. La sua implementazione attraverso query, key e value fornisce la flessibilità necessaria per apprendere relazioni complesse, mentre la formulazione matriciale garantisce l'efficienza computazionale.

Sebbene presenti limitazioni in termini di complessità quadratica, l'attention rimane uno strumento fondamentale nell'arsenale del deep learning moderno, e continua a ispirare nuove architetture e applicazioni in numerosi domini oltre al natural language processing.