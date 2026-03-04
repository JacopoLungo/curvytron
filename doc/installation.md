## Prerequisite

The original Curvytron is [declared to run on node.js >= 0.10](https://github.com/Curvytron/curvytron/blob/master/doc/installation.md). However, since that version is absurdly outdated, we use node.js == 10.24.1 (npm == 6.14.12) instead. Newer versions of node.js may work, but have not been tested and are not guaranteed to be compatible.

If you haven't already, clone the repository and navigate to the project directory:

    git clone https://github.com/JacopoLungo/curvytron.git
    cd curvytron

## Automatic installation
You can use the provided `install.sh` script to automate the installation process. This script will install nvm, node.js, bower, and all necessary dependencies, then build the game for you. Just sit back and see the magic happen!

    bash install.sh

If you prefer, you can also follow the manual installation steps below to set up the project yourself.

## Manual installation
__Install nvm (Node Version Manager) v0.40.4__
Follow the installation instructions on the [nvm repository](https://github.com/nvm-sh/nvm):

    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

__Install node.js v10.24.1 (npm v6.14.12)__

    nvm install 10.24.1
    nvm use 10.24.1

__Install bower__

    npm install -g bower

__Install dependencies__

    npm install

NB: in some cases, you may be prompted to answer a question: the answer is !1

This will install npm packages and bower dependencies. You may see warnings about optional dependencies (like `usage`) failing to build - this is expected and won't affect functionality.

__Create config file__

    cp config.json.sample config.json

__Build the game__

    npx gulp dev

__Compile SASS__ (if CSS is missing)

The gulp sass task may not output files on some systems. If `web/css/style.css` doesn't exist after building, run:

    mkdir -p web/css
    npx node-sass-chokidar src/sass/style.scss -o web/css/

## Launch local server

    node bin/curvytron.js

NB: [nvm is invoked per-shell](https://github.com/nvm-sh/nvm?tab=readme-ov-file#about). Therefore, remember to run `nvm use 10.24.1` when you open a new terminal otherwise node and npm commands are not recognized and won't work. Alternatively, you can run the server with nvm directly in one command:

    nvm exec 10.24.1 node bin/curvytron.js

## Play

Go to [http://localhost:8080/](http://localhost:8080/)
Join a room, choose a player name and play!

## Troubleshooting

### node-sass build failures

The legacy `node-sass` package doesn't work with modern systems. The project has been updated to use `sass` (Dart Sass) with `gulp-sass@5` instead.

### globalThis is not defined

This error occurs with older gulp versions. The `gulpfile.js` includes a fix at the top of the file:

```javascript
global.globalThis = global;
```

### Bower Angular version conflict

If you see Angular version conflicts during bower install, use:

    bower install -F

The `-F` flag forces resolution of version conflicts.
