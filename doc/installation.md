## Prerequisite

Curvytron runs on [node.js >= v10](https://nodejs.org/).
You need to install node and [bower](https://bower.io/) on the machine that will run the Curvytron server.

## Installation

__Clone the repository__

    git clone https://github.com/Elao/curvytron.git
    cd curvytron

__Install dependencies__

    npm install

This will install npm packages and bower dependencies. You may see warnings about optional dependencies (like `usage`) failing to build - this is expected and won't affect functionality.

__Create config file__

    cp config.json.sample config.json

__Build the game__

    npx gulp dev

__Compile SASS__ (if CSS is missing)

The gulp sass task may not output files on some systems. If `web/css/style.css` doesn't exist after building, run:

    mkdir -p web/css
    npx node-sass-chokidar src/sass/style.scss -o web/css/

## Launch server

    node bin/curvytron.js

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
