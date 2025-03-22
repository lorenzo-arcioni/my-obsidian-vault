# Rendimenti: semplici, lordi, netti, rateo e quotazione

## Introduzione
I **rendimenti** dei titoli obbligazionari rappresentano il guadagno che un investitore ottiene dall'investimento in un titolo. In questa sezione, esploreremo i concetti di **rendimento semplice lordo**, **rendimento semplice netto**, **rateo** e **quotazione**, con particolare attenzione ai titoli senza cedole (come i BoT e i CTz) e ai titoli con cedole. Utilizzeremo esempi pratici e spiegazioni dettagliate per chiarire ogni concetto.

---

## 1. Rendimento semplice lordo

### Definizione
Il **rendimento semplice lordo** ($r_L$) è il rendimento di un titolo obbligazionario privo di cedole, calcolato come il rapporto tra lo **scarto di emissione** (differenza tra valore nominale e prezzo di acquisto) e il prezzo di acquisto, normalizzato per la durata dell'investimento.

### Formula
Per un titolo obbligazionario $\{ -P, C \} / \{ t_1, t_2 \}$, il rendimento semplice lordo è:
$$
r_L = \frac{1}{t_2 - t_1} \cdot \frac{C - P}{P}
$$
dove:
- $P$ è il prezzo di acquisto al tempo $t_1$,
- $C$ è il valore nominale al tempo $t_2$,
- $t_2 - t_1$ è la durata dell'investimento.

### Esempio
Consideriamo un **Buono Ordinario del Tesoro (BoT)** con:
- Prezzo di acquisto $P = 965€$,
- Valore nominale $C = 1000€$,
- Durata $t_2 - t_1 = 0.5$ anni (6 mesi).

Il rendimento semplice lordo è:
$$
r_L = \frac{1}{0.5} \cdot \frac{1000 - 965}{965} = 7.25\%
$$

#### Spiegazione
- Lo **scarto di emissione** è $C - P = 1000 - 965 = 35€$.
- Il rendimento è normalizzato per la durata dell'investimento (6 mesi), quindi moltiplichiamo per $\frac{1}{0.5} = 2$.
- Il risultato è un rendimento annuo del **7.25%**.

---

## 2. Rendimento semplice netto

### Definizione
Il **rendimento semplice netto** ($r_N$) tiene conto della tassazione applicata sullo scarto di emissione. In Italia, le obbligazioni sono tassate con un'aliquota del **12.5%** sullo scarto di emissione.

### Formula
Il prezzo di acquisto al netto della tassazione ($P_b$) è:
$$
P_b = P + A(C - P)
$$
dove $A$ è l'aliquota fiscale (12.5% = 0.125).

Il rendimento semplice netto è:
$$
r_N = \frac{1}{t_2 - t_1} \cdot \frac{C - P_b}{P_b}
$$

### Esempio
Utilizzando lo stesso BoT dell'esempio precedente:
- Aliquota fiscale $A = 0.125$,
- Prezzo di acquisto al netto:
  $$
  P_b = 965 + 0.125(1000 - 965) = 965 + 4.375 = 969.375€
  $$
- Rendimento semplice netto:
  $$
  r_N = \frac{1}{0.5} \cdot \frac{1000 - 969.375}{969.375} = 2 \cdot \frac{30.625}{969.375} = 6.319\%
  $$

#### Spiegazione
- La tassazione riduce il rendimento lordo del **7.25%** a un rendimento netto del **6.319%**.
- Questo perché l'investitore paga una tassa del 12.5% sullo scarto di emissione (35€), che ammonta a **4.375€**.

---

## 3. Rateo

### Definizione
Il **rateo** è l'importo degli interessi maturati su una cedola ma non ancora pagati. Viene calcolato quando l'acquisto di un titolo avviene in un momento diverso dalla data di stacco della cedola.

### Formula
Il rateo ($R_i$) per una cedola $I$ è:
$$
R_i = I \cdot \left(1 - \frac{t_e - t_0}{T}\right)
$$
dove:
- $t_e$ è la data di stacco della cedola,
- $t_0$ è la data di acquisto,
- $T$ è il periodo tra due cedole.

### Esempio
Consideriamo un titolo con:
- Cedola semestrale $I = 2€$,
- Periodo $T = 0.5$ anni (6 mesi),
- Data di stacco della prima cedola $t_e = 4/12$ anni (4 mesi),
- Data di acquisto $t_0 = 0$.

Il rateo è:
$$
R_i = 2 \cdot \left(1 - \frac{4/12}{6/12}\right) = 2 \cdot \left(1 - \frac{1}{3}\right) = 2 \cdot \frac{2}{3} = 1.33333€
$$

#### Spiegazione
- La cedola è di **2€**, ma l'investitore ha diritto solo a una frazione di essa, poiché ha acquistato il titolo 4 mesi prima della data di stacco.
- Il rateo rappresenta la parte della cedola maturata fino alla data di acquisto.

---

## 4. Quotazione dei titoli

### Corso tel quel
Il **corso tel quel** è il prezzo effettivo pagato per un titolo, che include il valore nominale e il rateo.

### Corso secco
Il **corso secco** è il prezzo del titolo al netto del rateo, ovvero il valore che appare sui listini di borsa.

### Esempio
Per il titolo dell'esempio precedente:
- Corso tel quel: $95€$,
- Rateo: $1.33333€$,
- Corso secco: $95 - 1.33333 = 93.66667€$.

#### Spiegazione
- Il **corso tel quel** rappresenta il prezzo totale pagato per il titolo, inclusi gli interessi maturati.
- Il **corso secco** è il prezzo del titolo senza considerare il rateo, ed è il valore quotato sui listini.

---

## 5. Esempi pratici

### Esempio 1: BoT semestrale
- Prezzo di acquisto: $965€$,
- Valore nominale: $1000€$,
- Durata: 6 mesi,
- Rendimento semplice lordo: $7.25\%$,
- Rendimento semplice netto: $6.319\%$.

### Esempio 2: Titolo con cedole
- Cedola semestrale: $4.1€$,
- Periodo: 6 mesi,
- Data di stacco della prima cedola: 1 mese dopo l'acquisto,
- Rateo: $3.416€$,
- Corso secco: $93.2 - 3.416 = 89.783€$.

---

## 6. Considerazioni finali

### Vantaggi dei rendimenti semplici
- **Semplicità**: Facili da calcolare e interpretare.
- **Chiarezza**: Forniscono una misura diretta del guadagno.

### Limitazioni
- **Ignorano la capitalizzazione**: Non considerano il reinvestimento degli interessi.
- **Tassazione**: Il rendimento netto è influenzato dalle aliquote fiscali.

---

## Conclusione
I concetti di **rendimento semplice lordo**, **rendimento semplice netto**, **rateo** e **quotazione** sono fondamentali per valutare correttamente i titoli obbligazionari. Comprendere questi aspetti permette agli investitori di prendere decisioni informate e di massimizzare i propri guadagni. Nel prossimo file, esploreremo ulteriori dettagli sui **tassi d'interesse** e la **capitalizzazione composta**.