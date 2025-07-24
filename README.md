# @puzzlearena/audio

![npm version](https://img.shields.io/npm/v/@puzzlearena/audio?color=blue&label=npm)
![license](https://img.shields.io/github/license/feliperramos/puzzlearena-audio)
![platforms](https://img.shields.io/badge/platforms-ios%20|%20android-lightgrey)
![typescript](https://img.shields.io/badge/TypeScript-Ready-blue)

**Lightweight native sound module for React Native (iOS & Android).**

A simple, dependency-free audio module for playing **background music** and **sound effects** in React Native apps.

- 🎵 Supports **mp3**, **wav**, **ogg** formats
- 🔊 Control **volume** per playback
- ⚡ Native performance with **MediaPlayer** (Android) & **AVAudioPlayer** (iOS)
- 🛠 Includes CLI (`puzzlearena-audio`) for copying audio assets to `res/raw` automatically

---

## **Installation**

```bash
yarn add @puzzlearena/audio
# or
npm install @puzzlearena/audio
```

After installation:

### **iOS**

```bash
cd ios && pod install
```

### **Android**

No extra setup required. Just rebuild the app:

```bash
yarn android
```

---

## **Usage**

```ts
import { Audio } from "@puzzlearena/audio";

// Play a looping background music
await Audio.playBackground("menu_theme", true, 0.8);

// Stop background music
await Audio.stopBackground();

// Play a sound effect at 50% volume
await Audio.playEffect("click", 0.5);
```

> **Note:** Do **not** include the file extension.  
> For example, `menu_theme.mp3` → `"menu_theme"`.

---

## **Copying Audio Files**

### **Android**

Android requires `.mp3`/`.wav`/`.ogg` files to be placed in `android/app/src/main/res/raw`.  
To copy your assets automatically, run:

```bash
npx puzzlearena-audio
```

You will be prompted for the source folder (defaults to `src/assets/sounds`).

### **iOS**

For iOS, you need to manually add your audio files to the Xcode project:

- Open your project in Xcode.

- Go to Build Phases > Copy Bundle Resources.

- Drag and drop your audio files (e.g., theme.mp3, click.wav) into the resources list.

Note: Make sure you don't include the file extension when calling the audio methods.

---

## **API**

### **`Audio.playBackground(name: string, loop?: boolean, volume?: number): Promise<void>`**

- `name`: File name without extension (e.g. `"theme"` for `theme.mp3`).
- `loop`: (optional) `true` for continuous playback. Default: `true`.
- `volume`: (optional) Float from `0.0` to `1.0`. Default: `1.0`.

### **`Audio.stopBackground(): Promise<void>`**

Stops and releases the background music.

### **`Audio.playEffect(name: string, volume?: number): Promise<void>`**

- `name`: File name without extension (e.g. `"click"`).
- `volume`: (optional) Float from `0.0` to `1.0`. Default: `1.0`.

---

## **Supported Formats**

- `.mp3`
- `.wav`
- `.ogg`

If the file is missing or unsupported, the Promise will **reject** with an error code:

- `AUDIO_NOT_FOUND`
- `AUDIO_EFFECT_NOT_FOUND`
- `AUDIO_ERROR`
- `AUDIO_EFFECT_ERROR`

Example:

```ts
try {
  await Audio.playBackground("invalid_file");
} catch (e) {
  console.error(e); // { code: 'AUDIO_NOT_FOUND', message: 'Audio file not found: invalid_file' }
}
```

---

## **CLI Commands**

### **`npx puzzlearena-audio`**

Copies `.mp3`, `.wav` or `.ogg` files from `src/assets/sounds` (or a custom path) to `android/app/src/main/res/raw`.

---

## **Why @puzzlearena/audio?**

- Zero external dependencies.
- Instant load and playback.
- Tiny footprint compared to `react-native-sound` or `expo-av`.
- Works with **React Native 0.70+**.

---

## **License**

MIT © [Felipe Ramos](https://github.com/feliperramos)
