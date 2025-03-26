# Espressioni Regolari (Regex)

## Cosa sono le Regex?
- **Definizione**: Sequenze di caratteri che definiscono un pattern di ricerca, utilizzate per individuare, estrarre o sostituire testo.
- **Scopo principale**: Automatizzare operazioni di testo complesse (es. validare email, estrarre dati).
- **Esempi di utilizzo**:
  - Ricerca di parole chiave in documenti.
  - Pulizia di dataset testuali.
  - Sostituzioni avanzate in editor di codice.

---

## Strumenti per Testare le Regex
- **Regex101** ([link](https://regex101.com/)): Piattaforma web con debugger integrato e spiegazioni dettagliate.
- **Python** (`re` module): Libreria standard per manipolare regex ([esempi](https://www.programiz.com/python-programming/regex)).
- **Java**: Utilizza `java.util.regex` per operazioni avanzate ([guide](https://www.w3schools.com/java/java_regex.asp)).
- **Perl**: Linguaggio storico per regex, con operatori come `s///` per sostituzioni.

---

## Sintassi Base delle Regex
### Metacaratteri
| Simbolo | Funzione | Esempio |
|---------|----------|---------|
| `[]`    | Definisce un set di caratteri ammessi. | `[Aa]mico` → "Amico" o "amico" |
| `^`     | 1) Negazione dentro `[]`.<br>2) Inizio della riga. | `[^a-z]` → Non lettere minuscole.<br>`^Ciao` → "Ciao" solo all'inizio. |
| `?`     | Zero o una occorrenza del carattere precedente. | `colou?r` → "color" o "colour" |
| `.`     | Qualsiasi carattere (tranne newline). | `b.t` → "bat", "b@t", "b3t" |
| `*`     | Zero o più occorrenze del carattere precedente. | `lo*l` → "ll", "lol", "loooool" |
| `+`     | Una o più occorrenze del carattere precedente. | `a+` → "a", "aa", "aaa" |
| `{n,m}` | Da `n` a `m` occorrenze. | `a{2,4}` → "aa", "aaa", "aaaa" |

### Alias Utili
- `\d`: Cifra numerica (`[0-9]`).
- `\w`: Carattere alfanumerico o underscore (`[a-zA-Z0-9_]`).
- `\s`: Spazio bianco (spazio, tab, newline).
- `\D`, `\W`, `\S`: Negazioni dei precedenti.

---

## Esercizio Guidato: Trovare la Parola "the"
1. **Primo tentativo**: `/the/ → Trova "the" ma anche "there", "other" (falsi positivi).**
2. **Matching case-insensitive**: `/[tT]he/ → Trova "The" e "the".`
3. **Evitare parole contenenti "the"**:  
   `/[^a-zA-Z][tT]he[^a-zA-Z]/ → " the " in "Catch the ball".`
4. **Pattern avanzato**:  
   `/(^|[^a-zA-Z])[tT]he([^a-zA-Z]|$)/ → Considera inizio/fine riga.`

**Problemi comuni**:
- **Falsi positivi**: Match indesiderati (es. "there").
- **Falsi negativi**: Mancato match di "The" all'inizio frase.
- **Bilanciamento**: Aumentare la **precisione** (ridurre falsi positivi) e il **recall** (ridurre falsi negativi).

## Registri (Parentesi per Riferimenti)

Le **parentesi tonde** `()` nelle espressioni regolari vengono utilizzate per definire **gruppi di cattura**, ovvero parti del pattern che possono essere successivamente richiamate nei riferimenti numerici o nelle sostituzioni.

### Sintassi di Base
Un gruppo di cattura è definito con `()` e può essere richiamato con `\n`, dove `n` è il numero del gruppo nell'ordine in cui compare.

**Esempio**:
```regex
/(\d+)-(\d+)/
```
Questa regex cattura due numeri separati da un trattino `-`:
- `\1` si riferisce al primo numero.
- `\2` si riferisce al secondo numero.

Se applicata alla stringa `2023-2024`, cattura `2023` come `\1` e `2024` come `\2`.

### Applicazione: Riorganizzazione del Testo
I riferimenti ai gruppi catturati vengono utilizzati nelle operazioni di sostituzione.

**Esempio**:
```regex
s/(\w+) (\w+)/\2 \1/
```
Questa espressione inverte la posizione di due parole:
- Input: `Nome Cognome`
- Output: `Cognome Nome`

### Altri Esempi di Utilizzo
#### 1. Estrazione del Dominio da un'Email
```regex
/(\w+)@(\w+\.\w+)/
```
- `\1` rappresenta il nome utente.
- `\2` rappresenta il dominio dell'email.

Se applicata a `esempio@email.com`, cattura:
- `esempio` come `\1`
- `email.com` come `\2`

#### 2. Riformattazione della Data
Se una data è scritta come `2024/03/26` e la si vuole convertire in `26-03-2024`:
```regex
s/(\d{4})/(\d{2})/(\d{2})/\3-\2-\1/
```

- `\1` è l'anno.
- `\2` è il mese.
- `\3` è il giorno.

Risultato della sostituzione: `26-03-2024`.

### Conclusione
I **registri** e i **gruppi di cattura** sono strumenti potenti per manipolare il testo con le espressioni regolari. Sono utili per:
- Estrarre informazioni specifiche.
- Riordinare parti di una stringa.
- Modificare il formato di dati testuali.

## Caso Storico: ELIZA (1966)

    Descrizione: Primo chatbot che simulava uno psicologo rogersiano.

    Funzionamento:

        Utilizzava regex semplici per identificare parole chiave (es. "madre", "triste").

        Generava risposte predefinite basate su sostituzioni (es. "Dimmi di più sulla tua famiglia").

    Limitazioni: Nessuna comprensione semantica, solo pattern matching superficiale.

    Video dimostrativo: ELIZA in azione.

## Risorse

- Libro: Speech and Language Processing (Jurafsky & Martin).

- Tool online: Regex101 per testare pattern.

- Etichette: #Regex #NLP #PatternMatching
    
- Collegamenti: [[Introduzione all'NLP]], [[Elaborazione del Testo]]