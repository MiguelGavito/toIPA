# Backend - IPA Translator API

This is a Flask-based REST API that translates Spanish text to IPA (International Phonetic Alphabet) using the `epitran` library.

## How It Works

### Core Functionality
- **Endpoint:** `POST /trans`
- **Input:** JSON with a `text` field containing Spanish text
- **Output:** JSON with the original `input` and the `ipa` transliteration

### Example Request
```bash
curl -X POST http://localhost:5000/trans \
  -H "Content-Type: application/json" \
  -d '{"text": "Hola mundo"}'
```

### Example Response
```json
{
  "input": "Hola mundo",
  "ipa": "[ˈo.la ˈmun.do]"
}
```

### Key Dependencies
- **Flask**: Lightweight Python web framework for creating the API
- **epitran**: Library that handles Spanish (spa-Latn) transliteration to IPA
- **flask-cors**: Enables Cross-Origin Resource Sharing so the frontend can communicate with the backend
- **setuptools**: Required for Python package management

---

## Development Setup

### Running with Nix (Recommended)

1. **Enter the backend development environment:**
   ```bash
   nix develop .#backend
   ```
   This automatically installs all dependencies specified in `shell.nix`.

2. **Run the Flask server:**
   ```bash
   cd backend
   python myapp.py
   ```
   The API will be available at `http://localhost:5000`

3. **Test the API:**
   ```bash
   curl -X POST http://localhost:5000/trans \
     -H "Content-Type: application/json" \
     -d '{"text": "prueba"}'
   ```

### Without Nix
If you're not using Nix, install dependencies manually:
```bash
pip install flask epitran setuptools flask-cors
python myapp.py
```

---

## Adding New Dependencies

### Why Nix?
Using Nix ensures **reproducibility**: everyone on the team gets the exact same package versions, eliminating "works on my machine" problems.

### Step 1: Find the Package
Go to [search.nixos.org](https://search.nixos.org/) and search for the Python package you need.

**Example:** Looking for the `requests` library:
- Search for `python3.pkgs.requests` or just `requests`
- Note the exact package name from nixpkgs

### Step 2: Add to `shell.nix`

Open `backend/shell.nix` and add your package to the Python packages list:

```nix
(python3.withPackages (ps: [
  ps.flask 
  ps.epitran
  ps.setuptools
  ps.flask-cors
  ps.requests          # <-- Add your new package here
]))
```

### Step 3: Verify It Works

1. **Exit the current Nix shell** (if in one):
   ```bash
   exit
   ```

2. **Re-enter the shell** to load the new dependencies:
   ```bash
   nix develop .#backend
   ```

3. **Test the import** in Python:
   ```bash
   python -c "import requests; print(requests.__version__)"
   ```

4. **Update your code** to use the new dependency

5. **Test your application:**
   ```bash
   python myapp.py
   ```

### Step 4 (Optional): Update `flake.nix`

For consistency, also update the main `flake.nix` file in the project root:

```nix
backend = pkgs.mkShell {
  buildInputs = [
    (pkgs.python3.withPackages (ps: [
      ps.flask
      ps.epitran
      ps.setuptools
      ps.flask-cors
      ps.requests          # <-- Add here too
    ]))
  ];
};
```

---

## How to Check What Dependencies Are Required

### Method 1: Look at Project Requirements
Check `shell.nix` to see what's already installed.

### Method 2: Import Test
Try importing the library in Python:
```bash
python -c "import your_library_name"
```
If it works, it's installed. If not, you need to add it to `shell.nix`.

### Method 3: Check `pip` Packages (Non-Nix)
If working without Nix:
```bash
pip list | grep package_name
```

### Method 4: Search Nixpkgs
Go to [search.nixos.org](https://search.nixos.org/) and search for the package name. The search results show:
- Exact package name in nixpkgs
- Which versions are available
- Dependencies it requires

---

## Project Structure

```
backend/
├── myapp.py          # Main Flask application
├── shell.nix         # Nix shell configuration with dependencies
└── README.md         # This file
```

### `myapp.py` Breakdown
- **Flask setup:** Creates the app and enables CORS
- **Epitran initialization:** `epi = epitran.Epitran("spa-Latn")` loads the Spanish-to-IPA translator
- **Routes:**
  - `GET /`: Simple health check
  - `POST /trans`: Main transliteration endpoint

---

## Troubleshooting

### "Module not found" error
**Solution:** Ensure you've exited and re-entered the Nix shell after adding the dependency to `shell.nix`.

### Changes to `shell.nix` aren't taking effect
**Solution:** 
```bash
exit              # Exit current shell
nix flake update  # Update Nix flake (optional, for newer versions)
nix develop .#backend
```

### Port 5000 is already in use
**Solution:** Kill the existing process or change the port in `myapp.py`:
```python
app.run(host="0.0.0.0", port=5001)  # Use a different port
```

### CORS errors when calling from frontend
**Verify:** The backend is running and flask-cors is installed. Check that the frontend uses the correct backend URL.

---

## Next Steps for Development

1. **Modify `myapp.py`** to add new endpoints or change the language
2. **Change the language:** Replace `"spa-Latn"` with a different epitran language code
3. **Add validation:** Check input data before transliteration
4. **Add error handling:** Handle cases where transliteration fails
5. **Performance optimization:** Cache transliteration results if needed

---

## Useful Commands

```bash
# Enter backend development shell
nix develop .#backend

# Run the app
python myapp.py

# Test a specific endpoint
curl http://localhost:5000/

# Search for a package
# Visit: https://search.nixos.org/packages

# Clean up Nix cache (optional, frees disk space)
nix-collect-garbage
```

---

## Resources

- [Flask Documentation](https://flask.palletsprojects.com/)
- [Epitran Documentation](https://pypi.org/project/epitran/)
- [Nix Package Search](https://search.nixos.org/)
- [Python Packages in Nixpkgs](https://nixos.wiki/wiki/Python)
