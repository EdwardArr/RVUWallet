//
//  CustomSummaryNavigationBarView.swift
//  RVUWallet
//
//  Created by Edward Arribasplata on 4/3/21.
//

import SwiftUI


public extension View {
    func newNavigationBarLargeTitleItems<L>(trailing: L) -> some View where L : View {
        overlay(NavigationBarLargeTitleItems(trailing: trailing).frame(width: 0, height: 0))
    }
}

fileprivate struct NavigationBarLargeTitleItems<L : View>: UIViewControllerRepresentable {
    typealias UIViewControllerType = Wrapper
    
    private let trailingItems: L
    
    init(trailing: L) {
        self.trailingItems = trailing
    }
    
    func makeUIViewController(context: Context) -> Wrapper {
        Wrapper(representable: self)
    }
    
    func updateUIViewController(_ uiViewController: Wrapper, context: Context) {
    }
    
    class Wrapper: UIViewController {
        private let representable: NavigationBarLargeTitleItems?
        
        init(representable: NavigationBarLargeTitleItems) {
            self.representable = representable
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            self.representable = nil
            super.init(coder: coder)
        }
                
        override func viewWillAppear(_ animated: Bool) {
            guard let representable = self.representable else { return }
            guard let navigationBar = self.navigationController?.navigationBar else { return }
            guard let UINavigationBarLargeTitleView = NSClassFromString("_UINavigationBarLargeTitleView") else { return }
           
            navigationBar.subviews.forEach { subview in
                if subview.isKind(of: UINavigationBarLargeTitleView.self) {
                    let controller = UIHostingController(rootView: representable.trailingItems)
                    controller.view.translatesAutoresizingMaskIntoConstraints = false
                    subview.addSubview(controller.view)
                    
                    NSLayoutConstraint.activate([
                        controller.view.bottomAnchor.constraint(
                            equalTo: subview.bottomAnchor,
                            constant: -15
                        ),
                        controller.view.trailingAnchor.constraint(
                            equalTo: subview.trailingAnchor,
                            constant: -view.directionalLayoutMargins.trailing
                        )
                    ])
                }
            }

        }
    }
}


struct menuButton: View {
    @State var userSelection = "This month"

    var body: some View{

        Menu(content: {
            Button(action: {
                print("Home button pressed.")
                self.userSelection = "This month"
                print("Site selected is now \(userSelection)")
                
            }, label: {
                if self.userSelection == "This month"{
                    Image(systemName: "checkmark")
                    Text("This month")
                }else{
                    Text("This month")
                }
            })
            
            Button(action: {
                print("Home button pressed.")
                
                //Assign site variable to clubcorners
                self.userSelection = "This quarter"
                print("Site selected is now \(userSelection)")
            }, label: {
                HStack {
                    if userSelection == "This quarter"{
                        Image(systemName: "checkmark")
                        Text("This quarter")
                    }else{
                        Text("This quarter")
                    }
                }
            })
            
            Button(action: {
                print("Home button pressed.")
                
                //Assign site variable to clubcorners
                self.userSelection = "This year"
                print("Site selected is now \(userSelection)")
            }, label: {
                HStack {
                    if userSelection == "This year"{
                        Image(systemName: "checkmark")
                        Text("This year")
                    }else{
                        Text("This year")
                    }
                }
            })
            
        }, label: {
            Text(userSelection)
        })
    }
}

struct CustomSummaryNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        menuButton()

    }
}
