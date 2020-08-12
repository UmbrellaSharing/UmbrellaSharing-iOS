//
//  InformationViewModel.swift
//  UmbrellaSharing-iOS
//
//  Created by Katselenbogen, Igor on 2020/08/12.
//  Copyright © 2020 Katselenbogen, Igor. All rights reserved.
//

import Foundation

class InformationViewModel {
    
    weak var delegate: InformationDataModelDelegate?
    
    func load() {
        loadQuestionsAndAnswers()
    }
    
    private func loadQuestionsAndAnswers() {
        NetworkManager.shared.getFAQ().done { [weak self] response in
            guard self != nil else { return }
            if let delegate = self?.delegate {
                delegate.didLoadQuestionsAndAnswers(questionsAndAnswers: response)
            }
        }.catch { error in
            print("Error: \(error)")
        }
    }
}

protocol InformationDataModelDelegate: class {
    func didLoadQuestionsAndAnswers(questionsAndAnswers: [FAQEntity])
}
