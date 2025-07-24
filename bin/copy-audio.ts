#!/usr/bin/env node

import fs from "fs";
import path from "path";
import readline from "readline";

const SUPPORTED_EXTENSIONS = [".mp3", ".wav", ".ogg"];

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
});

function askQuestion(query: string): Promise<string> {
  return new Promise((resolve) => rl.question(query, resolve));
}

async function run() {
  const projectRoot = process.cwd();
  const defaultAudioPath = path.join(projectRoot, "src/assets/sounds");
  const androidDest = path.join(projectRoot, "android/app/src/main/res/raw");

  console.log(`\nProject root detected: ${projectRoot}\n`);

  const audioSrc = await askQuestion(
    `Enter audio source path [default: ${defaultAudioPath}]: `
  );

  const resolvedAudioSrc = audioSrc.trim() || defaultAudioPath;
  if (!fs.existsSync(resolvedAudioSrc)) {
    console.error(`❌ Source folder not found: ${resolvedAudioSrc}`);
    process.exit(1);
  }

  if (!fs.existsSync(androidDest)) {
    fs.mkdirSync(androidDest, { recursive: true });
  }

  const files = fs
    .readdirSync(resolvedAudioSrc)
    .filter((f) =>
      SUPPORTED_EXTENSIONS.some((ext) => f.toLowerCase().endsWith(ext))
    );

  if (files.length === 0) {
    console.warn(
      `⚠️ No audio files (.mp3, .wav, .ogg) found in source directory.`
    );
  }

  files.forEach((file) => {
    const src = path.join(resolvedAudioSrc, file);
    const dest = path.join(androidDest, file.toLowerCase());
    fs.copyFileSync(src, dest);
    console.log(`✅ Copied: ${file}`);
  });

  console.log("🎵 Audio files synced with Android (res/raw).");
  console.log(
    "For iOS, add these files to Xcode -> Build Phases -> Copy Bundle Resources."
  );

  rl.close();
}

run().catch((err) => {
  console.error("❌ Error copying audio files:", err);
  rl.close();
});
