# Frontend - IPA Translator React App

This is a React + TypeScript frontend built with Vite that provides a user interface for translating Spanish text to IPA notation. It communicates with the Flask backend API.

## How It Works

### User Interface
- Simple form with a text input field
- Submit button to send text to the backend
- Displays the IPA transliteration result

### Data Flow
1. User enters Spanish text in the input field
2. User clicks "Translate" button
3. Frontend sends a `POST` request to the backend (`http://localhost:5000/trans`)
4. Backend processes the text and returns the IPA version
5. Frontend displays the result on the page

### Key Dependencies
- **React**: JavaScript library for building interactive UIs
- **React-DOM**: Renders React components in the browser
- **TypeScript**: Adds type safety to JavaScript
- **Vite**: Lightning-fast frontend build tool and development server
- **@types/react & @types/react-dom**: TypeScript definitions for React

---

## Development Setup

### Running with Nix (Recommended)

1. **Enter the frontend development environment:**
   ```bash
   nix develop .#frontend
   ```
   This automatically installs Node.js, Yarn, and all npm dependencies.

2. **Install dependencies:**
   ```bash
   cd frontend
   yarn
   ```

3. **Start the development server:**
   ```bash
   yarn dev
   ```
   The frontend will be available at `http://localhost:5173` (Vite's default port)

4. **Make sure the backend is running** (in another terminal):
   ```bash
   nix develop .#backend
   cd backend
   python myapp.py
   ```

### Without Nix
If you're not using Nix:
```bash
# Make sure you have Node.js installed
npm install  # or yarn
yarn dev
```

---

## Understanding the Commands

### `yarn dev`
- **What it does:** Starts the Vite development server with hot module reloading (HMR)
- **When to use:** During development
- **What you see:** 
  - Live development server (usually `http://localhost:5173`)
  - Code changes instantly reload in the browser
  - Fast feedback loop for development
- **Stop it:** Press `Ctrl+C`

### `yarn build`
- **What it does:** Creates an optimized production build
- **When to use:** Before deploying to production
- **Output:** 
  - Minified and bundled JavaScript files
  - Optimized assets
  - Placed in the `dist/` folder
- **Run it:**
  ```bash
  yarn build
  ```

### `yarn preview`
- **What it does:** Runs a local preview of the production build
- **When to use:** To test how your app looks in production before deploying
- **How to use:**
  ```bash
  yarn build    # First create the production build
  yarn preview  # Then preview it locally
  ```
- **Note:** This is read-only preview mode (slow reload on changes)

---

## Testing the Frontend

### Manual Testing (UI Testing)

1. **Start the backend** (in terminal 1):
   ```bash
   nix develop .#backend
   cd backend
   python myapp.py
   ```

2. **Start the frontend** (in terminal 2):
   ```bash
   nix develop .#frontend
   cd frontend
   yarn
   yarn dev
   ```

3. **Open your browser** and go to:
   ```
   http://localhost:5173
   ```

4. **Test the app:**
   - Type Spanish text (e.g., "Hola")
   - Click the "Translate" button
   - Verify you see the IPA output

### Testing with Browser Developer Tools

1. Open browser DevTools (`F12` or `Ctrl+Shift+I`)
2. Go to the **Network** tab
3. Type text and click "Translate"
4. You should see a POST request to `http://localhost:5000/trans`
5. Click the request and check the **Response** to see the IPA output

### Debugging

If something isn't working:

1. **Check the Console tab** in DevTools for JavaScript errors
2. **Check the Network tab** to see if the request reaches the backend
3. **Verify the backend is running** by testing it with curl:
   ```bash
   curl -X POST http://localhost:5000/trans \
     -H "Content-Type: application/json" \
     -d '{"text": "prueba"}'
   ```
4. **Check the terminal** where you ran `yarn dev` for build errors

---

## Adding New Dependencies

### Why Nix for Node.js?
Just like Python, Nix ensures all team members have the exact same Node.js version and package versions. This prevents compatibility issues.

### Step 1: Understand the Dependency
Ask yourself:
- Is this a **runtime dependency** (needed when the app runs)? → Add to `dependencies`
- Is this a **development dependency** (only needed during development)? → Add to `devDependencies`

### Step 2: Add to `package.json`

You have two options:

**Option A: Using Yarn (Recommended)**
```bash
# For runtime dependencies
yarn add package-name

# For development dependencies
yarn add --dev package-name
```

This automatically updates `package.json` and `yarn.lock`.

**Option B: Manual Edit**
Edit `frontend/package.json`:
```json
{
  "dependencies": {
    "react": "^19.2.3",
    "react-dom": "^19.2.3",
    "axios": "^1.6.0"          // <-- Add here for runtime
  },
  "devDependencies": {
    "@types/react": "^19.2.7",
    "@types/node": "^20.0.0"   // <-- Add here for dev
  }
}
```

Then run:
```bash
yarn
```

### Step 3: Add to `shell.nix` (Node.js runtime)

If you need the dependency available in the Nix shell, no action needed—Yarn and `package.json` handle it automatically. The Nix shell just needs Node.js, which is already there:

```nix
frontend = pkgs.mkShell {
  buildInputs = [
    pkgs.nodejs   # <-- Provides Node.js and npm/yarn
    pkgs.yarn
  ];
};
```

### Step 4: Test It Works

1. **Exit and re-enter the Nix shell:**
   ```bash
   exit
   nix develop .#frontend
   ```

2. **Reinstall dependencies:**
   ```bash
   cd frontend
   yarn
   ```

3. **Start the dev server and test:**
   ```bash
   yarn dev
   ```

4. **Use the new dependency in your code:**
   ```typescript
   import axios from 'axios';
   ```

5. **Verify in the browser** that your app still works and the new feature works

---

## Project Structure

```
frontend/
├── index.html         # Entry point HTML file
├── package.json       # Project dependencies and scripts
├── shell.nix          # Nix shell configuration (optional, use flake.nix)
├── src/
│   ├── App.tsx        # Main React component
│   └── index.tsx      # React DOM renderer
└── README.md          # This file
```

### File Breakdown

#### `index.html`
- Defines the page structure
- Has a `<div id="root"></div>` where React attaches the app
- Loads `src/index.tsx` as the entry point

#### `src/index.tsx`
- Mounts the React app to the DOM
- Renders the `App` component

#### `src/App.tsx`
- Main React component
- **State:**
  - `text`: What the user typed
  - `result`: The IPA transliteration from the backend
- **Functions:**
  - `handleSubmit()`: Sends text to the backend and updates result
- **UI Elements:**
  - Input field for Spanish text
  - Submit button
  - Conditional display of results

#### `package.json`
- Lists all dependencies (React, Vite, TypeScript, etc.)
- Defines npm/yarn scripts (`dev`, `build`, `preview`)
- Specifies project metadata

---

## Modifying the Frontend

### Change the Language
Currently, the backend transliterates Spanish. To change languages, modify the backend (see `backend/README.md`), then update the frontend label/prompt:

```typescript
// In App.tsx
<input
  type="text"
  placeholder="Enter French text"  // Changed from "Enter text"
/>
```

### Add More Features
Examples:
- Add a language selector dropdown
- Show both Latin and IPA side by side
- Add a copy-to-clipboard button
- Store translation history
- Add sound pronunciation

### Improve Styling
Currently, styling is inline. To add a CSS file:

1. **Create `src/App.css`:**
   ```css
   .container {
     max-width: 600px;
     margin: 0 auto;
   }
   ```

2. **Import in `src/App.tsx`:**
   ```typescript
   import "./App.css";
   ```

---

## Troubleshooting

### Port 5173 is already in use
**Solution:** Vite uses the next available port automatically, or specify a port:
```bash
yarn dev -- --port 3000
```

### "Cannot find module" errors
**Solution:** 
```bash
rm -rf node_modules yarn.lock
yarn install
```

### Changes aren't showing in the browser
**Solution:**
1. Hard refresh: `Ctrl+Shift+R` (or `Cmd+Shift+R` on Mac)
2. Check the terminal for build errors
3. Make sure `yarn dev` is still running

### Frontend can't reach backend
**Verify:**
1. Backend is running on `localhost:5000`:
   ```bash
   curl http://localhost:5000/
   ```
2. Backend has CORS enabled (it does, via `flask-cors`)
3. Backend URL in `App.tsx` is correct:
   ```typescript
   const res = await fetch("http://localhost:5000/trans", {
   ```

### "CORS error" in browser console
**Solution:** Ensure the backend is running with CORS enabled:
```python
CORS(app)  # This line must be in myapp.py
```

---

## Performance & Optimization Tips

1. **Code Splitting:** Vite automatically handles this
2. **Production Build:** Always use `yarn build` before deploying
3. **Lazy Loading:** For larger apps, lazy-load components:
   ```typescript
   const App = React.lazy(() => import('./App'));
   ```
4. **Dependencies:** Check bundle size:
   ```bash
   yarn build
   # Check the dist/ folder size
   ```

---

## Useful Commands Reference

```bash
# Install dependencies
yarn

# Start development server
yarn dev

# Build for production
yarn build

# Preview production build locally
yarn preview

# Clean up (remove node_modules and lockfile)
rm -rf node_modules yarn.lock && yarn

# Enter Nix shell
nix develop .#frontend

# Check Node version
node --version

# Check Yarn version
yarn --version
```

---

## Resources

- [React Documentation](https://react.dev/)
- [Vite Documentation](https://vitejs.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/)
- [Yarn Documentation](https://yarnpkg.com/)
- [Nix & Node.js](https://nixos.wiki/wiki/Node.js)

---

## Next Steps for Development

1. **Style the app** - Add CSS for a better user experience
2. **Add validation** - Check if input is valid before sending
3. **Show loading state** - Display a loading indicator while fetching
4. **Handle errors** - Show user-friendly error messages
5. **Add history** - Keep track of previous translations
6. **Add language selector** - Support multiple languages
