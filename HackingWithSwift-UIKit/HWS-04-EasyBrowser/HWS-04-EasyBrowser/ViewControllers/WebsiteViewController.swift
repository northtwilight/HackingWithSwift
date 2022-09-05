//
//  WebsiteViewController.swift
//  HWS-04-EasyBrowser
//
//  Created by Massimo Savino on 2022-09-04.
//

import Combine
import UIKit
import WebKit

class WebsiteViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = [
        WebsiteConstants.Sites.appleCom,
        WebsiteConstants.Sites.hackingWithSwiftURL,
        WebsiteConstants.Sites.slashdotURL,
        WebsiteConstants.Sites.hackerNews,
        WebsiteConstants.Sites.lobsters
    ]
    
    var currentWebsite: Int?
    
    lazy var show404Subject = CurrentValueSubject<Bool, Never>(show404)
    var show404 = false
    var cancellable: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard currentWebsite != nil else {
            print("Current website on \(#file) is still nil")
            navigationController?.popViewController(animated: true)
            return
        }
        
        setupWebsiteViewController()
        loadURL()
        
        cancellable = show404Subject.sink { [weak self] shouldShow404 in
            self?.show404 = shouldShow404
            if self?.show404 == true {
                self?.make404Alert()
            }
        }

    }
    
    func setupWebsiteViewController() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
    
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: WebsiteConstants.open,
            style: .plain,
            target: self,
            action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let refresh = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: webView,
            action: #selector(webView.reload))
        let back = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: webView,
            action: #selector(webView.goBack))
        let forward = UIBarButtonItem(
            title: "Forward",
            style: .plain,
            target: webView,
            action: #selector(webView.goForward))
        
        toolbarItems = [back, progressButton, spacer, refresh, forward]
        navigationController?.isToolbarHidden = false
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    func loadURL() {
        guard let currentWebsite = currentWebsite,
              let url = URL(string: WebsiteConstants.https + websites[currentWebsite]) else {
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
            title: WebsiteConstants.openPage,
            message: nil,
            preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(
                title: website,
                style: .default,
                handler: openPage))
        }
        ac.addAction(UIAlertAction(
            title: WebsiteConstants.cancel,
            style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let title = action.title,
            let url = URL(string: WebsiteConstants.https + title)
        else {
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
        if keyPath == WebsiteConstants.estimatedProgress {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    func make404Alert() {
        let forbiddenAlert = UIAlertController(
            title: WebsiteConstants.forbiddenTitle,
            message: WebsiteConstants.forbiddenMessage,
            preferredStyle: .alert)
        forbiddenAlert.addAction(UIAlertAction(
            title: "OK", style: .default))
        present(forbiddenAlert, animated: true)
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
                } else {
                    show404Subject.send(show404)
                    
                }
            }
        }
        decisionHandler(.cancel)
    }
    
}
