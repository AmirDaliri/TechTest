//
//  NetworkPopUpView.swift
//  TechTest
//
//  Created by Amir Daliri on 22.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import UIKit
import PieCrust

class NetworkPopUpView: PCView {
    
    // MARK: - Property Methode
    
    lazy var titleLabel: PCLabel = {
        let label = PCLabel(text: .plain("Enternet Is Unreachable"), textAlignment: .center, numberOfLines: 1, textColor: UIColor.darkText, font: UIFont.boldSystemFont(ofSize: 16), backgroundColor: .clear, tintColor: .clear)
        return label
    }()
    
    lazy var detailLabel: PCLabel = {
        let label = PCLabel(text: .plain("Please connect to internet"), textAlignment: .center, numberOfLines: 0, textColor: UIColor.darkGray, font: UIFont.systemFont(ofSize: 14), backgroundColor: .clear, tintColor: .clear)
        return label
    }()
    
    lazy var okButton: PCButton = {
        let button = PCButton(type: .custom, title: .plain("ok"), image: nil, titleFont: UIFont.boldSystemFont(ofSize: 14), isEnabled: true, backgroundColor: PCColor(hex: 0x0D78C8), tintColor: .clear)
        button.cornerRadius = 15.0
        return button
    }()
    
    
    private lazy var containerView: PCView = {
        let view = PCView(backgroundColor: .white)
        view.cornerRadius = 20
        return view
    }()
    
    
    // MARK: - Setup VIew Methode
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.black.withAlphaComponent(0.8)
        containerView.addSubview(titleLabel)
        containerView.addSubview(detailLabel)
        containerView.addSubview(okButton)
        addSubview(containerView)
        
    }
    
    // MARK: - Constraints Methode
    
    override func setupLayout() {
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
            make.center.equalToSuperview()
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(preferredPadding)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(preferredPadding)
        }
        
        okButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(preferredPadding)
            make.leading.trailing.equalToSuperview().inset(preferredPadding*2.5)
        }
        
    }
}
