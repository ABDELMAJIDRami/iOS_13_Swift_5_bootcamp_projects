//
//  File.swift
//  S17-214-H4X0R News
//
//  Created by user183479 on 12/12/20.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let wkView = WKWebView()
        wkView.uiDelegate = context.coordinator
        return wkView;
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeString = urlString {
            if let url = URL(string: safeString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    // typealias UIViewType = WKWebView
    
    /* what happened in my version of xcode is a bit different from what i typed in GoodNotes
       1- first time xcode told me that i don't conform to protocol it added typealias field which i made it equal to the UIKit view i am planning to integrate in my SwiftUI
       2- then xcode gave me the same message -> fix -> inserted 2 delegate methods with WKWebView automatically referenced in them
       3- i am able to delete typealias prop.. */
}

class Coordinator: NSObject, WKUIDelegate {
//    var text: Binding<String>
//
//    init(_ text: Binding<String>) {
//        self.text = text
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//        self.text.wrappedValue = textView.text
//    }
}
