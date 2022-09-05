//
//  WebsiteConstants.swift
//  HWS-04-EasyBrowser
//
//  Created by Massimo Savino on 2022-09-04.
//

import Foundation

struct WebsiteConstants {
    struct Sites {
        static let hackingWithSwiftURL = "hackingwithswift.com"
        static let slashdotURL = "slashdot.org"
        static let appleCom = "apple.com"
        static let hackerNews = "news.ycombinator.com"
        static let lobsters = "lobste.rs"
    }
    
    static let cellIdentifier = "cell"
    static let websiteViewController = "websiteViewController"
    
    static let open = "Open"
    static let openPage = "Open page..."
    
    static let cancel = "Cancel"
    static let https = "https://"
    static let estimatedProgress = "estimatedProgress"
    
    static let forbiddenTitle = "Site access forbidden"
    static let forbiddenMessage = "Accessing this site on this browser is prohibited."
}
