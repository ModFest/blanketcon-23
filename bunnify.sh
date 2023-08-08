#!/usr/bin/env bash

# Bunnify
# Replaces any GitHub links found in the mods folder with a link to the Bunny bucket instead, for stability.
# Rehashes the pack afterwards.

echo "Converting any stray GitHub links to the Bunny bucket..."
cd mods
for f in *.pw.toml; do sed -i 's/github.com/blanketcon.b-cdn.net/g' $f; done
cd ..
packwiz refresh
echo "Conversion done!"
