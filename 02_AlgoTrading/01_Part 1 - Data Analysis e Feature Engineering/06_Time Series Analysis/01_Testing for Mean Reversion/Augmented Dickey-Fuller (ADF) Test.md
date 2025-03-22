# Testing for Mean Reversion

Uno dei concetti chiave nel trading quantitativo è la **mean reversion** (ritorno alla media). Questo fenomeno si riferisce a una serie temporale che tende a ritornare a un valore medio storico. Un comportamento di questo tipo può essere sfruttato per sviluppare strategie di trading: si entra nel mercato quando una serie di prezzi è lontana dalla media, aspettandosi che torni al valore medio, e si esce dal mercato con un profitto.

Per determinare se una serie temporale segue un processo di mean reversion, è necessario confrontarla con il comportamento di un **random walk**. Un **random walk** è un processo stocastico in cui ogni movimento successivo è completamente indipendente dai movimenti precedenti, il che significa che la serie temporale non ha "memoria". 

Al contrario, un processo **mean-reverting** mostra una dipendenza strutturata dai valori precedenti: il cambiamento nel valore della serie temporale nel periodo successivo è proporzionale alla differenza tra la media storica e il valore attuale.

### **Processo di Ornstein-Uhlenbeck**
Matematicamente, un processo di mean reversion continuo può essere modellato utilizzando l'**equazione differenziale stocastica di Ornstein-Uhlenbeck**:

$$
dX_t = \theta (\mu - X_t)dt + \sigma dW_t
$$

Dove:
- $\theta$ è il **tasso di ritorno alla media** (quanto velocemente la serie torna al valore medio $\mu$),
- $\mu$ è il **valore medio** attorno a cui la serie si muove,
- $\sigma$ è la **volatilità** del processo (quanto è grande il rumore stocastico),
- $W_t$ è un **processo di Wiener** (moto browniano).

Questa equazione indica che la variazione del prezzo nel prossimo istante di tempo $dt$ è composta da due termini:
1. Un termine **deterministico** $\theta (\mu - X_t)dt$ che spinge il valore verso la media $\mu$, caratterizzando la mean reversion.
2. Un termine **stocastico** $\sigma dW_t$ che rappresenta il rumore casuale di mercato.

Se una serie temporale segue questa dinamica, significa che è mean-reverting, il che è un'informazione preziosa per la costruzione di strategie di trading basate su arbitraggio statistico.

## Augmented Dickey-Fuller (ADF) Test

L'**ADF Test** verifica se una serie temporale è stazionaria, ossia se possiede una radice unitaria. Se la serie è stazionaria, è più probabile che sia mean-reverting, mentre una serie con una radice unitaria segue un random walk e non è mean-reverting.

Il modello su cui si basa il test ADF è un **modello autoregressivo con lag di ordine p (AR(p))**, che può essere scritto come:

$$
\Delta y_t = \alpha + \beta t + \gamma y_{t-1} + \delta_1 \Delta y_{t-1} + \dots + \delta_{p-1} \Delta y_{t-p+1} + \epsilon_t
$$

Dove:
- $\alpha$ è una costante,
- $\beta$ rappresenta un trend temporale,
- $\gamma$ è il coefficiente della variabile ritardata,
- $\delta_i$ sono i coefficienti dei termini laggati,
- $\epsilon_t$ è un termine di errore.

L'ipotesi nulla del test ADF è:

$$
H_0: \gamma = 0
$$

Se $\gamma = 0$, la serie ha una radice unitaria e segue un random walk, quindi non è mean-reverting. Se possiamo rifiutare l'ipotesi nulla, significa che la serie è probabilmente mean-reverting.

### Calcolo del Test ADF

Per eseguire il test, si calcola la **statistica del test**, nota come **Dickey-Fuller tau statistic**:

$$
DF_\tau = \frac{\hat{\gamma}}{SE(\hat{\gamma})}
$$

Dove $\hat{\gamma}$ è la stima del coefficiente $\gamma$ e $SE(\hat{\gamma})$ è il suo errore standard. Questa statistica viene confrontata con valori critici pre-calcolati per determinare se rifiutare l'ipotesi nulla.

La statistica del test è un numero negativo: più negativo è il valore, maggiore è l'evidenza a favore della mean reversion.

## Implementazione in Python

Possiamo eseguire il test ADF utilizzando le librerie **statsmodels** e **pandas**. Ecco un esempio con i dati delle azioni di Amazon dal 1° gennaio 2000 al 1° gennaio 2015:

```python
import statsmodels.tsa.stattools as ts
from datetime import datetime
import pandas_datareader.data as web

# Scarica i dati di Amazon da Yahoo Finance
amzn = web.DataReader("AMZN", "yahoo", datetime(2000,1,1), datetime(2015,1,1))

# Esegue il test ADF sulla serie temporale dei prezzi aggiustati
result = ts.adfuller(amzn['Adj Close'], maxlag=1)
print(result)
```

L'output del test include:
1. Il valore della statistica del test
2. Il p-value
3. Il numero di lag utilizzati
4. Il numero di osservazioni
5. I valori critici ai livelli di confidenza 1%, 5% e 10%

Esempio di output:

```
(0.0491, 0.9624, 1, 3771, {'1%': -3.432, '5%': -2.862, '10%': -2.567}, 19576.11)
```

Poiché la statistica del test (0.0491) è **maggiore** dei valori critici a qualsiasi livello di significatività, **non possiamo rifiutare l'ipotesi nulla**, suggerendo che la serie non è mean-reverting.

## Conclusione

L'Augmented Dickey-Fuller Test è un metodo efficace per rilevare la stazionarietà e quindi la mean reversion in una serie temporale. Tuttavia, è importante considerare anche altri test di stazionarietà e ulteriori analisi per confermare la presenza di un comportamento mean-reverting prima di sviluppare strategie di trading basate su questo concetto.