//
//  WebViewController.swift
//  GoFast
//
//  WebView controller for GoFast Delivery Driver web app
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    private var refreshControl: UIRefreshControl!
    
    private let targetURL = URL(string: "https://gofastdelivery.mu/driver-enhanced.html")!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        // Enable JavaScript
        webConfiguration.preferences.javaScriptEnabled = true
        
        // Enable storage
        webConfiguration.preferences.isFraudulentWebsiteWarningEnabled = false
        
        // Allow inline media playback
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        // Set user agent to identify as mobile
        webConfiguration.applicationNameForUserAgent = "GoFast-iOS/1.0"
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        // Allow back/forward navigation
        webView.allowsBackForwardNavigationGestures = true
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressView()
        setupRefreshControl()
        loadWebPage()
    }
    
    private func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = UIColor(red: 0.157, green: 0.647, blue: 0.271, alpha: 1.0) // #28a745
        
        view.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Observe loading progress
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            progressView.isHidden = webView.estimatedProgress == 1.0
        }
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        webView.scrollView.addSubview(refreshControl)
    }
    
    @objc private func refreshPage() {
        webView.reload()
    }
    
    private func loadWebPage() {
        let request = URLRequest(url: targetURL)
        webView.load(request)
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        // Handle external URLs (maps, phone, mail)
        if url.scheme == "tel" || url.scheme == "mailto" || url.scheme == "geo" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            decisionHandler(.cancel)
            return
        }
        
        // Handle Google Maps URLs
        if url.host?.contains("maps.google.com") == true || url.host?.contains("google.com/maps") == true {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            decisionHandler(.cancel)
            return
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshControl.endRefreshing()
        updateTitle()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        refreshControl.endRefreshing()
        showError(error: error)
    }
    
    private func updateTitle() {
        title = webView.title ?? "GoFast"
    }
    
    private func showError(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: "Failed to load page: \(error.localizedDescription)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Handle Back Navigation
    
    override func viewWillDisappear(_ animated: Bool) {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}
