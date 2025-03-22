# **Convessità**

## **Introduzione**
Nel contesto dell'ottimizzazione, il problema generale che vogliamo risolvere è:

$$
\min_{\Theta} \ell(\Theta)
$$

dove $\Theta$ rappresenta i parametri del modello e $\ell(\Theta)$ è la funzione di perdita. Trovare i minimizzatori per una funzione di perdita generale è un problema aperto nel campo dell'ottimizzazione. Il metodo di ottimizzazione dipende dalle proprietà specifiche della funzione di perdita e, in alcuni casi, potrebbero esserci vincoli sui parametri. Tuttavia, tratteremo principalmente problemi non vincolati.

## **Funzioni Convesse**
Una classe di funzioni particolarmente facile da minimizzare (o massimizzare) è quella delle **funzioni convesse**, definite dalla **disuguaglianza di Jensen**:

$$
f(\alpha x + (1 - \alpha)y) \leq \alpha f(x) + (1 - \alpha)f(y), \quad \forall x, y \text{ e } \alpha \in [0, 1]
$$

Questa disuguaglianza afferma che la trasformazione convessa di una media è minore o uguale alla media applicata dopo la trasformazione convessa. Per due punti, significa che la linea secante di una funzione convessa giace sopra il grafico della funzione.

![Jensen's Inequality](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/ConvexFunction.svg/1200px-ConvexFunction.svg.png)

*Figura 2.4: La disuguaglianza di Jensen generalizza l'affermazione che la linea secante di una funzione convessa giace sopra il grafico.*

## **Perché le funzioni convesse sono facili da minimizzare?**
Guardando il grafico sopra, possiamo intuire che esiste sempre un **minimo unico**. Se ricordiamo un po' di calcolo delle scuole superiori, sappiamo anche che il punto in cui tale minimo è raggiunto è il punto (ancora unico) in cui la derivata della funzione è zero.

Un'importante assunzione che spesso facciamo è che la funzione di perdita $\ell$ sia **differenziabile**, in modo da poter calcolare la sua derivata $\frac{d\ell}{dx}$ in tutti i punti $x$.

## **Formalizzazione della Convessità**
Per spiegare formalmente, riscriviamo la disuguaglianza di Jensen in una forma diversa:

$$
f(x + \alpha(y - x)) \leq (1 - \alpha)f(x) + \alpha f(y), \quad \forall x, y \text{ e } \alpha \in (0, 1)
$$

Effettuando alcune manipolazioni algebriche, otteniamo:

$$
\frac{f(x + \alpha(y - x))}{\alpha} \leq \frac{(1 - \alpha)f(x) + \alpha f(y)}{\alpha}
$$

$$
\frac{f(x + \alpha(y - x))}{\alpha} \leq \frac{f(x)}{\alpha} - f(x) + f(y) \quad (\text{espandendo il prodotto } (1 - \alpha)f(x))
$$

$$
\frac{f(x + \alpha(y - x)) - f(x)}{\alpha} + f(x) \leq f(y)
$$

Prendendo il limite per $\alpha \to 0$, notiamo che l'espressione assomiglia alla definizione di derivata di una funzione, ovvero il limite del rapporto incrementale:

$$
\frac{df}{dx} = \lim_{h \to 0} \frac{f(x + h) - f(x)}{h}
$$

Per completare l'espressione, abbiamo bisogno di un fattore $(y - x)$:

$$
\lim_{\alpha \to 0} \frac{f(x + \alpha(y - x)) - f(x)}{\alpha(y - x)} (y - x) + f(x) \leq f(y), \quad \forall x, y
$$

Poiché $(y - x)$ è uno scalare, possiamo estrarlo dal limite, e l'intero limite rappresenta la derivata di $f$:

$$
\frac{df(x)}{dx} (y - x) + f(x) \leq f(y), \quad \forall x, y
$$

Notiamo che il lato sinistro della disuguaglianza è l'approssimazione di Taylor del primo ordine di $f$ nel punto $x$, ovvero la migliore approssimazione lineare di $f$ in quel punto.

![Taylor Approximation](https://upload.wikimedia.org/wikipedia/commons/c/c6/Taylor_Approximation_of_sin%28x%29.jpeg)

*Figura 2.5: Approssimazione di Taylor.*

## **Minimizzazione di Funzioni Convesse**
Se vogliamo trovare un minimizzatore per una funzione convessa $f$, basta calcolare la sua derivata $\frac{df}{dx}$, imporla $= 0$ e risolvere per $x$. Come abbiamo mostrato, il punto $x$ soddisfa la disuguaglianza:

$$
\underbrace{\frac{df(x)}{dx} (y - x)}_{=0} + f(x) \leq f(y), \quad \forall y
$$

quindi

$$
f(x) \leq f(y), \quad \forall y
$$

e dunque $x$ è il **minimizzatore globale** della funzione.

In generale, per trovare un minimizzatore per una funzione convessa $f$, è sufficiente calcolare la sua derivata $\frac{df}{dx}$, impostarla a zero e risolvere per $x$. Il punto $x$ sarà quindi il minimizzatore globale della funzione.