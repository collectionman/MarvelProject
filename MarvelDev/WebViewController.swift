//
//  WebViewController.swift
//  MarvelDev
//
//  Created by Julian Llorensi on 25/04/2019.
//  Copyright © 2019 globant. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate  {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Para las WebView los delegados se deben setear a manopla :)
        webView.navigationDelegate = self
        
        if let url = URL( string: "https://www.marvel.com" ) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

