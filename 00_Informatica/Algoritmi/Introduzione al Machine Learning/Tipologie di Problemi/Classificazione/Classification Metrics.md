# Metriche di Valutazione per Classificazione in Machine Learning

## 1. Introduzione

La valutazione di modelli di classificazione richiede metriche specifiche che quantifichino la qualità delle predizioni. Questo documento presenta una trattazione completa e rigorosa delle principali metriche utilizzate nel machine learning.

## 2. Matrice di Confusione

La **matrice di confusione** è la base per calcolare tutte le metriche di classificazione. Per un problema binario:

|                    | **Predetto Positivo (P)** | **Predetto Negativo (N)** |
|--------------------|---------------------------|---------------------------|
| **Reale Positivo** | TP (True Positive)        | FN (False Negative)       |
| **Reale Negativo** | FP (False Positive)       | TN (True Negative)        |

### 2.1 Definizioni Rigorose

- **TP (True Positive)**: Istanze positive correttamente classificate come positive
- **TN (True Negative)**: Istanze negative correttamente classificate come negative
- **FP (False Positive)**: Istanze negative erroneamente classificate come positive (Errore di Tipo II)
- **FN (False Negative)**: Istanze positive erroneamente classificate come negative (Errore di Tipo I)

### 2.2 Visualizzazione della Matrice di Confusione

```python
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt
import numpy as np

X, y = make_classification(n_samples=1000, n_features=20, n_informative=15, 
                          n_redundant=5, random_state=42)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)
clf = RandomForestClassifier(random_state=42)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)

fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Matrice assoluta
cm = confusion_matrix(y_test, y_pred)
disp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=['Negativo', 'Positivo'])
disp.plot(cmap='Blues', ax=axes[0])
axes[0].set_title('Matrice di Confusione (Valori Assoluti)')

# Matrice normalizzata
cm_norm = confusion_matrix(y_test, y_pred, normalize='true')
disp_norm = ConfusionMatrixDisplay(confusion_matrix=cm_norm, display_labels=['Negativo', 'Positivo'])
disp_norm.plot(cmap='Greens', ax=axes[1], values_format='.2%')
axes[1].set_title('Matrice di Confusione (Normalizzata)')

plt.tight_layout()
plt.show()

tn, fp, fn, tp = cm.ravel()
print(f"True Positives (TP): {tp}")
print(f"True Negatives (TN): {tn}")
print(f"False Positives (FP): {fp}")
print(f"False Negatives (FN): {fn}")
```

### 2.3 Interpretazione Probabilistica

Dato un sistema di classificazione con soglia $\tau$, possiamo definire due ipotesi:

- **$H_0$**: L'istanza appartiene alla classe negativa
- **$H_1$**: L'istanza appartiene alla classe positiva

E due possibili decisioni:

- **$D_0$**: Classificare come negativo
- **$D_1$**: Classificare come positivo

Allora:
- **False Positive Rate (FPR)** = $P(D_1 | H_0)$ = Probabilità di classificare come positivo quando è negativo
- **False Negative Rate (FNR)** = $P(D_0 | H_1)$ = Probabilità di classificare come negativo quando è positivo

```python
from scipy import stats

fig, ax = plt.subplots(figsize=(12, 6))

# Simula distribuzioni positive vs negative
positive_scores = np.random.beta(8, 2, 1000)
negative_scores = np.random.beta(2, 8, 1000)

ax.hist(negative_scores, bins=50, alpha=0.6, label='Classe Negativa ($H_0$)', 
        color='red', density=True)
ax.hist(positive_scores, bins=50, alpha=0.6, label='Classe Positiva ($H_1$)', 
        color='green', density=True)

threshold = 0.5
ax.axvline(threshold, color='black', linestyle='--', linewidth=2, 
          label=f'Soglia $\\tau$ = {threshold}')

# Area FPR e FNR
x_fp = np.linspace(threshold, 1, 100)
x_fn = np.linspace(0, threshold, 100)

ax.fill_between(x_fp, 0, stats.beta.pdf(x_fp, 2, 8), alpha=0.3, color='red', 
                label='FPR (Errore Tipo II)')
ax.fill_between(x_fn, 0, stats.beta.pdf(x_fn, 8, 2), alpha=0.3, color='orange', 
                label='FNR (Errore Tipo I)')

ax.set_xlabel('Score di Classificazione')
ax.set_ylabel('Densità di Probabilità')
ax.set_title('Distribuzioni delle Classi e Errori al Variare della Soglia')
ax.legend()
ax.grid(alpha=0.3)
plt.show()
```

## 3. Metriche Fondamentali

### 3.1 Accuracy (Accuratezza)

L'**accuracy** misura la proporzione di predizioni corrette sul totale:

$$\text{Accuracy} = \frac{TP + TN}{TP + TN + FP + FN}$$

**Vantaggi**: Intuitiva e semplice  
**Svantaggi**: Inadeguata per dataset sbilanciati (può essere alta anche con un modello che predice sempre la classe maggioritaria)

```python
from sklearn.metrics import accuracy_score

accuracy = accuracy_score(y_test, y_pred)
print(f'Accuracy: {accuracy:.4f}')

# Visualizzazione impatto dello sbilanciamento
class_ratios = [0.5, 0.7, 0.9, 0.95, 0.99]
dummy_accuracies = class_ratios

fig, ax = plt.subplots(figsize=(10, 6))
ax.plot(class_ratios, dummy_accuracies, 'o-', linewidth=2, markersize=8, 
        label='Accuracy modello "dummy" (predice sempre classe maggioritaria)')
ax.axhline(accuracy, color='red', linestyle='--', linewidth=2, 
          label=f'Accuracy modello reale: {accuracy:.3f}')
ax.set_xlabel('Proporzione Classe Maggioritaria', fontsize=12)
ax.set_ylabel('Accuracy', fontsize=12)
ax.set_title('Accuracy può essere ingannevole con dataset sbilanciati!', fontsize=14)
ax.legend()
ax.grid(alpha=0.3)
plt.show()
```

### 3.2 Precision (Precisione)

La **precision** misura la proporzione di predizioni positive che sono effettivamente corrette:

$$\text{Precision} = \frac{TP}{TP + FP}$$

Risponde alla domanda: *"Tra tutti i casi predetti come positivi, quanti sono realmente positivi?"*

**Quando è critica**: Alto costo dei falsi positivi (es. spam detection, diagnosi mediche che richiedono trattamenti invasivi)

```python
from sklearn.metrics import precision_score

precision = precision_score(y_test, y_pred)
print(f'Precision: {precision:.4f}')

# Visualizzazione interpretazione
fig, ax = plt.subplots(figsize=(10, 6))
categories = ['Predetti\nPositivi', 'di cui Veri\nPositivi (TP)', 'di cui Falsi\nPositivi (FP)']
values = [tp + fp, tp, fp]
colors = ['lightblue', 'green', 'red']

bars = ax.bar(categories, values, color=colors, alpha=0.7, edgecolor='black', linewidth=2)
ax.set_ylabel('Numero di Campioni', fontsize=12)
ax.set_title(f'Precision = TP / (TP + FP) = {tp}/{tp+fp} = {precision:.3f}', fontsize=14)

for bar, val in zip(bars, values):
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height,
            f'{val}', ha='center', va='bottom', fontsize=12, fontweight='bold')

plt.tight_layout()
plt.show()
```

### 3.3 Recall (Sensibilità, True Positive Rate, TPR)

Il **recall** misura la proporzione di istanze positive che sono state correttamente identificate:

$$\text{Recall} = \text{TPR} = \text{Sensitivity} = \frac{TP}{TP + FN}$$

Risponde alla domanda: *"Tra tutti i casi realmente positivi, quanti sono stati identificati?"*

**Quando è critico**: Alto costo dei falsi negativi (es. rilevamento tumori, frodi finanziarie, sistemi di sicurezza)

```python
from sklearn.metrics import recall_score

recall = recall_score(y_test, y_pred)
print(f'Recall: {recall:.4f}')

# Visualizzazione interpretazione
fig, ax = plt.subplots(figsize=(10, 6))
categories = ['Reali\nPositivi', 'di cui Identificati\n(TP)', 'di cui Mancati\n(FN)']
values = [tp + fn, tp, fn]
colors = ['lightblue', 'green', 'orange']

bars = ax.bar(categories, values, color=colors, alpha=0.7, edgecolor='black', linewidth=2)
ax.set_ylabel('Numero di Campioni', fontsize=12)
ax.set_title(f'Recall = TP / (TP + FN) = {tp}/{tp+fn} = {recall:.3f}', fontsize=14)

for bar, val in zip(bars, values):
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height,
            f'{val}', ha='center', va='bottom', fontsize=12, fontweight='bold')

plt.tight_layout()
plt.show()
```

### 3.4 Specificity (Specificità, True Negative Rate)

La **specificity** misura la proporzione di istanze negative correttamente identificate:

$$\text{Specificity} = \text{TNR} = \frac{TN}{TN + FP}$$

**Relazione con FPR**:
$$\text{FPR} = 1 - \text{Specificity} = \frac{FP}{FP + TN}$$

```python
specificity = tn / (tn + fp)
fpr = fp / (fp + tn)
print(f'Specificity: {specificity:.4f}')
print(f'FPR (1-Specificity): {fpr:.4f}')
```

### 3.5 Trade-off Precision vs Recall

Precision e Recall sono tipicamente in trade-off: migliorare una peggiora l'altra.

```python
from sklearn.metrics import precision_recall_curve

y_proba = clf.predict_proba(X_test)[:, 1]
precisions, recalls, thresholds = precision_recall_curve(y_test, y_proba)

fig, axes = plt.subplots(1, 2, figsize=(15, 5))

# Curva Precision-Recall
axes[0].plot(recalls, precisions, linewidth=2, color='purple')
axes[0].scatter([recall], [precision], color='red', s=200, zorder=5, 
               label=f'Soglia attuale\nP={precision:.3f}, R={recall:.3f}')
axes[0].set_xlabel('Recall', fontsize=12)
axes[0].set_ylabel('Precision', fontsize=12)
axes[0].set_title('Trade-off Precision-Recall', fontsize=14)
axes[0].grid(alpha=0.3)
axes[0].legend()

# Precision e Recall vs Soglia
axes[1].plot(thresholds, precisions[:-1], label='Precision', linewidth=2)
axes[1].plot(thresholds, recalls[:-1], label='Recall', linewidth=2)
axes[1].set_xlabel('Soglia di Classificazione', fontsize=12)
axes[1].set_ylabel('Valore Metrica', fontsize=12)
axes[1].set_title('Precision e Recall al variare della Soglia', fontsize=14)
axes[1].legend()
axes[1].grid(alpha=0.3)

plt.tight_layout()
plt.show()
```

### 3.6 F1-Score

L'**F1-score** è la media armonica di precision e recall, bilanciando i due aspetti:

$$F_1 = 2 \cdot \frac{\text{Precision} \cdot \text{Recall}}{\text{Precision} + \text{Recall}} = \frac{2TP}{2TP + FP + FN}$$

La media armonica penalizza valori estremi: se Precision o Recall è bassa, anche F1 sarà bassa.

**Perché media armonica?** 
$$\text{Media Aritmetica} = \frac{P + R}{2} \quad \text{vs} \quad \text{Media Armonica} = \frac{2}{\frac{1}{P} + \frac{1}{R}}$$

La media armonica è più severa con valori sbilanciati.

```python
from sklearn.metrics import f1_score

f1 = f1_score(y_test, y_pred)
print(f'F1-Score: {f1:.4f}')

# Confronto medie
test_cases = [(0.9, 0.9), (0.9, 0.5), (0.9, 0.1), (0.5, 0.5)]
fig, ax = plt.subplots(figsize=(10, 6))

for i, (p, r) in enumerate(test_cases):
    harmonic = 2 * p * r / (p + r) if (p + r) > 0 else 0
    arithmetic = (p + r) / 2
    
    x_pos = [i*3, i*3+1]
    ax.bar(x_pos, [arithmetic, harmonic], width=0.8, 
           color=['lightblue', 'orange'], alpha=0.7,
           label=['Media Aritmetica', 'Media Armonica (F1)'] if i == 0 else '')
    ax.text(i*3 + 0.5, max(arithmetic, harmonic) + 0.05, 
           f'P={p}, R={r}', ha='center', fontsize=10, fontweight='bold')

ax.set_xticks([i*3 + 0.5 for i in range(len(test_cases))])
ax.set_xticklabels([f'Caso {i+1}' for i in range(len(test_cases))])
ax.set_ylabel('Valore', fontsize=12)
ax.set_title('F1 (Media Armonica) penalizza valori sbilanciati', fontsize=14)
ax.legend()
ax.grid(axis='y', alpha=0.3)
plt.tight_layout()
plt.show()
```

### 3.7 F-Beta Score

Generalizzazione dell'F1-score che permette di pesare diversamente precision e recall:

$$F_\beta = (1 + \beta^2) \cdot \frac{\text{Precision} \cdot \text{Recall}}{\beta^2 \cdot \text{Precision} + \text{Recall}}$$

- **$\beta < 1$**: Maggior peso alla precision
- **$\beta > 1$**: Maggior peso al recall
- **$\beta = 1$**: F1-score standard (bilanciamento)
- **$\beta = 2$**: F2-score (recall conta il doppio)
- **$\beta = 0.5$**: F0.5-score (precision conta il doppio)

```python
from sklearn.metrics import fbeta_score

betas = [0.5, 1, 2, 3]
f_scores = [fbeta_score(y_test, y_pred, beta=b) for b in betas]

fig, ax = plt.subplots(figsize=(10, 6))
bars = ax.bar([f'F{b}' for b in betas], f_scores, color=['red', 'purple', 'blue', 'green'], alpha=0.7)
ax.axhline(precision, color='red', linestyle='--', label=f'Precision: {precision:.3f}')
ax.axhline(recall, color='blue', linestyle='--', label=f'Recall: {recall:.3f}')
ax.set_ylabel('Score', fontsize=12)
ax.set_title('F-Beta Score: Bilanciamento tra Precision e Recall', fontsize=14)
ax.legend()
ax.grid(axis='y', alpha=0.3)

for bar, score in zip(bars, f_scores):
    ax.text(bar.get_x() + bar.get_width()/2, score + 0.01,
           f'{score:.3f}', ha='center', va='bottom', fontweight='bold')

plt.tight_layout()
plt.show()

print(f'F0.5-Score (favorisce Precision): {f_scores[0]:.4f}')
print(f'F1-Score (bilanciato): {f_scores[1]:.4f}')
print(f'F2-Score (favorisce Recall): {f_scores[2]:.4f}')
```

## 4. Tassi di Errore (Error Rates)

### 4.1 False Positive Rate (FPR) - Fall-out

Il **FPR** misura la proporzione di istanze negative erroneamente classificate come positive:

$$\text{FPR} = \frac{FP}{FP + TN} = 1 - \text{Specificity}$$

Se FPR = 0.1% → 1 su 1000 negativi viene erroneamente classificato come positivo

### 4.2 False Negative Rate (FNR) - Miss Rate

Il **FNR** misura la proporzione di istanze positive erroneamente classificate come negative:

$$\text{FNR} = \frac{FN}{FN + TP} = 1 - \text{Recall}$$

Se FNR = 0.05% → 1 su 2000 positivi viene erroneamente classificato come negativo

### 4.3 False Discovery Rate (FDR)

Il **FDR** misura la proporzione di predizioni positive che sono errate:

$$\text{FDR} = \frac{FP}{FP + TP} = 1 - \text{Precision}$$

### 4.4 Visualizzazione Completa dei Tassi di Errore

```python
# Calcolo di tutti i tassi
fpr = fp / (fp + tn)
fnr = fn / (fn + tp)
fdr = fp / (fp + tp)
tpr = tp / (tp + fn)  # = Recall
tnr = tn / (tn + fp)  # = Specificity

fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Grafico 1: FPR vs TNR
rates_neg = [tnr, fpr]
labels_neg = ['TNR\n(Specificity)', 'FPR\n(Fall-out)']
colors_neg = ['green', 'red']
axes[0, 0].bar(labels_neg, rates_neg, color=colors_neg, alpha=0.7, edgecolor='black', linewidth=2)
axes[0, 0].set_ylabel('Tasso', fontsize=12)
axes[0, 0].set_title('Classi Negative: TNR + FPR = 1', fontsize=14)
axes[0, 0].set_ylim([0, 1.1])
for i, (label, rate) in enumerate(zip(labels_neg, rates_neg)):
    axes[0, 0].text(i, rate + 0.02, f'{rate:.3f}', ha='center', fontsize=11, fontweight='bold')
axes[0, 0].axhline(1.0, color='black', linestyle='--', alpha=0.5)
axes[0, 0].grid(axis='y', alpha=0.3)

# Grafico 2: FNR vs TPR
rates_pos = [tpr, fnr]
labels_pos = ['TPR\n(Recall)', 'FNR\n(Miss Rate)']
colors_pos = ['green', 'orange']
axes[0, 1].bar(labels_pos, rates_pos, color=colors_pos, alpha=0.7, edgecolor='black', linewidth=2)
axes[0, 1].set_ylabel('Tasso', fontsize=12)
axes[0, 1].set_title('Classi Positive: TPR + FNR = 1', fontsize=14)
axes[0, 1].set_ylim([0, 1.1])
for i, (label, rate) in enumerate(zip(labels_pos, rates_pos)):
    axes[0, 1].text(i, rate + 0.02, f'{rate:.3f}', ha='center', fontsize=11, fontweight='bold')
axes[0, 1].axhline(1.0, color='black', linestyle='--', alpha=0.5)
axes[0, 1].grid(axis='y', alpha=0.3)

# Grafico 3: Tutte le metriche complementari
all_rates = [tpr, fnr, tnr, fpr, precision, fdr]
all_labels = ['TPR\n(Recall)', 'FNR', 'TNR\n(Spec)', 'FPR', 'Precision', 'FDR']
all_colors = ['green', 'orange', 'green', 'red', 'blue', 'purple']
bars = axes[1, 0].bar(range(len(all_rates)), all_rates, color=all_colors, alpha=0.7, 
                      edgecolor='black', linewidth=2)
axes[1, 0].set_xticks(range(len(all_rates)))
axes[1, 0].set_xticklabels(all_labels, fontsize=10)
axes[1, 0].set_ylabel('Valore', fontsize=12)
axes[1, 0].set_title('Panoramica Completa delle Metriche', fontsize=14)
axes[1, 0].set_ylim([0, 1.1])
for bar, rate in zip(bars, all_rates):
    axes[1, 0].text(bar.get_x() + bar.get_width()/2, rate + 0.02,
                    f'{rate:.3f}', ha='center', fontsize=10, fontweight='bold')
axes[1, 0].grid(axis='y', alpha=0.3)

# Grafico 4: Relazioni complementari
axes[1, 1].axis('off')
relations = [
    'TPR + FNR = 1',
    'TNR + FPR = 1',
    'Precision + FDR = 1',
    '',
    'TPR = Recall = Sensitivity',
    'FPR = 1 - Specificity = Fall-out',
    'FNR = 1 - Recall = Miss Rate',
    '',
    'FPR: tasso errori su negativi',
    'FNR: tasso errori su positivi'
]
y_start = 0.95
for i, rel in enumerate(relations):
    if rel:
        axes[1, 1].text(0.1, y_start - i*0.08, rel, fontsize=11, 
                       family='monospace')
axes[1, 1].set_title('Relazioni e Equivalenze', fontsize=14, fontweight='bold')

plt.tight_layout()
plt.show()
```

## 5. Curve ROC e AUC

### 5.1 Curva ROC (Receiver Operating Characteristic)

La **curva ROC** visualizza il trade-off tra TPR (Recall/Sensitivity) e FPR (Fall-out) al variare della soglia di classificazione:

- **Asse Y**: True Positive Rate (TPR) = Recall = Sensitivity
- **Asse X**: False Positive Rate (FPR) = Fall-out = 1 - Specificity

$$\text{TPR}(\tau) = \frac{TP(\tau)}{TP(\tau) + FN(\tau)}$$

$$\text{FPR}(\tau) = \frac{FP(\tau)}{FP(\tau) + TN(\tau)}$$

**Interpretazione**:
- Punto (0, 0): Tutto classificato come negativo (soglia infinita)
- Punto (1, 1): Tutto classificato come positivo (soglia zero)
- Punto (0, 1): Classificatore perfetto
- Diagonale: Classificatore casuale

```python
from sklearn.metrics import roc_curve, auc

fpr_roc, tpr_roc, thresholds_roc = roc_curve(y_test, y_proba)
roc_auc = auc(fpr_roc, tpr_roc)

fig, axes = plt.subplots(1, 2, figsize=(15, 6))

# Curva ROC standard
axes[0].plot(fpr_roc, tpr_roc, color='darkorange', lw=3, 
            label=f'ROC curve (AUC = {roc_auc:.3f})')
axes[0].plot([0, 1], [0, 1], color='navy', lw=2, linestyle='--', 
            label='Random Classifier (AUC = 0.5)')
axes[0].fill_between(fpr_roc, tpr_roc, alpha=0.3, color='orange')
axes[0].scatter([0], [1], s=200, c='green', marker='*', zorder=5, 
               label='Classificatore Perfetto')
axes[0].set_xlim([0.0, 1.0])
axes[0].set_ylim([0.0, 1.05])
axes[0].set_xlabel('False Positive Rate (FPR = 1 - Specificity)', fontsize=12)
axes[0].set_ylabel('True Positive Rate (TPR = Recall = Sensitivity)', fontsize=12)
axes[0].set_title('Receiver Operating Characteristic (ROC)', fontsize=14, fontweight='bold')
axes[0].legend(loc="lower right")
axes[0].grid(alpha=0.3)

# ROC con annotazioni
axes[1].plot(fpr_roc, tpr_roc, color='darkorange', lw=3)
axes[1].plot([0, 1], [0, 1], color='navy', lw=2, linestyle='--')
axes[1].fill_between(fpr_roc, tpr_roc, alpha=0.2, color='orange', label='AUC')

# Annotazioni interpretative
axes[1].annotate('Soglia Alta\n(Conservativo)\nFPR↓ FNR↑', 
                xy=(0.1, 0.5), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.7))
axes[1].annotate('Soglia Bassa\n(Permissivo)\nFPR↑ FNR↓', 
                xy=(0.7, 0.9), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightcoral', alpha=0.7))

axes[1].set_xlim([0.0, 1.0])
axes[1].set_ylim([0.0, 1.05])
axes[1].set_xlabel('FPR (False Positive Rate)', fontsize=12)
axes[1].set_ylabel('TPR (True Positive Rate)', fontsize=12)
axes[1].set_title('ROC: Interpretazione delle Zone', fontsize=14, fontweight='bold')
axes[1].legend(loc="lower right")
axes[1].grid(alpha=0.3)

plt.tight_layout()
plt.show()
```

### 5.2 AUC (Area Under the ROC Curve)

L'**AUC** quantifica l'area sotto la curva ROC:

$$\text{AUC} = \int_0^1 \text{TPR}(t) \, d(\text{FPR}(t)) = P(\text{score}_{\text{positive}} > \text{score}_{\text{negative}})$$

L'AUC rappresenta la **probabilità che il classificatore assegni uno score più alto a un esempio positivo casuale rispetto a uno negativo casuale**.

**Interpretazione Rigorosa**:
- **AUC = 1.0**: Classificatore perfetto (separa completamente le classi)
- **AUC = 0.5**: Classificatore casuale (nessun potere discriminante)
- **AUC < 0.5**: Peggio del caso (predizioni invertite)
- **0.5 < AUC < 0.7**: Scarso
- **0.7 ≤ AUC < 0.8**: Accettabile  
- **0.8 ≤ AUC < 0.9**: Eccellente
- **AUC ≥ 0.9**: Outstanding

**Proprietà matematiche**:
- Invariante alla scala (dipende solo dall'ordinamento)
- Robusta a classi sbilanciate (confronta distribuzioni)
- Equivale al test di Wilcoxon-Mann-Whitney

```python
from sklearn.metrics import roc_auc_score

auc_score = roc_auc_score(y_test, y_proba)

# Visualizzazione interpretazione AUC
fig, axes = plt.subplots(2, 2, figsize=(14, 10))

# Simulazione diversi classificatori
np.random.seed(42)
classifiers = {
    'Perfetto': (np.random.beta(9, 1, 500), np.random.beta(1, 9, 500)),
    'Eccellente': (np.random.beta(7, 2, 500), np.random.beta(2, 7, 500)),
    'Buono': (np.random.beta(5, 3, 500), np.random.beta(3, 5, 500)),
    'Casuale': (np.random.uniform(0, 1, 500), np.random.uniform(0, 1, 500))
}

for idx, (name, (pos_scores, neg_scores)) in enumerate(classifiers.items()):
    ax = axes[idx // 2, idx % 2]
    
    # Distribuzioni
    ax.hist(neg_scores, bins=30, alpha=0.6, label='Negativi', color='red', density=True)
    ax.hist(pos_scores, bins=30, alpha=0.6, label='Positivi', color='green', density=True)
    
    # Calcola AUC
    y_true = np.concatenate([np.ones(len(pos_scores)), np.zeros(len(neg_scores))])
    y_scores = np.concatenate([pos_scores, neg_scores])
    auc_val = roc_auc_score(y_true, y_scores)
    
    ax.set_xlabel('Score', fontsize=11)
    ax.set_ylabel('Densità', fontsize=11)
    ax.set_title(f'{name}: AUC = {auc_val:.3f}', fontsize=12, fontweight='bold')
    ax.legend()
    ax.grid(alpha=0.3)

plt.suptitle('AUC e Separabilità delle Distribuzioni', fontsize=14, fontweight='bold', y=1.02)
plt.tight_layout()
plt.show()

print(f'AUC Score del modello: {auc_score:.4f}')
```

### 5.3 Proprietà e Vantaggi della ROC/AUC

```python
# Dimostrazione robustezza a classi sbilanciate
from sklearn.metrics import precision_recall_curve, average_precision_score

# Crea dataset sbilanciato
imbalance_ratios = [0.5, 0.7, 0.9, 0.95]
aucs = []
aps = []

fig, axes = plt.subplots(2, 2, figsize=(14, 10))

for idx, ratio in enumerate(imbalance_ratios):
    # Genera dati sbilanciati
    n_samples = 1000
    n_positive = int(n_samples * (1 - ratio))
    n_negative = n_samples - n_positive
    
    X_imb, y_imb = make_classification(n_samples=n_samples, n_features=20,
                                       n_informative=15, weights=[ratio, 1-ratio],
                                       random_state=42)
    X_tr, X_te, y_tr, y_te = train_test_split(X_imb, y_imb, test_size=0.3, random_state=42)
    
    clf_imb = RandomForestClassifier(random_state=42)
    clf_imb.fit(X_tr, y_tr)
    y_prob_imb = clf_imb.predict_proba(X_te)[:, 1]
    
    # ROC
    fpr_imb, tpr_imb, _ = roc_curve(y_te, y_prob_imb)
    auc_imb = auc(fpr_imb, tpr_imb)
    aucs.append(auc_imb)
    
    # Precision-Recall
    prec_imb, rec_imb, _ = precision_recall_curve(y_te, y_prob_imb)
    ap_imb = average_precision_score(y_te, y_prob_imb)
    aps.append(ap_imb)
    
    ax = axes[idx // 2, idx % 2]
    ax.plot(fpr_imb, tpr_imb, lw=2, label=f'ROC (AUC={auc_imb:.3f})')
    ax.plot([0, 1], [0, 1], 'k--', lw=1)
    ax.set_xlabel('FPR', fontsize=11)
    ax.set_ylabel('TPR', fontsize=11)
    ax.set_title(f'Classe Pos: {(1-ratio)*100:.0f}% (Ratio 1:{ratio/(1-ratio):.1f})', 
                fontsize=12, fontweight='bold')
    ax.legend()
    ax.grid(alpha=0.3)

plt.suptitle('ROC-AUC è robusta a classi sbilanciate', fontsize=14, fontweight='bold', y=1.02)
plt.tight_layout()
plt.show()

print("\nRobustezza AUC vs Sbilanciamento:")
for ratio, auc_val, ap_val in zip(imbalance_ratios, aucs, aps):
    print(f"  Positivi: {(1-ratio)*100:5.1f}% | AUC: {auc_val:.4f} | AP: {ap_val:.4f}")
```

## 6. Curva Precision-Recall

La **curva Precision-Recall** è particolarmente utile per dataset sbilanciati dove la classe positiva è rara:

```python
precision_curve, recall_curve, thresholds_pr = precision_recall_curve(y_test, y_proba)
avg_precision = average_precision_score(y_test, y_proba)

fig, axes = plt.subplots(1, 2, figsize=(15, 6))

# Curva PR
axes[0].plot(recall_curve, precision_curve, color='blue', lw=3,
            label=f'PR curve (AP = {avg_precision:.3f})')
axes[0].fill_between(recall_curve, precision_curve, alpha=0.3, color='blue')

baseline = np.sum(y_test) / len(y_test)
axes[0].axhline(baseline, color='red', linestyle='--', lw=2,
               label=f'Baseline (prevalenza = {baseline:.3f})')

axes[0].set_xlabel('Recall (TPR)', fontsize=12)
axes[0].set_ylabel('Precision (PPV)', fontsize=12)
axes[0].set_title('Precision-Recall Curve', fontsize=14, fontweight='bold')
axes[0].legend(loc="lower left")
axes[0].grid(alpha=0.3)
axes[0].set_xlim([0.0, 1.0])
axes[0].set_ylim([0.0, 1.05])

# Confronto ROC vs PR per dataset sbilanciato
axes[1].plot(fpr_roc, tpr_roc, 'r-', lw=2, label=f'ROC (AUC={roc_auc:.3f})', alpha=0.7)
axes[1].set_xlabel('FPR / Recall*', fontsize=12)
axes[1].set_ylabel('TPR / Precision*', fontsize=12)

# Sovrapponi PR (scalata)
recall_scaled = recall_curve
precision_scaled = precision_curve  
axes[1].plot(recall_scaled, precision_scaled, 'b-', lw=2, 
            label=f'PR (AP={avg_precision:.3f})', alpha=0.7)

axes[1].set_title('ROC vs PR: Visualizzazione Comparativa', fontsize=14, fontweight='bold')
axes[1].legend()
axes[1].grid(alpha=0.3)
axes[1].set_xlim([0, 1])
axes[1].set_ylim([0, 1.05])

plt.tight_layout()
plt.show()
```

### 6.1 Average Precision (AP)

L'**Average Precision** riassume la curva PR come la media pesata delle precision a ogni soglia:

$$\text{AP} = \sum_n (R_n - R_{n-1}) \cdot P_n$$

dove $P_n$ e $R_n$ sono precision e recall alla soglia $n$.

**Differenza con AUC**:
- AUC-ROC: Buona per dataset bilanciati, mostra trade-off TPR/FPR
- AUC-PR (AP): Preferibile per dataset sbilanciati, focus su classe positiva

```python
print(f"Average Precision: {avg_precision:.4f}")
print(f"ROC-AUC: {roc_auc:.4f}")
print(f"\nPer dataset sbilanciato (classe positiva {baseline*100:.1f}%):")
print(f"  → AP è più informativa di AUC")
```

## 7. Metriche Avanzate

### 7.1 Matthews Correlation Coefficient (MCC)

Il **MCC** è considerato una delle migliori metriche per classificazione binaria, specialmente con classi sbilanciate:

$$\text{MCC} = \frac{TP \cdot TN - FP \cdot FN}{\sqrt{(TP + FP)(TP + FN)(TN + FP)(TN + FN)}}$$

**Proprietà**:
- Range: $[-1, 1]$
- MCC = 1: Predizione perfetta
- MCC = 0: Predizione casuale
- MCC = -1: Totale disaccordo
- Simmetrico rispetto a classi positive/negative
- Robusto a sbilanciamenti

```python
from sklearn.metrics import matthews_corrcoef

mcc = matthews_corrcoef(y_test, y_pred)
print(f'Matthews Correlation Coefficient: {mcc:.4f}')

# Comparazione MCC con altre metriche su dataset sbilanciati
imbalance_ratios = [0.5, 0.7, 0.9, 0.95, 0.99]
metrics_comparison = {'Accuracy': [], 'F1': [], 'MCC': []}

fig, ax = plt.subplots(figsize=(12, 6))

for ratio in imbalance_ratios:
    X_imb, y_imb = make_classification(n_samples=1000, n_features=20,
                                       weights=[ratio, 1-ratio], random_state=42)
    X_tr, X_te, y_tr, y_te = train_test_split(X_imb, y_imb, test_size=0.3, random_state=42)
    
    clf_imb = RandomForestClassifier(random_state=42)
    clf_imb.fit(X_tr, y_tr)
    y_pred_imb = clf_imb.predict(X_te)
    
    metrics_comparison['Accuracy'].append(accuracy_score(y_te, y_pred_imb))
    metrics_comparison['F1'].append(f1_score(y_te, y_pred_imb))
    metrics_comparison['MCC'].append(matthews_corrcoef(y_te, y_pred_imb))

for metric, values in metrics_comparison.items():
    ax.plot(imbalance_ratios, values, marker='o', markersize=8, lw=2, label=metric)

ax.set_xlabel('Proporzione Classe Maggioritaria', fontsize=12)
ax.set_ylabel('Valore Metrica', fontsize=12)
ax.set_title('MCC è più stabile con dataset sbilanciati rispetto ad Accuracy', 
            fontsize=14, fontweight='bold')
ax.legend(fontsize=11)
ax.grid(alpha=0.3)
ax.set_ylim([0, 1.05])

plt.tight_layout()
plt.show()
```

### 7.2 Cohen's Kappa

Il **Cohen's Kappa** misura l'accordo tra predizioni e valori reali, correggendo per l'accordo casuale:

$$\kappa = \frac{p_o - p_e}{1 - p_e}$$

dove:
- $p_o = \frac{TP + TN}{TP + TN + FP + FN}$ : Accuratezza osservata
- $p_e = \frac{(TP+FP)(TP+FN) + (TN+FP)(TN+FN)}{(TP+TN+FP+FN)^2}$ : Accordo casuale atteso

**Interpretazione**:
- $\kappa < 0$: Accordo peggiore del caso
- $0 \leq \kappa < 0.20$: Accordo lieve
- $0.20 \leq \kappa < 0.40$: Accordo discreto
- $0.40 \leq \kappa < 0.60$: Accordo moderato
- $0.60 \leq \kappa < 0.80$: Accordo sostanziale
- $0.80 \leq \kappa \leq 1.00$: Accordo quasi perfetto

```python
from sklearn.metrics import cohen_kappa_score

kappa = cohen_kappa_score(y_test, y_pred)
print(f"Cohen's Kappa: {kappa:.4f}")

# Visualizzazione interpretazione
kappa_ranges = [
    (0, 0.20, 'Lieve', 'lightcoral'),
    (0.20, 0.40, 'Discreto', 'lightyellow'),
    (0.40, 0.60, 'Moderato', 'lightblue'),
    (0.60, 0.80, 'Sostanziale', 'lightgreen'),
    (0.80, 1.00, 'Quasi Perfetto', 'darkgreen')
]

fig, ax = plt.subplots(figsize=(12, 3))

for start, end, label, color in kappa_ranges:
    ax.barh(0, end - start, left=start, height=0.5, color=color, 
           edgecolor='black', linewidth=2, alpha=0.7)
    ax.text((start + end) / 2, 0, f'{label}\n[{start:.1f}-{end:.1f}]', 
           ha='center', va='center', fontsize=10, fontweight='bold')

ax.plot([kappa, kappa], [-0.3, 0.3], 'r-', linewidth=4, label=f'Kappa={kappa:.3f}')
ax.scatter([kappa], [0], s=200, c='red', marker='v', zorder=5, edgecolor='black', linewidth=2)

ax.set_xlim([0, 1])
ax.set_ylim([-0.4, 0.4])
ax.set_xlabel("Cohen's Kappa", fontsize=12)
ax.set_yticks([])
ax.set_title("Interpretazione Cohen's Kappa", fontsize=14, fontweight='bold')
ax.legend(loc='upper left')

plt.tight_layout()
plt.show()
```

### 7.3 Log Loss (Cross-Entropy Loss)

La **Log Loss** valuta la qualità delle probabilità predette, penalizzando fortemente predizioni con alta confidenza ma errate:

$$\text{Log Loss} = -\frac{1}{N} \sum_{i=1}^{N} \left[ y_i \log(p_i) + (1 - y_i) \log(1 - p_i) \right]$$

dove $p_i$ è la probabilità predetta per la classe positiva.

**Proprietà**:
- Range: $[0, \infty)$, valori più bassi sono migliori
- Log Loss = 0: Predizioni probabilistiche perfette
- Penalizza errori con alta confidenza più di altri

```python
from sklearn.metrics import log_loss

logloss = log_loss(y_test, y_proba)
print(f'Log Loss: {logloss:.4f}')

# Dimostrazione penalizzazione
fig, axes = plt.subplots(1, 2, figsize=(14, 5))

# Grafico 1: Log Loss per diverse predizioni
true_label = 1
predicted_probs = np.linspace(0.01, 0.99, 100)
log_losses = [-np.log(p) if true_label == 1 else -np.log(1-p) for p in predicted_probs]

axes[0].plot(predicted_probs, log_losses, 'b-', lw=3)
axes[0].axvline(0.5, color='gray', linestyle='--', alpha=0.5, label='Incertezza (p=0.5)')
axes[0].set_xlabel('Probabilità Predetta (per classe positiva)', fontsize=12)
axes[0].set_ylabel('Log Loss', fontsize=12)
axes[0].set_title('Log Loss penalizza predizioni sbagliate con alta confidenza\n(Vera classe: Positiva)', 
                 fontsize=13, fontweight='bold')
axes[0].set_ylim([0, 5])
axes[0].grid(alpha=0.3)
axes[0].legend()

# Annotazioni
axes[0].annotate('Predizione corretta\ncon alta confidenza\n(Loss → 0)', 
                xy=(0.95, 0.1), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightgreen', alpha=0.7))
axes[0].annotate('Predizione sbagliata\ncon alta confidenza\n(Loss → ∞)', 
                xy=(0.05, 4), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightcoral', alpha=0.7))

# Grafico 2: Esempi concreti
scenarios = [
    ('Corretto\nconfidente', 1, 0.95, 'green'),
    ('Corretto\nincerto', 1, 0.55, 'lightgreen'),
    ('Sbagliato\nincerto', 1, 0.45, 'orange'),
    ('Sbagliato\nconfidente', 1, 0.05, 'red')
]

losses_scenarios = []
for _, true, pred, _ in scenarios:
    loss = -np.log(pred) if true == 1 else -np.log(1-pred)
    losses_scenarios.append(loss)

bars = axes[1].bar(range(len(scenarios)), losses_scenarios, 
                   color=[c for _, _, _, c in scenarios], alpha=0.7, 
                   edgecolor='black', linewidth=2)
axes[1].set_xticks(range(len(scenarios)))
axes[1].set_xticklabels([s[0] for s in scenarios], fontsize=10)
axes[1].set_ylabel('Log Loss', fontsize=12)
axes[1].set_title('Log Loss per Scenari Diversi', fontsize=13, fontweight='bold')
axes[1].grid(axis='y', alpha=0.3)

for bar, loss, (_, _, pred, _) in zip(bars, losses_scenarios, scenarios):
    axes[1].text(bar.get_x() + bar.get_width()/2, loss + 0.05,
                f'{loss:.3f}\np={pred}', ha='center', fontsize=9, fontweight='bold')

plt.tight_layout()
plt.show()
```

### 7.4 Brier Score

Il **Brier Score** misura l'accuratezza delle predizioni probabilistiche come MSE:

$$\text{Brier Score} = \frac{1}{N} \sum_{i=1}^{N} (p_i - y_i)^2$$

**Proprietà**:
- Range: $[0, 1]$, valori più bassi sono migliori
- Brier = 0: Probabilità perfette
- Equivalente al Mean Squared Error

```python
from sklearn.metrics import brier_score_loss

brier = brier_score_loss(y_test, y_proba)
print(f'Brier Score: {brier:.4f}')

# Confronto Log Loss vs Brier Score
fig, ax = plt.subplots(figsize=(10, 6))

true_label = 1
probs = np.linspace(0.01, 0.99, 100)
log_losses_comp = [-np.log(p) for p in probs]
brier_scores = [(p - true_label)**2 for p in probs]

ax.plot(probs, log_losses_comp, 'b-', lw=3, label='Log Loss')
ax2 = ax.twinx()
ax2.plot(probs, brier_scores, 'r-', lw=3, label='Brier Score')

ax.set_xlabel('Probabilità Predetta', fontsize=12)
ax.set_ylabel('Log Loss', fontsize=12, color='blue')
ax2.set_ylabel('Brier Score', fontsize=12, color='red')
ax.set_title('Log Loss vs Brier Score\n(Log Loss penalizza più severamente)', 
            fontsize=14, fontweight='bold')
ax.tick_params(axis='y', labelcolor='blue')
ax2.tick_params(axis='y', labelcolor='red')
ax.grid(alpha=0.3)

lines1, labels1 = ax.get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
ax.legend(lines1 + lines2, labels1 + labels2, loc='upper center')

plt.tight_layout()
plt.show()
```

## 8. Calibrazione delle Probabilità

La **calibration curve** mostra se le probabilità predette riflettono la vera probabilità:

```python
from sklearn.calibration import calibration_curve

fraction_of_positives, mean_predicted_value = calibration_curve(y_test, y_proba, n_bins=10)

fig, axes = plt.subplots(1, 2, figsize=(14, 6))

# Curva di calibrazione
axes[0].plot(mean_predicted_value, fraction_of_positives, "s-", 
            linewidth=2, markersize=8, label="Modello")
axes[0].plot([0, 1], [0, 1], "k--", linewidth=2, label="Perfettamente calibrato")
axes[0].set_xlabel("Probabilità Predetta", fontsize=12)
axes[0].set_ylabel("Frazione di Positivi", fontsize=12)
axes[0].set_title("Curva di Calibrazione", fontsize=14, fontweight='bold')
axes[0].legend()
axes[0].grid(alpha=0.3)

# Distribuzione delle probabilità
axes[1].hist(y_proba[y_test == 0], bins=20, alpha=0.6, label='Negativi', 
            color='red', density=True)
axes[1].hist(y_proba[y_test == 1], bins=20, alpha=0.6, label='Positivi', 
            color='green', density=True)
axes[1].set_xlabel('Probabilità Predetta', fontsize=12)
axes[1].set_ylabel('Densità', fontsize=12)
axes[1].set_title('Distribuzione delle Probabilità Predette', fontsize=14, fontweight='bold')
axes[1].legend()
axes[1].grid(alpha=0.3)

plt.tight_layout()
plt.show()
```

## 9. Metriche per Classificazione Multi-classe

### 9.1 Strategie di Aggregazione

Per estendere le metriche binarie al caso multi-classe:

#### Macro-averaging
$$\text{Metric}_{\text{macro}} = \frac{1}{K} \sum_{k=1}^{K} \text{Metric}_k$$
Tutte le classi hanno lo stesso peso.

#### Micro-averaging
$$\text{Precision}_{\text{micro}} = \frac{\sum_{k=1}^{K} TP_k}{\sum_{k=1}^{K} (TP_k + FP_k)}$$
Aggrega i contributi; favorisce classi frequenti.

#### Weighted-averaging
$$\text{Metric}_{\text{weighted}} = \sum_{k=1}^{K} w_k \cdot \text{Metric}_k$$
dove $w_k$ è la frequenza della classe $k$.

```python
from sklearn.metrics import classification_report

# Dataset multi-classe
X_mc, y_mc = make_classification(n_samples=1000, n_features=20, n_classes=4,
                                  n_informative=15, n_redundant=5, n_clusters_per_class=1,
                                  random_state=42)
X_train_mc, X_test_mc, y_train_mc, y_test_mc = train_test_split(
    X_mc, y_mc, test_size=0.3, random_state=42)

clf_mc = RandomForestClassifier(random_state=42)
clf_mc.fit(X_train_mc, y_train_mc)
y_pred_mc = clf_mc.predict(X_test_mc)

# Calcolo metriche
averages = ['macro', 'micro', 'weighted']
metrics = {}

for avg in averages:
    metrics[avg] = {
        'Precision': precision_score(y_test_mc, y_pred_mc, average=avg, zero_division=0),
        'Recall': recall_score(y_test_mc, y_pred_mc, average=avg, zero_division=0),
        'F1-Score': f1_score(y_test_mc, y_pred_mc, average=avg, zero_division=0)
    }

# Visualizzazione
fig, axes = plt.subplots(1, 2, figsize=(15, 6))

# Grafico comparativo
metric_names = list(metrics['macro'].keys())
x = np.arange(len(metric_names))
width = 0.25

for i, avg in enumerate(averages):
    values = [metrics[avg][m] for m in metric_names]
    axes[0].bar(x + i*width, values, width, label=avg.capitalize(), alpha=0.8)

axes[0].set_xlabel('Metrica', fontsize=12)
axes[0].set_ylabel('Valore', fontsize=12)
axes[0].set_title('Confronto Strategie di Aggregazione (Multi-classe)', 
                 fontsize=14, fontweight='bold')
axes[0].set_xticks(x + width)
axes[0].set_xticklabels(metric_names)
axes[0].legend()
axes[0].grid(axis='y', alpha=0.3)
axes[0].set_ylim([0, 1.1])

# Matrice di confusione
cm_mc = confusion_matrix(y_test_mc, y_pred_mc)
im = axes[1].imshow(cm_mc, cmap='Blues')
axes[1].set_xlabel('Predetto', fontsize=12)
axes[1].set_ylabel('Reale', fontsize=12)
axes[1].set_title('Matrice di Confusione Multi-classe', fontsize=14, fontweight='bold')
axes[1].set_xticks(range(4))
axes[1].set_yticks(range(4))

for i in range(4):
    for j in range(4):
        text = axes[1].text(j, i, cm_mc[i, j], ha="center", va="center",
                          color="white" if cm_mc[i, j] > cm_mc.max()/2 else "black",
                          fontsize=12, fontweight='bold')

plt.colorbar(im, ax=axes[1])
plt.tight_layout()
plt.show()

# Report dettagliato
print("\n" + "="*60)
print("CLASSIFICATION REPORT (Multi-classe)")
print("="*60)
print(classification_report(y_test_mc, y_pred_mc, digits=4))
```

---

*Continua nella Parte 3: Ottimizzazione della Soglia, Lift/Gain Charts e Linee Guida*