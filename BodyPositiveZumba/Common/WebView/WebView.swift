//
//  WebView.swift
//  Common
//
//  Created by Andrew Elbert on 2/1/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    let title: String
    @Environment(\.dismiss) private var dismiss
    let onWebViewCreated: (WKWebView) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: url)
        webView.load(request)
        onWebViewCreated(webView)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // intentionally blank - need to conform to protocol
    }

    func makeCoordinator() -> Coordinator {
        // intentionally useless - need to conform to protocol
        return Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

struct WebViewContainer: View {
    let url: URL
    let title: String
    @Environment(\.dismiss) private var dismiss
    @State private var webView: WKWebView?

    var body: some View {
        NavigationStack {
            WebView(url: url, title: title) { createdWebView in
                self.webView = createdWebView
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        webView?.reload()
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text(title)
                        .fontDesign(.serif)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}
