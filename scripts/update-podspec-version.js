const fs = require('fs');
const path = require('path');

const packageJson = require('../package.json');
const podspecPath = path.resolve(__dirname, '../PuzzleArenaAudio.podspec');

let podspec = fs.readFileSync(podspecPath, 'utf8');
podspec = podspec.replace(/s.version\s*=\s*".*"/, `s.version      = "${packageJson.version}"`);
fs.writeFileSync(podspecPath, podspec);

console.log(`Podspec version updated to ${packageJson.version}`);
