#!/usr/bin/env bash

# Bunnify
# Replaces any unreliable links found in the mods folder with a link to the Bunny bucket instead, for stability.
# Rehashes the pack afterwards.

echo "Converting any stray links to the Bunny bucket..."
for repl in \
	'https://github.com/=https://blanketcon.b-cdn.net/' \
	'https://mvn.devos.one/=https://blanketcon.b-cdn.net/devos/' \
	'https://ci.blamejared.com/=https://blanketcon.b-cdn.net/jared/' \
	'https://jaskarth.com/=https://blanketcon.b-cdn.net/jaskarth/' \
	'https://maven.ithundxr.dev/=https://blanketcon.b-cdn.net/ithundxr/' \
	; do
	find -name '*.pw.toml' -print0 | xargs -0 sed -i "s=$repl=g"
done
packwiz refresh
echo "Conversion done!"
