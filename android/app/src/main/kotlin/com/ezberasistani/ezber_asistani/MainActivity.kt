package com.ezberasistani.ezber_asistani

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.speech.RecognitionListener
import android.speech.RecognitionSupport
import android.speech.RecognitionSupportCallback
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Doğruluk kontrolü için ses tanıma köprüsü.
 *
 * Yalnızca Android'in CİHAZ ÜZERİNDE tanıyıcısı kullanılır
 * (createOnDeviceSpeechRecognizer). Cihazda yoksa özellik kapalı kalır;
 * sesi sunucuya gönderebilen normal tanıyıcıya hiçbir durumda düşülmez.
 * Hazır paketler (speech_to_text) bu durumda sessizce normal tanıyıcıya
 * geçtiği için kullanılmadı.
 */
private const val TAG = "EzberSTT"

class MainActivity : FlutterActivity() {
    private var recognizer: SpeechRecognizer? = null
    private var pending: MethodChannel.Result? = null
    private var heardSpeech = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ezber/stt")
            .setMethodCallHandler { call, result -> handle(call, result) }
    }

    private fun isDebuggable(): Boolean =
        (applicationInfo.flags and android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0

    private fun onDeviceAvailable(): Boolean =
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
            SpeechRecognizer.isOnDeviceRecognitionAvailable(this)

    private fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "available" -> result.success(onDeviceAvailable())
            "support" -> support(call.argument<String>("language")!!, result, download = false)
            "download" -> support(call.argument<String>("language")!!, result, download = true)
            "listen" -> listen(
                call.argument<String>("language")!!,
                call.argument<Int>("silenceMs") ?: 1000,
                result,
            )
            "finish" -> {
                recognizer?.stopListening()
                result.success(null)
            }
            "cancel" -> {
                finish(mapOf("error" to "cancelled"))
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    /** Dilin cihaz üzerinde yüklü/indirilebilir olup olmadığı (Android 13+). */
    private fun support(language: String, result: MethodChannel.Result, download: Boolean) {
        if (!onDeviceAvailable()) return result.success("unavailable")
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) return result.success("unknown")
        val intent = recognizerIntent(language, 1000)
        val r = SpeechRecognizer.createOnDeviceSpeechRecognizer(this)
        if (download) {
            // Yalnızca dil modelini indirir; kullanıcının sesi gönderilmez.
            r.triggerModelDownload(intent)
            r.destroy()
            return result.success("downloading")
        }
        r.checkRecognitionSupport(intent, mainExecutor, object : RecognitionSupportCallback {
            override fun onSupportResult(s: RecognitionSupport) {
                val tag = language.lowercase()
                fun has(list: List<String>) = list.any { it.lowercase() == tag || it.lowercase().startsWith(tag.substringBefore('-')) }
                Log.d(TAG, "support installed=${s.installedOnDeviceLanguages} pending=${s.pendingOnDeviceLanguages} supported=${s.supportedOnDeviceLanguages.size}")
                val state = when {
                    has(s.installedOnDeviceLanguages) -> "installed"
                    has(s.pendingOnDeviceLanguages) -> "downloading"
                    has(s.supportedOnDeviceLanguages) -> "downloadable"
                    else -> "unsupported"
                }
                r.destroy()
                result.success(state)
            }

            override fun onError(error: Int) {
                Log.d(TAG, "support onError $error")
                r.destroy()
                result.success("unknown")
            }
        })
    }

    private fun recognizerIntent(language: String, silenceMs: Int) =
        Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, language)
            putExtra(RecognizerIntent.EXTRA_PREFER_OFFLINE, true)
            putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 5)
            putExtra(RecognizerIntent.EXTRA_PARTIAL_RESULTS, false)
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_COMPLETE_SILENCE_LENGTH_MILLIS, silenceMs)
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, silenceMs)
        }

    private fun listen(language: String, silenceMs: Int, result: MethodChannel.Result) {
        if (!onDeviceAvailable()) return result.success(mapOf("error" to "unavailable"))
        finish(mapOf("error" to "cancelled"))
        pending = result
        heardSpeech = false
        val r = recognizer ?: SpeechRecognizer.createOnDeviceSpeechRecognizer(this).also { recognizer = it }
        r.setRecognitionListener(object : RecognitionListener {
            override fun onBeginningOfSpeech() {
                Log.d(TAG, "onBeginningOfSpeech")
                heardSpeech = true
            }

            override fun onResults(results: Bundle) {
                val texts = results.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION) ?: arrayListOf()
                // Söylenen metin yalnızca geliştirme sürümünde loglanır.
                if (isDebuggable()) Log.d(TAG, "onResults heard=$heardSpeech texts=$texts")
                // Hiç ses duymadan boş sonuç: tanıyıcı arızası (Dart tarafı ses
                // seviyesi dinleyicisine geçer, prova atlamaz).
                if (texts.isEmpty()) finish(mapOf("error" to if (heardSpeech) "nomatch" else "empty", "heard" to heardSpeech))
                else finish(mapOf("texts" to texts, "heard" to true))
            }

            override fun onError(error: Int) {
                Log.d(TAG, "onError $error heard=$heardSpeech")
                val code = when (error) {
                    SpeechRecognizer.ERROR_SPEECH_TIMEOUT -> "silent"
                    SpeechRecognizer.ERROR_NO_MATCH -> if (heardSpeech) "nomatch" else "silent"
                    SpeechRecognizer.ERROR_LANGUAGE_NOT_SUPPORTED,
                    SpeechRecognizer.ERROR_LANGUAGE_UNAVAILABLE -> "language"
                    SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS -> "permission"
                    else -> "error$error"
                }
                finish(mapOf("error" to code, "heard" to heardSpeech))
            }

            override fun onReadyForSpeech(params: Bundle?) {
                Log.d(TAG, "onReadyForSpeech")
            }
            override fun onRmsChanged(rmsdB: Float) {}
            override fun onBufferReceived(buffer: ByteArray?) {}
            override fun onEndOfSpeech() {
                Log.d(TAG, "onEndOfSpeech")
            }
            override fun onPartialResults(partialResults: Bundle?) {}
            override fun onEvent(eventType: Int, params: Bundle?) {}
        })
        Log.d(TAG, "startListening $language silence=$silenceMs")
        r.startListening(recognizerIntent(language, silenceMs))
    }

    private fun finish(value: Map<String, Any>) {
        val p = pending ?: return
        pending = null
        if (value["error"] == "cancelled") recognizer?.cancel()
        p.success(value)
    }

    override fun onDestroy() {
        recognizer?.destroy()
        recognizer = null
        super.onDestroy()
    }
}
