# Regressione Lineare

La **Regressione Lineare** è un modello statistico utilizzato per descrivere la relazione tra una variabile dipendente (target) e una o più variabili indipendenti (predittori). Assume una relazione lineare tra le variabili e minimizza l'errore quadratico medio. Quindi la regressione lineare studia la dipendenza in media tra fenomeni, cercando una funzione che esprima tale dipendenza in modo lineare.

## **1. Formulazione Generale**
Assumiamo di avere un dataset $\mathcal{D} = \{(x_i, y_i)\}_{i=1}^n$, dove $x_i \in \mathbb R$ sono le variabili indipendenti e $y_i \in \mathbb R$ la variabile dipendente.
Un modello di regressione lineare ha la forma:

$$
y_i = f(\mathbf{x}_i) + \epsilon_i = \mathbf{x}_i^T \mathbf{w} + \epsilon_i = 1 \cdot w_0 + x_iw_1 + \epsilon_i
$$

Dove:

- $y_i \in \mathbb R$ è la variabile target,
- $\mathbf{x}_i = \begin{bmatrix} 1 \\ x_i \end{bmatrix}$, dove gli $x_i$ sono le variabili indipendenti (features),
- $\mathbf{w} = \begin{bmatrix} w_0 \\ w_1 \end{bmatrix} \in \mathbb R^2$ sono i coefficienti del modello (parametri da stimare),
  - $w_0$ è l'intercetta, che rappresenta il valore previsto di $y$ quando $x = 0$,
  - $w_1$ rappresenta la pendenza, che rappresenta quanto $y$ cresce per ogni unita di aumento di $x$.
- $1$ è il cosi detto bias,
- $\epsilon_i$ è l'errore (rumore) che segue una [[Distribuzione Normale|distribuzione normale]] $\mathcal{N}(0, \sigma^2)$.

---

### Approfondimento sul rumore

Il termine $\epsilon_i$ incapsula **tutte** le fonti di variabilità non spiegate dal modello: rumore di misura, fattori non osservati, approssimazioni del modello, ecc. L'ipotesi sulla distribuzione di $\epsilon_i$ è quindi l'ipotesi fondamentale che determina sia la funzione di verosimiglianza sia le proprietà inferenziali.

Se il rumore osservato è il risultato della **somma di molti piccoli contributi indipendenti** (errori di misura multipli, micro‑fluttuazioni, componenti di variabili non modellate), il **Teorema del Limite Centrale** (CLT) dice che la somma (appropriatamente normalizzata) tende in distribuzione a una normale.

Quindi, dal punto di vista modellistico, **assumere $\epsilon_i$ normale è spesso una buona approssimazione naturale**. Per la dimostrazione formale e le condizioni precise (Lindeberg, Lindeberg–Feller, indipendenza, varianze finite, ecc.) vedi la nota **[[Teorema del Limite Centrale]]**.

**Nota sui limiti del CLT:** il CLT richiede (in qualche forma) che i contributi abbiano varianza finita e che non ci siano dipendenze troppo forti; in presenza di code pesanti con varianza infinita (es. alcune leggi di potenza) o di forti dipendenze, il risultato può non essere la normale ma una legge stabile diversa (es. Lévy stable).

Un'altra giustificazione elegante è il **[[Principio di Massima Entropia]]**: tra tutte le distribuzioni con media e varianza fissate, quella che massimizza l'entropia è la normale. Pertanto la normale è la scelta “meno informativa” coerente con conoscere solo media e varianza del rumore.

---

Quindi possiamo riscrivere il modello in forma matriciale come:

$$
\mathbf{y} = \mathbf{X} \mathbf{w} + \mathbf{\epsilon}
$$

Dove:

- $\mathbf{y}$è il vettore delle variabili dipendenti $n \times 1$,
- $\mathbf{X} = \begin{bmatrix} 1 & x_1 \\ 1 & x_2 \\ \vdots & \vdots \\ 1 & x_n \end{bmatrix}$è la matrice delle variabili indipendenti $n \times 2$,
- $\mathbf{w}$è il vettore dei parametri $2 \times 1$,
- $\mathbf{\epsilon}$ è il vettore degli errori $n \times 1$.
  
Nel caso più generale (**regressione multipla**), considerando il dataset diventa $\mathcal{D} = \{(\mathbf{x}_i, y_i)\}_{i=1}^n$. In questo caso, la formula vettoriale diventa:

$$
y_i = \mathbf{x}_i^T \mathbf{w} + \mathbf{\epsilon}_i
$$

In forma matriciale:

$$
\mathbf{y} = \mathbf{X} \mathbf{w} + \mathbf{\epsilon}
$$

Dove:

- $\mathbf{y}$è il vettore delle variabili dipendenti $n \times 1$,
$$
\mathbf{X} = \begin{bmatrix}
1 & \text{------} \mathbf{x}_1^T \text{------} \\
1 & \text{------} \mathbf{x}_2^T \text{------} \\
\vdots & \vdots \\
1 & \text{------} \mathbf{x}_n^T \text{------}
\end{bmatrix}
$$ 
è la matrice dei dati con dimensioni $n \times (m+1)$, dove $m$ sono le variabili indipendenti.
- $\mathbf{w} = \begin{bmatrix} w_0 \\ w_1 \\ \vdots \\ w_m \end{bmatrix} \in \mathbb R^{m+1}$ sono i coefficienti del modello (parametri da stimare),
- $\boldsymbol{\epsilon} = \begin{bmatrix} \epsilon_1 \\ \epsilon_2 \\ \vdots \\ \epsilon_n \end{bmatrix} \in \mathbb R^n$ sono i rumori (errore) che seguono una distribuzione normale $\mathcal{N}(0, \sigma^2)$.

Nel caso **multivariato**, il dataset diventa $\mathcal{D} = \{(\mathbf{x}_i, \mathbf y_i)\}_{i=1}^n$, dove $\mathbf x_i \in \mathbb R^m$ sono i vettori di variabili indipendenti e $\mathbf y_i \in \mathbb R^p$ i vettori di variabili dipendenti. In questo caso, la formula vettoriale diventa:

$$
\mathbf{y}_i = \mathbf{x}_i^T \mathbf{W} + \mathbf{\large \epsilon}_i
$$

Volendo quindi rappresentare il nostro modello di regressione lineare in forma matriciale (considerando l'intero dataset), possiamo definire:

$$
\underbrace{\begin{bmatrix}
\text{------} \mathbf{y}_1^\top \text{------} \\
\text{------} \mathbf{y}_2^\top \text{------} \\
\vdots \\
\text{------} \mathbf{y}_n^\top \text{------}
\end{bmatrix}}_{\large \mathbf{Y}}
=
\underbrace{\begin{bmatrix}
1 \ |\text{------} \mathbf{x}_1^\top \text{------}\\
1 \ |\text{------} \mathbf{x}_2^\top \text{------}\\
\vdots \\
1 \ |\text{------} \mathbf{x}_n^\top \text{------}
\end{bmatrix}}_{\large \mathbf{X}}
\underbrace{\begin{bmatrix}
| & | &  & | \\
\mathbf{w}_1 & \mathbf{w}_2 & \dots & \mathbf{w}_p \\
| & | &  & | 
\end{bmatrix}}_{\large \mathbf{W}}
+ 
\underbrace{\begin{bmatrix}
\text{------} \boldsymbol{\epsilon}_1^\top \text{------} \\
\text{------} \boldsymbol{\epsilon}_2^\top \text{------} \\
\vdots \\
\text{------} \boldsymbol{\epsilon}_n^\top \text{------}
\end{bmatrix}}_{\large{\boldsymbol \epsilon}}
$$

Dove:
- $\mathbf{Y}$ è la matrice delle variabili dipendenti $n \times p$,
- $\mathbf{X}$ è la matrice delle variabili indipendenti $n \times (m+1)$,
- $\mathbf{W}$ è la matrice dei coefficienti $(m+1) \times p$, e $\mathbf w_i = \begin{bmatrix} w_{0,i} \\ w_{1,i} \\ \vdots \\ w_{m,i} \end{bmatrix}$ con $i \in [p]$,
- $\large{\boldsymbol \epsilon}$ è la matrice degli errori $n \times p$, e $\boldsymbol{\epsilon}_i \sim \mathcal{N}(\mathbf{0}, \sigma^2 \mathbf{I})$ con $i \in [p]$.

## **2. Assunzioni della Regressione Lineare**

1. **Linearità**: La relazione tra le variabili indipendenti e la variabile dipendente è lineare. Quindi $\mathbf y$ si può scrivere come una combinazione lineare delle variabili indipendenti $\mathbf x$ e degli errori: $\mathbf y = \mathbf x^T \mathbf w + \large{\mathbf \epsilon}$.
2. **Indipendenza e Normalità**: Gli errori $\epsilon_i$ sono indipendenti tra loro e seguono una distribuzione normale $\epsilon_i \sim\mathcal{N}(0, \sigma^2)$. Questo implica che le variabili dipendenti sono distribuite normalmente con:
    - Media: $\mathbb E[\mathbf y | \mathbf x] = f(\mathbf x) = \mathbf x^T \mathbf w$.
      - **Proof:**
        $\mathbb E[\mathbf y | \mathbf  x] = \mathbb E[f(\mathbf x) + \epsilon | \mathbf x] = \underbrace{\mathbb E[f(\mathbf x)|\mathbf x]}_\text{Una volta fissato x, f(x) è deterministico, quindi = f(x)} + \underbrace{\mathbb E[\epsilon |\mathbf x]}_\text{epsilon non dipende da x, quindi = 0} = f(\mathbf x) + 0 = f(\mathbf x). \ \square$
    - Varianza: $\mathbb V[\mathbf y | \mathbf x] = \sigma^2$
      - **Proof:** $\mathbb V[\mathbf y | \mathbf x] = \mathbb V[f(\mathbf x) + \epsilon | \mathbf x] = \underbrace{\mathbb V[f(\mathbf x)|\mathbf x]}_\text{f(x) è una costante, quindi = 0} + \mathbb V[\epsilon |\mathbf x] + 2 \cdot \underbrace{\mathbb Cov[\underbrace{f(\mathbf x)}_\text{è costante dato x}, \epsilon | \mathbf x]}_\text{=0} = 0 + \sigma^2 + 0 = \sigma^2. \ \square$
  
   Da questo si ottiene che:
   $$
   y_i | \mathbf x_i, \mathbf w \sim \mathcal{N}(f(\mathbf x_i), \sigma^2).
   $$
3. **Assenza di multicollinearità**: Le variabili indipendenti non devono essere linearmente dipendenti tra loro.  
   - Se esiste una relazione lineare tra alcune colonne della matrice **$\mathbf{X}$**, allora la matrice $\mathbf{X}^T \mathbf{X}$ diventa **singolare** (cioè non invertibile). Questo è problematico perché nella stima dei parametri con il metodo dei minimi quadrati ordinari (OLS), l'espressione  
     $$
     \mathbf{w} = (\mathbf{X}^T \mathbf{X})^{-1} \mathbf{X}^T \mathbf{y}
     $$
     richiede che $(\mathbf{X}^T \mathbf{X})^{-1}$ esista, il che non è possibile se $\mathbf{X}^T \mathbf{X}$ è singolare.
  In [[Multicollinearità|questa]] nota viene approfondito il problema della multicollinearità.
   - Per risolvere la multicollinearità si possono adottare strategie come:
     - Rimuovere una delle variabili altamente correlate.
     - Utilizzare metodi di regressione penalizzata come **Ridge Regression** o **Lasso**.
     - Applicare una **PCA (Principal Component Analysis)** per trasformare le variabili indipendenti in nuove variabili non correlate.

Le assunzioni della regressione lineare sono importanti per garantire la robustezza del modello e la sua applicabilita in situazioni reali.

## **3. Stima dei Parametri**

La stima dei coefficienti $\mathbf{w}$ nella regressione lineare è basata sulla minimizzazione dell'errore quadratico medio (**MSE - Mean Squared Error**), che deriva direttamente dal principio della **massima verosimiglianza** sotto l'assunzione di rumore gaussiano.

### **3.1. Assunzione di Rumore Gaussiano**
Si assume che il rumore $\epsilon_i$ in ogni osservazione sia distribuito secondo una **normale con media zero e varianza costante** $\sigma^2$:

$$
\epsilon_i \sim \mathcal{N}(0, \sigma^2)
$$

Quindi 

$$
p(\epsilon_i) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp \left( -\frac{\epsilon_i^2}{2\sigma^2} \right)
$$

e dato che $\epsilon = y_i - \mathbf{x}_i^\top \mathbf{w}$, sostituendo abbiamo:

$$
p(y_i \mid \mathbf{x}_i, \mathbf{w}) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp \left( -\frac{(y_i - \mathbf{x}_i^\top \mathbf{w})^2}{2\sigma^2} \right)
$$

Quindi, la distribuzione condizionale della variabile dipendente $y_i$, dato l'input $x_i$, è anch'essa gaussiana:

$$
y_i \mid \mathbf x_i, \mathbf{w} \sim \mathcal{N}(\mathbf{x}_i^\top \mathbf{w}, \sigma^2).
$$

### **3.2. Costruzione della Funzione di Verosimiglianza**
Dati $N$ esempi indipendenti $\{(\mathbf x_i, y_i)\}_{i=1}^{N}$, la **funzione di verosimiglianza** è il prodotto delle probabilità condizionali di tutte le osservazioni:

$$
L(\mathbf{w}) = \prod_{i=1}^{N} p(y_i \mid \mathbf x_i, \mathbf{w})
$$

Sostituendo la distribuzione gaussiana:

$$
L(\mathbf{w}) = \prod_{i=1}^{N} \frac{1}{\sqrt{2\pi\sigma^2}} \exp \left( -\frac{(y_i - \mathbf{x}_i^\top \mathbf{w})^2}{2\sigma^2} \right)
$$

### **3.3. Log-Verosimiglianza**
Per facilitare il calcolo, prendiamo il logaritmo della funzione di verosimiglianza (**log-likelihood**):

$$
\log L(\mathbf{w}) = \sum_{i=1}^{N} \log \left( \frac{1}{\sqrt{2\pi\sigma^2}} \exp \left( -\frac{(y_i - \mathbf{x}_i^\top \mathbf{w})^2}{2\sigma^2} \right) \right)
$$

Separando i termini:

$$
\log L(\mathbf{w}) = \sum_{i=1}^{N} \left[ -\frac{1}{2} \log (2\pi\sigma^2) - \frac{(y_i - \mathbf{x}_i^\top \mathbf{w})^2}{2\sigma^2} \right] = - \frac{N}{2} \log (2\pi\sigma^2) - \frac{1}{2\sigma^2} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2.
$$

Prendere il logaritmo della funzione di verosimiglianza non modifica il problema di ottimizzazione perché il logaritmo è una **funzione monotona crescente**. Questo significa che **massimizzare la verosimiglianza è equivalente a massimizzare la log-verosimiglianza**:

$$
\arg\max_{\mathbf{w}} L(\mathbf{w}) = \arg\max_{\mathbf{w}} \log L(\mathbf{w})
$$

I principali vantaggi del logaritmo sono:
1. **Trasforma il prodotto in somma**, semplificando i calcoli:
   $$
   \log L(\mathbf{w}) = \sum_{i=1}^{N} \log p(y_i \mid x_i, \mathbf{w})
   $$
2. **Evita problemi di precisione numerica**, riducendo il rischio di underflow quando $N$ è grande.
3. **Preserva la convessità della funzione obiettivo**, facilitando l'ottimizzazione.

In sintesi, la log-verosimiglianza è un'utile trasformazione che rende il problema di stima più semplice e numericamente stabile senza alterarne la soluzione

### **3.4. Stima dei Parametri con Massima Verosimiglianza**
Seguiamo ora questi passaggi: 
1. **Identificazione dei termini dipendenti da $\mathbf{w}$** 
	- Il primo termine, $-\frac{N}{2} \log (2\pi\sigma^2)$, **non dipende** da $\mathbf{w}$, quindi è una costante e può essere ignorato nell'ottimizzazione. 
2. **Massimizzazione della log-verosimiglianza equivale a minimizzare la penalità quadratica** 
	- Il secondo termine, $- \frac{1}{2\sigma^2} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2$, **dipende da $\mathbf{w}$** e deve essere massimizzato. 
	- Poiché questo termine è **negativo**, massimizzarlo significa **minimizzare** la somma dei quadrati degli errori: 
   $$ \min_{\mathbf{w}} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2 $$

   Che in notazione matriciale generale diventa:
   $$
   \min_{W} \|Y -XW\|^2_F
   $$
   Dove:

   - $Y$ è la matrice delle osservazioni $n \times p$
   - $X$ è la matrice dei regressori $n \times (m+1)$
   - $W$è la matrice dei coefficienti $(m+1) \times p$, e $w_i = \begin{bmatrix} w_{0,i} \\ w_{1,i} \\ \vdots \\ w_{m,i} \end{bmatrix}$ con $i \in [p]$

3. **Il fattore $2\sigma^2$ non influisce sull'argomento del minimo** 
	- Il termine è diviso per $2\sigma^2$, ma poiché la varianza $\sigma^2$ è una costante positiva, rimuoverlo **non cambia la posizione del minimo**. Quindi, il problema di **massima verosimiglianza** si riduce esattamente alla minimizzazione della somma dei quadrati degli errori, che è la funzione di costo dell'**errore quadratico medio (MSE)** nella regressione lineare.


Dividendo per $N$ otteniamo la funzione di costo **MSE** (**Mean Squared Error**):

$$
MSE = \frac{1}{N} \sum_{i=1}^{N} (y_i - \hat{y}_i)^2
$$

dove:

$$
\hat{y}_i = \mathbf{x}_i^\top \mathbf{w}
$$

è la previsione del modello. O equivalentemente:

$$
\hat{Y} = \mathbf{X} \mathbf{W}.
$$

Che in notazione matriciale generale diventa:

$$
MSE = \frac{1}{N} \|Y - \hat{Y}\|_F^2
$$

Quindi, **minimizzare il MSE è equivalente alla stima di massima verosimiglianza quando si assume rumore gaussiano con varianza costante**.

### **3.5. Metodi per Minimizzare la Funzione di Costo (MSE)**  

Poiché l’MSE deriva dalla **Massima Verosimiglianza (MLE)** sotto l’assunzione di rumore gaussiano, possiamo stimare i parametri della regressione lineare con diversi approcci:  

#### **1️⃣ Soluzione Analitica: Minimi Quadrati Ordinari (OLS - Ordinary Least Squares)**  
- Trova direttamente i coefficienti che minimizzano l’MSE.  
- La soluzione chiusa è:  
  $$
  \mathbf{w} = (\mathbf{X}^\top \mathbf{X})^{-1} \mathbf{X}^\top \mathbf{y}
  $$
- **Limiti:**  
  - Richiede l’inversione della matrice $(\mathbf{X}^\top \mathbf{X})$, che può essere numericamente instabile in presenza di **multicollinearità**.  
  - Non è scalabile per dataset molto grandi.  

#### **2️⃣ Approccio Bayesiano: Massima A Posteriori (MAP - Maximum A Posteriori)**  
- Estende MLE introducendo una **distribuzione a priori** sui parametri $\mathbf{w}$.  
- Se il prior è **gaussiano** $\mathcal{N}(0, \lambda I)$, si ottiene la **Regressione Ridge**.  

#### **3️⃣ Minimi Quadrati con [[Regolarizzazione]] (Ridge, Lasso, Elastic Net)**  
Aggiungono una penalizzazione ai coefficienti per migliorare la **stabilità** e il **controllo della complessità** del modello:  

✅ **Ridge Regression** (*L2-regularization*)  
  $$
  \min_{\mathbf{w}} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2 + \lambda ||\mathbf{w}||_2^2
  $$
  - Penalizza i coefficienti grandi, ma non li azzera.  
  - **Equivalente alla MAP con prior gaussiano.**  

✅ **Lasso Regression** (*L1-regularization*)  
  $$
  \min_{\mathbf{w}} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2 + \lambda ||\mathbf{w}||_1
  $$
  - Impone **sparsità**, azzerando alcuni coefficienti.  
  - Seleziona automaticamente le feature più importanti.  

✅ **Elastic Net** (*combinazione di Ridge e Lasso*)  
  $$
  \min_{\mathbf{w}} \sum_{i=1}^{N} (y_i - \mathbf{x}_i^\top \mathbf{w})^2 + \lambda_1 ||\mathbf{w}||_1 + \lambda_2 ||\mathbf{w}||_2^2
  $$
  - Unisce i vantaggi di Ridge e Lasso.  
  - Utile quando le feature sono **correlate tra loro**.  

#### **4️⃣ Soluzioni Iterative: Discesa del Gradiente (Gradient Descent)**
Metodo iterativo che aggiorna i coefficienti nella direzione del gradiente negativo:  
  $$
  \mathbf{w}^{(t+1)} = \mathbf{w}^{(t)} - \alpha \nabla MSE
  $$
- **Vantaggi:**  
  ✅ Scalabile su dataset di grandi dimensioni.  
  ✅ Utile quando $(\mathbf{X}^\top \mathbf{X})^{-1}$ è difficile da calcolare.

- **Varianti:**  
  🔹 *Batch Gradient Descent* (usa tutto il dataset a ogni iterazione).  
  🔹 *Stochastic Gradient Descent (SGD)* (aggiorna i pesi a ogni singolo campione).  
  🔹 *Mini-batch Gradient Descent* (compromesso tra batch e SGD).  

## **4. Interpretazione dei Coefficienti**

Nella regressione lineare, i coefficienti $\mathbf{w}$ rappresentano l'effetto che una variazione unitaria di una variabile indipendente ha sulla variabile dipendente, mantenendo le altre variabili costanti.

### **4.1. Significato dei Coefficienti**
Consideriamo il modello di regressione lineare semplice con una sola variabile indipendente:

$$
y = w_0 + w_1 x + \epsilon
$$

Dove:
- $w_0$ è **l'intercetta** (bias), che rappresenta il valore previsto di $y$ quando $x = 0$.
- $w_1$ è **il coefficiente angolare**, che misura la variazione di $y$ per una variazione unitaria di $x$.

Se $w_1 > 0$, significa che all'aumentare di $x$, anche $y$ tende ad aumentare (relazione positiva).  
Se $w_1 < 0$, significa che all'aumentare di $x$, $y$ tende a diminuire (relazione negativa).  

### **4.2. Interpretazione nella Regressione Multipla**
Nel caso della regressione multipla:

$$
y = w_0 + w_1 x_1 + w_2 x_2 + \dots + w_m x_m + \epsilon
$$

Ogni coefficiente $w_j$ indica l'effetto di una variazione unitaria di $x_j$ su $y$, **tenendo tutte le altre variabili costanti**.  

Esempio:
- Se $w_2 = 3$, significa che, **a parità di tutte le altre variabili**, un aumento di 1 unità in $x_2$ comporta un aumento medio di 3 unità in $y$.

### **4.3. Punteggio Standardizzato (Beta Coefficients)**
Nella regressione lineare multipla, i coefficienti standardizzati (noti anche come **Beta Coefficients**) permettono di confrontare l'importanza relativa delle variabili indipendenti eliminando l'effetto delle diverse unità di misura.  

Quando una regressione utilizza coefficienti **non standardizzati**, i valori ottenuti dipendono dalle unità di misura delle variabili. Ciò rende difficile confrontare l'influenza relativa di ciascuna variabile indipendente sulla variabile dipendente.  

Per risolvere questo problema, utilizziamo i **coefficienti standardizzati**, definiti dalla formula:  

$$
\beta_j = w_j \cdot \frac{\sigma_{x_j}}{\sigma_y}
$$

Dove:  
- $\beta_j$ è il coefficiente standardizzato della variabile $x_j$.  
- $w_j$ è il coefficiente non standardizzato ottenuto dalla regressione.  
- $\sigma_{x_j}$ è la deviazione standard della variabile indipendente $x_j$.  
- $\sigma_y$ è la deviazione standard della variabile dipendente $y$.  

#### **Interpretazione**  
I coefficienti standardizzati indicano **quanto cambia la variabile dipendente $y$, espressa in deviazioni standard**, a seguito di una variazione di **una deviazione standard** nella variabile indipendente $x_j$.  

In altre parole:  
- Se $\beta_j = 0.5$, significa che un aumento di una deviazione standard in $x_j$ comporta un aumento di **0.5 deviazioni standard** in $y$.  
- Se $\beta_j = -0.3$, significa che un aumento di una deviazione standard in $x_j$ comporta una **diminuzione di 0.3 deviazioni standard** in $y$.  

#### **Vantaggi dell'uso dei Coefficienti Standardizzati**  
- **Permettono di confrontare direttamente l'impatto delle variabili**: il valore assoluto di $\beta_j$ indica l'importanza relativa di $x_j$ rispetto alle altre variabili nel modello.  
- **Eliminano il problema delle diverse unità di misura**, rendendo il confronto più intuitivo.  
- **Facilitano l'interpretazione pratica** nei modelli con variabili di diversa scala (ad esempio, reddito in euro e età in anni).  

In sintesi, l'uso dei coefficienti standardizzati è utile per comprendere **quali variabili hanno un impatto maggiore sulla variabile dipendente** e per confrontare la loro influenza in maniera oggettiva. 

### **4.4. Intervalli di Confidenza**
Poiché i coefficienti sono stimati da un campione, è utile calcolare il loro intervallo di confidenza per capire la loro precisione.

L'intervallo di confidenza al **95%** per un coefficiente $w_j$ è:

$$
[w_j - t_{\alpha/2} \cdot SE(w_j), \quad w_j + t_{\alpha/2} \cdot SE(w_j)]
$$

Dove:
- $SE(w_j)$ è l'errore standard del coefficiente.
- $t_{\alpha/2}$ è il valore della distribuzione $t$ di Student con $(n - m - 1)$ gradi di libertà.

Se l'intervallo include **zero**, il coefficiente potrebbe non essere significativo.

### **4.5. p-value e Significatività Statistica**
Per valutare se un coefficiente è statisticamente significativo, si utilizza il **test t**:

$$
t_j = \frac{w_j}{SE(w_j)}
$$

Il **p-value** associato a $t_j$ indica la probabilità di osservare un valore così estremo sotto l'ipotesi nulla $H_0: w_j = 0$.

- Se $p < 0.05$, il coefficiente è **statisticamente significativo** al livello del 5%.
- Se $p > 0.05$, non abbiamo prove sufficienti per affermare che il coefficiente sia diverso da zero.

### **4.6. Multicollinearità e Interpretazione**
Se due o più variabili indipendenti sono fortemente correlate, si verifica **multicollinearità**, che rende difficile interpretare i coefficienti.  
Un alto **Variance Inflation Factor (VIF)** indica multicollinearità:

$$
VIF_j = \frac{1}{1 - R_j^2}
$$

Dove $R_j^2$ è il coefficiente di determinazione della regressione di $x_j$ sulle altre variabili indipendenti.

- Se $VIF > 10$, indica un problema di **multicollinearità elevata**.

Per mitigare la multicollinearità, si possono usare:
1. **Ridge Regression** o **Lasso Regression** (penalizzazione).
2. **Rimuovere variabili ridondanti**.
3. **Utilizzare la PCA (Principal Component Analysis)**.

### **Conclusione**
L'interpretazione corretta dei coefficienti è fondamentale per comprendere l'effetto delle variabili indipendenti su $y$. È importante considerare intervalli di confidenza, p-value e multicollinearità per trarre conclusioni valide dal modello.

## **5. Valutazione del Modello**  

Per determinare la qualità di un modello di regressione, utilizziamo diverse metriche e test statistici. Questi strumenti permettono di valutare **quanto bene il modello spiega la variabilità dei dati** e **se i coefficienti stimati sono statisticamente significativi**.  

### **5.1. Errore Quadratico Medio (MSE)**  
L'**Errore Quadratico Medio** (**Mean Squared Error**, MSE) misura l'accuratezza del modello calcolando la media dei quadrati degli errori di previsione.

- Un **MSE più basso** indica un modello con **migliore capacità predittiva**.  
- Poiché l'MSE è espresso nelle unità al quadrato di $y$, non è sempre intuitivo da interpretare. Per questo motivo, spesso si usa la **Radice dell'Errore Quadratico Medio** (**RMSE**):  

$$
RMSE = \sqrt{MSE}
$$

---

### **5.2. Coefficiente di Determinazione ($R^2$)**  
Il coefficiente di determinazione $R^2$ misura **la proporzione della varianza della variabile dipendente spiegata dal modello**:  

$$
R^2 = 1 - \frac{\sum (y_i - \hat{y}_i)^2}{\sum (y_i - \bar{y})^2}
$$

Dove:  
- $\sum (y_i - \hat{y}_i)^2$ rappresenta la **devianza residua** (errore del modello).  
- $\sum (y_i - \bar{y})^2$ rappresenta la **devianza totale** (variabilità totale dei dati rispetto alla loro media).  
- $\bar{y}$ è la media dei valori osservati di $y$.  

**Interpretazione:**  
- $R^2$ varia tra **0 e 1**:
  - Un valore vicino a **1** indica che il modello spiega quasi tutta la variabilità dei dati.  
  - Un valore vicino a **0** indica che il modello ha **scarsa capacità esplicativa**.  
- Un $R^2$ elevato non implica necessariamente che il modello sia valido: può essere influenzato dalla presenza di variabili irrilevanti.  

Per modelli con molte variabili, si preferisce il **$R^2$ aggiustato**, che penalizza l'aggiunta di variabili non significative:

$$
R^2_{\text{adj}} = 1 - \left( \frac{(1 - R^2)(N - 1)}{N - p - 1} \right)
$$

Dove $p$ è il numero di variabili indipendenti nel modello.  

---

### **5.3. Test F: Significatività Globale del Modello**  
Il **Test F** valuta se il modello, nel suo complesso, è statisticamente significativo, ovvero se almeno una delle variabili indipendenti ha un effetto su $y$. L'ipotesi nulla ($H_0$) del test è:  

$$
H_0: \quad w_1 = w_2 = ... = w_p = 0
$$

Se il test F risulta significativo (p-value < soglia, es. 0.05), possiamo rifiutare $H_0$, indicando che **almeno una variabile indipendente ha un effetto significativo su $y$**.  

Il valore della statistica F è calcolato come:  

$$
F = \frac{\left( \frac{R^2}{p} \right)}{\left( \frac{1 - R^2}{N - p - 1} \right)}
$$

Dove:  
- $p$ è il numero di variabili indipendenti.  
- $N$ è il numero di osservazioni.  

Un valore di **F alto** e un **p-value basso** indicano un modello globalmente significativo.

---

### **5.4. p-value dei Coefficienti**  
Ogni coefficiente $w_j$ della regressione ha un **p-value**, che misura la probabilità di ottenere un effetto uguale o maggiore **se l'effetto reale fosse nullo**.  

L'ipotesi nulla per ciascun coefficiente è:  

$$
H_0: \quad w_j = 0
$$

Se il **p-value è inferiore** a una soglia prestabilita (tipicamente 0.05 o 0.01), possiamo rifiutare $H_0$, indicando che la variabile $x_j$ ha un effetto significativo su $y$.  

**Interpretazione:**  
- Un **p-value < 0.05** suggerisce che la variabile $x_j$ è statisticamente significativa.  
- Un **p-value alto** indica che l'effetto della variabile potrebbe essere dovuto al caso e che la variabile potrebbe non essere utile nel modello.  

Se più variabili hanno p-value alti, potrebbe essere necessario **semplificare il modello** eliminando quelle non significative.

---

### **5.5. Considerazioni Finali sulla Valutazione del Modello**  
Un modello di regressione ideale dovrebbe:  
✅ Avere un **MSE basso** e, preferibilmente, un RMSE interpretabile.  
✅ Presentare un **$R^2$ elevato**, ma non eccessivamente vicino a 1 per evitare overfitting.  
✅ Superare il **test F**, indicando che almeno una variabile ha un effetto su $y$.  
✅ Avere **coefficienti con p-value bassi**, per garantire che le variabili siano significative.  

L'analisi dei residui (differenze tra $y_i$ e $\hat{y}_i$) è un altro strumento fondamentale per verificare la bontà del modello e individuare eventuali problemi di eteroschedasticità o non linearità.

## 6. Estensione del Modello

La regressione lineare è un modello potente e versatile, ma in alcuni casi la relazione tra le variabili indipendenti e la variabile dipendente non è lineare. In queste situazioni, è possibile estendere il modello di regressione lineare per catturare relazioni più complesse. Di seguito esploriamo alcune delle principali estensioni del modello di regressione lineare.

### 6.1. Regressione Polinomiale

La regressione polinomiale è un'estensione della regressione lineare che permette di modellare relazioni non lineari tra le variabili indipendenti e la variabile dipendente. Questo viene fatto introducendo termini polinomiali delle variabili indipendenti nel modello.

#### 6.1.1. Formulazione del Modello

Consideriamo il caso di una singola variabile indipendente $x$. Il modello di regressione polinomiale di grado $d$ è dato da:

$$
y = w_0 + w_1 x + w_2 x^2 + \dots + w_d x^d + \epsilon
$$

Dove:

- $w_0, w_1, \dots, w_d$ sono i coefficienti del modello.
- $x^2, x^3, \dots, x^d$ sono i termini polinomiali della variabile indipendente $x$.
- $\epsilon$ è il termine di errore.

In forma matriciale, il modello può essere scritto come:

$$
y = Xw + \epsilon
$$

Dove:

$$
X = \begin{bmatrix} 
1 & x_1 & x_1^2 & \dots & x_1^d \\
1 & x_2 & x_2^2 & \dots & x_2^d \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & x_n & x_n^2 & \dots & x_n^d
\end{bmatrix}
$$

è la matrice delle variabili indipendenti con i termini polinomiali.

$$
w = \begin{bmatrix} 
w_0 \\
w_1 \\
\vdots \\
w_d
\end{bmatrix}
$$

è il vettore dei coefficienti.

#### 6.1.2. Scelta del Grado del Polinomio

La scelta del grado $d$ del polinomio è cruciale:

- Un grado troppo basso può portare a **underfitting**, ovvero il modello non cattura la complessità dei dati.
- Un grado troppo alto può portare a **overfitting**, ovvero il modello si adatta troppo ai dati di training e generalizza male su nuovi dati.

Per scegliere il grado ottimale, si possono utilizzare tecniche come la cross-validation o l'analisi dell'errore di validazione.

#### 6.1.3. Esempio di Regressione Polinomiale

Supponiamo di avere un dataset con una relazione non lineare tra $x$ e $y$. Un modello di regressione polinomiale di grado 2 potrebbe essere:

$$
y = w_0 + w_1 x + w_2 x^2 + \epsilon
$$

Questo modello può catturare relazioni quadratiche tra $x$ e $y$, come ad esempio una parabola.

### 6.2. Regressione con Interazioni

La regressione con interazioni permette di modellare l'effetto combinato di due o più variabili indipendenti. Questo è utile quando l'effetto di una variabile dipendente su $y$ dipende dal valore di un'altra variabile.

#### 6.2.1. Formulazione del Modello

Consideriamo due variabili indipendenti $x_1$ e $x_2$. Il modello di regressione con interazione è dato da:

$$
y = w_0 + w_1 x_1 + w_2 x_2 + w_3 x_1 x_2 + \epsilon
$$

Dove:

- $w_0$ è l'intercetta.
- $w_1$ e $w_2$ sono i coefficienti delle variabili $x_1$ e $x_2$.
- $w_3$ è il coefficiente del termine di interazione $x_1 x_2$.
- $\epsilon$ è il termine di errore.

#### 6.2.2. Interpretazione dei Coefficienti

- Coefficiente di interazione ($w_3$): Misura l'effetto combinato di $x_1$ e $x_2$ su $y$. Se $w_3$ è positivo, l'effetto di $x_1$ su $y$ aumenta all'aumentare di $x_2$, e viceversa.

#### 6.2.3. Esempio di Regressione con Interazioni

Supponiamo di voler modellare l'effetto del prezzo ($x_1$) e della pubblicità ($x_2$) sulle vendite ($y$). Un modello con interazione potrebbe essere:

$$
y = w_0 + w_1 x_1 + w_2 x_2 + w_3 x_1 x_2 + \epsilon
$$

Questo modello cattura l'effetto combinato del prezzo e della pubblicità sulle vendite.

### 6.3. Regressione con Funzioni di Base

La regressione con funzioni di base è un'estensione della regressione lineare che permette di modellare relazioni non lineari utilizzando funzioni di base (basis functions) delle variabili indipendenti.

#### 6.3.1. Formulazione del Modello

Consideriamo una variabile indipendente $x$. Il modello di regressione con funzioni di base è dato da:

$$
y = w_0 + w_1 \phi_1(x) + w_2 \phi_2(x) + \dots + w_d \phi_d(x) + \epsilon
$$

Dove:

- $\phi_1(x), \phi_2(x), \dots, \phi_d(x)$ sono le funzioni di base.
- $w_0, w_1, \dots, w_d$ sono i coefficienti del modello.
- $\epsilon$ è il termine di errore.

#### 6.3.2. Scelta delle Funzioni di Base

Le funzioni di base possono essere scelte in base alla natura dei dati e alla relazione attesa tra le variabili. Alcune scelte comuni includono:

- Funzioni polinomiali: $\phi_j(x) = x^j$
- Funzioni trigonometriche: $\phi_j(x) = \sin(jx), \phi_j(x) = \cos(jx)$
- Funzioni radiali: $\phi_j(x) = \exp\left(\frac{-(x - \mu_j)^2}{2\sigma^2}\right)$

#### 6.3.3. Esempio di Regressione con Funzioni di Base

Supponiamo di voler modellare una relazione periodica tra $x$ e $y$. Un modello con funzioni trigonometriche potrebbe essere:

$$
y = w_0 + w_1 \sin(x) + w_2 \cos(x) + \epsilon
$$

Questo modello può catturare relazioni periodiche come quelle presenti in dati stagionali.

### 6.4. Regressione Non Parametrica

La regressione non parametrica è un approccio che non assume una forma specifica per la relazione tra le variabili indipendenti e la variabile dipendente. Invece, il modello si adatta ai dati in modo flessibile.

#### 6.4.1. Metodi Comuni

Alcuni metodi comuni di regressione non parametrica includono:

- **Kernel Regression**: Stima la relazione tra $x$ e $y$ utilizzando una funzione di kernel per pesare i dati vicini.
- **Spline Regression**: Utilizza funzioni spline per modellare la relazione tra $x$ e $y$.
- **Local Regression (LOESS)**: Adatta un modello di regressione lineare localmente ai dati.

#### 6.4.2. Vantaggi e Svantaggi

- **Vantaggi**:
  - Flessibilità nel modellare relazioni complesse.
  - Non richiede assunzioni sulla forma della relazione.

- **Svantaggi**:
  - Maggiore complessità computazionale.
  - Rischio di overfitting se non si controlla la complessità del modello.

### 6.5. Regressione Ponderata (Weighted Regression)

La regressione ponderata è una variante della regressione lineare in cui ogni osservazione ha un peso specifico. Questo è utile quando alcune osservazioni sono più importanti o affidabili di altre.

#### 6.5.1. Formulazione del Modello

Nella regressione ponderata, l'obiettivo è minimizzare la somma degli errori quadratici ponderati:

$$
\min_{\mathbf{w}} \sum_{i=1}^{N} v_i \left( y_i - \mathbf{w}^T \mathbf{x}_i \right)^2
$$

Dove:
- $v_i$ è il peso associato all'osservazione $i$ (tipicamente costante per tutto il dataset)
- $\mathbf{w}$ è il vettore dei coefficienti

La soluzione in forma chiusa è:
$$
\mathbf{w}^* = (\mathbf{X}^T \mathbf{V} \mathbf{X})^{-1} \mathbf{X}^T \mathbf{V} \mathbf{y}
$$

dove $\mathbf{V} = \text{diag}(v_1, v_2, \ldots, v_N)$ è la matrice diagonale dei pesi.

#### 6.5.2. Estensione Locale: LWLR

Un'importante estensione della regressione ponderata è la [[Locally Weighted Linear Regression]] (LWLR), dove i pesi non sono fissi ma **cambiano dinamicamente** per ogni punto di query in base alla distanza:

$$
w_i(\mathbf{x}_q) = \exp\left(-\frac{\|\mathbf{x}_i - \mathbf{x}_q\|^2}{2\tau^2}\right)
$$

A differenza della regressione ponderata classica che usa pesi globali fissi, LWLR costruisce un modello lineare locale per ogni previsione, rendendo il metodo non-parametrico e capace di catturare relazioni non lineari.

La differenza fondamentale è:
- **Weighted Regression**: Un singolo modello globale con pesi fissi
- **LWLR**: Infiniti modelli locali con pesi adattivi per ogni query

Per una trattazione completa di LWLR, incluse le tre implementazioni (forma chiusa, SGD, BGD) e tutti i dettagli matematici, si veda [[Locally Weighted Linear Regression]].

### 6.6. Conclusione

Le estensioni del modello di regressione lineare permettono di catturare relazioni più complesse tra le variabili indipendenti e la variabile dipendente. La scelta del modello dipende dalla natura dei dati e dalla relazione attesa. È importante bilanciare la flessibilità del modello con il rischio di overfitting, utilizzando tecniche come la cross-validation e la regolarizzazione.


## **7. Conclusioni**

- La **Regressione Lineare** è un modello semplice ma potente per analizzare relazioni tra variabili.
- Richiede l'analisi delle **assunzioni** per evitare problemi di interpretabilità.
- Può essere estesa con **regolarizzazione** e **modelli polinomiali** per migliorare le prestazioni

**Risorse aggiuntive:**

- *The Elements of Statistical Learning* - Hastie, Tibshirani, Friedman.
- *Introduction to Statistical Learning* - James, Witten, Hastie, Tibshirani.