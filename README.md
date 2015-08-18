# Claire Cordova Dockerfile

This container manages building and signing android apk builds and compiling gopherjs files.

# Building image
Clone this repo and run `docker build -t claire/cordova .`

# Installing cdv script
Run `sudo ./install` which will install `cdv` script to `/usr/local/bin/` directory

# Usage examples

You use cordova as usual, the only difference is that you prepend your commands with `cdv`.

For example, to create a new cordova project, you would type:
`cdv cordova create project-name`

Or to add an android platform to the project build targets, you would type `cdv cordova platform add android` from your project source directory.

# Note on gopherjs
You need to place your js files in `www/js`, they are all compiled to `main.js`

# Builtin tools

### apk-build
Run `cdv apk-build` from your project source folder to compile go files and generate debug apk

### apk-build release
Place your `ClaireGooglePlay.keystore` file to your project source folder

Then run `cdv apk-build release` to compile go files, generate release build and automatically sign it
