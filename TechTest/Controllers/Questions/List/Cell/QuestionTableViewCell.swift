//
//  QuestionTableViewCell.swift
//  TechTest
//
//  Created by Amir Daliri on 21.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import UIKit
import PieCrust

class QuestionTableViewCell: PCTableViewCell {
    
    var choices = [Choices]()
    
    // MARK: - Property Methode
    
    lazy var questionLabel: PCLabel = {
        let lbl = PCLabel(text: .empty, textAlignment: .left, numberOfLines: 0, textColor: .black, font: UIFont.boldSystemFont(ofSize: 15), backgroundColor: .clear, tintColor: .clear)
        return lbl
    }()
    
    lazy var questionImageView: PCImageView = {
        let view = PCImageView(image: nil, contentMode: .scaleAspectFit)
        view.cornerRadius = 50
        return view
    }()
    
    lazy var dateLabel: PCLabel = {
        let lbl = PCLabel(text: .empty, textAlignment: .left, numberOfLines: 0, textColor: .darkGray, font: UIFont.boldSystemFont(ofSize: 12), backgroundColor: .clear, tintColor: .clear)
        return lbl
    }()
    
    lazy var shareButton: PCButton = {
        return PCButton(type: .custom, title: nil, image: #imageLiteral(resourceName: "Search-icon"), titleFont: nil, isEnabled: true, backgroundColor: .clear, tintColor: .clear)
    }()
    
    lazy var seprator: PCView = {
        return PCView(backgroundColor: UIColor.lightGray)
    }()
    
    
    lazy var collectionView: PCCollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 210, height: 70)
        layout.scrollDirection = .horizontal
        let collection = PCCollectionView(layout: layout, cells: [ChoicesCollectionViewCell.self], showsHorizontalScrollIndicator: true, backgroundColor: .clear)
        collection.delegate = self
        collection.dataSource = self
        collection.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return collection
    }()

    
    // MARK: - Setup VIew Methode
    
    override func setupViews() {
        super.setupViews()
        
        self.accessoryType = .disclosureIndicator
        addSubview(questionLabel)
        addSubview(questionImageView)
        addSubview(dateLabel)
        addSubview(shareButton)
        addSubview(collectionView)
        addSubview(seprator)
    }
    
    // MARK: - Constraints Methode
    
    override func setupLayout() {
        super.setupLayout()
        
        
        questionImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredPadding/2)
//            make.bottom.equalToSuperview().inset(preferredPadding/2)
            make.width.height.equalTo(100)
            make.left.equalToSuperview().inset(8)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(preferredPadding/2)
            make.left.equalTo(questionImageView.snp.right).offset(8)
            make.trailing.equalToSuperview().inset(8)

        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(questionImageView.snp.right).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.top.equalTo(questionLabel.snp.bottom).inset(-preferredPadding)
        }
        
        shareButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            make.centerY.equalTo(dateLabel.snp.centerY)
//            make.top.equalTo(questionLabel.snp.bottom).inset(-preferredPadding)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(questionImageView.snp.bottom).inset(-preferredPadding)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(70)
            make.bottom.equalToSuperview().inset(4)
        }
        
        seprator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(preferredPadding*1.5)
            make.height.equalTo(0.5)
        }
    }
    
}

extension QuestionTableViewCell {
    
    static var identifier: String {
        return "MainTableViewCell"
    }
    
    func config(data: QuestionsList) {
        questionLabel.text = data.question
        dateLabel.text = Helpers.convertDateFormatter(date: data.publishedAt)
        questionImageView.downloaded(from: data.thumbUrl!)
        choices = data.choices!
        collectionView.reloadData()
    }
}


// MARK: - UICollectionView Methode

extension QuestionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoicesCollectionViewCell.reuseIdentifier, for: indexPath) as! ChoicesCollectionViewCell
        cell.nameLabel.text = choices[indexPath.row].choice
        cell.votesLabel.text = "\(choices[indexPath.row].votes ?? 0)"
        return cell
    }
    
    
}
