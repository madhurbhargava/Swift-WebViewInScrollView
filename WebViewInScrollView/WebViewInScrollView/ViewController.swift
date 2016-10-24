//
//  ViewController.swift
//  WebViewInScrollView
//
//  Created by madhur.bhargava333@gmail.com on 24/10/16.
//  Copyright © 2016 LunarMonk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var contentHeightConstraint: NSLayoutConstraint!
    var testHTML = "<h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My First Heading</h1><p>My first paragraph.</p><h1>My Last Heading</h1><p>My last paragraph.</p>"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.webView.delegate = self
        self.webView.scrollView.isScrollEnabled = false
        self.webView.loadHTMLString(testHTML, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Resizes the screen to fit entire tip content
    func resizeViewToContent(webView: UIWebView, containerView:UIView) {
        //resize the webview
        webView.layoutSubviews()
        
        // Set to smallest rect value
        var frame:CGRect = webView.frame
        frame.size.height = 1.0
        webView.frame = frame
        
        let height:CGFloat = webView.scrollView.contentSize.height
        contentHeightConstraint.constant = height
        frame.size.height = height
        webView.frame = frame
        webView.window?.setNeedsUpdateConstraints()
        webView.window?.setNeedsLayout()
        
        //resize the container
        let containerHeightConstraint = NSLayoutConstraint(item: containerView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: height+webView.frame.origin.y)
        containerView.addConstraint(containerHeightConstraint)
        containerView.window?.setNeedsUpdateConstraints()
        containerView.window?.setNeedsLayout()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        //inject css to do the font rendering
        let cssString = "body { font-family: CentraleSans; font-size: 18px }";
        let javascriptString = "var style = document.createElement('style'); style.innerHTML = '%@'; document.head.appendChild(style)";
        let javascriptWithCSSString = String(format: javascriptString, cssString)
        webView.stringByEvaluatingJavaScript(from: javascriptWithCSSString)
        
        self.resizeViewToContent(webView: self.webView, containerView: self.containerView)
    }



}

