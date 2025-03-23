# Problema della Classificazione Binaria: Interpretazione Probabilistica

La **classificazione binaria** è un problema in cui un'istanza $\mathbf{x} \in \mathbb{R}^d$ deve essere assegnata a una delle due classi possibili, generalmente denotate come $y \in \{0,1\}$.

Un approccio comune è utilizzare un **modello probabilistico** che stima la probabilità condizionale di una classe dato un vettore di caratteristiche $\mathbf{x}$:
$$
p(y=1 \mid \mathbf{x}) = f(\mathbf{x})
$$
Dove $f(\mathbf{x})$ è una funzione che restituisce una probabilità tra 0 e 1.

---

## **Likelihood e Posteriori**

Per stimare la probabilità della classe, possiamo applicare il **Teorema di Bayes**:
$$
p(y \mid \mathbf{x}) = \frac{p(\mathbf{x} \mid y) p(y)}{p(\mathbf{x})}
$$

- $p(y)$ è la probabilità a priori della classe $y$.
- $p(\mathbf{x} \mid y)$ è la **verosimiglianza** (*likelihood*), che modella come le caratteristiche $\mathbf{x}$ sono distribuite all'interno di ciascuna classe.
- $p(\mathbf{x}) = \sum_{y \in \{0,1\}} p(\mathbf{x} \mid y) p(y)$ è la probabilità marginale dei dati.

In pratica, possiamo stimare $p(y \mid \mathbf{x})$ attraverso un modello parametrico che approssima la distribuzione dei dati.

---

## **Il Concetto di Logit e la Funzione Sigmoide**

Come abbiamo visto, nella classificazione binaria, possiamo esprimere la probabilità che un'osservazione $\mathbf x \in \mathbb R^d$ appartenga alla classe 1 come: $p(y = 1 \mid \mathbf{x}) = \frac{p(\mathbf{x} \mid y) p(y)}{p(\mathbf{x})}$. Introduciamo ora il concetto di logit: una misura logaritmica di quanto verosimile sia la classe 1 rispetto alla classe 0 (logaritmicamente):

$$\begin{align*}
logit(p(y = 1 \mid \mathbf{x})) = a &= \log \frac{p(y = 1 \mid \mathbf{x})}{\underbrace{p(y = 0 \mid \mathbf{x})}_{= 1 - p(y = 1 \mid \mathbf{x})}}\\
e^a &= \frac{p(y = 1 \mid \mathbf{x})}{p(y = 0 \mid \mathbf{x})}\\
p(y = 1 \mid \mathbf{x}) &= e^a p(y = 0 \mid \mathbf{x})\\
\end{align*}
$$

E dato che $p(y = 0 \mid \mathbf{x}) + p(y = 1 \mid \mathbf{x}) = 1$,

$$\begin{align*}
e^a p(y = 0 \mid \mathbf{x}) + p(y = 0 \mid \mathbf{x}) &= 1\\
p(y = 0 \mid \mathbf{x}) (e^a + 1) &= 1\\
p(y = 0 \mid \mathbf{x}) &= \frac{1}{e^a + 1}\\
\end{align*}
$$

E ora, usando il fatto che $p(y=1 \mid \mathbf x) = e^a \cdot p(y=0\mid\mathbf x)$, otteniamo:

$$\begin{align*}
    p(y=1 \mid\mathbf x) &= e^a \cdot \frac{1}{1 + e^a}\\
    p(y=1 \mid\mathbf x) &= \frac{e^a}{1 + e^a}\\
    p(y=1 \mid\mathbf x) &= \frac{\frac{e^a}{e^a}}{\frac{1}{e^a} + \frac{e^a}{e^a}}\\
    p(y=1 \mid\mathbf x) &= \frac{1}{1 + e^{-a}} = \sigma(a) \ \text{La funzione sigmoide.}\\
\end{align*}
$$

Questa funzione si chiama **funzione sigmoide** e viene utilizzata per ottenere la probabilità di una classe dato un vettore di caratteristiche. Sarebbe quindi l'inverso della funzione logit, in quanto abbiamo ricavato la $x$ (che nel nostro caso era $p(y = 1 \mid \mathbf{x})$) dalla funzione $logit(x)$. Infatti,

$$
\begin{align*}
\text{Partendo da } p &= \sigma(x) = \frac{1}{1 + e^{-x}} \\
\frac{1}{p} &= 1 + e^{-x} \quad \text{(Reciproco di entrambi i lati)} \\
\frac{1}{p} - 1 &= e^{-x} \quad \text{(Isolare } e^{-x}) \\
\frac{1 - p}{p} &= e^{-x} \quad \text{(Semplificare)} \\
\ln\left(\frac{1 - p}{p}\right) &= -x \quad \text{(Applicare il logaritmo naturale)} \\
x &= -\ln\left(\frac{1 - p}{p}\right) = \ln\left(\frac{p}{1 - p}\right) \quad \text{(Risolvere per } x) \\
\text{Quindi otteniamo alla fine: }\\
\sigma^{-1}(p) &= \ln\left(\frac{p}{1 - p}\right).
\end{align*}
$$

Questo perché il logit trasforma un rapporto di probabilità $\in [0, 1]$ in un valore $\in (-\infty, +\infty)$. Mentre la funzione sigmoide trasforma un valore $\in (-\infty, +\infty)$ in un rapporto di probabilità $\in [0, 1]$. In altre parole, il logit controlla quanto le features in input influenzano la probabilità di appartenenza alla classe 1 rispetto alla classe 0.

## **Collegamento con la Regressione Logistica**

La regressione logistica è un modello **discriminativo**, che apprende direttamente $p(y \mid \mathbf{x})$ senza modellare $p(\mathbf{x} \mid y)$. Può essere vista come un caso particolare dell'**Analisi Discriminante Lineare (LDA)** sotto certe assunzioni sulle distribuzioni dei dati.