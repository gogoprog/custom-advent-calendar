dev:
	haxe build.hxml

release:
	haxe build.hxml
	terser --compress -- build/cac.js > build/cac.min.js
