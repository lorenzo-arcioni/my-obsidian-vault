# Soluzioni quesiti

## Quesito 1: Average Causal Effect (ACE) di X e Z su Y

Si considerano le frequenze osservate della tabella:

| X | Y | Z | Frequenza |
|---|---|---|-----------|
| 0 | 0 | 0 | 140       |
| 0 | 1 | 0 | 140       |
| 0 | 0 | 1 | 36        |
| 0 | 1 | 1 | 84        |
| 1 | 0 | 0 | 48        |
| 1 | 1 | 0 | 72        |
| 1 | 0 | 1 | 96        |
| 1 | 1 | 1 | 384       |

Totale osservazioni: **1000**

---

### Calcolo dell’ACE di X su Y

#### Formula:

$$
ACE_X = P(Y=1|do(X=1)) - P(Y=1|do(X=0))
$$

#### Probabilità condizionate:

- $P(Y=1|X=0, Z=0) = \frac{140}{140+140} = 0.5$
- $P(Y=1|X=0, Z=1) = \frac{84}{36+84} = 0.7$
- $P(Y=1|X=1, Z=0) = \frac{72}{48+72} = 0.6$
- $P(Y=1|X=1, Z=1) = \frac{384}{96+384} = 0.8$

#### Distribuzioni di Z condizionate a X:

- $P(Z=0|X=0) = \frac{280}{400} = 0.7$
- $P(Z=1|X=0) = \frac{120}{400} = 0.3$
- $P(Z=0|X=1) = \frac{120}{600} = 0.2$
- $P(Z=1|X=1) = \frac{480}{600} = 0.8$

#### Calcolo:

$$
P(Y=1|do(X=0)) = 0.5 \cdot 0.7 + 0.7 \cdot 0.3 = 0.56
$$
$$
P(Y=1|do(X=1)) = 0.6 \cdot 0.2 + 0.8 \cdot 0.8 = 0.76
$$

$$
ACE_X = 0.76 - 0.56 = \boxed{0.20}
$$

---

### Calcolo dell’ACE di Z su Y

#### Formula:

$$
ACE_Z = P(Y=1|do(Z=1)) - P(Y=1|do(Z=0))
$$

#### Distribuzioni di X condizionate a Z:

- $P(X=0|Z=0) = \frac{280}{400} = 0.7$
- $P(X=1|Z=0) = \frac{120}{400} = 0.3$
- $P(X=0|Z=1) = \frac{120}{600} = 0.2$
- $P(X=1|Z=1) = \frac{480}{600} = 0.8$

#### Calcolo:

$$
P(Y=1|do(Z=0)) = 0.5 \cdot 0.7 + 0.6 \cdot 0.3 = 0.53
$$
$$
P(Y=1|do(Z=1)) = 0.7 \cdot 0.2 + 0.8 \cdot 0.8 = 0.78
$$

$$
ACE_Z = 0.78 - 0.53 = \boxed{0.25}
$$

---

### Conclusione

- **ACE(X → Y) = 0.20**
- **ACE(Z → Y) = 0.25**

👉 Il fattore **Z ha un impatto causale maggiore** su Y rispetto a X.

---

### Ipotesi necessarie per stimare ACE da dati osservazionali

1. **Ignorabilità (assenza di confondenti)** tra X→Y e Z→Y, condizionando su Z o X rispettivamente.
2. **Positività**: ogni combinazione delle variabili ha probabilità positiva.
3. **Consistenza**: i dati osservati riflettono i potenziali risultati sotto intervento.
4. **Corretta specificazione del modello causale**: Z agisce come mediatore e non come confondente.

### Esempio concreto

**Contesto**: Un'app di car-sharing modifica i prezzi (X) in base alla domanda. L’uso del servizio (Y) dipende dal prezzo ma anche dal **meteo (Z)**, che agisce da mediatore. Ad esempio, se piove (Z=1), le persone usano il servizio anche con prezzi alti.

👉 In questo caso, il meteo (Z) **media** l'effetto del prezzo (X) sull’uso (Y).

## Quesito 1 Bis: Comportamento razionale dei venditori e impatto sulla piattaforma

### 🎯 Contesto

- L’acquirente paga:
  - **100€** se **un solo venditore** vende.
  - **40€ a ciascun venditore** se **entrambi vendono** (totale 80€).
  - Se **nessuno vende**, non accade nulla (status quo).
- La **piattaforma trattiene il 10%** per ogni transazione.

---

### 📌 Analisi dei casi

#### Caso 1: Un solo venditore vende
- Acquirente paga 100€
- Il venditore incassa **90€** (100 - 10%)
- La piattaforma guadagna **10€**

#### Caso 2: Entrambi vendono
- L’acquirente paga 80€ (2×40)
- Ogni venditore incassa **36€** (40 - 10%)
- La piattaforma guadagna **8€** (10% di 80)

#### Caso 3: Nessuno vende
- Nessuna transazione
- Venditori guadagnano 0€
- Piattaforma guadagna 0€

---

### 🤔 Comportamento razionale (gioco strategico)

Ogni venditore ragiona strategicamente sul guadagno atteso:

- Se **pensa che l’altro non venderà**, vendere porta 90€ → molto conveniente.
- Se **pensa che anche l’altro venderà**, vendere porta 36€, mentre non vendere porta 0€ → comunque meglio vendere.

🧠 Questo porta a un classico **dilemma del prigioniero**:  
👉 **Dominant strategy** per ciascun venditore = **vendere**

---

### 🔚 Esito razionale (equilibrio di Nash)

- **Entrambi vendono**
- Guadagno per venditore: **36€**
- Guadagno per piattaforma: **8€**

---

### ⚠️ Ma si poteva fare di meglio...

- Se **solo uno vendesse**, quel venditore avrebbe **guadagnato 90€**
- La piattaforma avrebbe guadagnato **10€**
- Ma poiché **entrambi hanno incentivo a vendere**, si verifica un **esito subottimale**

---

### 💡 Suggerimenti per migliorare i risultati

1. **Segmentazione trasparente e selettiva**:
   - Invece di annunciare l'acquirente a entrambi, mostra l’opportunità a un solo venditore alla volta (rotazione o algoritmo predittivo).
   - Riduce la concorrenza diretta e massimizza il guadagno.

2. **Meccanismo di asta inversa o priorità**:
   - Introduzione di regole che premiano chi risponde prima o ha maggiore affidabilità.
   - Incentiva l'efficienza e limita duplicazioni.

3. **Randomizzazione controllata**:
   - L’algoritmo può decidere casualmente a chi mostrare l’annuncio, ma con probabilità pesate da reputazione o performance passata.

4. **Vincoli informativi**:
   - Limitare le informazioni date ai venditori (es. non sapere se l’altro ha ricevuto l'annuncio).

5. **Commissioni adattive**:
   - Se solo uno vende, commissione più bassa → stimola concorrenza positiva.

---

### ✅ Conclusione

- L'esito razionale conduce a un guadagno **inferiore** sia per la piattaforma (8€) che per i venditori (36€ ciascuno).
- Un algoritmo con **trasparenza controllata o selettiva** può migliorare il risultato individuale e collettivo.

## Quesito 2 – Previsione del comportamento del cliente nel supermercato

### 🗺️ Contesto

Il supermercato è diviso in 4 aree:
- **F**: Prodotti freschi
- **C**: Confezionati
- **B**: Bevande
- **I**: Igiene

Il cliente è stato osservato per 10 giorni. I dati in tabella rappresentano i passaggi **dall’area di partenza (riga) a quella di arrivo (colonna)**:

| From \ To | F | C | B | I |
|-----------|---|---|---|---|
| **F**     | - | 25 | 35 | 30 |
| **C**     | 60 | - | 40 | 50 |
| **B**     | 20 | 70 | - | 20 |
| **I**     | 30 | 60 | 20 | - |

---

### 🔁 Calcolo della matrice di transizione

#### 1. Calcoliamo il totale delle uscite da ciascuna area:

- From **F**: 25 + 35 + 30 = **90**
- From **C**: 60 + 40 + 50 = **150**
- From **B**: 20 + 70 + 20 = **110**
- From **I**: 30 + 60 + 20 = **110**

#### 2. Calcoliamo le probabilità di transizione:

| From \ To | F      | C       | B       | I       |
|-----------|--------|---------|---------|---------|
| **F**     | -      | 25/90 ≈ 0.28 | 35/90 ≈ 0.39 | 30/90 ≈ 0.33 |
| **C**     | 60/150 = 0.4 | -       | 0.27    | 0.33    |
| **B**     | 20/110 ≈ 0.18 | 70/110 ≈ 0.64 | -       | 20/110 ≈ 0.18 |
| **I**     | 30/110 ≈ 0.27 | 60/110 ≈ 0.55 | 20/110 ≈ 0.18 | - |

---

### 🚶‍♂️ Simulazione della traiettoria dal giorno 11

**Partenza: area B**

#### Passo 1: da B

- Probabilità massima: B → **C** (0.64) → **vai in C**

#### Passo 2: da C

- Probabilità massima: C → **F** (0.4) → **vai in F**

#### Passo 3: da F

- Probabilità massima: F → **B** (0.39) → **vai in B**

#### Passo 4: da B

- Di nuovo, B → **C** (0.64) → **vai in C**

**Possibile ciclo osservato**:  
B → C → F → B → C → ...

---

### ❌ Area svantaggiata

L’area **Igiene (I)** ha le **probabilità di accesso più basse** da tutte le aree:

- Da F: 0.33
- Da C: 0.33
- Da B: 0.18
- Da I: 0.00 (non autotransizioni)

👉 Quindi **l’area "Igiene" è svantaggiata** nella traiettoria stimata.

---

### 🔧 Intervento sull'algoritmo

Per non alterare la concorrenza tra le aree ma migliorare la soddisfazione del cliente:

#### Suggerimento:
**Ribilanciamento basato sulla frequenza cumulata, non solo sulla massima probabilità.**

- Utilizzare **metodi probabilistici pesati**: invece di seguire sempre la transizione più probabile, il robot può:
  - Scegliere la prossima area **proporzionalmente** alle frequenze osservate.
  - Introdurre **esplorazione controllata** verso aree meno frequentate ma non ignorate (es. I).

#### Altri interventi:

- Inserire un **meccanismo di decay**: aree meno visitate hanno priorità crescente nel tempo.
- Raccogliere **feedback esplicito** dal cliente sulle preferenze reali, integrando le osservazioni.


## Quesito – Assegnazione del bonus tra Nord e Sud

### 📌 Contesto

Il bonus è destinato **alle famiglie con figli**, sulla base di due soglie:

- **Soglia 1**: Bonus concesso a chi ha **almeno 2 figli**
- **Soglia 2**: Bonus concesso a chi ha **almeno 3 figli**

---

### 👨‍👩‍👧‍👦 Dati sulle famiglie

#### Nord – Totale 20 milioni

| N. figli     | Famiglie | % povertà | Povertà (n°) | Non povertà (n°) |
|--------------|----------|-----------|--------------|------------------|
| 0 figli      | 8M       | 50%       | 4M           | 4M               |
| 1 figlio     | 6M       | 50%       | 3M           | 3M               |
| 2 figli      | 4M       | 50%       | 2M           | 2M               |
| ≥3 figli     | 2M       | 50%       | 1M           | 1M               |

#### Sud – Totale 10 milioni

| N. figli     | Famiglie | % povertà | Povertà (n°) | Non povertà (n°) |
|--------------|----------|-----------|--------------|------------------|
| 0 figli      | 3M       | 75%       | 2.25M        | 0.75M            |
| 1 figlio     | 3M       | 75%       | 2.25M        | 0.75M            |
| 2 figli      | 2M       | 75%       | 1.5M         | 0.5M             |
| ≥3 figli     | 2M       | 75%       | 1.5M         | 0.5M             |

---

## 🧮 Calcoli

### 🔹 Soglia 1: Bonus a famiglie con ≥2 figli

#### ✅ Veri positivi = poveri con ≥2 figli  
- Nord: 2M (2 figli) + 1M (≥3 figli) = **3M**
- Sud: 1.5M (2 figli) + 1.5M (≥3 figli) = **3M**

Totale veri positivi: **6M**

#### ❌ Falsi positivi = NON poveri con ≥2 figli  
- Nord: 2M
- Sud: 0.5M + 0.5M = **1M**

Totale falsi positivi: **3M**

#### ❌ Veri negativi = NON poveri con <2 figli  
- Nord: 4M (0 figli) + 3M (1 figlio) = **7M**
- Sud: 0.75M + 0.75M = **1.5M**

Totale veri negativi: **8.5M**

#### ❌ Falsi negativi = poveri con <2 figli  
- Nord: 4M (0 figli) + 3M (1 figlio) = **7M**
- Sud: 2.25M + 2.25M = **4.5M**

Totale falsi negativi: **11.5M**

---

### 🔹 Soglia 2: Bonus a famiglie con ≥3 figli

#### ✅ Veri positivi = poveri con ≥3 figli  
- Nord: 1M
- Sud: 1.5M  
Totale: **2.5M**

#### ❌ Falsi positivi = NON poveri con ≥3 figli  
- Nord: 1M
- Sud: 0.5M  
Totale: **1.5M**

#### ✅ Veri negativi = NON poveri con <3 figli  
- Nord: 4M + 3M + 2M = **9M**
- Sud: 0.75M + 0.75M + 0.5M = **2M**  
Totale: **11M**

#### ❌ Falsi negativi = poveri con <3 figli  
- Nord: 4M + 3M + 2M = **9M**
- Sud: 2.25M + 2.25M + 1.5M = **6M**  
Totale: **15M**

---

### 📊 Percentuali per ciascuna soglia

#### Soglia 1

- **% Veri Positivi su tot. poveri**:
  - Nord: 3M / 10M = 30%
  - Sud: 3M / 7.5M = **40%**

- **% Veri Negativi su tot. non poveri**:
  - Nord: 7M / 10M = 70%
  - Sud: 1.5M / 2.5M = **60%**

**Scarto VP: 10%**  
**Scarto VN: 10%**

➡️ Parità di opportunità **forte** (scarto < 20%)

---

#### Soglia 2

- **% Veri Positivi su tot. poveri**:
  - Nord: 1M / 10M = 10%
  - Sud: 1.5M / 7.5M = 20%

- **% Veri Negativi su tot. non poveri**:
  - Nord: 9M / 10M = 90%
  - Sud: 2M / 2.5M = 80%

**Scarto VP: 10%**  
**Scarto VN: 10%**

➡️ Anche qui: parità di opportunità **forte**

---

### ⚖️ Quale soglia è più inclusiva?

- **Soglia 1** assegna il bonus a:
  - 6M poveri + 3M non poveri = 9M famiglie
- **Soglia 2** assegna il bonus a:
  - 2.5M poveri + 1.5M non poveri = 4M famiglie

➡️ **Soglia 1 è più inclusiva**, perché **raggiunge più poveri**, anche se include più non poveri.

---

### ✅ Conclusione

- Entrambe le soglie soddisfano una **parità di opportunità forte** (scarto ≤ 10%)
- **Soglia 1** è **più inclusiva**
- **Soglia 2** è **più esclusiva**