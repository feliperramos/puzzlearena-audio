package com.puzzlearena.audio

import android.media.MediaPlayer
import android.media.SoundPool
import android.media.AudioAttributes
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

class AudioModule(private val reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    private var mediaPlayer: MediaPlayer? = null
    private var soundPool: SoundPool? = null
    private val soundMap = HashMap<String, Int>()

    override fun getName(): String = "PuzzleArenaAudio"

    init {
        val audioAttributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_GAME)
            .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
            .build()

        soundPool = SoundPool.Builder()
            .setAudioAttributes(audioAttributes)
            .setMaxStreams(5)
            .build()
    }

    private fun findAudioResId(name: String): Int {
        val cleanName = name
            .lowercase()
            .removeSuffix(".mp3")
            .removeSuffix(".wav")
            .removeSuffix(".ogg")
        return reactContext.resources.getIdentifier(cleanName, "raw", reactContext.packageName)
    }

    @ReactMethod
    fun playBackground(resName: String, loop: Boolean, volume: Double?, promise: Promise) {
        stopBackground()
        val resId = findAudioResId(resName)
        if (resId == 0) {
            promise.reject("AUDIO_NOT_FOUND", "Audio file not found: $resName")
            return
        }

        try {
            mediaPlayer = MediaPlayer.create(reactContext, resId)
            mediaPlayer?.isLooping = loop
            val vol = (volume ?: 1.0).toFloat().coerceIn(0f, 1f)
            mediaPlayer?.setVolume(vol, vol)
            mediaPlayer?.start()
        } catch (e: Exception) {
            promise.reject("AUDIO_ERROR", e.message)
        }
    }   

    @ReactMethod
    fun stopBackground(promise: Promise) {
        try {
            mediaPlayer?.stop()
            mediaPlayer?.release()
            mediaPlayer = null
        } catch (e: Exception) {
            promise.reject("AUDIO_STOP_ERROR", e.message)
        }
    }

    @ReactMethod
    fun playEffect(resName: String, volume: Double?, promise: Promise) {
        val resId = findAudioResId(resName)
        if (resId == 0) {
            promise.reject("AUDIO_EFFECT_NOT_FOUND", "Audio effect not found in raw: $resName")
            return
        }

        val vol = (volume ?: 1.0).toFloat().coerceIn(0f, 1f)
        try {
            val soundId = soundPool?.load(reactContext, resId, 1) ?: return
            soundMap[resName] = soundId
            soundPool?.setOnLoadCompleteListener { _, sampleId, _ ->
                if (sampleId == soundId) {
                    soundPool?.play(soundId, vol, vol, 1, 0, 1f)
                }
            }
        } catch (e: Exception) {
            promise.reject("AUDIO_EFFECT_ERROR", e.message)
        }
    }

    override fun onCatalystInstanceDestroy() {
        stopBackground(Promise { _, _ -> })
        soundPool?.release()
        soundPool = null
    }
}
