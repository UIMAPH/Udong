//
//  LoginWebViewController.swift
//  Udong
//
//  Created by changgyo seo on 2022/05/18.
//

import Foundation
import UIKit
import SnapKit
import WebKit

class LoginWebViewController: UIViewController{
    
    var loginWebView = WKWebView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displaySetting()
        
    }
    private func displaySetting(){
        loginWebView.uiDelegate = self
        loginWebView.navigationDelegate = self
        let url = URL(string: "http://15.164.158.186:8080/oauth2/authorization/kakao?redirect_uri=http://localhost:3000/oauth/redirct")
        let request = URLRequest(url: url!)
        view.addSubview(loginWebView)
        loginWebView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        loginWebView.load(request)
    }
    
}
extension LoginWebViewController: WKUIDelegate, WKNavigationDelegate{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let urlString = navigationAction.request.url?.absoluteString ?? ""
        decisionHandler(.allow)
        if urlString.contains("http://localhost:3000/oauth/redirct?token=") {
            let token = urlString.components(separatedBy: "=")
            let passingCode = "Bearer " + token[1]
            if let tokenData = passingCode.data(using: String.Encoding.utf8){
                KeyChain.save(key: "token", data: tokenData)
                print("===============================")
                print(passingCode)
                print("===============================")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                fatalError("Token parsing error")
            }
        }
        else {
            //fatalError("Login redirect error")
        }
        
    }
}
