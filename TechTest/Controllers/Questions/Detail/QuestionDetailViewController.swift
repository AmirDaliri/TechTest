//
//  QuestionDetailViewController.swift
//  TechTest
//
//  Created by Amir Daliri on 24.07.2019.
//  Copyright © 2019 AmirDaliri. All rights reserved.
//

import Foundation
import PieCrust

class QuestionDetailViewController: PCViewController, Layouting {
    typealias View = QuestionDetailView
    
    var questionId: Int?
    var choices: [Choices] = []
    
    // MARK: - Lifecycle Methods
    
    override func loadView() {
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // I'm Here...
        NotificationCenter.default.addObserver(self,selector: #selector(statusManager), name: .flagsChanged, object: nil)
        getDetail()
        pcView.collectionView.dataSource = self
        pcView.collectionView.delegate = self
    }
    
    override func setNavigationItem() {
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditBarBttnItem(_:))), animated: true)
        self.title = "Detail"
    }
    
}

// MARK: - Action Methode

@objc extension QuestionDetailViewController {
    
    func didTapEditBarBttnItem(_ sender: UIBarButtonItem) {
        print(#function)
    }
}

// MARK: - API Methode

private extension QuestionDetailViewController {
    
    func getDetail() {
        guard let id = self.questionId else { return }
        
        ApiRequest.shared.getQuestionDetail(id: String(id)) { (question, error) in
            guard let data = question else {
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let imageURL = data.imageUrl, let titleText = data.question, let date = data.publishedAt, let choiceList = data.choices else {return}
            
            self.pcView.questionImageView.downloaded(from: imageURL)
            self.pcView.titleLabel.text = titleText
            self.pcView.dateLabel.text = Helpers.convertDateFormatter(date: date)
            
            self.choices = choiceList
            self.pcView.collectionView.reloadData()
        }
    }
    
}

// MARK: - UICollectionView Methode

extension QuestionDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
