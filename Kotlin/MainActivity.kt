package com.example.flutter_kotlin

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat

        class MainActivity : AppCompatActivity() {

            private val PERMISSION_REQUEST_CODE = 101
            private lateinit var webView: WebView

            override fun onCreate(savedInstanceState: Bundle?) {
                super.onCreate(savedInstanceState)
                setContentView(R.layout.activity_main)

                webView = findViewById(R.id.webView)

                requestPermissions()

                setupWebView()
            }

            private fun requestPermissions() {
                val permissions = mutableListOf<String>()

                if (ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
                    permissions.add(Manifest.permission.CAMERA)
                }

                if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
                    permissions.add(Manifest.permission.RECORD_AUDIO)
                }

                if (permissions.isNotEmpty()) {
                    ActivityCompat.requestPermissions(this, permissions.toTypedArray(), PERMISSION_REQUEST_CODE)
                }
            }

            private fun setupWebView() {
                val webSettings = webView.settings
                webSettings.javaScriptEnabled = true
                webSettings.mediaPlaybackRequiresUserGesture = false

                webView.webViewClient = WebViewClient()
                webView.webChromeClient = WebChromeClient()

                webView.loadUrl("https://www.auraehealth.com")
            }
        }

