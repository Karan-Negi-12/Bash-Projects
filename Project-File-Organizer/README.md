
# 📁 File Organizer Script

Organize files in a directory into subfolders based on their file extensions — clean, simple, and safe by default.

> **Highlights**: Handles hidden files, avoids overwriting existing files, and consistently groups files without extensions into an `Others/` folder.

---

## ✨ Features
- 📦 Groups files by extension (e.g., `.jpg` → `Jpgs/`, `.pdf` → `Pdfs/`)
- 👀 Includes **hidden files** (e.g., `.env`, `.gitignore`)
- 🛑 **No overwrite** safety (`mv -n`) — existing files aren’t clobbered
- 🔤 **Case-insensitive** extension handling (`PNG` and `png` → `Pngs/`)
- 🗂️ Files without extensions go to **`Others/`**

---

## 🧩 Script
Save this as `organize.sh` (or keep it handy here):

```bash
#!/bin/bash
# Description: Organizes files in a specified directory into subdirectories based on file extensions.

DIR=${1:-.}

# Check if directory exists
if [ ! -d "$DIR" ]; then
  echo "Directory $DIR does not exist."
  exit 1
else
  echo "Directory $DIR exists."
  echo "Let's start organizing files..."
fi

# Include hidden files
shopt -s dotglob

for file in "$DIR"/*; do
    [ -e "$file" ] || continue  # Skip if no files

    # Skip directories
    if [ -d "$file" ]; then
        continue
    fi

    filename=$(basename -- "$file")
    extension="${filename##*.}"

    # Handle files without extension
    if [ "$filename" = "$extension" ]; then
        folder="Others"
    else
        # Normalize extension to lowercase
        extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
        # Capitalize first letter and add 's'
        folder="$(tr '[:lower:]' '[:upper:]' <<< ${extension:0:1})${extension:1}s"
    fi

    # Create folder and move file without overwriting
    mkdir -p "$DIR/$folder"
    mv -n "$file" "$DIR/$folder/"
    echo "Moved: $filename → $folder/"
done

echo "✅ Organization complete!"
```

---

## 🚀 Quick Start

1. Save the script above as `organize.sh`
2. Make it executable:
   ```bash
   chmod +x organize.sh
   ```
3. Run it against a directory (or omit the argument to use the current directory):
   ```bash
   ./organize.sh /path/to/your/directory
   # or
   ./organize.sh
   ```

---

## 📘 Usage
```bash
bash organize.sh [DIRECTORY]
```
- **DIRECTORY**: Optional. Defaults to the current directory `.`

**What it does:**
- Creates subfolders like `Pdfs/`, `Jpgs/`, `TxTs/` (normalized to `Txts/`) based on extensions
- Moves files into their respective folders
- Skips directories and non-existent matches
- Never overwrites files in destination (thanks to `mv -n`)

---

## 🧪 Examples

**Before**
```
Downloads/
├── report.PDF
├── photo.png
├── photo (1).PNG
├── notes
├── .env
├── README
```

**Run**
```bash
bash organize.sh ~/Downloads
```

**After**
```
Downloads/
├── Pdfs/
│   └── report.PDF
├── Pngs/
│   ├── photo.png
│   └── photo (1).PNG
├── Others/
│   ├── README
│   └── .env
├── notes
```
> Note: `notes` is a directory, so it isn’t moved.

---

## 📝 Notes & Gotchas
- **Hidden files**: Included via `shopt -s dotglob`.
- **No overwrite**: Uses `mv -n`. If a destination file exists, the source is **left in place**.
  - Prefer interactive prompts? Replace `mv -n` with `mv -i`.
- **Case normalization**: Extensions are converted to lowercase before folder naming (`JPG`, `jpg` → `Jpgs/`).
- **No recursion**: Only operates on the **top-level** of the specified directory.
- **No extension detection**: Files without `.` go to `Others/`.

---

## 🔧 Customizations (optional)
- **Recursive mode**: Walk subdirectories with `find` (skipping already created buckets).
- **Dry run**: Add a `--dry-run` flag to print planned moves without changing files.
- **Conflict policy**: Switch `mv -n` → `mv -i` (interactive) or `mv -f` (force) per your needs.

> Want these added? Open an issue or ask for an enhanced version and I’ll generate it.

---

## ❓ FAQ
**Q: Will it move folders?**  
A: No. It only moves regular files.

**Q: Will it organize files inside subfolders?**  
A: Not by default. Ask for a recursive version if you need that.

**Q: What about multi-dot names (e.g., `archive.tar.gz`)?**  
A: The extension is everything after the **last** dot (`gz` → `Gzs/`). If you prefer `Tar.gzs/`, we can tweak the logic.

---

## 👤 Author
**Karan Negi**

---

## 🪪 License
Choose a license (e.g., MIT, Apache-2.0) and add it here.

