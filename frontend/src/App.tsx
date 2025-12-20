import React, { useState } from "react";

function App() {
  const [text, setText] = useState("");
  const [result, setResult] = useState("");

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();

    // Replace with your backend URL/port
    const res = await fetch("http://localhost:5000/trans", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ text }),
    });

    const json = await res.json();
    setResult(json.ipa ?? "No result");
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>IPA Translator</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={text}
          onChange={(e) => setText(e.target.value)}
          placeholder="Enter text"
        />
        <button type="submit">Translate</button>
      </form>

      {result && (
        <div>
          <h2>Result:</h2>
          <p>{result}</p>
        </div>
      )}
    </div>
  );
}

export default App;

