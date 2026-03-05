#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────
# Curvytron – installation script
# Requires: bash, wget, git
# ─────────────────────────────────────────────

NODE_VERSION="10.24.1"
NVM_VERSION="0.40.4"
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# ── 1. Install nvm ────────────────────────────
echo ">>> Installing nvm ${NVM_VERSION}..."
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash

# Load nvm into the current shell session
export NVM_DIR
# shellcheck source=/dev/null
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ── 2. Install & activate Node.js ────────────
echo ">>> Installing Node.js ${NODE_VERSION}..."
nvm install "${NODE_VERSION}"
nvm use "${NODE_VERSION}"

# ── 3. Install bower globally ─────────────────
echo ">>> Installing bower..."
npm install -g bower

# ── 4. Install dependencies ───────────────────
echo ">>> Installing npm & bower dependencies..."
npm install

# ── 5. Create config file ─────────────────────
if [ ! -f config.json ]; then
    echo ">>> Creating config.json from sample..."
    cp config.json.sample config.json
fi

# ── 6. Build the game ─────────────────────────
echo ">>> Building Curvytron with gulp..."
npx gulp dev

# ── 7. Compile SASS if CSS is missing ─────────
if [ ! -f web/css/style.css ]; then
    echo ">>> CSS not found – compiling SASS manually..."
    mkdir -p web/css
    npx node-sass-chokidar src/sass/style.scss -o web/css/
fi

# ─────────────────────────────────────────────
echo ""
echo "✅  Installation complete!"
echo ""
echo "To start the server, run:"
echo "   nvm exec ${NODE_VERSION} node bin/curvytron.js"
