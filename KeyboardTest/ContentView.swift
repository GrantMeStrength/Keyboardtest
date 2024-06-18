//
//  ContentView.swift
//  KeyboardTest
//
//  Created by John Kennedy on 6/17/24.
//

import SwiftUI

import UIKit

class KeyboardHostingController: UIViewController {
    var onKeyPress: ((UIKey) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(focusView))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
    }

    @objc private func focusView() {
        becomeFirstResponder()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        super.pressesBegan(presses, with: event)
        for press in presses {
            if let key = press.key {
                onKeyPress?(key)
            }
        }
    }
}

struct KeyboardHandlingView: UIViewControllerRepresentable {
    var onKeyPress: (UIKey) -> Void

    func makeUIViewController(context: Context) -> KeyboardHostingController {
        let controller = KeyboardHostingController()
        controller.onKeyPress = onKeyPress
        return controller
    }

    func updateUIViewController(_ uiViewController: KeyboardHostingController, context: Context) {}
}


struct ContentView: View {
    
    @State private var buttonText = "Press Me"
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            
            Text(buttonText)
                           .font(.largeTitle)
                           .padding()
                       
            Button(action: {
                           self.buttonText = "Button Pressed"
                            print("pressed")
                       }) {
                           Text("Press Me")
                               .font(.title)
                               .padding()
                               .background(Color.blue)
                               .foregroundColor(.white)
                               .cornerRadius(10)
                     
                                  
                               
                       }
            
            KeyboardHandlingView { key in
                           handleKeyPress(key: key)
                       }
            
            
            
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
    
    func handleKeyPress(key: UIKey) {
           if key.keyCode == .keyboardReturnOrEnter {
               self.buttonText = "Enter Key Pressed"
           } else if key.keyCode == .keyboardSpacebar {
               self.buttonText = "Spacebar Pressed"
           } else {
               self.buttonText = "Key Pressed: \(key.characters)"
           }
       }
    
}

#Preview {
    ContentView()
}
