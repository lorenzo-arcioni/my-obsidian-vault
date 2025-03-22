#!/bin/bash
VAULT_PATH="/home/lorenzo/Documenti/Obsidian Vault"
OUTPUT_JSON="graph.json"
TMP_FILE="tmp_graph.txt"

# Inizializza il file temporaneo per salvare gli edge
> "$TMP_FILE"

# Ciclo ricorsivo su tutti i file Markdown nel vault
find "$VAULT_PATH" -type f -name "*.md" | while IFS= read -r file; do
    # Estrai il nome della nota (senza percorso e senza estensione)
    note=$(basename "$file" .md)
    # Estrai i link nel formato [[...]] mantenendo eventuali spazi e virgole
    # Utilizziamo grep -oP per estrarre il contenuto interno, poi sed per eliminare la parte dopo "|"
    grep -oP "\[\[\K[^]]+(?=\]\])" "$file" | sed -E 's/\|.*//g' | while IFS= read -r link; do
        echo "{\"from\": \"${note}\", \"to\": \"${link}\"}," >> "$TMP_FILE"
    done
done

# Genera la lista dei nodi (tutti i file Markdown trovati, senza duplicati)
NODES=$(find "$VAULT_PATH" -type f -name "*.md" | while IFS= read -r file; do
    note=$(basename "$file" .md)
    echo "{\"id\": \"${note}\", \"label\": \"${note}\"},"
done)

# Costruisci il file JSON finale
{
  echo '{'
  echo '  "nodes": ['
  # Rimuove l'ultima virgola dalla lista dei nodi
  echo "$NODES" | sed '$ s/,$//'
  echo '  ],'
  echo '  "edges": ['
  # Rimuove l'ultima virgola dalla lista degli edge
  sed '$ s/,$//' "$TMP_FILE"
  echo '  ]'
  echo '}'
} > "$OUTPUT_JSON"

# Pulisci il file temporaneo
rm "$TMP_FILE"

echo "Esportazione completata in $OUTPUT_JSON"




