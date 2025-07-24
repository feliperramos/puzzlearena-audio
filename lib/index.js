import { NativeModules, Platform } from "react-native";
const LINKING_ERROR = `The package '@puzzlearena/audio' doesn't seem to be linked. Make sure:\n\n` +
    Platform.select({
        ios: "- You have run 'pod install'\n",
        default: "",
    }) +
    "- You rebuilt the app after installing the package\n" +
    "- You are not using Expo managed workflow\n";
const PuzzleArenaAudio = NativeModules.PuzzleArenaAudio
    ? NativeModules.PuzzleArenaAudio
    : new Proxy({}, {
        get() {
            throw new Error(LINKING_ERROR);
        },
    });
export const Audio = {
    playBackground: (name, loop = true, volume = 1) => PuzzleArenaAudio.playBackground(name, loop, volume),
    stopBackground: () => PuzzleArenaAudio.stopBackground(),
    playEffect: (name, volume = 1) => PuzzleArenaAudio.playEffect(name, volume),
};
