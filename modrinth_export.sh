#!/bin/bash
./bunnify.sh # ensure stray github urls/etc are converted
echo "Touching every file in the CDN to ensure it's available..."
for f in $(grep -hr 'url\s*=\s*"https://blanketcon.b-cdn.net' |cut -d= -f2- |cut -d\" -f 2- |rev |cut -d\" -f 2- |rev); do
	(
		curl -fsL "$f" -o /dev/null
	) &
done
wait
echo "Asking lepton to run a mirror update..."
curl -s https://unascribed.com/api/bc23-cdn-mirror/update
for i in 1 2 3 4 5 6 7 8 9 10 11 12; do
	if curl -s https://unascribed.com/api/bc23-cdn-mirror/status |tee /dev/stderr |grep 'No update is scheduled or in progress' >/dev/null; then
		break
	fi
	sleep 10
done
echo "Replacing CDN links..."
sed -i 's@"https://blanketcon.b-cdn.net/@"https://github.com/unascribed/bc23-cdn-github-mirror/raw/trunk/files/@g' $(find -name '*.pw.toml')
echo "Exporting mrpack..."
packwiz modrinth export
echo "Putting CDN links back..."
sed -i 's@"https://github.com/unascribed/bc23-cdn-github-mirror/raw/trunk/files/@"https://blanketcon.b-cdn.net/@g' $(find -name '*.pw.toml')
