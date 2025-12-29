# Metriche di Valutazione per Classificazione in Machine Learning

## 1. Introduzione

La valutazione di modelli di classificazione richiede metriche specifiche che quantifichino la qualità delle predizioni. Questo documento presenta una trattazione completa e rigorosa delle principali metriche utilizzate nel machine learning, con particolare enfasi sulla teoria delle decisioni bayesiane e sulla minimizzazione del rischio.

### 1.1 Contesto Teorico: Bayesian Decision Theory

Nel contesto della teoria delle decisioni, un problema di classificazione può essere formalizzato come un **gioco contro la natura**. In questo scenario:

1. La natura sceglie uno stato (label) $y \in \mathcal{Y}$, sconosciuto a noi
2. Genera un'osservazione $x \in \mathcal{X}$, che possiamo osservare
3. Dobbiamo scegliere un'azione $a$ da uno spazio di azioni $\mathcal{A}$
4. Incorriamo in una perdita $L(y, a)$ che misura quanto la nostra azione sia compatibile con lo stato reale

L'obiettivo è trovare una **policy di decisione** o **decision rule** $\delta: \mathcal{X} \rightarrow \mathcal{A}$ che minimizzi la perdita attesa:

$$\delta(x) = \arg\min_{a \in \mathcal{A}} \mathbb{E}[L(y, a)]$$

Nell'approccio **bayesiano**, l'azione ottimale dopo aver osservato $x$ è quella che minimizza la **perdita attesa a posteriori**:

$$\rho(a|x) = \mathbb{E}_{p(y|x)}[L(y, a)] = \sum_{y} L(y, a) p(y|x)$$

Quindi, il **Bayes estimator** (o **Bayes decision rule**) è dato da:

$$\delta^*(x) = \arg\min_{a \in \mathcal{A}} \rho(a|x)$$

### 1.2 Principio di Utilità Attesa Massima

In economia, è più comune parlare di **funzione di utilità** $U(y, a) = -L(y, a)$, trasformando il problema in:

$$\delta(x) = \arg\max_{a \in \mathcal{A}} \mathbb{E}[U(y, a)]$$

Questo è noto come **principio di utilità attesa massima** ed è l'essenza del comportamento razionale.

## 2. Matrice di Confusione

La **matrice di confusione** è la struttura fondamentale per calcolare tutte le metriche di classificazione. Per un problema binario:

|                    | **Predetto Positivo ($\hat{y}=1$)** | **Predetto Negativo ($\hat{y}=0$)** |
|--------------------|---------------------------|---------------------------|
| **Reale Positivo ($y=1$)** | TP (True Positive)        | FN (False Negative)       |
| **Reale Negativo ($y=0$)** | FP (False Positive)       | TN (True Negative)        |

### 2.1 Definizioni Rigorose

Definiamo formalmente le quattro quantità:

- **True Positive (TP)**: $|\{i: y_i = 1 \land \hat{y}_i = 1\}|$ - Istanze positive correttamente classificate
- **True Negative (TN)**: $|\{i: y_i = 0 \land \hat{y}_i = 0\}|$ - Istanze negative correttamente classificate
- **False Positive (FP)**: $|\{i: y_i = 0 \land \hat{y}_i = 1\}|$ - Istanze negative erroneamente classificate come positive (**Errore di Tipo I**)
- **False Negative (FN)**: $|\{i: y_i = 1 \land \hat{y}_i = 0\}|$ - Istanze positive erroneamente classificate come negative (**Errore di Tipo II**)

*Nota*: Per ricordarle bene, osserviamo che la prima lettera si riferisce alla realtà e la seconda alla predizione; es. $TP$ corrisponde al numero di esempi che nella realtà sono positivi e nella predizione sono stati predetti come positivi.

### 2.2 Relazioni Fondamentali

Dalla matrice di confusione derivano alcune identità fondamentali:

$$N = TP + TN + FP + FN$$

dove $N$ è il numero totale di esempi. Inoltre:

$$N_+ = TP + FN \quad \text{(numero reale di positivi)}$$
$$N_- = TN + FP \quad \text{(numero reale di negativi)}$$
$$\hat{N}_+ = TP + FP \quad \text{(numero predetto di positivi)}$$
$$\hat{N}_- = TN + FN \quad \text{(numero predetto di negativi)}$$

### 2.3 Interpretazione Probabilistica

Dato un sistema di classificazione con soglia $\tau$, definiamo:

**Ipotesi**:

- $H_0$: L'istanza appartiene alla classe negativa ($y=0$)
- $H_1$: L'istanza appartiene alla classe positiva ($y=1$)

**Decisioni**:

- $D_0$: Classificare come negativo ($\hat{y}=0$)
- $D_1$: Classificare come positivo ($\hat{y}=1$)

Allora le probabilità di errore condizionate sono:

$$\text{FPR} = P(D_1 | H_0) = P(\hat{y}=1 | y=0)$$

$$\text{FNR} = P(D_0 | H_1) = P(\hat{y}=0 | y=1)$$

## 3. Loss Functions e Bayes Estimators

### 3.1 0-1 Loss e Stima MAP

La **0-1 loss** è definita come:

$$L(y, a) = \mathbb{I}(y \neq a) = \begin{cases} 0 & \text{se } a = y \\ 1 & \text{se } a \neq y \end{cases}$$

**Teorema**: La 0-1 loss è minimizzata dalla stima **MAP (Maximum A Posteriori)**.

**Dimostrazione**:

La perdita attesa a posteriori è:

$$\rho(a|x) = \sum_{y} L(y,a) p(y|x) = \sum_{y \neq a} p(y|x) = 1 - p(a|x)$$

Per minimizzare $\rho(a|x)$, dobbiamo massimizzare $p(a|x)$, quindi:

$$\delta^*(x) = \arg\min_a \rho(a|x) = \arg\max_a p(a|x) = \arg\max_{y \in \mathcal{Y}} p(y|x)$$

che è esattamente la **stima MAP**. $\square$

#### 3.1.1 Matrice di Loss Generalizzata

Per problemi binari, possiamo rappresentare la loss come matrice:

|            | $\hat{y}=1$ | $\hat{y}=0$ |
|------------|------------|------------|
| $y=1$      | $0$        | $L_{FN}$   |
| $y=0$      | $L_{FP}$   | $0$        |

dove $L_{FN}$ è il costo di un falso negativo e $L_{FP}$ è il costo di un falso positivo.

**Teorema (Regola di Decisione Ottimale)**: Dovremmo scegliere $\hat{y}=1$ se e solo se:

$$\frac{p(y=1|x)}{p(y=0|x)} > \frac{L_{FP}}{L_{FN}}$$

**Dimostrazione**:

Le perdite attese per le due azioni sono:

$$\rho(\hat{y}=0|x) = L_{FN} \cdot p(y=1|x)$$
$$\rho(\hat{y}=1|x) = L_{FP} \cdot p(y=0|x)$$

Scegliamo $\hat{y}=1$ quando $\rho(\hat{y}=1|x) < \rho(\hat{y}=0|x)$:

$$L_{FP} \cdot p(y=0|x) < L_{FN} \cdot p(y=1|x)$$

$$\frac{p(y=1|x)}{p(y=0|x)} > \frac{L_{FP}}{L_{FN}}$$

Se $L_{FN} = c \cdot L_{FP}$, la regola diventa: scegliere $\hat{y}=1$ se $p(y=1|x) > \tau$ dove $\tau = \frac{c}{1+c}$. $\square$

#### 3.1.2 Reject Option

In domini ad alto rischio (medicina, finanza), potrebbe essere preferibile **rifiutare** di classificare esempi incerti. Formalizziamo l'azione di rifiuto come $a = C+1$ con costo $\lambda_r$, mentre gli errori di sostituzione hanno costo $\lambda_s$.

**Teorema**: L'azione ottimale è rifiutare se:

$$\max_{i \in \{1,\ldots,C\}} p(y=i|x) < 1 - \frac{\lambda_r}{\lambda_s}$$

altrimenti scegliere la classe con probabilità massima.

### 3.2 Quadratic Loss ($\ell_2$) e Posterior Mean

La **quadratic loss** o **squared error** è definita come:

$$L(y, a) = (y - a)^2$$

**Teorema**: La $\ell_2$ loss è minimizzata dalla **media a posteriori**.

**Dimostrazione**:

La perdita attesa a posteriori è:

$$\rho(a|x) = \mathbb{E}[(y-a)^2|x] = \mathbb{E}[y^2|x] - 2a\mathbb{E}[y|x] + a^2$$

Derivando rispetto ad $a$ e ponendo uguale a zero:

$$\frac{\partial \rho(a|x)}{\partial a} = -2\mathbb{E}[y|x] + 2a = 0$$

$$\Rightarrow \hat{y} = \mathbb{E}[y|x] = \int y \, p(y|x) \, dy$$

Questa è la **stima MMSE (Minimum Mean Squared Error)**. $\square$

Per regressione lineare con $p(y|x,\theta) = \mathcal{N}(y|x^T w, \sigma^2)$, abbiamo:

$$\mathbb{E}[y|x, \mathcal{D}] = x^T \mathbb{E}[w|\mathcal{D}]$$

cioè, basta usare la media a posteriori dei parametri.

### 3.3 Absolute Loss ($\ell_1$) e Posterior Median

La **absolute loss** è:

$$L(y, a) = |y - a|$$

**Teorema**: La $\ell_1$ loss è minimizzata dalla **mediana a posteriori**.

**Dimostrazione**:

La perdita attesa è:

$$\rho(a|x) = \int |y-a| p(y|x) dy = \int_{-\infty}^{a} (a-y) p(y|x) dy + \int_{a}^{\infty} (y-a) p(y|x) dy$$

Derivando rispetto ad $a$:

$$\frac{\partial \rho(a|x)}{\partial a} = \int_{-\infty}^{a} p(y|x) dy - \int_{a}^{\infty} p(y|x) dy = P(y \leq a|x) - P(y > a|x)$$

Ponendo uguale a zero:

$$P(y \leq a|x) = P(y > a|x) = 0.5$$

che è la definizione di **mediana**. $\square$

La $\ell_1$ loss è più robusta agli outlier rispetto alla $\ell_2$ loss perché penalizza linearmente (anziché quadraticamente) le deviazioni.

## 4. Metriche Fondamentali

### 4.1 Accuracy (Accuratezza)

L'**accuracy** misura la proporzione di predizioni corrette:

$$\text{Accuracy} = \frac{TP + TN}{TP + TN + FP + FN} = \frac{TP + TN}{N}$$

**Interpretazione**: Rappresenta $P(\hat{y} = y)$, la probabilità che la predizione sia corretta.

**Proprietà**:

- Range: $[0, 1]$, dove $1$ indica predizioni perfette
- Simmetrica rispetto alle classi
- **Limitazione critica**: Inadeguata per dataset sbilanciati

**Esempio**: Con prevalenza $p(y=1) = 0.01$, un classificatore "dummy" che predice sempre $\hat{y}=0$ ottiene accuracy $0.99$, pur essendo completamente inutile per identificare i positivi.

### 4.2 Precision (Precisione, Positive Predictive Value)

La **precision** misura la proporzione di predizioni positive corrette:

$$\text{Precision} = \frac{TP}{TP + FP} = \frac{TP}{\hat{N}_+} = P(y=1|\hat{y}=1)$$

**Interpretazione**: "Tra tutti i casi che ho predetto come positivi, quanti sono realmente positivi?"

**Quando è critica**: Scenari dove i falsi positivi sono costosi:

- **Spam detection**: Classificare email legittime come spam
- **Diagnosi mediche**: Prescrivere trattamenti invasivi non necessari
- **Sistemi di raccomandazione**: Raccomandare prodotti irrilevanti

**Complemento**: $\text{FDR} = 1 - \text{Precision} = \frac{FP}{TP+FP}$ (False Discovery Rate)

### 4.3 Recall (Sensibilità, True Positive Rate)

Il **recall** misura la proporzione di positivi reali correttamente identificati:

$$\text{Recall} = \text{TPR} = \text{Sensitivity} = \frac{TP}{TP + FN} = \frac{TP}{N_+} = P(\hat{y}=1|y=1)$$

**Interpretazione**: "Tra tutti i casi realmente positivi, quanti ne ho identificati?"

**Quando è critico**: Scenari dove i falsi negativi sono costosi:

- **Rilevamento tumori**: Non diagnosticare un cancro presente
- **Rilevamento frodi**: Non bloccare transazioni fraudolente
- **Sistemi di sicurezza**: Non rilevare intrusioni

**Complemento**: $\text{FNR} = 1 - \text{Recall} = \frac{FN}{TP+FN}$ (False Negative Rate, Miss Rate)

### 4.4 Specificity (True Negative Rate)

La **specificity** misura la proporzione di negativi correttamente identificati:

$$\text{Specificity} = \text{TNR} = \frac{TN}{TN + FP} = \frac{TN}{N_-} = P(\hat{y}=0|y=0)$$

**Interpretazione**: Capacità di identificare correttamente i negativi.

**Relazione con FPR**:

$$\text{FPR} = 1 - \text{Specificity} = \frac{FP}{FP + TN} = P(\hat{y}=1|y=0)$$

Il FPR è la probabilità di **falso allarme** (Errore di Tipo I).

### 4.5 Trade-off Precision vs Recall

Precision e Recall sono tipicamente in **trade-off**: aumentare una tende a diminuire l'altra.

**Intuizione**:

- Per aumentare il recall (catturare più positivi), abbassiamo la soglia → più predizioni positive → ma aumentano anche i falsi positivi → precision diminuisce
- Per aumentare la precision (evitare falsi positivi), alziamo la soglia → solo predizioni molto confidenti → ma perdiamo alcuni veri positivi → recall diminuisce

Formalmente, variando la soglia $\tau$ nella regola $\hat{y} = \mathbb{I}(p(y=1|x) > \tau)$:

- $\tau \to 0$: Recall $\to 1$, Precision $\to$ prevalenza
- $\tau \to 1$: Precision $\to 1$, Recall $\to 0$

### 4.6 F-Scores: Combinare Precision e Recall

#### 4.6.1 F1-Score

L'**F1-score** è la **media armonica** di precision e recall:

$$F_1 = 2 \cdot \frac{\text{Precision} \cdot \text{Recall}}{\text{Precision} + \text{Recall}} = \frac{2TP}{2TP + FP + FN}$$

**Perché media armonica?**

La media armonica $H(a,b) = \frac{2ab}{a+b}$ è più severa della media aritmetica $A(a,b) = \frac{a+b}{2}$ quando i valori sono sbilanciati.

**Esempio**: Se $P = 0.9$ e $R = 0.1$:

- Media aritmetica: $\frac{0.9 + 0.1}{2} = 0.5$
- Media armonica (F1): $\frac{2 \cdot 0.9 \cdot 0.1}{0.9 + 0.1} = 0.18$

L'F1 penalizza fortemente sistemi con precision o recall molto bassi.

**Proprietà**:

- Range: $[0, 1]$
- $F_1 = 1$ solo se $P = R = 1$
- $F_1 \geq H(P, R) \geq G(P, R)$ dove $G$ è la media geometrica

#### 4.6.2 F-Beta Score

Generalizzazione che pesa diversamente precision e recall:

$$F_\beta = (1 + \beta^2) \cdot \frac{\text{Precision} \cdot \text{Recall}}{\beta^2 \cdot \text{Precision} + \text{Recall}}$$

**Interpretazione di $\beta$**:

- $\beta < 1$: Recall pesa meno → maggior enfasi su Precision
- $\beta = 1$: F1-score (bilanciamento equo)
- $\beta > 1$: Recall pesa di più → maggior enfasi su Recall
- $\beta = 2$: F2-score (recall vale il doppio)
- $\beta = 0.5$: F0.5-score (precision vale il doppio)

**Derivazione del peso**: Il parametro $\beta$ rappresenta quanto il recall è più importante della precision. Se scriviamo:

$$F_\beta = \frac{(1+\beta^2) \cdot TP}{(1+\beta^2) \cdot TP + \beta^2 \cdot FN + FP}$$

vediamo che $FN$ è pesato per $\beta^2$ rispetto a $FP$, quindi $\beta^2$ è il rapporto di importanza.

## 5. ROC Curves e AUC

### 5.1 Curva ROC (Receiver Operating Characteristic)

La **curva ROC** visualizza il trade-off tra True Positive Rate e False Positive Rate al variare della soglia $\tau$:

- **Asse Y**: $\text{TPR}(\tau) = \frac{TP(\tau)}{TP(\tau) + FN(\tau)}$
- **Asse X**: $\text{FPR}(\tau) = \frac{FP(\tau)}{FP(\tau) + TN(\tau)}$

**Costruzione**: 
1. Per ogni possibile soglia $\tau \in [0,1]$, calcoliamo TPR e FPR
2. Plottiamo il punto $(FPR(\tau), TPR(\tau))$
3. Colleghiamo i punti per formare la curva

**Punti Notevoli**:

- $(0, 0)$: Soglia $\tau = 1$ → tutto classificato come negativo
- $(1, 1)$: Soglia $\tau = 0$ → tutto classificato come positivo
- $(0, 1)$: Classificatore perfetto
- Diagonale $TPR = FPR$: Classificatore casuale

**Interpretazione Geometrica**: Una curva ROC che "abbraccia" l'angolo superiore sinistro indica un buon classificatore.

### 5.2 AUC (Area Under the ROC Curve)

L'**AUC** quantifica l'area sotto la curva ROC:

$$\text{AUC} = \int_0^1 \text{TPR}(t) \, d(\text{FPR}(t))$$

**Teorema (Interpretazione Probabilistica dell'AUC)**: 

$$\text{AUC} = P(f(x_+) > f(x_-))$$

dove $x_+ \sim p(x|y=1)$ e $x_- \sim p(x|y=0)$ sono campioni casuali dalle classi positiva e negativa, e $f(x)$ è lo score del classificatore.

**Dimostrazione** (sketch):

Sia $S_+ = \{f(x_i) : y_i = 1\}$ e $S_- = \{f(x_j) : y_j = 0\}$ gli insiemi di score per positivi e negativi.

L'AUC può essere calcolata come:

$$\text{AUC} = \frac{1}{|S_+| \cdot |S_-|} \sum_{i \in S_+} \sum_{j \in S_-} \mathbb{I}(f(x_i) > f(x_j))$$

Questa è esattamente la frazione di coppie $(x_+, x_-)$ per cui lo score del positivo supera quello del negativo, cioè una stima di $P(f(x_+) > f(x_-))$. $\square$

**Equivalenza con test di Wilcoxon-Mann-Whitney**: L'AUC è equivalente alla statistica U del test non parametrico di Wilcoxon-Mann-Whitney.

**Scala di Interpretazione**:

- $\text{AUC} = 1.0$: Separazione perfetta
- $\text{AUC} = 0.5$: Nessun potere discriminante (casuale)
- $\text{AUC} < 0.5$: Performance peggiore del caso (predizioni invertite)
- $0.5 < \text{AUC} < 0.7$: Scarso
- $0.7 \leq \text{AUC} < 0.8$: Accettabile
- $0.8 \leq \text{AUC} < 0.9$: Eccellente
- $\text{AUC} \geq 0.9$: Outstanding

**Proprietà Chiave**:

1. **Invarianza alla scala**: Dipende solo dall'ordinamento relativo degli score
2. **Robustezza allo sbilanciamento**: Non dipende dalla prevalenza delle classi
3. **Interpretazione come ranking metric**: Misura quanto bene il modello ordina esempi positivi prima dei negativi

### 5.3 Equal Error Rate (EER)

L'**Equal Error Rate** è il punto dove:

$$\text{FPR}(\tau^*) = \text{FNR}(\tau^*) = \text{EER}$$

Poiché $\text{FNR} = 1 - \text{TPR}$, questo corrisponde al punto sulla curva ROC dove la linea $\text{TPR} = 1 - \text{FPR}$ interseca la curva.

**Interpretazione**: Rappresenta il punto di bilanciamento ottimale tra i due tipi di errore. EER più basso indica performance migliore.

## 6. Precision-Recall Curves

### 6.1 Motivazione per Dataset Sbilanciati

Quando la classe positiva è rara (e.g., $p(y=1) \ll 0.5$), la curva ROC può essere poco informativa perché:

1. Il numero di veri negativi $N_-$ è molto grande
2. Anche un piccolo FPR corrisponde a molti falsi positivi in termini assoluti
3. Tutta l'"azione" nella curva ROC si concentra vicino all'origine

La **curva Precision-Recall** risolve questo problema focalizzandosi solo sui positivi.

### 6.2 Definizione

La curva PR plotta:

- **Asse X**: Recall $= \frac{TP}{TP + FN}$
- **Asse Y**: Precision $= \frac{TP}{TP + FP}$

al variare della soglia $\tau$.

**Baseline**: Un classificatore casuale ottiene precision pari alla prevalenza: $P = p(y=1)$.

### 6.3 Average Precision (AP)

L'**Average Precision** riassume la curva PR come media pesata delle precision:

$$\text{AP} = \sum_{n=1}^{N} (R_n - R_{n-1}) \cdot P_n$$

dove $(P_n, R_n)$ sono precision e recall alla soglia $n$-esima, ordinati per recall crescente.

**Interpretazione**: Approssima l'area sotto la curva PR.

**Differenze AUC-ROC vs AUC-PR**:

| Aspetto | AUC-ROC | AUC-PR |
|---------|---------|--------|
| Focus | Bilanciamento TPR/FPR | Classe positiva |
| Dataset | Bilanciati | Sbilanciati |
| Sensibilità | Meno sensibile a sbilanciamento | Più sensibile |
| Uso | Classificazione generale | Rilevamento eventi rari |

### 6.4 Precision@K e Average Precision@K

In information retrieval e sistemi di ranking:

**Precision@K**: Precision calcolata sui primi $K$ elementi recuperati:

$$P@K = \frac{|\{i \in \text{top-}K : y_i = 1\}|}{K}$$

**Average Precision@K**: Media delle precision calcolate ad ogni posizione dove compare un elemento rilevante, fino a $K$:

$$AP@K = \frac{1}{\min(m, K)} \sum_{k=1}^{K} P(k) \cdot \text{rel}(k)$$

dove $\text{rel}(k) = 1$ se l'item in posizione $k$ è rilevante, $0$ altrimenti, e $m$ è il numero totale di item rilevanti.

## 7. Metriche Avanzate

### 7.1 Matthews Correlation Coefficient (MCC)

Il **MCC** è un coefficiente di correlazione tra predizioni e valori reali:

$$\text{MCC} = \frac{TP \cdot TN - FP \cdot FN}{\sqrt{(TP + FP)(TP + FN)(TN + FP)(TN + FN)}}$$

**Derivazione**: Il MCC è il coefficiente di correlazione di Pearson $\phi$ tra due variabili binarie $y$ e $\hat{y}$:

$$\phi = \frac{n_{11}n_{00} - n_{10}n_{01}}{\sqrt{n_{1\cdot}n_{0\cdot}n_{\cdot1}n_{\cdot0}}}$$

dove $n_{ij}$ è la frequenza congiunta di $y=i$ e $\hat{y}=j$.

**Proprietà**:

- Range: $[-1, +1]$
- $\text{MCC} = +1$: Predizione perfetta
- $\text{MCC} = 0$: Predizione casuale (non correlata)
- $\text{MCC} = -1$: Disaccordo totale (predizioni invertite)
- **Simmetrico** rispetto alle classi: $\text{MCC}(y, \hat{y}) = \text{MCC}(\hat{y}, y)$
- **Invariante** al bilanciamento: Non favorisce la classe maggioritaria

**Teorema (Invarianza)**: MCC è invariante rispetto a scambi di classe (scambiare positivi con negativi).

**Dimostrazione**: Sotto lo scambio $y \leftrightarrow (1-y)$ e $\hat{y} \leftrightarrow (1-\hat{y})$:

- $TP \leftrightarrow TN$
- $FP \leftrightarrow FN$

Quindi il numeratore diventa $TN \cdot TP - FN \cdot FP = TP \cdot TN - FP \cdot FN$ (stesso valore).

Il denominatore è simmetrico per costruzione. $\square$

### 7.2 Cohen's Kappa

Il **Cohen's Kappa** misura l'accordo tra predizioni e valori reali, corretto per l'accordo casuale:

$$\kappa = \frac{p_o - p_e}{1 - p_e}$$

dove:

- $p_o = \frac{TP + TN}{N}$ è l'**accuratezza osservata**
- $p_e = \frac{(TP+FP)(TP+FN) + (TN+FP)(TN+FN)}{N^2}$ è l'**accordo casuale atteso**

**Derivazione di $p_e$**: Se $y$ e $\hat{y}$ fossero indipendenti ma con le stesse distribuzioni marginali:

$$p_e = P(y = \hat{y}) = P(y=1)P(\hat{y}=1) + P(y=0)P(\hat{y}=0)$$

$$= \frac{N_+}{N} \cdot \frac{\hat{N}_+}{N} + \frac{N_-}{N} \cdot \frac{\hat{N}_-}{N}$$

**Interpretazione**:

- $\kappa = 1$: Accordo perfetto
- $\kappa = 0$: Accordo pari al caso
- $\kappa < 0$: Accordo peggiore del caso

**Scala di Landis e Koch**:
- $\kappa < 0$: Accordo peggiore del caso
- $0 \leq \kappa < 0.20$: Accordo lieve
- $0.20 \leq \kappa < 0.40$: Accordo discreto
- $0.40 \leq \kappa < 0.60$: Accordo moderato
- $0.60 \leq \kappa < 0.80$: Accordo sostanziale
- $0.80 \leq \kappa \leq 1.00$: Accordo quasi perfetto

**Relazione con MCC**: Per problemi binari, MCC e Kappa sono strettamente correlati ma non identici. Il MCC è generalmente preferito perché:
1. Ha interpretazione come coefficiente di correlazione
2. È più stabile numericamente
3. Ha migliori proprietà sotto campionamento

### 7.3 Balanced Accuracy

La **balanced accuracy** è la media delle accuratezze per classe, utile per dataset sbilanciati:

$\text{Balanced Accuracy} = \frac{1}{2}\left(\frac{TP}{TP+FN} + \frac{TN}{TN+FP}\right) = \frac{\text{TPR} + \text{TNR}}{2}$

**Motivazione**: L'accuracy standard può essere dominata dalla classe maggioritaria. La balanced accuracy dà peso uguale a ciascuna classe.

**Esempio**: Dataset con 95% negativi, 5% positivi.
- Classificatore che predice sempre negativo: Accuracy = 95%, Balanced Accuracy = 50%
- Balanced Accuracy rivela che il modello è equivalente al caso per la classe positiva

**Generalizzazione multi-classe**:

$\text{Balanced Accuracy} = \frac{1}{C} \sum_{c=1}^{C} \frac{TP_c}{TP_c + FN_c}$

dove $C$ è il numero di classi.

## 8. Metriche Probabilistiche e Calibrazione

### 8.1 Log Loss (Cross-Entropy Loss)

La **log loss** o **cross-entropy** valuta la qualità delle probabilità predette:

$\text{Log Loss} = -\frac{1}{N} \sum_{i=1}^{N} \left[ y_i \log(p_i) + (1 - y_i) \log(1 - p_i) \right]$

dove $p_i = P(y_i = 1|x_i)$ è la probabilità predetta per il campione $i$.

**Derivazione dall'entropia incrociata**: La log loss è l'entropia incrociata tra la distribuzione empirica $q(y|x)$ e la distribuzione predetta $p(y|x)$:

$H(q, p) = -\mathbb{E}_{y \sim q}[\log p(y|x)] = -\sum_{y} q(y|x) \log p(y|x)$

Per classificazione binaria con $q(y=1|x) = y$ (0 o 1):

$H = -y \log p - (1-y) \log(1-p)$

**Proprietà**:
- Range: $[0, +\infty)$, dove 0 indica probabilità perfette
- **Penalizzazione esponenziale**: Predizioni confidenti ma sbagliate sono penalizzate pesantemente
- **Proper scoring rule**: Minimizzata dalle vere probabilità

**Esempio di penalizzazione**:
- Vera classe: $y=1$
- Predizione confidante errata: $p=0.01$ → Loss $= -\log(0.01) \approx 4.6$
- Predizione incerta: $p=0.5$ → Loss $= -\log(0.5) \approx 0.69$
- Predizione corretta confidante: $p=0.99$ → Loss $= -\log(0.99) \approx 0.01$

**Collegamento con likelihood**: Minimizzare la log loss equivale a massimizzare la log-likelihood:

$\arg\min_\theta \text{Log Loss} = \arg\max_\theta \sum_{i=1}^{N} \log p(y_i|x_i, \theta)$

### 8.2 Brier Score

Il **Brier score** misura l'errore quadratico medio delle probabilità predette:

$\text{Brier Score} = \frac{1}{N} \sum_{i=1}^{N} (p_i - y_i)^2$

**Derivazione**: È semplicemente il MSE tra probabilità predette e label binari.

**Decomposizione di Murphy**: Il Brier score può essere decomposto in tre termini:

$\text{BS} = \text{Reliability} - \text{Resolution} + \text{Uncertainty}$

dove:
- **Reliability**: Quanto le probabilità predette corrispondono alle frequenze osservate
- **Resolution**: Quanto bene il modello separa i casi positivi dai negativi
- **Uncertainty**: Varianza intrinseca dei dati (non controllabile)

**Confronto Log Loss vs Brier Score**:

| Aspetto | Log Loss | Brier Score |
|---------|----------|-------------|
| Penalizzazione | Logaritmica (più severa) | Quadratica |
| Range | $[0, \infty)$ | $[0, 1]$ |
| Proper scoring rule | Sì | Sì |
| Interpretabilità | Meno intuitiva | Più intuitiva (MSE) |
| Sensibilità a errori confidenti | Molto alta | Moderata |

### 8.3 Calibrazione delle Probabilità

Un modello è **ben calibrato** se le probabilità predette riflettono le vere frequenze:

$P(y=1 | p(y=1|x) = q) = q \quad \forall q \in [0,1]$

**Interpretazione**: Se il modello assegna probabilità 0.7 a 100 esempi, circa 70 dovrebbero essere effettivamente positivi.

#### 8.3.1 Reliability Diagram (Calibration Plot)

Per valutare la calibrazione:

1. **Binning**: Dividi le predizioni in $B$ bin basati su $p_i$
2. Per ogni bin $b$:
   - Calcola probabilità media predetta: $\bar{p}_b = \frac{1}{|B_b|} \sum_{i \in B_b} p_i$
   - Calcola frazione empirica di positivi: $\bar{y}_b = \frac{1}{|B_b|} \sum_{i \in B_b} y_i$
3. Plotta $\bar{y}_b$ vs $\bar{p}_b$

**Interpretazione**:
- Modello perfettamente calibrato: Punti sulla diagonale
- Sopra la diagonale: Modello sotto-confidente
- Sotto la diagonale: Modello sovra-confidente

#### 8.3.2 Expected Calibration Error (ECE)

L'**ECE** quantifica la deviazione dalla calibrazione perfetta:

$\text{ECE} = \sum_{b=1}^{B} \frac{|B_b|}{N} |\bar{y}_b - \bar{p}_b|$

**Proprietà**:
- Range: $[0, 1]$
- ECE = 0 indica calibrazione perfetta
- Usa errore assoluto (più robusto di MSE)

**Maximum Calibration Error (MCE)**:

$\text{MCE} = \max_{b=1,\ldots,B} |\bar{y}_b - \bar{p}_b|$

Misura la peggiore deviazione locale dalla calibrazione.

#### 8.3.3 Metodi di Calibrazione

**Platt Scaling**: Applica regressione logistica agli score:

$p_{\text{calibrated}} = \frac{1}{1 + e^{-(a \cdot s + b)}}$

dove $s$ è lo score non calibrato, e $a, b$ sono appresi su un validation set.

**Isotonic Regression**: Apprende una funzione monotona non-parametrica che mappa score a probabilità calibrate.

**Temperature Scaling** (per reti neurali): Scala i logit con un parametro $T$:

$p_i = \frac{e^{z_i/T}}{\sum_j e^{z_j/T}}$

dove $T > 1$ "addolcisce" le probabilità (meno confidenti), $T < 1$ le rende più confidenti.

### 8.4 Decisioni con Costi Asimmetrici

#### 8.4.1 Framework del Rischio Bayesiano

Il **rischio bayesiano** (o rischio atteso) per una decision rule $\delta$ è:

$R(\delta) = \mathbb{E}_{(X,Y) \sim p(x,y)}[L(Y, \delta(X))] = \sum_x \sum_y L(y, \delta(x)) p(x,y)$

**Distinzione chiave**:

**Rischio Empirico** (Training):
$\hat{R}_{\text{emp}}(\delta) = \frac{1}{N} \sum_{i=1}^{N} L(y_i, \delta(x_i))$

Calcolato sul training set, tende a sottostimare il vero rischio (overfitting).

**Rischio di Generalizzazione** (Test):
$R_{\text{true}}(\delta) = \mathbb{E}_{(X,Y) \sim p_{\text{true}}(x,y)}[L(Y, \delta(X))]$

Il vero rischio sulla distribuzione sottostante (sconosciuta).

**Obiettivo**: Minimizzare $R_{\text{true}}(\delta)$, stimabile via validation set o cross-validation.

#### 8.4.2 Ottimizzazione della Soglia per Costi Specifici

Dato un modello che produce $p(y=1|x)$, la soglia ottimale $\tau^*$ dipende dai costi:

**Teorema (Soglia Ottimale con Costi Asimmetrici)**:

Dato $L_{FP}$ (costo falso positivo) e $L_{FN}$ (costo falso negativo), la soglia ottimale è:

$\tau^* = \frac{L_{FP}}{L_{FP} + L_{FN}}$

**Dimostrazione**:

Il rischio atteso per soglia $\tau$ è:

$R(\tau) = L_{FN} \cdot P(Y=1, \hat{Y}=0) + L_{FP} \cdot P(Y=0, \hat{Y}=1)$

$= L_{FN} \int_{p(y=1|x) \leq \tau} p(y=1|x) p(x) dx + L_{FP} \int_{p(y=1|x) > \tau} p(y=0|x) p(x) dx$

Derivando rispetto a $\tau$ e usando il calcolo variazionale:

$\frac{\partial R}{\partial \tau} = 0 \Rightarrow L_{FN} \cdot \tau = L_{FP} \cdot (1-\tau)$

$\Rightarrow \tau^* = \frac{L_{FP}}{L_{FP} + L_{FN}}$ $\square$

**Esempi applicativi**:

1. **Diagnosi medica (screening cancro)**:
   - $L_{FN} = 100$ (mancata diagnosi → morte)
   - $L_{FP} = 1$ (falso allarme → biopsia inutile)
   - $\tau^* = \frac{1}{101} \approx 0.01$ → Soglia molto bassa, massimizza recall

2. **Sistema anti-spam**:
   - $L_{FN} = 1$ (spam in inbox)
   - $L_{FP} = 10$ (email legittima in spam)
   - $\tau^* = \frac{10}{11} \approx 0.91$ → Soglia alta, massimizza precision

3. **Rilevamento frodi bancarie**:
   - $L_{FN} = 1000$ (frode non rilevata)
   - $L_{FP} = 5$ (transazione legittima bloccata)
   - $\tau^* = \frac{5}{1005} \approx 0.005$ → Soglia molto bassa

#### 8.4.3 Ottimizzazione Multi-Obiettivo

Quando vogliamo ottimizzare per una metrica specifica (es. F1, F2), possiamo cercare la soglia che la massimizza:

$\tau^*_{F_\beta} = \arg\max_\tau F_\beta(\tau)$

Questo richiede una ricerca (grid search o ottimizzazione) sul validation set.

**Algoritmo**:
```
Input: Validation set {(x_i, y_i, p_i)}_{i=1}^M
1. For τ in [0, 1] con step 0.01:
2.     Compute ŷ_i = I(p_i > τ)
3.     Compute F_β(τ)
4. Return τ* = argmax_τ F_β(τ)
```

## 9. Metriche Multi-Classe

### 9.1 Estensione della Matrice di Confusione

Per $C$ classi, la matrice di confusione è $C \times C$:

$M_{ij} = |\{k : y_k = i \land \hat{y}_k = j\}|$

Elementi sulla diagonale sono predizioni corrette, elementi fuori diagonale sono errori.

### 9.2 Strategie di Aggregazione

#### 9.2.1 Macro-Averaging

Calcola la metrica per ogni classe separatamente, poi fa la media:

$\text{Metric}_{\text{macro}} = \frac{1}{C} \sum_{c=1}^{C} \text{Metric}_c$

**Proprietà**:
- **Peso uguale a tutte le classi**: Ogni classe contribuisce equamente
- **Sensibile a classi rare**: Una classe con pochi esempi ha lo stesso peso di una grande
- **Uso**: Quando tutte le classi sono ugualmente importanti

**Esempio**:
- Classe 1: 10 esempi, Precision = 0.5
- Classe 2: 1000 esempi, Precision = 0.9
- Macro-Precision = $(0.5 + 0.9)/2 = 0.7$

#### 9.2.2 Micro-Averaging

Aggrega i conteggi globalmente prima di calcolare la metrica:

$\text{Precision}_{\text{micro}} = \frac{\sum_{c=1}^{C} TP_c}{\sum_{c=1}^{C} (TP_c + FP_c)}$

$\text{Recall}_{\text{micro}} = \frac{\sum_{c=1}^{C} TP_c}{\sum_{c=1}^{C} (TP_c + FN_c)}$

**Proprietà**:
- **Peso proporzionale alla dimensione**: Classi grandi dominano
- **Equivale all'accuracy** per classificazione multi-classe bilanciata
- **Uso**: Quando si vuole enfatizzare le performance sulle classi più comuni

**Esempio** (stesso di prima):
- Micro-Precision = $(TP_1 + TP_2)/(TP_1 + TP_2 + FP_1 + FP_2)$
- Sarà vicino a 0.9 (dominato dalla classe 2)

#### 9.2.3 Weighted-Averaging

Pesa le metriche per classe in base alla loro frequenza:

$\text{Metric}_{\text{weighted}} = \sum_{c=1}^{C} w_c \cdot \text{Metric}_c$

dove $w_c = \frac{N_c}{N}$ è la proporzione di esempi nella classe $c$.

**Proprietà**:
- **Compromesso**: Via di mezzo tra macro e micro
- **Uso**: Quando si vuole dare importanza proporzionale ma non esclusiva alle classi grandi

**Confronto**:

| Strategia | Peso classi | Sensibilità sbilanciamento | Uso tipico |
|-----------|-------------|---------------------------|------------|
| Macro | Uguale | Alta | Classi ugualmente importanti |
| Micro | Proporzionale (volume) | Bassa | Enfasi su classi comuni |
| Weighted | Proporzionale (frequenza) | Media | Compromesso generale |

### 9.3 Cohen's Kappa Multi-Classe

Estensione diretta della formula binaria:

$\kappa = \frac{p_o - p_e}{1 - p_e}$

dove ora:

$p_o = \frac{\sum_{c=1}^{C} M_{cc}}{N} = \frac{\text{Trace}(M)}{N}$

$p_e = \sum_{c=1}^{C} \frac{N_c \cdot \hat{N}_c}{N^2}$

dove $N_c = \sum_j M_{cj}$ (veri positivi classe $c$) e $\hat{N}_c = \sum_i M_{ic}$ (predetti classe $c$).

**Interpretazione**: Stesso range e interpretazione del caso binario.

### 9.4 Matthews Correlation Coefficient Multi-Classe

La generalizzazione del MCC per $C$ classi è il **R_K coefficient**:

$\text{MCC}_{\text{multi}} = \frac{\sum_c M_{cc} \cdot N - \sum_c N_c \hat{N}_c}{\sqrt{N^2 - \sum_c \hat{N}_c^2} \cdot \sqrt{N^2 - \sum_c N_c^2}}$

**Proprietà**:
- Range: $[-1, +1]$
- Riduce al MCC binario per $C=2$
- Simmetrico e invariante a permutazioni di classe

### 9.5 Curve PR Multi-Classe

#### 9.5.1 One-vs-Rest (OvR)

Per ogni classe $c$, trattiamo il problema come binario:
- Positivi: Classe $c$
- Negativi: Tutte le altre classi

Generiamo $C$ curve PR separate, una per classe.

**Aggregazione**:

**Macro-average PR**: Media delle PR curve per ogni classe.

**Micro-average PR**: Pool di tutti i TP, FP, FN attraverso le classi:

$\text{Precision}_{\text{micro}} = \frac{\sum_{c} TP_c}{\sum_c (TP_c + FP_c)}$

$\text{Recall}_{\text{micro}} = \frac{\sum_{c} TP_c}{\sum_c (TP_c + FN_c)}$

Plottiamo questi valori globali per generare un'unica curva.

**Interpretazione**:
- Macro: Peso uguale a ogni classe
- Micro: Peso proporzionale alla frequenza, dominato da classi grandi

## 10. Interpretazioni Statistiche Avanzate

### 10.1 ROC come Test di Mann-Whitney U

**Teorema (Equivalenza AUC e Mann-Whitney U)**:

L'AUC è equivalente alla statistica U del test di Mann-Whitney:

$\text{AUC} = \frac{U}{n_+ \cdot n_-}$

dove:
- $n_+$ = numero di esempi positivi
- $n_-$ = numero di esempi negativi
- $U = \sum_{i=1}^{n_+} \sum_{j=1}^{n_-} \mathbb{I}(f(x_i^+) > f(x_j^-))$

**Interpretazione**: $U$ conta il numero di coppie $(x_+, x_-)$ dove lo score del positivo supera quello del negativo.

**Dimostrazione** (sketch):

Per costruzione, AUC è la probabilità che un esempio positivo casuale abbia score maggiore di un negativo casuale:

$\text{AUC} = P(f(X_+) > f(X_-))$

Questo può essere stimato campionariamente come:

$\hat{\text{AUC}} = \frac{1}{n_+ n_-} \sum_{i=1}^{n_+} \sum_{j=1}^{n_-} \mathbb{I}(f(x_i^+) > f(x_j^-)) = \frac{U}{n_+ n_-}$

La statistica U è esattamente questa stima. $\square$

**Implicazione**: Il test di Mann-Whitney U per verificare se due distribuzioni sono diverse è equivalente a testare se AUC ≠ 0.5.

### 10.2 PR come Metrica per Dati Sbilanciati

**Teorema (Sensibilità al Prior)**:

Dato uno shift nella prevalenza da $\pi_{\text{train}}$ a $\pi_{\text{test}}$:

- **ROC-AUC**: Invariante (dipende solo da $p(x|y)$)
- **PR-AUC**: Cambia (dipende da $p(y|x) \propto p(x|y)p(y)$)

**Dimostrazione**:

ROC usa TPR e FPR che sono entrambi condizionati su $y$:

$\text{TPR} = P(\hat{y}=1|y=1) \quad \text{FPR} = P(\hat{y}=1|y=0)$

Questi dipendono solo da $p(x|y)$ e dalla soglia, non dalla prevalenza $p(y)$.

PR usa Precision che dipende dal prior:

$\text{Precision} = P(y=1|\hat{y}=1) = \frac{P(\hat{y}=1|y=1)P(y=1)}{P(\hat{y}=1)}$

Applicando Bayes, vediamo che Precision dipende esplicitamente da $P(y=1) = \pi$. $\square$

**Implicazione pratica**: Se la prevalenza cambia tra training e test, la curva PR sarà diversa, ma la ROC rimarrà la stessa. Questo rende PR più "onesta" per dataset molto sbilanciati.

### 10.3 Expected Precision in Ranking

Per sistemi di ranking (information retrieval), la curva PR può essere interpretata come:

$\text{Expected Precision at random recall level}$

Se scegliamo casualmente un livello di recall $r \in [0,1]$, la precision media attesa è:

$\mathbb{E}[P(r)] = \int_0^1 P(r) dr = \text{AP}$

Questo giustifica l'uso di Average Precision come metrica singola.

## 11. Linee Guida Pratiche per la Scelta delle Metriche

### 11.1 Albero Decisionale per la Scelta

```
START
│
├─ Dataset bilanciato?
│  ├─ SÌ → Accuracy, F1, ROC-AUC
│  └─ NO ↓
│
├─ Classe positiva molto rara (< 5%)?
│  ├─ SÌ → PR-AUC, F2, Recall @ fixed FPR
│  └─ NO → F1, Balanced Accuracy, MCC
│
├─ Costi FP e FN asimmetrici?
│  ├─ SÌ → Ottimizza soglia per costo totale
│  │       Usa F-beta appropriato
│  └─ NO → F1-Score
│
├─ Interessa il ranking?
│  ├─ SÌ → AUC-ROC o AUC-PR, Precision@K
│  └─ NO → Metriche basate su soglia fissa
│
├─ Probabilità predette importanti?
│  ├─ SÌ → Log Loss, Brier Score, ECE
│  └─ NO → Metriche basate su label hard
│
└─ Multi-classe?
   ├─ Classi bilanciate → Micro-averaged metrics
   ├─ Classi sbilanciate → Macro-averaged metrics
   └─ Classe importante specifica → OvR per quella classe
```

### 11.2 Metriche per Scenario

#### Scenario: Diagnosi Medica
**Priorità**: Minimizzare falsi negativi
- **Metriche primarie**: Recall, F2-Score, FNR
- **Metriche secondarie**: Specificity (per evitare troppi falsi allarmi)
- **Soglia**: Ottimizzare per costo $L_{FN} \gg L_{FP}$

#### Scenario: Spam Detection
**Priorità**: Minimizzare falsi positivi
- **Metriche primarie**: Precision, F0.5-Score, FPR
- **Metriche secondarie**: Recall (catturare abbastanza spam)
- **Soglia**: Alta, ottimizzare per costo $L_{FP} > L_{FN}$

#### Scenario: Information Retrieval
**Priorità**: Ranking corretto
- **Metriche primarie**: AUC-PR, MAP, NDCG, Precision@K
- **Metriche secondarie**: Recall@K
- **Nota**: Non serve soglia fissa, importa l'ordinamento

#### Scenario: Rilevamento Frodi (Rare)
**Priorità**: Catturare frodi, dataset molto sbilanciato
- **Metriche primarie**: PR-AUC, Recall @ FPR fissato, F2
- **Metriche secondarie**: Precision (per evitare overhead investigativo)
- **Nota**: ROC-AUC può essere ingannevole

#### Scenario: Multi-Classe Sbilanciato
**Priorità**: Performance su tutte le classi
- **Metriche primarie**: Macro F1, Balanced Accuracy, MCC multi-classe
- **Metriche secondarie**: Confusion matrix, per-class precision/recall
- **Nota**: Micro-averaging maschera performance su classi rare

### 11.3 Checklist Completa per Valutazione

- [ ] **Analisi Esplorativa**
  - [ ] Calcolare prevalenza di classe
  - [ ] Visualizzare matrice di confusione
  - [ ] Identificare pattern di errore

- [ ] **Metriche Base**
  - [ ] Accuracy (solo se bilanciato)
  - [ ] Precision, Recall, F1
  - [ ] Specificity, FPR, FNR

- [ ] **Metriche Robuste**
  - [ ] MCC o Cohen's Kappa
  - [ ] Balanced Accuracy (se sbilanciato)

- [ ] **Curve e AUC**
  - [ ] ROC curve e AUC-ROC
  - [ ] PR curve e AUC-PR (se sbilanciato)
  - [ ] Identificare EER

- [ ] **Probabilità**
  - [ ] Log Loss o Brier Score
  - [ ] Reliability diagram
  - [ ] ECE

- [ ] **Ottimizzazione Soglia**
  - [ ] Grid search per F-beta ottimale
  - [ ] Soglia per costo specifico (se noto)

- [ ] **Validazione**
  - [ ] Cross-validation (almeno 5-fold)
  - [ ] Riportare media ± std
  - [ ] Test su hold-out set

- [ ] **Documentazione**
  - [ ] Scelta metriche giustificata
  - [ ] Limitazioni discusse
  - [ ] Intervalli di confidenza

## 12. Conclusioni

### 12.1 Principi Fondamentali

1. **Non esiste una metrica universale**: Ogni problema richiede metriche appropriate al contesto

2. **Usa metriche multiple**: Una singola metrica può essere ingannevole

3. **Considera i costi**: FP e FN hanno spesso costi asimmetrici nel mondo reale

4. **Dataset sbilanciati richiedono metriche speciali**: Accuracy e ROC-AUC possono mascherare problemi

5. **Le probabilità contano**: Se il modello produce probabilità, valutale con metriche appropriate

6. **Visualizza sempre**: Curve (ROC, PR), matrici di confusione e reliability plots forniscono insight

7. **Valida robustamente**: Cross-validation e intervalli di confidenza sono essenziali