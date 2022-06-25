//
//  ViewController.swift
//  HWS-04-EasyBrowser
//
//  Created by Massimo Savino on 2022-05-18.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    private struct Constants {
        static let hackingWithSwiftURL = "hackingwithswift.com"
        static let open = "Open"
        static let openPage = "Open page..."
        static let appleCom = "apple.com"
        static let cancel = "Cancel"
        static let https = "https://"
        static let estimatedProgress = "estimatedProgress"
    }
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [ Constants.appleCom, Constants.hackingWithSwiftURL ]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.open,
            style: .plain,
            target: self,
            action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let refresh = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        guard let url = URL(string: Constants.https + websites[0]) else {
            print("Cannot load URL properly")
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
    }

    @objc func openTapped() {
        let ac = UIAlertController(
            title: Constants.openPage,
            message: nil,
            preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(
                title: website,
                style: .default,
                handler: openPage))
        }
        ac.addAction(UIAlertAction(
            title: Constants.cancel,
            style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let title = action.title, let url = URL(string: Constants.https + title) else {
            let ac = UIAlertController(
                title: "URL blocked",
                message: "URL not allowed",
                preferredStyle: .alert)
            ac.addAction(UIAlertAction(
                title: "Continue",
                style: .cancel,
                handler: nil))
            return
        }
        webView.load(URLRequest(url: url))
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Constants.estimatedProgress {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    // MARK: WebView delegate methods
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
    
}

