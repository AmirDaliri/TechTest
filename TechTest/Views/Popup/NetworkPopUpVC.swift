//
//  NetworkPopUpVC.swift
//  TechTest
//
//  Created by Amir Daliri on 22.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import UIKit
import PieCrust

class NetworkPopUpVC: PCViewController, Layouting {
    typealias View = NetworkPopUpView
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        pcView.okButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        //        NotificationCenter.default.addObserver(self,selector: #selector(inputStatusManager), name: .flagsChanged, object: nil)
        
    }
    
    @objc final func didTapOkButton() {
        dismiss(animated: true) {
        }
    }
    
    func inputUpdateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            pcView.okButton.isEnabled = false
        case .wwan:
            pcView.okButton.isEnabled = false
        case .wifi:
            pcView.okButton.isEnabled = true
        }
    }
    
    @objc func inputStatusManager(_ notification: Notification) {
        inputUpdateUserInterface()
    }
}
