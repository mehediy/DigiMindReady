//
//  WebView.swift
//  DigiMindReady
//
//  Created by Md Mehedi Hasan on 11/30/23.
//

import SwiftUI
import WebKit

protocol WebViewDataSource {
    func fetchWebData(completionHandler: @escaping (Result<String, Error>) -> Void)
}

enum WebSourceType {
    case htmlString(String)
    case url(URL)
    case videoUrl(URL)
    case staticHtmlFile(String)
    case dataSource(WebViewDataSource)
}

struct WebView: UIViewRepresentable {
    var sourceType: WebSourceType
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        switch sourceType {
        case .htmlString(let htmlString):
            webView.loadHTMLString(htmlString, baseURL: nil)
            
        case .url(let url):
            let request = URLRequest(url: url)
            webView.load(request)
            
        case .videoUrl(let url):
            let request = URLRequest(url: url)
            webView.scrollView.isScrollEnabled = false
            webView.load(request)
            
        case .staticHtmlFile(let fileName):
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "html"),
               let htmlString = try? String(contentsOfFile: filePath, encoding: .utf8) {
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
        case .dataSource(let dataSource):
            dataSource.fetchWebData { result in
                switch result {
                case .success(let htmlContent):
                    DispatchQueue.main.async {
                        webView.loadHTMLString(htmlContent, baseURL: nil)
                    }
                case .failure(let error):
                    // Handle error, maybe show an error page
                    print(error.localizedDescription)
                }
            }
        }
    }
}


