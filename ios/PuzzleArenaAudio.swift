import Foundation
import AVFoundation

@objc(PuzzleArenaAudio)
class PuzzleArenaAudio: NSObject {
  var backgroundPlayer: AVAudioPlayer?
  var effectsPlayer: AVAudioPlayer?
  let extensions = ["mp3", "wav", "ogg"]

  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }

  private func findURL(for name: String) -> URL? {
    let cleanName = name.lowercased()
      .replacingOccurrences(of: ".mp3", with: "")
      .replacingOccurrences(of: ".wav", with: "")
      .replacingOccurrences(of: ".ogg", with: "")
    for ext in extensions {
      if let url = Bundle.main.url(forResource: cleanName, withExtension: ext) {
        return url
      }
    }
    return nil
  }

  @objc func playBackground(_ name: String, loop: Bool, volume: NSNumber?, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    stopBackground()

    guard let url = findURL(for: name) else {
      reject("AUDIO_NOT_FOUND", "Audio file not found: \(name)", nil)
      return
    }

    do {
      backgroundPlayer = try AVAudioPlayer(contentsOf: url)
      backgroundPlayer?.numberOfLoops = loop ? -1 : 0
      let vol = volume?.floatValue ?? 1.0
      backgroundPlayer?.volume = max(0.0, min(vol, 1.0))
      backgroundPlayer?.prepareToPlay()
      backgroundPlayer?.play()
      resolve(true)
    } catch {
      reject("AUDIO_ERROR", error.localizedDescription, error)
    }
  }

  @objc func stopBackground(_ resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    backgroundPlayer?.stop()
    backgroundPlayer = nil
    resolve(true)
  }

  @objc func playEffect(_ name: String, volume: NSNumber?, resolve: RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    guard let url = findURL(for: name) else {
      reject("AUDIO_EFFECT_NOT_FOUND", "Audio Effect not found: \(name)", nil)
      return
    }

    do {
      effectsPlayer = try AVAudioPlayer(contentsOf: url)
      let vol = volume?.floatValue ?? 1.0
      effectsPlayer?.volume = max(0.0, min(vol, 1.0))
      effectsPlayer?.prepareToPlay()
      effectsPlayer?.play()
    } catch {
      reject("AUDIO_EFFECT_ERROR", error.localizedDescription, error)
    }
  }
}
