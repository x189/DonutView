//
//  DonutPresenter.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import Foundation

class DonutPresenter {
    private weak var view: DonutViewInput!
    var interactor: DonutInteractorInput!
    
    init(view: DonutViewInput) {
        self.view = view
    }
    
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .decimal
        
        return formatter
    }()
}

extension DonutPresenter: DonutInteractorOutput {
    func scoresRetrievalSucceededWith(currentScore: Double, maxScore: Double) {
        let formattedCurrentScore = numberFormatter.string(from: currentScore as NSNumber) ?? String(currentScore)
        let formattedMaxScore = numberFormatter.string(from: maxScore as NSNumber) ?? String(maxScore)
        
        view.hideLoadingIndicator()
        view.updateScoresWith(currentScore: formattedCurrentScore, maxScore: formattedMaxScore)
    }
    
    func scoresRetrievalFailedWith(error: Error) {
        view.hideLoadingIndicator()
        view.showAlertWith(message: error.localizedDescription)
    }
}

extension DonutPresenter: DonutViewOutput {
    func viewIsReady() {
        loadScores()
    }
    
    func retryTapped() {
        loadScores()
    }
    
    private func loadScores() {
        view.showLoadingIndicator()
        interactor.getScores()
    }
}
