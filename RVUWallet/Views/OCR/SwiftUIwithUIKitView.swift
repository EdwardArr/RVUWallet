//
//  TextScanner.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/5/21.
//


import SwiftUI
import UIKit

struct TextScanner: UIViewControllerRepresentable {
    
    public typealias UIViewControllerType = VisionViewController
    
    private let delegate: ViewControllerDelegate
    
    public init(delegate: ViewControllerDelegate){
        self.delegate = delegate
    }
    
    
    // this is the binding that we receive from the SwiftUI side
//    let identifier: Binding<String>
    
   
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TextScanner>) -> VisionViewController {
        let scanner =  VisionViewController()
        scanner.delegate = delegate
        
        return scanner
    }
    
    func updateUIViewController(_ uiViewController: VisionViewController, context: UIViewControllerRepresentableContext<TextScanner>) {
        // nothing to do here
    }

}

extension TextScanner {
    
    public class Delegate: NSObject, ViewControllerDelegate{
        
        public init(didClassify: @escaping (String) -> ()){
            self.didClassify = didClassify
        }
        
        private let didClassify: (String) -> ()
        
        
        func clasificationOccured(_ viewController: ViewController, identifier: String) {
            didClassify(identifier)
        }
        
//        clasificationOccured
    }
    
}

// this is very important, this coordinator will be used in `makeUIViewController`
//func makeCoordinator() -> Coordinator {
//    Coordinator(identifierBinding: identifier)
//}

// this will be the delegate of the view controller, it's role is to allow
// the data transfer from UIKit to SwiftUI
//class Coordinator: ViewControllerDelegate {
//    let identifierBinding: Binding<String>
//
//    init(identifierBinding: Binding<String>) {
//        self.identifierBinding = identifierBinding
//    }
//
//    func clasificationOccured(_ viewController: ViewController, identifier: String) {
//        // whenever the view controller notifies it's delegate about receiving a new idenfifier
//        // the line below will propagate the change up to SwiftUI
//        identifierBinding.wrappedValue = identifier
//    }
//}

//
//struct TextScanner_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIwithUIKitView()
//    }
//}
