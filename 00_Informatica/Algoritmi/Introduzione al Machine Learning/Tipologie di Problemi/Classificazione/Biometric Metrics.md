# Metriche di Valutazione per Sistemi Biometrici

## 1. Introduzione

La valutazione di sistemi biometrici di verifica e identificazione richiede metriche specifiche che quantifichino la capacità del sistema di distinguere tra **utenti genuini** (genuine users) e **impostori** (impostors). Questo documento presenta una trattazione completa e rigorosa delle principali metriche utilizzate nella biometria, con particolare attenzione alle differenze rispetto alle metriche di machine learning classico.

## 2. Fondamenti: Matching e Scoring

### 2.1 Il Processo di Verifica Biometrica

Un sistema biometrico di verifica opera attraverso i seguenti passaggi:

1. **Enrollment**: Acquisizione del template biometrico di riferimento
2. **Probe**: Acquisizione di un nuovo campione biometrico
3. **Feature Extraction**: Estrazione delle caratteristiche distintive
4. **Matching**: Confronto tra probe e template
5. **Scoring**: Generazione di un similarity score o distance score
6. **Decision**: Accettazione o rifiuto basato su una soglia τ

### 2.2 Similarity vs Distance Scores

I sistemi biometrici possono generare due tipi di score:

**Similarity Score** (Punteggio di Similarità):

- **Range**: Tipicamente [0, 1] o [0, 100]
- **Interpretazione**: Valori più alti indicano maggiore similarità
- **Esempio**: Cosine similarity, correlazione

**Distance Score** (Distanza):

- **Range**: [0, ∞), spesso normalizzato in [0, 1]
- **Interpretazione**: Valori più bassi indicano maggiore similarità
- **Esempio**: Distanza Euclidea, distanza di Hamming

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

# Simulazione distribuzioni genuine vs impostor
np.random.seed(42)

# Per similarity scores (più alto = più simile)
genuine_similarity = np.random.beta(8, 2, 1000)
impostor_similarity = np.random.beta(2, 8, 1000)

# Per distance scores (più basso = più simile)
genuine_distance = np.random.beta(2, 8, 1000)
impostor_distance = np.random.beta(8, 2, 1000)

fig, axes = plt.subplots(1, 2, figsize=(15, 5))

# Similarity scores
axes[0].hist(impostor_similarity, bins=50, alpha=0.6, label='Impostor', 
             color='red', density=True)
axes[0].hist(genuine_similarity, bins=50, alpha=0.6, label='Genuine', 
             color='green', density=True)
axes[0].axvline(0.5, color='black', linestyle='--', linewidth=2, 
                label='Soglia τ = 0.5')
axes[0].set_xlabel('Similarity Score', fontsize=12)
axes[0].set_ylabel('Densità', fontsize=12)
axes[0].set_title('Distribuzioni Similarity Scores', fontsize=14, fontweight='bold')
axes[0].legend()
axes[0].grid(alpha=0.3)

# Distance scores
axes[1].hist(impostor_distance, bins=50, alpha=0.6, label='Impostor', 
             color='red', density=True)
axes[1].hist(genuine_distance, bins=50, alpha=0.6, label='Genuine', 
             color='green', density=True)
axes[1].axvline(0.5, color='black', linestyle='--', linewidth=2, 
                label='Soglia τ = 0.5')
axes[1].set_xlabel('Distance Score', fontsize=12)
axes[1].set_ylabel('Densità', fontsize=12)
axes[1].set_title('Distribuzioni Distance Scores', fontsize=14, fontweight='bold')
axes[1].legend()
axes[1].grid(alpha=0.3)

plt.tight_layout()
plt.show()
```

### 2.3 Tabella dei Risultati di Matching

In biometria, i risultati del matching sono classificati in quattro categorie:

| **Scenario Reale** | **Decisione Sistema** | **Risultato** | **Equivalente ML** |
|--------------------|-----------------------|---------------|-------------------|
| Genuine (stesso utente) | Accept | **Genuine Acceptance (GA)** o **Genuine Match (GM)** | True Positive (TP) |
| Genuine (stesso utente) | Reject | **False Rejection (FR)** o **False Non-Match (FNM)** | False Negative (FN) |
| Impostor (utente diverso) | Accept | **False Acceptance (FA)** o **False Match (FM)** | False Positive (FP) |
| Impostor (utente diverso) | Reject | **Genuine Rejection (GR)** o **Genuine Non-Match (GNM)** | True Negative (TN) |

**Nota Cruciale**: In biometria si usa spesso "Match" invece di "Acceptance":

- **Genuine Match (GM)** = Genuine Acceptance (GA)
- **False Match (FM)** = False Acceptance (FA)
- **False Non-Match (FNM)** = False Rejection (FR)
- **Genuine Non-Match (GNM)** = Genuine Rejection (GR)

## 3. Metriche di Errore Fondamentali

### 3.1 False Acceptance Rate (FAR) / False Match Rate (FMR)

Il **FAR** (o **FMR**) misura la proporzione di tentativi di impostor che vengono erroneamente accettati:

$$\text{FAR} = \text{FMR} = \frac{\text{FA}}{\text{FA} + \text{GR}} = \frac{\text{False Acceptances}}{\text{Total Impostor Attempts}}$$

**Equivalente ML**: False Positive Rate (FPR) = FP/(FP+TN)

**Interpretazione**:

- FAR = 0.001 (0.1%) → 1 impostor su 1000 viene accettato
- FAR = 0.01 (1%) → 1 impostor su 100 viene accettato

**Quando è Critico**:

- Sistemi ad alta sicurezza (banche, militare)
- Controllo accessi a zone riservate
- Autenticazione per transazioni finanziarie

```python
def compute_far(false_acceptances: int, genuine_rejections: int) -> float:
    """
    Compute False Acceptance Rate.
    
    Args:
        false_acceptances: Number of impostor attempts accepted
        genuine_rejections: Number of impostor attempts rejected
        
    Returns:
        FAR value
    """
    total_impostor_attempts = false_acceptances + genuine_rejections
    if total_impostor_attempts == 0:
        return 0.0
    return false_acceptances / total_impostor_attempts

# Esempio
fa = 5
gr = 9995
far = compute_far(fa, gr)
print(f"FAR = {far:.4f} ({far*100:.2f}%)")
print(f"Interpretazione: {1/far:.0f} impostori su {int(1/far)} vengono accettati")
```

### 3.2 False Rejection Rate (FRR) / False Non-Match Rate (FNMR)

Il **FRR** (o **FNMR**) misura la proporzione di utenti genuini che vengono erroneamente rifiutati:

$$\text{FRR} = \text{FNMR} = \frac{\text{FR}}{\text{FR} + \text{GA}} = \frac{\text{False Rejections}}{\text{Total Genuine Attempts}}$$

**Equivalente ML**: False Negative Rate (FNR) = FN/(FN+TP)

**Interpretazione**:

- FRR = 0.001 (0.1%) → 1 utente genuino su 1000 viene rifiutato
- FRR = 0.05 (5%) → 1 utente genuino su 20 viene rifiutato

**Quando è Critico**:

- Sistemi consumer (smartphone)
- Applicazioni dove l'usabilità è prioritaria
- Sistemi con alta frequenza di accesso

```python
def compute_frr(false_rejections: int, genuine_acceptances: int) -> float:
    """
    Compute False Rejection Rate.
    
    Args:
        false_rejections: Number of genuine attempts rejected
        genuine_acceptances: Number of genuine attempts accepted
        
    Returns:
        FRR value
    """
    total_genuine_attempts = false_rejections + genuine_acceptances
    if total_genuine_attempts == 0:
        return 0.0
    return false_rejections / total_genuine_attempts

# Esempio
fr = 50
ga = 9950
frr = compute_frr(fr, ga)
print(f"FRR = {frr:.4f} ({frr*100:.2f}%)")
print(f"Interpretazione: {1/frr:.0f} utenti genuini su {int(1/frr)} vengono rifiutati")
```

### 3.3 Genuine Acceptance Rate (GAR) / True Match Rate (TMR)

Il **GAR** (o **TMR**) misura la proporzione di utenti genuini correttamente accettati:

$$\text{GAR} = \text{TMR} = \frac{\text{GA}}{\text{GA} + \text{FR}} = 1 - \text{FRR}$$

**Equivalente ML**: True Positive Rate (TPR) = Recall = Sensitivity

**Interpretazione**:

- GAR = 0.999 (99.9%) → 999 utenti genuini su 1000 sono riconosciuti
- GAR = 0.95 (95%) → 950 utenti genuini su 1000 sono riconosciuti

```python
def compute_gar(genuine_acceptances: int, false_rejections: int) -> float:
    """
    Compute Genuine Acceptance Rate.
    
    Args:
        genuine_acceptances: Number of genuine attempts accepted
        false_rejections: Number of genuine attempts rejected
        
    Returns:
        GAR value
    """
    total_genuine_attempts = genuine_acceptances + false_rejections
    if total_genuine_attempts == 0:
        return 0.0
    return genuine_acceptances / total_genuine_attempts

# Relazione con FRR
gar = compute_gar(ga, fr)
print(f"GAR = {gar:.4f} ({gar*100:.2f}%)")
print(f"Verifica: GAR + FRR = {gar + frr:.4f} ≈ 1.0 ✓")
```

### 3.4 Visualizzazione del Trade-off FAR vs FRR

```python
# Simula FAR e FRR al variare della soglia
thresholds = np.linspace(0, 1, 200)
fars = []
frrs = []

for tau in thresholds:
    # Per similarity scores: accept if score >= tau
    fa = np.sum(impostor_similarity >= tau)
    gr = np.sum(impostor_similarity < tau)
    fr = np.sum(genuine_similarity < tau)
    ga = np.sum(genuine_similarity >= tau)
    
    far = fa / (fa + gr) if (fa + gr) > 0 else 0
    frr = fr / (fr + ga) if (fr + ga) > 0 else 0
    
    fars.append(far)
    frrs.append(frr)

fig, axes = plt.subplots(1, 2, figsize=(15, 6))

# FAR e FRR vs Threshold
axes[0].plot(thresholds, fars, 'r-', lw=3, label='FAR (False Acceptance Rate)')
axes[0].plot(thresholds, frrs, 'orange', lw=3, label='FRR (False Rejection Rate)')

# Trova EER
diff = np.abs(np.array(fars) - np.array(frrs))
eer_idx = np.argmin(diff)
eer_threshold = thresholds[eer_idx]
eer_value = (fars[eer_idx] + frrs[eer_idx]) / 2

axes[0].plot(eer_threshold, eer_value, 'go', markersize=15, 
            label=f'EER = {eer_value:.4f} @ τ={eer_threshold:.3f}', zorder=5)
axes[0].axvline(eer_threshold, color='green', linestyle='--', alpha=0.5)
axes[0].axhline(eer_value, color='green', linestyle='--', alpha=0.5)

axes[0].set_xlabel('Soglia di Accettazione (τ)', fontsize=12)
axes[0].set_ylabel('Tasso di Errore', fontsize=12)
axes[0].set_title('FAR e FRR al variare della Soglia', fontsize=14, fontweight='bold')
axes[0].legend()
axes[0].grid(alpha=0.3)
axes[0].set_xlim([0, 1])
axes[0].set_ylim([0, 0.5])

# Annotazioni
axes[0].annotate('Soglia Bassa\nSistema PERMISSIVO\nFAR ↑, FRR ↓', 
                xy=(0.2, 0.4), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightcoral', alpha=0.7))
axes[0].annotate('Soglia Alta\nSistema RESTRITTIVO\nFAR ↓, FRR ↑', 
                xy=(0.8, 0.4), fontsize=10, ha='center',
                bbox=dict(boxstyle='round', facecolor='lightblue', alpha=0.7))

# Scala logaritmica
axes[1].semilogy(thresholds, fars, 'r-', lw=3, label='FAR')
axes[1].semilogy(thresholds, frrs, 'orange', lw=3, label='FRR')
axes[1].plot(eer_threshold, eer_value, 'go', markersize=15, label='EER', zorder=5)

axes[1].set_xlabel('Soglia di Accettazione (τ)', fontsize=12)
axes[1].set_ylabel('Tasso di Errore (scala log)', fontsize=12)
axes[1].set_title('FAR e FRR (Scala Logaritmica)', fontsize=14, fontweight='bold')
axes[1].legend()
axes[1].grid(alpha=0.3, which='both')
axes[1].set_xlim([0, 1])

plt.tight_layout()
plt.show()
```

## 4. Equal Error Rate (EER)

### 4.1 Definizione e Significato

L'**Equal Error Rate (EER)** è il punto operativo dove FAR = FRR. È la metrica più comune per confrontare sistemi biometrici.

$$\text{EER} = \text{FAR}(\tau^*) = \text{FRR}(\tau^*)$$

dove $\tau^*$ è la soglia per cui $\text{FAR}(\tau) = \text{FRR}(\tau)$

**Proprietà**:

- **EER più basso** = sistema migliore
- Rappresenta un **bilanciamento** tra sicurezza e usabilità
- Metrica standard per **confronto** tra sistemi
- Indipendente dalla distribuzione di genuine/impostor

**Interpretazione**:

- EER = 0.001 (0.1%) → Sistema eccellente
- EER = 0.01 (1%) → Sistema buono
- EER = 0.05 (5%) → Sistema accettabile
- EER = 0.10 (10%) → Sistema scarso

```python
def compute_eer(genuine_scores: np.ndarray, 
                impostor_scores: np.ndarray,
                scores_are_similarity: bool = True) -> tuple:
    """
    Compute Equal Error Rate and corresponding threshold.
    
    Args:
        genuine_scores: Scores from genuine comparisons
        impostor_scores: Scores from impostor comparisons
        scores_are_similarity: If True, higher scores mean more similar
        
    Returns:
        (eer, eer_threshold)
    """
    # Create combined array with labels
    scores = np.concatenate([genuine_scores, impostor_scores])
    labels = np.concatenate([np.ones(len(genuine_scores)), 
                            np.zeros(len(impostor_scores))])
    
    # Sort thresholds
    thresholds = np.unique(scores)
    fars = []
    frrs = []
    
    for tau in thresholds:
        if scores_are_similarity:
            # Accept if score >= threshold
            predicted_positive = scores >= tau
        else:
            # Accept if score <= threshold (for distances)
            predicted_positive = scores <= tau
            
        fa = np.sum((labels == 0) & predicted_positive)
        gr = np.sum((labels == 0) & ~predicted_positive)
        fr = np.sum((labels == 1) & ~predicted_positive)
        ga = np.sum((labels == 1) & predicted_positive)
        
        far = fa / (fa + gr) if (fa + gr) > 0 else 0
        frr = fr / (fr + ga) if (fr + ga) > 0 else 0
        
        fars.append(far)
        frrs.append(frr)
    
    # Find EER
    fars = np.array(fars)
    frrs = np.array(frrs)
    diff = np.abs(fars - frrs)
    eer_idx = np.argmin(diff)
    
    eer = (fars[eer_idx] + frrs[eer_idx]) / 2
    eer_threshold = thresholds[eer_idx]
    
    return eer, eer_threshold

# Calcolo EER
eer, eer_tau = compute_eer(genuine_similarity, impostor_similarity, 
                           scores_are_similarity=True)

print(f"Equal Error Rate (EER): {eer:.4f} ({eer*100:.2f}%)")
print(f"EER Threshold: {eer_tau:.4f}")
print(f"\nInterpretazione:")
print(f"  • Al punto EER, {eer*100:.2f}% di impostori vengono accettati")
print(f"  • Al punto EER, {eer*100:.2f}% di genuini vengono rifiutati")
```

### 4.2 EER sulla Curva ROC e DET

```python
from sklearn.metrics import roc_curve, auc

# Create labels and scores
y_true = np.concatenate([np.ones(len(genuine_similarity)), 
                        np.zeros(len(impostor_similarity))])
y_scores = np.concatenate([genuine_similarity, impostor_similarity])

# ROC curve
fpr, tpr, thresholds_roc = roc_curve(y_true, y_scores)
roc_auc = auc(fpr, tpr)

# Find EER point on ROC
fnr = 1 - tpr
eer_idx_roc = np.argmin(np.abs(fpr - fnr))

fig, axes = plt.subplots(1, 3, figsize=(18, 5))

# ROC with EER
axes[0].plot(fpr, tpr, 'b-', lw=3, label=f'ROC (AUC={roc_auc:.4f})')
axes[0].plot([0, 1], [0, 1], 'k--', lw=2, label='Random')
axes[0].plot([0, 1], [1, 0], 'r--', lw=2, alpha=0.5, label='FAR = FRR line')
axes[0].plot(fpr[eer_idx_roc], tpr[eer_idx_roc], 'go', markersize=15, 
            label=f'EER point', zorder=5)
axes[0].set_xlabel('FAR (False Acceptance Rate)', fontsize=12)
axes[0].set_ylabel('GAR (Genuine Acceptance Rate)', fontsize=12)
axes[0].set_title('ROC Curve con punto EER', fontsize=14, fontweight='bold')
axes[0].legend()
axes[0].grid(alpha=0.3)

# DET curve (linear)
axes[1].plot(fpr, fnr, 'b-', lw=3, label='DET Curve')
axes[1].plot([0, 1], [0, 1], 'k--', lw=2, label='EER line')
axes[1].plot(fpr[eer_idx_roc], fnr[eer_idx_roc], 'ro', markersize=15, 
            label=f'EER = {(fpr[eer_idx_roc] + fnr[eer_idx_roc])/2:.4f}', zorder=5)
axes[1].set_xlabel('FAR (False Acceptance Rate)', fontsize=12)
axes[1].set_ylabel('FRR (False Rejection Rate)', fontsize=12)
axes[1].set_title('DET Curve (scala lineare)', fontsize=14, fontweight='bold')
axes[1].legend()
axes[1].grid(alpha=0.3)

# DET curve (log)
axes[2].loglog(fpr, fnr, 'b-', lw=3, label='DET Curve')
axes[2].plot([1e-4, 1], [1e-4, 1], 'k--', lw=2, label='EER line')
axes[2].plot(fpr[eer_idx_roc], fnr[eer_idx_roc], 'ro', markersize=15, 
            label=f'EER', zorder=5)
axes[2].set_xlabel('FAR (False Acceptance Rate) [log]', fontsize=12)
axes[2].set_ylabel('FRR (False Rejection Rate) [log]', fontsize=12)
axes[2].set_title('DET Curve (scala logaritmica)', fontsize=14, fontweight='bold')
axes[2].legend()
axes[2].grid(alpha=0.3, which='both')

plt.tight_layout()
plt.show()
```

## 5. Punti Operativi Notevoli

### 5.1 ZeroFAR (Zero False Acceptance Rate)

Il **ZeroFAR** è il punto operativo dove FAR = 0, cioè nessun impostor viene accettato.

$$\text{ZeroFAR}: \quad \text{FAR}(\tau_{\text{ZeroFAR}}) = 0$$

Il sistema opera con **massima sicurezza**, al costo di un FRR più alto.

**Applicazioni**:

- Sistemi bancari ad alta sicurezza
- Controllo accessi militari
- Autenticazione per operazioni critiche

```python
def find_zerofar_point(fars: np.ndarray, frrs: np.ndarray, 
                       thresholds: np.ndarray) -> tuple:
    """Find ZeroFAR operating point."""
    zero_far_indices = np.where(np.array(fars) == 0)[0]
    if len(zero_far_indices) == 0:
        return None, None, None
    
    # Take the first threshold where FAR = 0
    idx = zero_far_indices[0]
    return fars[idx], frrs[idx], thresholds[idx]

zerofar_far, zerofar_frr, zerofar_tau = find_zerofar_point(fars, frrs, thresholds)

if zerofar_far is not None:
    print(f"ZeroFAR Operating Point:")
    print(f"  Threshold: τ = {zerofar_tau:.4f}")
    print(f"  FAR = {zerofar_far:.4f} (0%)")
    print(f"  FRR = {zerofar_frr:.4f} ({zerofar_frr*100:.2f}%)")
    print(f"\n  Interpretazione:")
    print(f"    • Nessun impostor viene accettato (massima sicurezza)")
    print(f"    • {zerofar_frr*100:.1f}% di utenti genuini viene rifiutato")
    print(f"    • 1 utente genuino su {1/zerofar_frr:.0f} deve riprovare")
```

### 5.2 ZeroFRR (Zero False Rejection Rate)

Il **ZeroFRR** è il punto operativo dove FRR = 0, cioè nessun utente genuino viene rifiutato.

$$\text{ZeroFRR}: \quad \text{FRR}(\tau_{\text{ZeroFRR}}) = 0$$

Il sistema opera con **massima usabilità**, al costo di un FAR più alto.

**Applicazioni**:

- Smartphone consumer
- Applicazioni con priorità UX
- Sistemi a bassa criticità

```python
def find_zerofrr_point(fars: np.ndarray, frrs: np.ndarray, 
                       thresholds: np.ndarray) -> tuple:
    """Find ZeroFRR operating point."""
    zero_frr_indices = np.where(np.array(frrs) == 0)[0]
    if len(zero_frr_indices) == 0:
        return None, None, None
    
    # Take the last threshold where FRR = 0
    idx = zero_frr_indices[-1]
    return fars[idx], frrs[idx], thresholds[idx]

zerofrr_far, zerofrr_frr, zerofrr_tau = find_zerofrr_point(fars, frrs, thresholds)

if zerofrr_far is not None:
    print(f"\nZeroFRR Operating Point:")
    print(f"  Threshold: τ = {zerofrr_tau:.4f}")
    print(f"  FAR = {zerofrr_far:.4f} ({zerofrr_far*100:.2f}%)")
    print(f"  FRR = {zerofrr_frr:.4f} (0%)")
    print(f"\n  Interpretazione:")
    print(f"    • Tutti gli utenti genuini vengono accettati (massima UX)")
    print(f"    • {zerofrr_far*100:.1f}% di impostori viene accettato")
    print(f"    • 1 impostor su {1/zerofrr_far:.0f} riesce ad accedere")
```

### 5.3 Punti Operativi a FAR Fisso

Spesso si valuta il sistema a specifici valori di FAR:

- **FAR = 0.1% (0.001)**: Standard per applicazioni commerciali
- **FAR = 1% (0.01)**: Applicazioni consumer
- **FAR = 0.01% (0.0001)**: Alta sicurezza

```python
def find_far_operating_point(fars: np.ndarray, frrs: np.ndarray, 
                            thresholds: np.ndarray, target_far: float) -> tuple:
    """Find operating point closest to target FAR."""
    idx = np.argmin(np.abs(np.array(fars) - target_far))
    return fars[idx], frrs[idx], thresholds[idx]

# Punti operativi comuni
target_fars = [0.001, 0.01, 0.1]

print("\nPunti Operativi a FAR Fisso:")
print("-" * 70)

for target_far in target_fars:
    far, frr, tau = find_far_operating_point(fars, frrs, thresholds, target_far)
    gar = 1 - frr
    
    print(f"\nFAR Target = {target_far*100:.1f}%:")
    print(f"  Threshold: τ = {tau:.4f}")
    print(f"  FAR effettivo = {far:.4f} ({far*100:.2f}%)")
    print(f"  FRR = {frr:.4f} ({frr*100:.2f}%)")
    print(f"  GAR = {gar:.4f} ({gar*100:.2f}%)")
```

### 5.4 Visualizzazione Comparativa dei Punti Operativi

```python
fig, axes = plt.subplots(2, 2, figsize=(15, 12))

# Plot 1: FAR e FRR con tutti i punti
ax = axes[0, 0]
ax.plot(thresholds, fars, 'r-', lw=2, label='FAR')
ax.plot(thresholds, frrs, 'orange', lw=2, label='FRR')

# EER
ax.plot(eer_tau, eer, 'go', markersize=12, label=f'EER={eer:.4f}')

# ZeroFAR
if zerofar_tau is not None:
    ax.plot(zerofar_tau, zerofar_frr, 'bs', markersize=10, 
           label=f'ZeroFAR (FRR={zerofar_frr:.3f})')

# ZeroFRR
if zerofrr_tau is not None:
    ax.plot(zerofrr_tau, zerofrr_far, 'm^', markersize=10, 
           label=f'ZeroFRR (FAR={zerofrr_far:.3f})')

ax.set_xlabel('Soglia τ', fontsize=12)
ax.set_ylabel('Tasso di Errore', fontsize=12)
ax.set_title('Punti Operativi sul Trade-off FAR/FRR', fontsize=14, fontweight='bold')
ax.legend()
ax.grid(alpha=0.3)

# Plot 2: Tabella riassuntiva
ax = axes[0, 1]
ax.axis('off')

summary_text = f"""
╔══════════════════════════════════════════════════════════╗
║           PUNTI OPERATIVI - CONFRONTO                   ║
╚══════════════════════════════════════════════════════════╝

📊 EQUAL ERROR RATE (EER) - Bilanciato
   Soglia:     τ = {eer_tau:.4f}
   FAR:        {eer:.4f} ({eer*100:.2f}%)
   FRR:        {eer:.4f} ({eer*100:.2f}%)
   GAR:        {(1-eer):.4f} ({(1-