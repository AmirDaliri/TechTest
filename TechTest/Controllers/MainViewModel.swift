//
//  MainViewModel.swift
//  TechTest
//
//  Created by Amir Daliri on 19.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import SnapKit
import PieCrust

class MainViewModel: PCView {
    
    // MARK: - Property Methode
    
    
    // MARK: - Setup VIew Methode
    
    override func setupViews() {
        super.setupViews()
        
    }
    
    // MARK: - Constraints Methode
    
    override func setupLayout() {
        super.setupLayout()
        

    }
}

extension MainViewModel {
    
    
    private func animate(){
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}
