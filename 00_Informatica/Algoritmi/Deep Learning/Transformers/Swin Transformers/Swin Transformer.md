# Swin Transformer: Guida Completa e Dettagliata

## Introduzione

Lo **Swin Transformer** (Shifted Window Transformer) è un'architettura di deep learning progettata per elaborare immagini in modo efficiente. A differenza dei Vision Transformer tradizionali che applicano l'attenzione su tutti i pixel dell'immagine contemporaneamente (operazione molto costosa computazionalmente), Swin Transformer utilizza una strategia intelligente basata su **finestre locali** che vengono spostate tra i layer per catturare sia informazioni locali che globali.

Immaginate di osservare un'immagine attraverso piccole finestre: prima guardate regioni locali, poi spostate leggermente le finestre per vedere connessioni tra diverse regioni. Questa è l'essenza di Swin Transformer.

In generale, Swin Transformer trasforma un'immagine in una sequenza di token (come in NLP) e le passa attraverso un'architettura di deep learning, in modo da ottenere rappresentazioni gerarchiche di immagini in un embedding 1D.

## Architettura Generale

L'architettura di Swin Transformer si compone di quattro fasi principali, ognuna con una risoluzione spaziale progressivamente ridotta (simile alle CNN), creando una **gerarchia di rappresentazioni**.

### Input e Parametri

Consideriamo un'immagine di input:

$$
\mathbf{X}_{\text{input}} \in \mathbb{R}^{B \times 3 \times H_0 \times W_0}
$$

dove:
- $B$ = dimensione del batch (numero di immagini elaborate insieme)
- $3$ = numero di canali (RGB)
- $H_0 = W_0 = 224$ (tipicamente, dimensione immagine standard)

## Fase 1: Patch Embedding

### Suddivisione in Patch

Il primo passo consiste nel suddividere l'immagine in patch non sovrapposte. Ogni patch viene trattata come un "token" (simile alle parole in NLP).

**Parametri:**
- Dimensione patch: $P = 4$ (tipicamente)
- Dimensione embedding: $C = 96$ (tipicamente)

**Operazione:**

L'immagine viene suddivisa usando una convoluzione 2D:

$$
\text{Conv2D}: \mathbb{R}^{B \times 3 \times 224 \times 224} \rightarrow \mathbb{R}^{B \times 96 \times 56 \times 56}
$$

Parametri della convoluzione:
- Kernel size: $4 \times 4$
- Stride: $4$
- Output channels: $96$

Questo produce:

$$
H_1 = \frac{H_0}{P} = \frac{224}{4} = 56
$$

$$
W_1 = \frac{W_0}{P} = \frac{224}{4} = 56
$$

Il numero totale di patch è:

$$
N = H_1 \times W_1 = 56 \times 56 = 3136
$$

**Reshape per elaborazione:**

Il tensore viene riorganizzato da formato spaziale a sequenza:

$$
\mathbf{X}_{\text{embed}} \in \mathbb{R}^{B \times 96 \times 56 \times 56} \rightarrow \mathbb{R}^{B \times 3136 \times 96}
$$

**Normalizzazione (opzionale):**

Se `patch_norm=True`, si applica Layer Normalization:

$$
\mathbf{X}_{\text{norm}} = \text{LayerNorm}(\mathbf{X}_{\text{embed}})
$$

con $\mathbf{X}_{\text{norm}} \in \mathbb{R}^{B \times 3136 \times 96}$

### Absolute Position Embedding (opzionale)

Se il parametro `ape=True` è attivato, viene aggiunto un embedding posizionale assoluto:

$$
\mathbf{X}_{\text{pos}} = \mathbf{X}_{\text{norm}} + \mathbf{E}_{\text{abs}}
$$

dove $\mathbf{E}_{\text{abs}} \in \mathbb{R}^{1 \times 3136 \times 96}$ è un parametro apprendibile che codifica la posizione di ogni patch nell'immagine.

Dimensione finale dopo dropout:

$$
\mathbf{X}_0 = \text{Dropout}(\mathbf{X}_{\text{pos}}) \in \mathbb{R}^{B \times 3136 \times 96}
$$

## Stage 1: Primo Livello della Gerarchia

Lo Stage 1 processa le patch con la massima risoluzione spaziale.

### Parametri dello Stage 1

- Risoluzione input: $H_1 \times W_1 = 56 \times 56$
- Dimensione canali: $C_1 = 96$
- Numero di blocchi: $\text{depth}_1 = 2$
- Numero di head di attenzione: $\text{heads}_1 = 3$
- Dimensione finestra: $M = 7$

### Swin Transformer Block

Ogni stage contiene una sequenza di **Swin Transformer Blocks**. Ogni blocco alterna tra:
1. **W-MSA** (Window-based Multi-head Self Attention)
2. **SW-MSA** (Shifted Window-based Multi-head Self Attention)

## W-MSA: Window-based Multi-head Self Attention

### Concetto Base

Invece di calcolare l'attenzione su tutte le $N = 3136$ patch (operazione $O(N^2)$), W-MSA divide l'immagine in **finestre non sovrapposte** di dimensione $M \times M$ e calcola l'attenzione **localmente** all'interno di ogni finestra.

### Partizionamento in Finestre

**Input al blocco:**

$$
\mathbf{X} \in \mathbb{R}^{B \times (H \times W) \times C}
$$

Per lo Stage 1: $H = W = 56$, $C = 96$

**Reshape spaziale:**

$$
\mathbf{X} \rightarrow \mathbb{R}^{B \times H \times W \times C} = \mathbb{R}^{B \times 56 \times 56 \times 96}
$$

**Partizionamento:**

L'immagine viene divisa in finestre di dimensione $M \times M$ (con $M = 7$):

$$
\text{num\_windows} = \frac{H}{M} \times \frac{W}{M} = \frac{56}{7} \times \frac{56}{7} = 8 \times 8 = 64
$$

Ogni finestra contiene:

$$
M^2 = 7 \times 7 = 49 \text{ patch}
$$

**Reshape per l'attenzione:**

$$
\mathbf{X}_{\text{windows}} \in \mathbb{R}^{(B \times 64) \times 49 \times 96}
$$

Quindi abbiamo $B \times 64$ finestre indipendenti, ognuna con 49 patch.

### Layer Normalization

Prima dell'attenzione, si applica normalizzazione:

$$
\mathbf{X}_{\text{norm}} = \text{LayerNorm}(\mathbf{X}_{\text{windows}})
$$

$$
\mathbf{X}_{\text{norm}} \in \mathbb{R}^{(B \times 64) \times 49 \times 96}
$$

### Multi-Head Self Attention

**Numero di head:** $h = 3$ (per Stage 1)

**Dimensione per head:**

$$
d_h = \frac{C}{h} = \frac{96}{3} = 32
$$

**Proiezioni QKV:**

Le query, key e value vengono generate con una proiezione lineare:

$$
\mathbf{QKV} = \mathbf{X}_{\text{norm}} \mathbf{W}_{qkv}
$$

dove $\mathbf{W}_{qkv} \in \mathbb{R}^{96 \times 288}$ (288 = 3 × 96 per Q, K, V)

Risultato:

$$
\mathbf{QKV} \in \mathbb{R}^{(B \times 64) \times 49 \times 288}
$$

**Separazione e Reshape:**

$$
\mathbf{Q}, \mathbf{K}, \mathbf{V} \in \mathbb{R}^{(B \times 64) \times 49 \times 96}
$$

Reshape per multi-head:

$$
\mathbf{Q} \rightarrow \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 32}
$$

$$
\mathbf{K} \rightarrow \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 32}
$$

$$
\mathbf{V} \rightarrow \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 32}
$$

### Calcolo dell'Attenzione

**Scaled Dot-Product Attention:**

$$
\mathbf{A} = \frac{\mathbf{Q} \mathbf{K}^T}{\sqrt{d_h}} + \mathbf{B}
$$

dove:
- $\mathbf{Q} \mathbf{K}^T \in \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 49}$ (matrice di attenzione)
- $\sqrt{d_h} = \sqrt{32} \approx 5.66$ (fattore di scala)
- $\mathbf{B} \in \mathbb{R}^{3 \times 49 \times 49}$ (relative position bias)

### Relative Position Bias

Swin Transformer usa un **bias posizionale relativo** apprendibile invece di embedding posizionali assoluti per ogni token.

**Tabella dei bias:**

$$
\mathbf{B}_{\text{table}} \in \mathbb{R}^{(2M-1) \times (2M-1) \times h}
$$

Per $M = 7$, $h = 3$:

$$
\mathbf{B}_{\text{table}} \in \mathbb{R}^{13 \times 13 \times 3}
$$

**Indicizzazione:**

Per ogni coppia di posizioni $(i, j)$ all'interno della finestra, si calcola l'offset relativo e si recupera il bias corrispondente dalla tabella.

**Applicazione Softmax:**

$$
\mathbf{A}_{\text{norm}} = \text{Softmax}(\mathbf{A})
$$

$$
\mathbf{A}_{\text{norm}} \in \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 49}
$$

**Applicazione ai Values:**

$$
\mathbf{O} = \mathbf{A}_{\text{norm}} \mathbf{V}
$$

$$
\mathbf{O} \in \mathbb{R}^{(B \times 64) \times 3 \times 49 \times 32}
$$

**Concatenazione delle head:**

$$
\mathbf{O} \rightarrow \mathbb{R}^{(B \times 64) \times 49 \times 96}
$$

**Proiezione finale:**

$$
\mathbf{O}_{\text{proj}} = \mathbf{O} \mathbf{W}_{\text{proj}}
$$

dove $\mathbf{W}_{\text{proj}} \in \mathbb{R}^{96 \times 96}$

**Merge delle finestre:**

Le finestre vengono ricomposte nell'immagine originale:

$$
\mathbf{O}_{\text{proj}} \in \mathbb{R}^{(B \times 64) \times 49 \times 96} \rightarrow \mathbb{R}^{B \times 56 \times 56 \times 96} \rightarrow \mathbb{R}^{B \times 3136 \times 96}
$$

### Residual Connection

$$
\mathbf{X}_{\text{attn}} = \mathbf{X} + \text{DropPath}(\mathbf{O}_{\text{proj}})
$$

$$
\mathbf{X}_{\text{attn}} \in \mathbb{R}^{B \times 3136 \times 96}
$$

## Feed-Forward Network (MLP)

Dopo l'attenzione, ogni blocco include una rete feed-forward:

**Layer Norm:**

$$
\mathbf{X}_{\text{norm2}} = \text{LayerNorm}(\mathbf{X}_{\text{attn}})
$$

**MLP:**

$$
\mathbf{X}_{\text{mlp}} = \text{GELU}(\mathbf{X}_{\text{norm2}} \mathbf{W}_1 + \mathbf{b}_1) \mathbf{W}_2 + \mathbf{b}_2
$$

dove:
- $\mathbf{W}_1 \in \mathbb{R}^{96 \times 384}$ (espansione con ratio 4)
- $\mathbf{W}_2 \in \mathbb{R}^{384 \times 96}$ (proiezione al numero di canali originale)

**Dimensioni intermediate:**

$$
\mathbf{X}_{\text{hidden}} \in \mathbb{R}^{B \times 3136 \times 384}
$$

$$
\mathbf{X}_{\text{mlp}} \in \mathbb{R}^{B \times 3136 \times 96}
$$

**Residual Connection:**

$$
\mathbf{X}_{\text{out}} = \mathbf{X}_{\text{attn}} + \text{DropPath}(\mathbf{X}_{\text{mlp}})
$$

$$
\mathbf{X}_{\text{out}} \in \mathbb{R}^{B \times 3136 \times 96}
$$

## SW-MSA: Shifted Window Multi-head Self Attention

Il secondo blocco di ogni stage usa **finestre spostate** per permettere la comunicazione tra finestre diverse.

### Cyclic Shift

**Shift Amount:**

$$
s = \lfloor \frac{M}{2} \rfloor = \lfloor \frac{7}{2} \rfloor = 3
$$

**Operazione di Shift:**

L'immagine viene shiftata ciclicamente di $s$ pixel sia in altezza che in larghezza:

$$
\mathbf{X}_{\text{shifted}}[i, j] = \mathbf{X}[(i - s) \mod H, (j - s) \mod W]
$$

In notazione tensoriale usando `torch.roll`:

$$
\mathbf{X}_{\text{shifted}} = \text{roll}(\mathbf{X}, \text{shifts}=(-3, -3), \text{dims}=(1, 2))
$$

**Dimensioni:**

$$
\mathbf{X} \in \mathbb{R}^{B \times 56 \times 56 \times 96} \rightarrow \mathbf{X}_{\text{shifted}} \in \mathbb{R}^{B \times 56 \times 56 \times 96}
$$

### Partizionamento e Mascheramento

Dopo lo shift, l'immagine viene partizionata in finestre come in W-MSA. Tuttavia, alcune finestre ora contengono regioni che non erano adiacenti nell'immagine originale.

**Attention Mask:**

Una maschera viene applicata per impedire l'attenzione tra regioni non adiacenti:

$$
\mathbf{A}_{\text{masked}} = \mathbf{A} + \mathbf{M}_{\text{mask}}
$$

dove $\mathbf{M}_{\text{mask}}$ contiene $-100$ per coppie di posizioni che non dovrebbero interagire e $0$ altrove.

**Calcolo dell'attenzione con maschera:**

$$
\mathbf{A}_{\text{norm}} = \text{Softmax}(\mathbf{A}_{\text{masked}})
$$

### Reverse Cyclic Shift

Dopo l'attenzione, lo shift viene invertito:

$$
\mathbf{X}_{\text{unshifted}} = \text{roll}(\mathbf{X}_{\text{out}}, \text{shifts}=(3, 3), \text{dims}=(1, 2))
$$

L'output ha la stessa forma dell'input:

$$
\mathbf{X}_{\text{unshifted}} \in \mathbb{R}^{B \times 3136 \times 96}
$$

## Patch Merging

Alla fine di ogni stage (eccetto l'ultimo), un layer di **Patch Merging** riduce la risoluzione spaziale e aumenta il numero di canali.

### Downsampling Stage 1 → Stage 2

**Input:**

$$
\mathbf{X}_1 \in \mathbb{R}^{B \times 3136 \times 96}
$$

**Reshape spaziale:**

$$
\mathbf{X}_1 \rightarrow \mathbb{R}^{B \times 56 \times 56 \times 96}
$$

**Sampling 2×2:**

L'immagine viene campionata prendendo pixel alternati per creare 4 sottoimmagini:

$$
\mathbf{X}_0 = \mathbf{X}_1[:, 0::2, 0::2, :] \in \mathbb{R}^{B \times 28 \times 28 \times 96}
$$

$$
\mathbf{X}_1 = \mathbf{X}_1[:, 1::2, 0::2, :] \in \mathbb{R}^{B \times 28 \times 28 \times 96}
$$

$$
\mathbf{X}_2 = \mathbf{X}_1[:, 0::2, 1::2, :] \in \mathbb{R}^{B \times 28 \times 28 \times 96}
$$

$$
\mathbf{X}_3 = \mathbf{X}_1[:, 1::2, 1::2, :] \in \mathbb{R}^{B \times 28 \times 28 \times 96}
$$

**Concatenazione:**

$$
\mathbf{X}_{\text{concat}} = \text{Concat}([\mathbf{X}_0, \mathbf{X}_1, \mathbf{X}_2, \mathbf{X}_3], \text{dim}=-1)
$$

$$
\mathbf{X}_{\text{concat}} \in \mathbb{R}^{B \times 28 \times 28 \times 384}
$$

**Flatten:**

$$
\mathbf{X}_{\text{concat}} \rightarrow \mathbb{R}^{B \times 784 \times 384}
$$

**Layer Norm:**

$$
\mathbf{X}_{\text{norm}} = \text{LayerNorm}(\mathbf{X}_{\text{concat}})
$$

**Proiezione lineare:**

$$
\mathbf{X}_2 = \mathbf{X}_{\text{norm}} \mathbf{W}_{\text{reduction}}
$$

dove $\mathbf{W}_{\text{reduction}} \in \mathbb{R}^{384 \times 192}$

**Output:**

$$
\mathbf{X}_2 \in \mathbb{R}^{B \times 784 \times 192}
$$

Ora abbiamo:
- Risoluzione: $28 \times 28$ (dimezzata)
- Canali: $192$ (raddoppiati)
- Token: $784 = 28 \times 28$

## Stage 2: Secondo Livello della Gerarchia

### Parametri Stage 2

- Risoluzione: $H_2 \times W_2 = 28 \times 28$
- Canali: $C_2 = 192$
- Numero di blocchi: $\text{depth}_2 = 2$
- Numero di head: $\text{heads}_2 = 6$
- Dimensione finestra: $M = 7$

### Calcoli

**Numero di finestre:**

$$
\text{num\_windows} = \frac{28}{7} \times \frac{28}{7} = 4 \times 4 = 16
$$

**Dimensione per head:**

$$
d_h = \frac{192}{6} = 32
$$

Il processing è identico allo Stage 1, ma con dimensioni diverse. Ogni finestra contiene ancora $7 \times 7 = 49$ patch.

## Stage 3: Terzo Livello della Gerarchia

### Patch Merging Stage 2 → Stage 3

**Input:**

$$
\mathbf{X}_2 \in \mathbb{R}^{B \times 784 \times 192}
$$

Dopo patch merging:

$$
\mathbf{X}_3 \in \mathbb{R}^{B \times 196 \times 384}
$$

dove $196 = 14 \times 14$

### Parametri Stage 3

- Risoluzione: $H_3 \times W_3 = 14 \times 14$
- Canali: $C_3 = 384$
- Numero di blocchi: $\text{depth}_3 = 6$
- Numero di head: $\text{heads}_3 = 12$
- Dimensione finestra: $M = 7$

**Numero di finestre:**

$$
\text{num\_windows} = \frac{14}{7} \times \frac{14}{7} = 2 \times 2 = 4
$$

**Dimensione per head:**

$$
d_h = \frac{384}{12} = 32
$$

## Stage 4: Quarto Livello della Gerarchia

### Patch Merging Stage 3 → Stage 4

**Input:**

$$
\mathbf{X}_3 \in \mathbb{R}^{B \times 196 \times 384}
$$

Dopo patch merging:

$$
\mathbf{X}_4 \in \mathbb{R}^{B \times 49 \times 768}
$$

dove $49 = 7 \times 7$

### Parametri Stage 4

- Risoluzione: $H_4 \times W_4 = 7 \times 7$
- Canali: $C_4 = 768$
- Numero di blocchi: $\text{depth}_4 = 2$
- Numero di head: $\text{heads}_4 = 24$
- Dimensione finestra: $M = 7$

**Numero di finestre:**

$$
\text{num\_windows} = \frac{7}{7} \times \frac{7}{7} = 1 \times 1 = 1
$$

Con una sola finestra, W-MSA e SW-MSA sono equivalenti (non c'è shifting).

**Dimensione per head:**

$$
d_h = \frac{768}{24} = 32
$$

## Classification Head

Dopo tutti gli stage, l'output viene processato per la classificazione.

### Layer Norm Finale

$$
\mathbf{X}_{\text{norm}} = \text{LayerNorm}(\mathbf{X}_4)
$$

$$
\mathbf{X}_{\text{norm}} \in \mathbb{R}^{B \times 49 \times 768}
$$

### Global Average Pooling

$$
\mathbf{X}_{\text{pool}} = \text{AvgPool}(\mathbf{X}_{\text{norm}}^T)
$$

Trasponendo: $\mathbf{X}_{\text{norm}}^T \in \mathbb{R}^{B \times 768 \times 49}$

Dopo pooling:

$$
\mathbf{X}_{\text{pool}} \in \mathbb{R}^{B \times 768 \times 1} \rightarrow \mathbb{R}^{B \times 768}
$$

### Linear Classifier

$$
\mathbf{y} = \mathbf{X}_{\text{pool}} \mathbf{W}_{\text{head}} + \mathbf{b}_{\text{head}}
$$

dove:
- $\mathbf{W}_{\text{head}} \in \mathbb{R}^{768 \times K}$
- $K$ = numero di classi (es. 1000 per ImageNet)

**Output finale:**

$$
\mathbf{y} \in \mathbb{R}^{B \times K}
$$

Questo vettore contiene i logit per ogni classe.

## Riepilogo delle Dimensioni

| Stage | Risoluzione | Canali | Token | Blocchi | Head | Head Dim |
|-------|-------------|--------|-------|---------|------|----------|
| Input | 224×224 | 3 | - | - | - | - |
| Embed | 56×56 | 96 | 3136 | - | - | - |
| 1 | 56×56 | 96 | 3136 | 2 | 3 | 32 |
| 2 | 28×28 | 192 | 784 | 2 | 6 | 32 |
| 3 | 14×14 | 384 | 196 | 6 | 12 | 32 |
| 4 | 7×7 | 768 | 49 | 2 | 24 | 32 |
| Output | - | 768 | 1 | - | - | - |
| Logits | - | K | - | - | - | - |

## Complessità Computazionale

### Self-Attention Standard (Global)

Per $N$ token con dimensione $C$:

$$
\text{Complexity}_{\text{global}} = O(N^2 \cdot C)
$$

Per Stage 1 con $N = 3136$:

$$
\text{Complexity}_{\text{global}} = O(3136^2 \cdot 96) \approx O(9.4 \times 10^8)
$$

### Window-based Self-Attention

Con finestre di dimensione $M \times M$:

$$
\text{Complexity}_{\text{window}} = O\left(\frac{N}{M^2} \cdot (M^2)^2 \cdot C\right) = O(N \cdot M^2 \cdot C)
$$

Per Stage 1 con $M = 7$:

$$
\text{Complexity}_{\text{window}} = O(3136 \cdot 49 \cdot 96) \approx O(1.5 \times 10^7)
$$

**Riduzione della complessità:**

$$
\text{Speedup} = \frac{N^2 \cdot C}{N \cdot M^2 \cdot C} = \frac{N}{M^2} = \frac{3136}{49} = 64\times
$$

La window-based attention è **64 volte più efficiente** per lo Stage 1!

## Swin Transformer V2: Miglioramenti e Differenze

Swin Transformer V2 introduce diverse modifiche per migliorare stabilità, scalabilità e prestazioni.

### 1. Scaled Cosine Attention

**Swin V1** usa dot-product attention standard:

$$
\mathbf{A} = \frac{\mathbf{Q} \mathbf{K}^T}{\sqrt{d_h}}
$$

**Swin V2** usa cosine attention con temperatura apprendibile:

$$
\mathbf{A} = \tau \cdot \frac{\mathbf{Q}_{\text{norm}} \mathbf{K}_{\text{norm}}^T}{\|\mathbf{Q}_{\text{norm}}\| \|\mathbf{K}_{\text{norm}}\|}
$$

dove:
- Normalizzazione: $\mathbf{Q}_{\text{norm}} = \frac{\mathbf{Q}}{\|\mathbf{Q}\|_2}$, $\mathbf{K}_{\text{norm}} = \frac{\mathbf{K}}{\|\mathbf{K}\|_2}$
- $\tau = \log(\text{scale})$ è un parametro apprendibile per head
- $\text{scale}$ è limitato: $\text{scale} \leq \frac{1}{0.01} = 100$

**Vantaggi:**
- Maggiore stabilità durante il training
- Gradiente più uniforme
- Migliore convergenza per modelli grandi

### 2. Continuous Relative Position Bias

**Swin V1** usa una tabella discreta:

$$
\mathbf{B} \in \mathbb{R}^{(2M-1) \times (2M-1) \times h}
$$

**Swin V2** usa una **MLP continua** per generare i bias:

$$
\mathbf{B} = \text{MLP}(\Delta \mathbf{p})
$$

dove $\Delta \mathbf{p}$ sono le coordinate relative normalizzate.

**Architettura MLP:**

$$
\mathbf{B} = \mathbf{W}_2 \cdot \text{ReLU}(\mathbf{W}_1 \cdot \Delta \mathbf{p} + \mathbf{b}_1)
$$

con:
- $\mathbf{W}_1 \in \mathbb{R}^{512 \times 2}$ (proietta coordinate 2D a 512 dim)
- $\mathbf{W}_2 \in \mathbb{R}^{h \times 512}$ (proietta a numero di head)

**Normalizzazione delle coordinate:**

$$
\Delta p_x = \frac{i - j}{M - 1}, \quad \Delta p_y = \frac{k - l}{M - 1}
$$

Trasformazione log:

$$
\Delta \hat{p} = \text{sign}(\Delta p) \cdot \log_2(|\Delta p| + 1) / \log_2(8)
$$

Questa trasformazione mappa le coordinate in $[-1, 1]$ con maggiore risoluzione vicino allo zero.

**Post-processing del bias:**

$
\mathbf{B}_{\text{final}} = 16 \cdot \sigma(\mathbf{B})
$

dove $\sigma$ è la funzione sigmoid. Questo scala i bias in un range controllato $[0, 16]$.

**Vantaggi:**
- Transferibilità tra diverse risoluzioni di finestra
- Interpolazione continua delle posizioni
- Migliore generalizzazione

### 3. Log-spaced Continuous Position Bias

Le coordinate relative vengono trasformate in scala logaritmica prima di essere processate dalla MLP:

$
\hat{x} = \text{sign}(x) \cdot \log(1 + |x|) / \log(8)
$

Questo permette una rappresentazione più uniforme di distanze diverse.

### 4. Rimozione della Normalizzazione Pre-Attenzione

**Swin V1:**

$
\mathbf{X}_{\text{attn}} = \mathbf{X} + \text{Attn}(\text{LN}(\mathbf{X}))
$

$
\mathbf{X}_{\text{out}} = \mathbf{X}_{\text{attn}} + \text{MLP}(\text{LN}(\mathbf{X}_{\text{attn}}))
$

**Swin V2:** usa post-normalization per migliorare la stabilità

$
\mathbf{X}_{\text{attn}} = \text{LN}(\mathbf{X} + \text{Attn}(\mathbf{X}))
$

$
\mathbf{X}_{\text{out}} = \text{LN}(\mathbf{X}_{\text{attn}} + \text{MLP}(\mathbf{X}_{\text{attn}}))
$

Tuttavia, guardando il codice fornito, Swin V2 mantiene ancora la pre-normalization ma con alcune modifiche ai parametri di inizializzazione.

### 5. Scaled Cosine Attention - Dettagli Implementativi

**Query e Key Bias:**

In Swin V2, il QKV bias viene modificato:

$
\text{qkv\_bias} = [\mathbf{q}_{\text{bias}}, \mathbf{0}, \mathbf{v}_{\text{bias}}]
$

Il bias per le key è zero, mentre query e value hanno bias apprendibili.

**Calcolo attention:**

$
\mathbf{A} = \text{normalize}(\mathbf{Q}) \cdot \text{normalize}(\mathbf{K})^T
$

dove la normalizzazione è:

$
\text{normalize}(\mathbf{X}) = \frac{\mathbf{X}}{\|\mathbf{X}\|_2 + \epsilon}
$

**Scaling con temperatura:**

$
\tau = \exp(\log(\text{scale}))
$

con $\text{scale}$ limitato a $\max = \log(1/0.01) = \log(100) \approx 4.6$

$
\mathbf{A}_{\text{scaled}} = \tau \cdot \mathbf{A}
$

### 6. Modifiche al Patch Merging

**Swin V1:**

$
\text{Norm} \rightarrow \text{Linear}
$

**Swin V2:**

$
\text{Linear} \rightarrow \text{Norm}
$

L'ordine è invertito:

$
\mathbf{X}_{\text{reduced}} = \mathbf{W}_{\text{reduction}} \cdot \mathbf{X}_{\text{concat}}
$

$
\mathbf{X}_{\text{out}} = \text{LayerNorm}(\mathbf{X}_{\text{reduced}})
$

## Fused Window Process: Ottimizzazione

Il codice fornito mostra una implementazione ottimizzata delle operazioni di window partition e cyclic shift.

### Standard Implementation

**Roll + Window Partition (Python):**

```python
shifted_x = torch.roll(x, shifts=(-shift_size, -shift_size), dims=(1, 2))
x_windows = window_partition(shifted_x, window_size)
```

Questo richiede due operazioni separate:
1. Cyclic shift (roll)
2. Window partition (reshape + permute)

### Fused Implementation

Il kernel fuso combina entrambe le operazioni in un'unica operazione CUDA ottimizzata:

```python
x_windows = WindowProcess.apply(x, B, H, W, C, -shift_size, window_size)
```

**Forward Pass:**

$
\mathbf{X} \in \mathbb{R}^{B \times H \times W \times C} \xrightarrow{\text{fused}} \mathbf{X}_{\text{windows}} \in \mathbb{R}^{(B \cdot n_w) \times M \times M \times C}
$

in un'unica operazione kernel.

**Vantaggi:**
- Riduzione accessi alla memoria
- Eliminazione di tensori intermedi
- Migliore utilizzo della cache
- Speedup 2-3× rispetto all'implementazione standard

### Reverse Process

Analogamente per l'operazione inversa:

```python
x = WindowProcessReverse.apply(attn_windows, B, H, W, C, shift_size, window_size)
```

Combina:
1. Window merge
2. Reverse cyclic shift

$
\mathbf{X}_{\text{windows}} \in \mathbb{R}^{(B \cdot n_w) \times M \times M \times C} \xrightarrow{\text{fused}} \mathbf{X} \in \mathbb{R}^{B \times H \times W \times C}
$

## Training Details

### Loss Function

Per classificazione con $K$ classi:

$
\mathcal{L} = -\frac{1}{B} \sum_{i=1}^{B} \sum_{k=1}^{K} y_{ik} \log(\text{softmax}(\hat{y}_{ik}))
$

Con label smoothing ($\alpha = 0.1$):

$
y'_{ik} = (1 - \alpha) \cdot y_{ik} + \frac{\alpha}{K}
$

$
\mathcal{L}_{\text{smooth}} = -\frac{1}{B} \sum_{i=1}^{B} \sum_{k=1}^{K} y'_{ik} \log(\text{softmax}(\hat{y}_{ik}))
$

### Data Augmentation

**Mixup:** combina due immagini

$
\tilde{\mathbf{x}} = \lambda \mathbf{x}_i + (1 - \lambda) \mathbf{x}_j
$

$
\tilde{\mathbf{y}} = \lambda \mathbf{y}_i + (1 - \lambda) \mathbf{y}_j
$

dove $\lambda \sim \text{Beta}(\alpha_{\text{mixup}}, \alpha_{\text{mixup}})$ con $\alpha_{\text{mixup}} = 0.8$

**CutMix:** sostituisce una regione dell'immagine

$
\mathbf{M} \in \{0, 1\}^{H \times W}
$

$
\tilde{\mathbf{x}} = \mathbf{M} \odot \mathbf{x}_i + (1 - \mathbf{M}) \odot \mathbf{x}_j
$

### Optimizer

**AdamW** con:
- Learning rate base: $\eta_{\text{base}} = 5 \times 10^{-4}$
- Weight decay: $\lambda = 0.05$
- $\beta_1 = 0.9$, $\beta_2 = 0.999$
- $\epsilon = 10^{-8}$

**Linear scaling rule:**

$
\eta = \eta_{\text{base}} \times \frac{B \times N_{\text{gpu}}}{512}
$

### Learning Rate Schedule

**Cosine decay** con warmup:

**Warmup phase** (primi 20 epochs):

$
\eta(t) = \eta_{\text{warmup}} + \frac{\eta - \eta_{\text{warmup}}}{T_{\text{warmup}}} \cdot t
$

dove $\eta_{\text{warmup}} = 5 \times 10^{-7}$

**Cosine decay phase:**

$
\eta(t) = \eta_{\text{min}} + \frac{\eta - \eta_{\text{min}}}{2} \left(1 + \cos\left(\frac{t - T_{\text{warmup}}}{T_{\text{max}} - T_{\text{warmup}}} \pi\right)\right)
$

dove $\eta_{\text{min}} = 5 \times 10^{-6}$, $T_{\text{max}} = 300$ epochs

### Stochastic Depth

**Drop path** con probabilità crescente per layer profondi:

$
p_l = p_{\text{max}} \cdot \frac{l}{L}
$

dove:
- $p_{\text{max}} = 0.1$ (drop path rate massimo)
- $l$ = indice del layer
- $L$ = numero totale di layer

**Applicazione:**

$
\mathbf{X}_{\text{out}} = \mathbf{X} + \text{Bernoulli}(1 - p_l) \cdot \frac{\text{Layer}(\mathbf{X})}{1 - p_l}
$

## Varianti di Swin Transformer

### Swin-T (Tiny)

| Parametro | Valore |
|-----------|--------|
| Embed dim | 96 |
| Depths | [2, 2, 6, 2] |
| Num heads | [3, 6, 12, 24] |
| Window size | 7 |
| Parametri | ~29M |

### Swin-S (Small)

| Parametro | Valore |
|-----------|--------|
| Embed dim | 96 |
| Depths | [2, 2, 18, 2] |
| Num heads | [3, 6, 12, 24] |
| Window size | 7 |
| Parametri | ~50M |

### Swin-B (Base)

| Parametro | Valore |
|-----------|--------|
| Embed dim | 128 |
| Depths | [2, 2, 18, 2] |
| Num heads | [4, 8, 16, 32] |
| Window size | 7 |
| Parametri | ~88M |

### Swin-L (Large)

| Parametro | Valore |
|-----------|--------|
| Embed dim | 192 |
| Depths | [2, 2, 18, 2] |
| Num heads | [6, 12, 24, 48] |
| Window size | 7 |
| Parametri | ~197M |

## Applicazioni

### Image Classification

Output diretto dal classification head:

$
\mathbf{y} \in \mathbb{R}^{B \times K}
$

### Object Detection

Swin Transformer può essere usato come backbone in framework come:
- **Mask R-CNN**
- **Cascade Mask R-CNN**
- **HTC** (Hybrid Task Cascade)

Le feature maps dei diversi stage vengono usate:

$
\{\mathbf{F}_1, \mathbf{F}_2, \mathbf{F}_3, \mathbf{F}_4\}
$

con risoluzioni:

$
\left\{\frac{H}{4} \times \frac{W}{4}, \frac{H}{8} \times \frac{W}{8}, \frac{H}{16} \times \frac{W}{16}, \frac{H}{32} \times \frac{W}{32}\right\}
$

### Semantic Segmentation

Usato in **UperNet** per segmentazione:

Le feature gerarchiche vengono combinate con:
- **FPN** (Feature Pyramid Network)
- **PPM** (Pyramid Pooling Module)

Output finale:

$
\mathbf{S} \in \mathbb{R}^{B \times K_{\text{seg}} \times H \times W}
$

dove $K_{\text{seg}}$ è il numero di classi di segmentazione.

## Vantaggi di Swin Transformer

### 1. Efficienza Computazionale

La window-based attention riduce la complessità da quadratica a lineare rispetto alla risoluzione:

$
O(N^2) \rightarrow O(N)
$

### 2. Hierarchical Representation

Come le CNN, Swin costruisce rappresentazioni gerarchiche che sono utili per task dense come detection e segmentation.

### 3. Flessibilità

Può processare immagini di diverse dimensioni (con alcuni aggiustamenti) grazie alla struttura a finestre.

### 4. State-of-the-Art Performance

Su ImageNet-1K:
- Swin-B: 83.5% top-1 accuracy
- Swin-L: 84.5% top-1 accuracy

Su COCO object detection:
- Swin-L: 58.7 box AP (Cascade Mask R-CNN)

## Limitazioni e Considerazioni

### 1. Window Size Trade-off

- Window piccole: meno recettività globale, più efficienza
- Window grandi: maggiore recettività, meno efficienza

Il valore $M = 7$ è un compromesso empirico.

### 2. Shifted Windows Overhead

Lo shift ciclico e il mascheramento aggiungono overhead computazionale, anche se recuperato dall'efficienza locale.

### 3. Memory Requirements

Nonostante l'efficienza, i modelli grandi (Swin-L) richiedono ancora molta memoria:

$
\text{Memory} \propto B \cdot H \cdot W \cdot C \cdot L
$

### 4. Fixed Window Size

Il window size fisso può non essere ottimale per tutte le scale di oggetti nell'immagine.

## Conclusioni

Swin Transformer rappresenta un breakthrough nell'applicazione dei Transformer alla computer vision, combinando:

1. **Efficienza** delle window-based attention
2. **Flessibilità** delle shifted windows per catturare dipendenze cross-window
3. **Struttura gerarchica** simile alle CNN per task multi-scala
4. **Performance state-of-the-art** su molteplici benchmark

Le dimensioni dei tensori attraverso la rete mostrano una progressione logica:

$
\mathbb{R}^{B \times 3 \times 224 \times 224} \rightarrow \mathbb{R}^{B \times 3136 \times 96} \rightarrow \mathbb{R}^{B \times 784 \times 192} \rightarrow \mathbb{R}^{B \times 196 \times 384} \rightarrow \mathbb{R}^{B \times 49 \times 768} \rightarrow \mathbb{R}^{B \times K}
$

Ogni transizione dimezza la risoluzione spaziale e raddoppia i canali, creando rappresentazioni sempre più astratte e semantiche dell'input, mentre la window-based attention mantiene la complessità computazionale gestibile anche ad alte risoluzioni.