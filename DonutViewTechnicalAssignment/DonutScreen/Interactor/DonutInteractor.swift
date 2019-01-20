//
//  DonutInteractor.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import Foundation

protocol DonutInteractorInput {
    func getScores()
}

protocol DonutInteractorOutput: class {
    func scoresRetrievalSucceededWith(currentScore: Double, maxScore: Double)
    func scoresRetrievalFailedWith(error: Error)
}

class DonutInteractor {
    private weak var output: DonutInteractorOutput!
    
    private let scoresWebServiceHandler: CreditScoresWebServiceHandler
    
    init(output: DonutInteractorOutput, scoresWebServiceHandler: CreditScoresWebServiceHandler) {
        self.output = output
        self.scoresWebServiceHandler = scoresWebServiceHandler
    }
}

extension DonutInteractor: DonutInteractorInput {
    func getScores() {
        scoresWebServiceHandler.getCreditScores { (scores, error) in
            // No need to capture self as weak - the handler doesn't keep a reference to this closure
            if let scores = scores {
                let (currentScore, maxScore) = scores
                self.output.scoresRetrievalSucceededWith(currentScore: currentScore, maxScore: maxScore)
            } else if let error = error {
                self.output.scoresRetrievalFailedWith(error: error)
            }
        }
    }
}
