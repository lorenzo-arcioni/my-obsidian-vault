# Modelli di Spazio Semantico

## Introduzione

I **modelli di spazio semantico** (VSM, *Vector Space Models*) rappresentano un approccio fondamentale per modellare computazionalmente il significato delle parole.  
L'idea centrale è associare ad ogni parola un **vettore** di numeri reali, posizionandola così come un punto in uno spazio vettoriale a $N$ dimensioni.

### Concetti principali:
- **Modellano il significato** delle parole basandosi sulla **similarità** tra parole.
- **Definiscono** il significato di una parola come un vettore numerico.
- **Parole semanticamente simili** sono rappresentate come **vettori vicini** nello spazio.

In altre parole, in un VSM, parole con significati affini (come "dog" e "puppy") avranno vettori che si trovano a poca distanza l'uno dall'altro.

```tikz
\usepackage{tikz}

\begin{document}
\begin{tikzpicture}[every node/.style={font=\small}]
    % Cluster negativo (sinistra)
    \node at (-5, 0.5)  {not good};
    \node at (-5.5, 0)  {dislike bad};
    \node at (-6, -1)   {incredibly bad};
    \node at (-4, -0.5) {worst};
    \node at (-4.5, -2) {worse};

    % Cluster neutrale (centro)
    \node at (0, 2)    {to by};
    \node at (-1, 1)   {'s};
    \node at (1, 0.5)  {that now};
    \node at (0, -0.5) {are};
    \node at (-0.5, 2) {a};
    \node at (0, 1)  {you};
    \node at (0.5, -1) {than with};
    \node at (-1, -1)  {is};

    % Cluster positivo (destra)
    \node at (5, 2)    {very good};
    \node at (4.5, 1)  {amazing};
    \node at (6, 0.5)  {terrific};
    \node at (5, -0.5) {incredibly good};
    \node at (6.5, 1)  {fantastic};
    \node at (4, -1)   {nice};
    \node at (5.5, -2) {wonderful};
    \node at (6, -1)   {good};
\end{tikzpicture}
\end{document}
```
Come possiamo vedere, in un VSM le parole semanticamente simili sono rappresentate come punti (vettori) vicini nello spazio dei significati.

## Word Embeddings: parole nello spazio

L'**embedding** è il processo standard in NLP per rappresentare parole come punti nello spazio vettoriale.  
Il termine **embedding** si riferisce al fatto che gli oggetti (in questo caso le parole) sono **immersi** all'interno di uno spazio numerico.

- Quando "embeddiamo" **parole**, otteniamo dei **word embeddings**.
- Ogni parola è un **vettore**.

L'idea chiave è che strutturando così il significato possiamo calcolare la distanza tra parole e stimare il grado di similarità semantica.

## Tipi principali di Word Embeddings

Esistono due grandi categorie di rappresentazioni vettoriali delle parole:

| Categoria         | Caratteristiche principali                                                                 | Esempi                       |
|:------------------|:-------------------------------------------------------------------------------------------|:------------------------------|
| **Sparse Embeddings** | - Vettori molto grandi ma prevalentemente pieni di zeri.<br>- Basati su conteggi di co-occorrenza. | Term-Document Matrix, Word-Word Matrix |
| **Dense Embeddings**  | - Vettori piccoli e compatti.<br>- Dimensioni latenti.<br>- Basati su modelli predittivi.   | Word2Vec, GloVe, FastText     |

👉 Vedi anche:

- [[Sparse Word Embeddings]]
- [[Dense Word Embeddings]]
