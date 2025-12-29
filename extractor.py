import re
import os

def extract_python_code_from_markdown(input_file, code_output_file, markdown_output_file):
    """
    Estrae il codice Python da un file Markdown e lo salva in un file separato.
    Salva anche il markdown senza il codice Python in un altro file.
    
    Args:
        input_file: Path del file markdown di input
        code_output_file: Path del file txt dove salvare il codice Python
        markdown_output_file: Path del file markdown dove salvare il markdown senza codice
    """
    
    # Leggi il file markdown
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"❌ Errore: File '{input_file}' non trovato!")
        return
    except Exception as e:
        print(f"❌ Errore durante la lettura del file: {e}")
        return
    
    # Pattern per trovare blocchi di codice Python
    # Cerca ```python ... ``` oppure ```py ... ```
    python_code_pattern = r'```(?:python|py)\n(.*?)```'
    
    # Trova tutti i blocchi di codice Python
    python_blocks = re.findall(python_code_pattern, content, re.DOTALL)
    
    # Rimuovi i blocchi di codice Python dal markdown
    markdown_without_code = re.sub(python_code_pattern, '', content, flags=re.DOTALL)
    
    # Salva il codice Python estratto
    try:
        with open(code_output_file, 'w', encoding='utf-8') as f:
            if python_blocks:
                f.write("# Codice Python estratto da Markdown\n")
                f.write("# " + "="*70 + "\n\n")
                
                for i, block in enumerate(python_blocks, 1):
                    f.write(f"# ===== Blocco di codice {i} =====\n\n")
                    f.write(block.strip())
                    f.write("\n\n" + "#" + "-"*70 + "\n\n")
                
                print(f"✅ Estratti {len(python_blocks)} blocchi di codice Python")
                print(f"✅ Codice salvato in: {code_output_file}")
            else:
                f.write("# Nessun blocco di codice Python trovato nel file markdown\n")
                print("⚠️  Nessun blocco di codice Python trovato nel file markdown")
    except Exception as e:
        print(f"❌ Errore durante il salvataggio del codice: {e}")
        return
    
    # Salva il markdown senza codice
    try:
        with open(markdown_output_file, 'w', encoding='utf-8') as f:
            # Pulisci eventuali linee vuote multiple
            cleaned_markdown = re.sub(r'\n{3,}', '\n\n', markdown_without_code)
            f.write(cleaned_markdown.strip())
        
        print(f"✅ Markdown senza codice salvato in: {markdown_output_file}")
    except Exception as e:
        print(f"❌ Errore durante il salvataggio del markdown: {e}")
        return
    
    # Statistiche
    print(f"\n📊 STATISTICHE:")
    print(f"   - File originale: {os.path.getsize(input_file)} bytes")
    print(f"   - File codice: {os.path.getsize(code_output_file)} bytes")
    print(f"   - File markdown: {os.path.getsize(markdown_output_file)} bytes")
    print(f"   - Blocchi Python estratti: {len(python_blocks)}")


def extract_all_code_blocks(input_file, code_output_file, markdown_output_file):
    """
    Versione alternativa che estrae TUTTI i blocchi di codice (non solo Python)
    e li salva indicando il linguaggio.
    """
    
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"❌ Errore: File '{input_file}' non trovato!")
        return
    except Exception as e:
        print(f"❌ Errore durante la lettura del file: {e}")
        return
    
    # Pattern per trovare TUTTI i blocchi di codice con linguaggio specificato
    code_pattern = r'```(\w+)\n(.*?)```'
    
    # Trova tutti i blocchi di codice con il loro linguaggio
    code_blocks = re.findall(code_pattern, content, re.DOTALL)
    
    # Rimuovi tutti i blocchi di codice dal markdown
    markdown_without_code = re.sub(r'```\w*\n.*?```', '', content, flags=re.DOTALL)
    
    # Salva il codice estratto
    try:
        with open(code_output_file, 'w', encoding='utf-8') as f:
            if code_blocks:
                f.write("# Codice estratto da Markdown\n")
                f.write("# " + "="*70 + "\n\n")
                
                for i, (language, code) in enumerate(code_blocks, 1):
                    f.write(f"# ===== Blocco {i} - Linguaggio: {language} =====\n\n")
                    f.write(code.strip())
                    f.write("\n\n" + "#" + "-"*70 + "\n\n")
                
                print(f"✅ Estratti {len(code_blocks)} blocchi di codice")
                print(f"✅ Codice salvato in: {code_output_file}")
            else:
                f.write("# Nessun blocco di codice trovato nel file markdown\n")
                print("⚠️  Nessun blocco di codice trovato nel file markdown")
    except Exception as e:
        print(f"❌ Errore durante il salvataggio del codice: {e}")
        return
    
    # Salva il markdown senza codice
    try:
        with open(markdown_output_file, 'w', encoding='utf-8') as f:
            cleaned_markdown = re.sub(r'\n{3,}', '\n\n', markdown_without_code)
            f.write(cleaned_markdown.strip())
        
        print(f"✅ Markdown senza codice salvato in: {markdown_output_file}")
    except Exception as e:
        print(f"❌ Errore durante il salvataggio del markdown: {e}")
        return
    
    # Statistiche con linguaggi
    languages = {}
    for lang, _ in code_blocks:
        languages[lang] = languages.get(lang, 0) + 1
    
    print(f"\n📊 STATISTICHE:")
    print(f"   - File originale: {os.path.getsize(input_file)} bytes")
    print(f"   - File codice: {os.path.getsize(code_output_file)} bytes")
    print(f"   - File markdown: {os.path.getsize(markdown_output_file)} bytes")
    print(f"   - Blocchi totali estratti: {len(code_blocks)}")
    print(f"   - Linguaggi trovati:")
    for lang, count in sorted(languages.items()):
        print(f"     • {lang}: {count} blocchi")


# ============================================================================
# ESEMPIO DI UTILIZZO
# ============================================================================

if __name__ == "__main__":
    print("="*80)
    print("ESTRATTORE DI CODICE DA MARKDOWN")
    print("="*80 + "\n")
    
    # Configurazione file
    input_markdown = "Classification Metrics.md"  # File markdown di input
    output_code = "codice_estratto.txt"  # File output per il codice
    output_markdown = "documento_senza_codice.md"  # File output per markdown
    
    # Scegli quale versione usare:
    
    # OPZIONE 1: Estrae solo codice Python
    print("🔍 Estrazione codice PYTHON...\n")
    extract_python_code_from_markdown(input_markdown, output_code, output_markdown)
    
    # OPZIONE 2: Estrae tutti i blocchi di codice (decommentare per usare)
    # print("🔍 Estrazione di TUTTI i blocchi di codice...\n")
    # extract_all_code_blocks(input_markdown, output_code, output_markdown)
    
    print("\n" + "="*80)
    print("✨ PROCESSO COMPLETATO!")
    print("="*80)