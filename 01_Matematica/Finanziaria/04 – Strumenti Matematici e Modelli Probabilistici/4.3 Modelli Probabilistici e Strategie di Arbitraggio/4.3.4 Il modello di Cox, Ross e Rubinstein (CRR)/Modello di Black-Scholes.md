# Il Modello di Black-Scholes

Il **modello di Black-Scholes** è utilizzato per stimare il valore di un'opzione europea su un'azione che **non paga dividendi**.  
Fu sviluppato da **Fischer Black e Myron Scholes nel 1973** e successivamente ampliato da **Robert Merton**.

## **Formula del Prezzo di un'Opzione Call**
Il valore teorico di un'opzione call è dato dalla formula:

$$
C = S_0 N(d_1) - X e^{-rt} N(d_2)
$$

Dove:
- $C$ = Prezzo dell'opzione call.
- $S_0$ = Prezzo corrente dell'attività sottostante.
- $X$ = Prezzo di esercizio dell'opzione (strike price).
- $r$ = Tasso di interesse privo di rischio.
- $\sigma$ = Volatilità dell'attività sottostante.
- $T$ = Tempo alla scadenza dell'opzione (in anni).
- $N(d)$ = Funzione di ripartizione della normale cumulativa (CDF), che rappresenta la probabilità che una variabile casuale standardizzata sia inferiore a $d$.

I parametri $d_1$ e $d_2$ sono definiti come:

$$
d_1 = \frac{\ln(S_0 / X) + (r + \sigma^2/2) T}{\sigma \sqrt{T}}
$$

$$
d_2 = d_1 - \sigma \sqrt{T}
$$

## **Interpretazione della Formula**
La formula di Black-Scholes può essere interpretata come segue:
- Il termine $S_0 N(d_1)$ rappresenta il valore attuale atteso del sottostante ponderato per la probabilità di esercizio dell'opzione.
- Il termine $X e^{-rt} N(d_2)$ è il valore attuale del prezzo di esercizio moltiplicato per la probabilità di esercizio dell'opzione.
- La differenza tra questi due termini fornisce il valore dell'opzione.

## **Ipotesi del Modello**
Il modello di Black-Scholes si basa sulle seguenti ipotesi:
1. Il mercato è **privo di arbitraggio**.
2. Il prezzo dell'attività sottostante segue un **moto browniano geometrico**, con una volatilità costante $\sigma$.
3. Il tasso di interesse $r$ è **costante** e noto.
4. L'opzione è **europea**, quindi può essere esercitata solo alla scadenza.
5. Non ci sono **dividendi** pagati dall'attività sottostante.
6. Il mercato è **liquido** e non ci sono costi di transazione.

## **Esempio di Calcolo**
Supponiamo di avere i seguenti parametri:
- $S_0 = 100$ (Prezzo dell'azione)
- $X = 105$ (Strike price)
- $r = 5\% = 0.05$ (Tasso di interesse privo di rischio)
- $\sigma = 20\% = 0.2$ (Volatilità annualizzata)
- $T = 1$ anno (Tempo alla scadenza)

Calcoliamo $d_1$ e $d_2$:

$$
d_1 = \frac{\ln(100 / 105) + (0.05 + 0.2^2 / 2) \cdot 1}{0.2 \sqrt{1}}
$$

$$
d_2 = d_1 - 0.2 \sqrt{1}
$$

Dopo aver calcolato $d_1$ e $d_2$, possiamo sostituire i valori nella formula di Black-Scholes per ottenere il prezzo dell'opzione.

## **Conclusione**
Il modello di Black-Scholes rappresenta una pietra miliare della finanza matematica, fornendo una metodologia per la valutazione delle opzioni. Tuttavia, è importante notare che alcune ipotesi del modello possono non riflettere la realtà dei mercati, in particolare la volatilità costante e l'assenza di costi di transazione.

Per affrontare queste limitazioni, sono stati sviluppati modelli più avanzati, come il **modello di Black-Scholes con volatilità stocastica** e il **modello di Heston**.
