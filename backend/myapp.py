#!/usr/bin/env python

from flask import Flask, request, jsonify
from flask_cors import CORS

import epitran # for the ipa


app = Flask(__name__)
CORS(app)
epi = epitran.Epitran("spa-Latn")

@app.route("/")
def hello():
    return {
        "message": "Hello, Nix"
    }

@app.route("/trans",  methods=["POST"])
def trans():
    data = request.get_json()
    text = data.get("text", "")
    ipa_text = epi.transliterate(text)
    return jsonify({
        "input": text,
        "ipa": ipa_text
    })

def run():
    app.run(host="0.0.0.0", port=5000)

if __name__ == "__main__":
    run()
