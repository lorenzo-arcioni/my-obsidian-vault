# Parsing Sintattico

## Introduzione

**Definizione**  
Fare *parsing sintattico* significa riconoscere una frase e assegnarle una struttura sintattica. 

> In inglese: **Syntactic Parsing**

## Perché fare il parsing di una frase?

- **Controllo grammaticale**  
  Applicazioni per il controllo ortografico e grammaticale.  
  *Esempio*: Un parser segnala l’errore in "He are student".

- **Analisi semantica**  
  Serve come base per l’analisi semantica.  
  *Esempio*: In "He eats sushi", il parser identifica "eats" come verbo principale.

- **Question Answering**  
  Per rispondere ad una domanda è necessario almeno identificare:
  - il **soggetto** (es. *what books*)
  - il **verbo principale** (*write*)
  - l’**aggiunto da-agentivo** (*Raymond Queneau*)

- **Traduzione automatica**  
  Fornisce una struttura sintattica coerente da cui generare la traduzione.  
  *Esempio*: "The cat sleeps" → "Il gatto dorme"

## Parsing Costitutivo

Si esplora lo **spazio dei possibili alberi sintattici** per trovare il migliore dato un input.

### Vincoli

1. **Vincolo sui dati**  
   Un albero per una frase di $k$ parole deve avere **$k$ foglie**.  
   *Esempio*: "He runs" → foglie: "He", "runs"

2. **Vincolo grammaticale**  
   L’albero deve avere **una sola radice**.  
   *Esempio*: "He is a student" → radice unica $S$

## Strategie di parsing

### Top-down (goal-directed)

Parte dalla radice $S$ ed espande ricorsivamente secondo la grammatica:

$$
\begin{align*}
  N &= \{ S, NP, Nom, VP, PP, Det, Noun, Verb, Adjective, Pronoun, Proper\text{-}Noun, Preposition \} \\
  T &= \{\text{me}, \text{I}, \text{he}, \text{you}, \text{it}, \text{him}, \text{her}, \text{Rome}, \text{Sapienza}, \\
    &\quad \text{a}, \text{an}, \text{the}, \text{student}, \text{researcher}, \text{research}, \text{am}, \text{is}, \\
    &\quad \text{bright}, \text{from}, \text{to}, \text{on}, \text{in}, \text{near}, \text{at}, \text{and}, \text{or}, \text{but} \} \\
  P &= \{ \\
  &\quad S \rightarrow NP\ VP, \\
  &\quad NP \rightarrow Pronoun \mid Proper\text{-}Noun \mid Det\ Nom, \\
  &\quad Nom \rightarrow Nom\ Noun \mid Noun, \\
  &\quad VP \rightarrow Verb \mid Verb\ NP \mid Verb\ NP\ PP \mid Verb\ PP, \\
  &\quad PP \rightarrow Preposition\ NP, \\
  &\quad Noun \rightarrow \text{student} \mid \text{researcher} \mid \text{research}, \\
  &\quad Verb \rightarrow \text{am} \mid \text{is}, \\
  &\quad Adjective \rightarrow \text{bright}, \\
  &\quad Pronoun \rightarrow \text{me} \mid \text{I} \mid \text{he} \mid \text{you} \mid \text{it} \mid \text{him} \mid \text{her}, \\
  &\quad Proper\text{-}Noun \rightarrow \text{Rome} \mid \text{Sapienza}, \\
  &\quad Det \rightarrow \text{the} \mid \text{a} \mid \text{an}, \\
  &\quad Preposition \rightarrow \text{from} \mid \text{to} \mid \text{on} \mid \text{in} \mid \text{near} \mid \text{at}, \\
  &\quad Conjunction \rightarrow \text{and} \mid \text{or} \mid \text{but} \\
  \} \\
  S &= S
\end{align*}
$$

Di seguito, una semplice rappresentazione del parsing di un albero sintattico per la frase "He is a student in Rome" con la radice $S$:

```tikz
\documentclass[tikz, border=0pt]{standalone}
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\usepackage{tikz}
\usetikzlibrary{trees, shapes.misc, arrows.meta}

\tikzset{
  scale=2,
  transform shape,
  level distance=1.5cm,
  sibling distance=4cm,
  every node/.style={font=\normalsize, align=center},
  edge from parent/.style={draw, -{Latex[length=2mm]}},
  stepnum/.style={draw,circle,fill=white!30,inner sep=2pt,font=\bfseries},
  cross/.style={red,very thick},
  terminal/.style={font=\normalsize\itshape}
}

\begin{document}

%---------------------------
% Sezione 1: Step 1-2-3
%---------------------------
\begin{tikzpicture}
\node[stepnum] at (-5, 0) {1};
\node at (-4, 0) {S};

\node[stepnum] at (-1, 0) {2};
\node (S2) at (0.5, 0) {S}
    child {node (NP2) {NP}}
    child {node (VP2) {VP}};

\node[stepnum] at (5, 0) {3};
\node (S3a) at (7, 0) {S}
    child {node (NP3a) {NP}
        child {node (Pro3) {Pronoun}}
    }
    child {node (VP3a) {VP}};
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=0pt]{standalone}
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\usepackage{tikz}
\usetikzlibrary{trees, shapes.misc, arrows.meta}

\tikzset{
  scale=2,
  transform shape,
  level distance=1.5cm,
  sibling distance=4cm,
  every node/.style={font=\normalsize, align=center},
  edge from parent/.style={draw, -{Latex[length=2mm]}},
  stepnum/.style={draw,circle,fill=white!30,inner sep=2pt,font=\bfseries},
  cross/.style={red,very thick},
  terminal/.style={font=\normalsize\itshape}
}

\begin{document}
%---------------------------
% Sezione 2: Step 4
%---------------------------
\begin{tikzpicture}
\node[stepnum] at (-7, 0) {4};
\node (S4a) at (-5, 0) {S}
    child {node (NP4a) {NP}
        child {node (Pro4a) {Pronoun}}
    }
    child {node (VP4a) {VP}
        child {node (V4a) {Verb}}
    };
\draw[cross] (VP4a) -- (V4a);

\node (S4b) at (1, 0) {S}
    child {node (NP4b) {NP}
        child {node (Pro4b) {Pronoun}}
    }
    child[sibling distance=2.5cm] {node (VP4b) {VP}
        child {node (V4b) {Verb}}
        child {node (NP4c) {NP}}
    };

\node (S4c) at (8, 0) {S}
    child {node (NP4d) {NP}
        child {node (Pro4c) {Pronoun}}
    }
    child[sibling distance=2.5cm] {node (VP4c) {VP}
        child {node (V4c) {Verb}}
        child {node (PP4a) {PP}}
    };
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=0pt]{standalone}
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\usepackage{tikz}
\usetikzlibrary{trees, shapes.misc, arrows.meta}

\tikzset{
  scale=2,
  transform shape,
  level distance=1.5cm,
  sibling distance=4cm,
  every node/.style={font=\normalsize, align=center},
  edge from parent/.style={draw, -{Latex[length=2mm]}},
  stepnum/.style={draw,circle,fill=white!30,inner sep=2pt,font=\bfseries},
  cross/.style={red,very thick},
  terminal/.style={font=\normalsize\itshape}
}

\begin{document}
%---------------------------
% Sezione 3: Step 5-6
%---------------------------
\begin{tikzpicture}
\node[stepnum] at (-7, 0) {5};
\node (S5) at (0, 0) {S}
    child[sibling distance=6cm] {node (NP5) {NP}
        child {node (Pro5) {Pronoun}
            child {node[terminal] (He) {"He"}}
        }
    }
    child[sibling distance=6cm] {node (VP5) {VP}
        child[sibling distance=2cm] {node (V5) {Verb}
            child {node[terminal] (Is) {"is"}}
        }
        child[sibling distance=2cm] {node (NP5b) {NP}}
        child[sibling distance=2cm] {node (PP5) {PP}}
    };
\end{tikzpicture}

\begin{tikzpicture}
\node[stepnum] at (-7, 0) {6};
\node (S6) at (0, 0) {S}
    child[sibling distance=10cm] {node (NP6) {NP}
        child {node (Pro6) {Pronoun}
            child {node[terminal] (He6) {"He"}}
        }
    }
    child[sibling distance=10cm] {node (VP6) {VP}
        child[sibling distance=3cm] {node (V6) {Verb}
            child {node[terminal] (Is6) {"is"}}
        }
        child[sibling distance=4cm] {node (NP6b) {NP}
            child[sibling distance=2cm] {node (Det6) {Det}
                child {node[terminal] (A6) {"a"}}
            }
            child[sibling distance=2cm] {node (Nom6) {Nom}}
        }
        child[sibling distance=3cm] {node (PP6) {PP}}
    };
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=0pt]{standalone}
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\usepackage{tikz}
\usetikzlibrary{trees, shapes.misc, arrows.meta}

\tikzset{
  scale=2,
  transform shape,
  level distance=1.5cm,
  sibling distance=4cm,
  every node/.style={font=\normalsize, align=center},
  edge from parent/.style={draw, -{Latex[length=2mm]}},
  stepnum/.style={draw,circle,fill=white!30,inner sep=2pt,font=\bfseries},
  cross/.style={red,very thick},
  terminal/.style={font=\normalsize\itshape}
}

\begin{document}
%---------------------------
% Sezione 4: Step 7
%---------------------------
\begin{tikzpicture}
\node[stepnum] at (-7, 0) {7};
\node (S7) at (0, 0) {S}
    child[sibling distance=12cm] {node (NP7) {NP}
        child[sibling distance=2cm] {node (Pro7) {Pronoun}
            child {node[terminal] (He7) {"He"}}
        }
    }
    child[sibling distance=12cm] {node (VP7) {VP}
        child[sibling distance=3.5cm] {node (V7) {Verb}
            child {node[terminal] (Is7) {"is"}}
        }
        child[sibling distance=5cm] {node (NP7b) {NP}
            child[sibling distance=2.5cm] {node (Det7) {Det}
                child {node[terminal] (A7) {"a"}}
            }
            child[sibling distance=2.5cm] {node (Nom7) {Nom}
                child {node (Noun7) {Noun}
                    child {node[terminal] (Student7) {"student"}}
                }
            }
        }
        child[sibling distance=5cm] {node (PP7) {PP}
            child[sibling distance=2.5cm] {node (Prep7) {Preposition}
                child {node[terminal] (In7) {"in"}}
            }
            child[sibling distance=2.5cm] {node (NP7c) {NP}}
        }
    };
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=0pt]{standalone}
\usepackage[active,tightpage]{preview}
\PreviewEnvironment{tikzpicture}
\usepackage{tikz}
\usetikzlibrary{trees, shapes.misc, arrows.meta}

\tikzset{
  scale=0.8, % ridotto per compattezza
  transform shape,
  level distance=1.2cm, % un po' più stretto in verticale
  sibling distance=3.5cm, % distanza di default tra fratelli (può essere sovrascritta sotto)
  every node/.style={font=\normalsize, align=center},
  edge from parent/.style={draw, -{Latex[length=2mm]}},
  stepnum/.style={draw,circle,fill=white!30,inner sep=2pt,font=\bfseries},
  cross/.style={red,very thick},
  terminal/.style={font=\normalsize\itshape}
}

\begin{document}
\begin{tikzpicture}
\node[stepnum] at (-6.5, 0) {8};
\node (S8) at (0, 0) {S}
    child[sibling distance=4cm] {node (NP8) {NP}
        child {node (Pro8) {Pronoun}
            child {node[terminal] (He8) {"He"}}
        }
    }
    child[sibling distance=7.5cm] {node (VP8) {VP}
        child[sibling distance=2.5cm] {node (V8) {Verb}
            child {node[terminal] (Is8) {"is"}}
        }
        child[sibling distance=3.8cm] {node (NP8b) {NP}
            child[sibling distance=1.5cm] {node (Det8) {Det}
                child {node[terminal] (A8) {"a"}}
            }
            child[sibling distance=1.5cm] {node (Nom8) {Nom}
                child {node (Noun8) {Noun}
                    child {node[terminal] (Student8) {"student"}}
                }
            }
        }
        child[sibling distance=3.8cm] {node (PP8) {PP}
            child[sibling distance=1.8cm] {node (Prep8) {Preposition}
                child {node[terminal] (In8) {"in"}}
            }
            child[sibling distance=1.8cm] {node (NP8c) {NP}
                child {node (PN8) {Proper-Noun}
                    child {node[terminal] (Rome8) {"Rome"}}
                }
            }
        }
    };
\end{tikzpicture}
\end{document}
```


### Bottom-up (data-directed)

Parte dalle parole e risale combinando in costituenti.

```tikz
\documentclass[tikz, border=50pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\footnotesize},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}

% SEZIONE 1: Parole individuali e POS tagging
\begin{tikzpicture}[node distance=1.2cm]
  % Numero step
  \node[stepnum] at (-5.5, 0) {1};
  
  % Parole della frase
  \node[word] (he) at (-4.5, 0) {He};
  \node[word] (is) at (-3.5, 0) {is};
  \node[word] (a) at (-2.5, 0) {a};
  \node[word] (student) at (-1.3, 0) {student};
  \node[word] (in) at (0, 0) {in};
  \node[word] (rome) at (1, 0) {Rome};
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\small},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}
\begin{tikzpicture}[level distance=1.2cm, sibling distance=1.2cm]
  % Numero step
  \node[stepnum] at (-5.5, 0) {2};
  
  % Albero categoriale
  \node[tag] at (-4.5, 0.6) {Pronoun};
  \node[tag] at (-3.5, 0.6) {Verb};
  \node[tag] at (-2.5, 0.6) {Det};
  \node[tag] at (-1.3, 0.6) {Noun};
  \node[tag] at (0, 0.6) {Prep};
  \node[tag] at (2, 0.6) {Proper-Noun};

  % Collegamenti verso le parole
  \node[word] (he) at (-4.5, 0) {He};
  \node[word] (is) at (-3.5, 0) {is};
  \node[word] (a) at (-2.5, 0) {a};
  \node[word] (student) at (-1.3, 0) {student};
  \node[word] (in) at (0, 0) {in};
  \node[word] (rome) at (1, 0) {Rome};

  % Linee di collegamento
  \draw[edge] (-4.5, 0.4) -- (he);
  \draw[edge] (-3.5, 0.4) -- (is);
  \draw[edge] (-2.5, 0.4) -- (a);
  \draw[edge] (-1.3, 0.4) -- (student);
  \draw[edge] (0, 0.4) -- (in);
  \draw[edge] (2, 0.4) -- (rome);
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\small},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}
\begin{tikzpicture}[level distance=1.2cm, sibling distance=1.2cm]
  % Numero step
  \node[stepnum] at (-5.5, 0) {3};
  
  % Primo albero NP (He)
  \node[tag] at (-4.5, 1.2) {NP};
  \node[tag] at (-4.5, 0.6) {Pronoun};
  \node[word] (he) at (-4.5, 0) {He};
  \draw[edge] (-4.5, 1.0) -- (-4.5, 0.8);
  \draw[edge] (-4.5, 0.4) -- (he);
  
  % Verbo
  \node[tag] at (-3.5, 0.6) {Verb};
  \node[word] (is) at (-3.5, 0) {is};
  \draw[edge] (-3.5, 0.4) -- (is);
  
  % Secondo albero Nom → NP
  \node[tag] at (-1.5, 1.8) {Nom};
  \node[tag] at (-2.5, 0.6) {Det};
  \node[tag] at (-1.3, 0.6) {Noun};
  \node[word] (a) at (-2.5, 0) {a};
  \node[word] (student) at (-1.3, 0) {student};
  \draw[edge] (-1.5, 1.6) -- (-1.3, 0.8);
  \draw[edge] (-2.5, 0.4) -- (a);
  \draw[edge] (-1.3, 0.4) -- (student);
  
  % Terzo albero NP (Rome)
\node[tag] at (1, 1.2) {NP};
\node[tag] at (0, 0.6) {Prep};
\node[tag] at (2, 0.6) {Proper-Noun};
\node[word] (in) at (0, 0) {in};
\node[word] (rome) at (2, 0) {Rome};
\draw[edge] (1, 1.0) -- (2, 0.8);
\draw[edge] (0, 0.4) -- (in);
\draw[edge] (2, 0.4) -- (rome);
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\small},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}
\begin{tikzpicture}[level distance=1.2cm, sibling distance=1.5cm]
  % Numero step
  \node[stepnum] at (-5.5, 0) {4};

  % Primo NP (He)
  \node[tag] at (-4.5, 1.2) {NP};
  \node[tag] at (-4.5, 0.6) {Pronoun};
  \node[word] (he) at (-4.5, 0) {He};
  \draw[edge] (-4.5, 1.0) -- (-4.5, 0.8);
  \draw[edge] (-4.5, 0.4) -- (he);
  
  % VP (parziale)
  \node[tag] at (-3.5, 0.6) {Verb};
  \node[word] (is) at (-3.5, 0) {is};
  \draw[edge] (-3.5, 0.4) -- (is);
  
  % NP (a student)
  \node[tag] at (-1.5, 1.8) {NP};
  \node[tag] at (-1.5, 1.2) {Nom};
  \node[tag] at (-2.5, 0.6) {Det};
  \node[tag] at (-1.3, 0.6) {Noun};
  \node[word] (a) at (-2.5, 0) {a};
  \node[word] (student) at (-1.3, 0) {student};
  \draw[edge] (-1.5, 1.6) -- (-1.5, 1.4);
  \draw[edge] (-1.5, 1.0) -- (-1.3, 0.8);
  \draw[edge] (-2.5, 0.4) -- (a);
  \draw[edge] (-1.3, 0.4) -- (student);
  
  % PP (in Rome)
  \node[tag] at (0.5, 1.8) {PP};
  \node[tag] at (0, 0.6) {Prep};
  \node[tag] at (1, 1.2) {NP};
  \node[tag] at (2, 0.6) {Proper-Noun};
  \node[word] (in) at (0, 0) {in};
  \node[word] (rome) at (2, 0) {Rome};
  \draw[edge] (0.5, 1.6) -- (0, 0.8);
  \draw[edge] (0.5, 1.6) -- (1, 1.4);
  \draw[edge] (1, 1.0) -- (2, 0.8);
  \draw[edge] (0, 0.4) -- (in);
  \draw[edge] (2, 0.4) -- (rome);
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\small},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}
\begin{tikzpicture}
  % Numero step
  \node[stepnum] at (-5, 3) {5};

  % Albero sintattico più esteso 
  \node[tag] (vp) at (-1, 2.8) {VP};
  \node[tag] (np1) at (-4, 2) {NP};
  \node[tag] (verb) at (-2.5, 2) {Verb};
  \node[tag] (np2) at (-1, 2) {NP};
  \node[tag] (pp) at (1, 2) {PP};
  
  \node[tag] (pron) at (-4, 1.2) {Pronoun};
  \node[tag] (nom) at (-1, 1.2) {Nom};
  \node[tag] (prep) at (0, 1.2) {Prep};
  \node[tag] (np3) at (2, 1.2) {NP};
  
  \node[tag] (det) at (-2, 0.4) {Det};
  \node[tag] (noun) at (0, 0.4) {Noun};
  \node[tag] (properN) at (2, 0.4) {Proper-Noun};
  
  \node[word] (he) at (-4, -0.4) {He};
  \node[word] (is) at (-2.5, -0.4) {is};
  \node[word] (a) at (-2, -0.4) {a};
  \node[word] (student) at (0, -0.4) {student};
  \node[word] (in) at (1, -0.4) {in};
  \node[word] (rome) at (2, -0.4) {Rome};
  
  % Collegamenti
  \draw[edge] (vp) -- (verb);
  \draw[edge] (vp) -- (np2);
  \draw[edge] (vp) -- (pp);
  
  \draw[edge] (np1) -- (pron);
  \draw[edge] (np2) -- (nom);
  \draw[edge] (pp) -- (prep);
  \draw[edge] (pp) -- (np3);
  
  \draw[edge] (pron) -- (he);
  \draw[edge] (verb) -- (is);
  \draw[edge] (nom) -- (det);
  \draw[edge] (nom) -- (noun);
  \draw[edge] (prep) -- (in);
  \draw[edge] (np3) -- (properN);
  
  \draw[edge] (det) -- (a);
  \draw[edge] (noun) -- (student);
  \draw[edge] (properN) -- (rome);
\end{tikzpicture}
\end{document}
```
```tikz
\documentclass[tikz, border=10pt]{standalone}
\usepackage{tikz}
\usetikzlibrary{positioning, arrows.meta}

\tikzset{
  stepnum/.style={draw, circle, fill=white!20, inner sep=1pt, font=\footnotesize\bfseries, minimum size=5pt},
  word/.style={font=\small},
  tag/.style={font=\footnotesize},
  edge/.style={draw, -},
  level/.style={level distance=1cm, sibling distance=2cm}
}

\begin{document}
\begin{tikzpicture}
  % Numero step
  \node[stepnum] at (-5, 3.5) {6};
  
  % Albero completo
  \node[tag] (s) at (-1.5, 3.5) {S};
  \node[tag] (np1) at (-3.5, 2.5) {NP};
  \node[tag] (vp) at (-0.5, 2.5) {VP};
  
  \node[tag] (pron) at (-3.5, 1.5) {Pronoun};
  \node[tag] (verb) at (-2.5, 1.5) {Verb};
  \node[tag] (np2) at (-0.5, 1.5) {NP};
  \node[tag] (pp) at (1.5, 1.5) {PP};
  
  \node[tag] (nom) at (-0.5, 0.5) {Nom};
  \node[tag] (prep) at (0.5, 0.5) {Prep};
  \node[tag] (np3) at (2.5, 0.5) {NP};
  
  \node[tag] (det) at (-1.5, -0.5) {Det};
  \node[tag] (noun) at (0.5, -0.5) {Noun};
  \node[tag] (properN) at (2.5, -0.5) {Proper-Noun};
  
  \node[word] (he) at (-3.5, -1.5) {He};
  \node[word] (is) at (-2.5, -1.5) {is};
  \node[word] (a) at (-1.5, -1.5) {a};
  \node[word] (student) at (0.5, -1.5) {student};
  \node[word] (in) at (1.5, -1.5) {in};
  \node[word] (rome) at (2.5, -1.5) {Rome};
  
  % Collegamenti
  \draw[edge] (s) -- (np1);
  \draw[edge] (s) -- (vp);
  
  \draw[edge] (np1) -- (pron);
  \draw[edge] (vp) -- (verb);
  \draw[edge] (vp) -- (np2);
  \draw[edge] (vp) -- (pp);
  
  \draw[edge] (pron) -- (he);
  \draw[edge] (verb) -- (is);
  \draw[edge] (np2) -- (nom);
  \draw[edge] (pp) -- (prep);
  \draw[edge] (pp) -- (np3);
  
  \draw[edge] (nom) -- (det);
  \draw[edge] (nom) -- (noun);
  \draw[edge] (prep) -- (in);
  \draw[edge] (np3) -- (properN);
  
  \draw[edge] (det) -- (a);
  \draw[edge] (noun) -- (student);
  \draw[edge] (properN) -- (rome);
\end{tikzpicture}
\end{document}
```

## Ambiguità strutturale

Un’importante sfida nel parsing sintattico è la **presenza di più alberi possibili per una stessa frase**, ossia *ambiguità strutturale*.

### Esempio classico

**Frase**:  
> "He saw the man with the telescope"

Questa frase ha **due interpretazioni** sintattiche distinte:

1. **Interpretazione 1** – *Ha visto l’uomo con il telescopio* (cioè, l’uomo ha il telescopio)  
   → Il sintagma preposizionale "with the telescope" si collega al **nome "man"**

2. **Interpretazione 2** – *Ha visto (con il telescopio) l’uomo*  
   → Il sintagma preposizionale "with the telescope" si collega al **verbo "saw"**

### Implicazioni

- Queste ambiguità sono comuni in linguaggio naturale.
- Rappresentano un ostacolo per i parser sintattici deterministici.
- In NLP, è spesso necessario ricorrere a **modelli probabilistici** o **contesto semantico** per risolverle.

Anche se una frase non è ambigua globalmente, può essere ambigua localmente, e può essere computazionalmente costosa risolverla. Come ad esempio:

**Frase**:  
> "Book that flight"

- La frase non è ambigua globalmente.
- Quando il parser vede la parola *Book* non sa se si tratta di un verbo o un nome, per cui non riesce a decidere la sua [Part-of-Speech Tagging|PoS] corretta.

## Approccio Backtracking nel Parsing

Uno degli approcci più semplici per il parsing sintattico è il **backtracking**, in cui si esplorano **tutte le possibili derivazioni** della frase a partire dalla grammatica, tornando indietro ogni volta che un'analisi si rivela non valida. Esattamente l'approccio utilizzato negli esempi di parsing sintattico (Top-Down e Bottom-Up) precedenti.

### Come funziona

- Si parte dal simbolo iniziale della grammatica.
- Si tenta di derivare la frase applicando le regole grammaticali.
- Se un cammino porta a un vicolo cieco, si torna indietro (*backtrack*) e si prova una derivazione alternativa.

### Svantaggi del backtracking

- È **computazionalmente costoso**, perché in presenza di ambiguità strutturale o grammatiche complesse, il numero di derivazioni può crescere **esponenzialmente**.
- Può causare **ripetizione di lavoro**, esplorando più volte gli stessi sottoproblemi.

### Programmazione dinamica come alternativa

Per superare queste limitazioni, si preferisce usare **algoritmi di parsing basati su programmazione dinamica**, come l’algoritmo **CKY**, che:

- Evita ripetizioni memorizzando i risultati intermedi.
- Riduce il tempo di parsing a **tempo polinomiale** per grammatiche in forma normale di Chomsky (CNF).
- È più adatto per implementazioni efficienti in NLP.

👉 Vedi anche: [[Algoritmo CKY]]

## Conclusioni

Il **parsing sintattico** è un passaggio cruciale nell'analisi del linguaggio naturale, in quanto permette di attribuire una struttura gerarchica e formale alle frasi. In questa nota abbiamo:

- Esplorato cosa siano gli **alberi sintattici** e il loro ruolo nella rappresentazione della struttura delle frasi.
- Analizzato il concetto di **ambiguità strutturale**, evidenziando come una stessa frase possa dare luogo a interpretazioni sintattiche differenti.
- Descritto l'approccio di **backtracking** e i suoi limiti computazionali, motivando la preferenza per tecniche più efficienti come la **programmazione dinamica**.

Comprendere il parsing sintattico non solo è essenziale per applicazioni NLP come l'analisi grammaticale automatica, ma fornisce anche una base teorica solida per comprendere come i computer possano "capire" il linguaggio umano. È un ponte tra la linguistica e l'informatica che dimostra la potenza e la bellezza delle grammatiche formali.