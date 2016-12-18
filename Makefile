clean:
	rm -rf public/build

js: clean
	elm-make src/Main.elm --output=public/build/bundle.js
