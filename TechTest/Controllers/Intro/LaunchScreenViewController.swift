//
//  LaunchScreenViewController.swift
//  TechTest
//
//  Created by Amir Daliri on 22.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import PieCrust

class LaunchScreenViewController: PCViewController, Layouting, AlertPresenting {
    typealias View = LaunchScreenViewModel
    
    override func loadView() {
        view = View()
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        DispatchQueue.main.async {
            SwiftSpinner.show("Checking Health...")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            self.healt()
        }
    }
    
    override func setNavigationItem() {
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - API Methode
    
    func healt() {
        ApiRequest.shared.healt { (success) in
            guard let healtIsSuccess = success else {
                self.presentAlert(title: "Sorry!", message: "something wrong")

                return
            }
            if healtIsSuccess {
                SwiftSpinner.hide({
                    let mainVC = MainViewController()
                    self.present(PCNavigationController(rootViewController: mainVC), animated: true, completion: nil)
                })
            } else {
                self.presentAlert(title: "Sorry!", message: "app is not healthy")
            }
        }
    }
    
}
