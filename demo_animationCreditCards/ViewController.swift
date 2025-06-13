//
//  ViewController.swift
//  demo_animationCreditCards
//
//  Created by Asmaa Ashraf Oraby on 01/06/2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {    
    
    override func viewDidLoad() {
        let cards: [Cards] = [
            Cards(name: "A", cardNumber: "1234 56789", cardImage: "image1"),
            Cards(name: "B", cardNumber: "1234 56789", cardImage: "image2"),
            Cards(name: "C", cardNumber: "1234 56789", cardImage: "image3"),
            Cards(name: "A", cardNumber: "1234 56789", cardImage: "image1"),
            Cards(name: "B", cardNumber: "1234 56789", cardImage: "image2"),
            Cards(name: "C", cardNumber: "1234 56789", cardImage: "image3")
        ]
        
        let vc = UIHostingController(rootView: Home(cards: cards))
//        let vc = UIHostingController(rootView: SwiftUIView())

        super.viewDidLoad()
        addChild(vc) // for lifecycle handling
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self) // notify VC it has moved to a parent
    }
    
}

