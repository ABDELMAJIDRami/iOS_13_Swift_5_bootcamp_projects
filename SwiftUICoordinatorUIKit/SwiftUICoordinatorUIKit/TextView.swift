//
//  TextView.swift
//  SwiftUITextViewDemo
//
//  Created by Simon Ng on 7/5/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var text: String
    let textStyle: UIFont.TextStyle
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    var text: Binding<String>

    init(_ text: Binding<String>) {
        self.text = text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.text.wrappedValue = textView.text
    }
}