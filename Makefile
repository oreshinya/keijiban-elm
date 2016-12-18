clean:
	rm -rf public/build

js:
	elm-make src/Main.elm --output=public/build/bundle.js

css:
	elm-css StyleCompiler.elm --module=StyleCompiler --output=public/build

build: clean js css
