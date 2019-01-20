//
//  DonutInteractorTests.swift
//  DonutViewTechnicalAssignmentTests
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import XCTest

class DonutInteractorTests: XCTestCase {
    var mockOutput: MockOutput!
    var mockHandler: MockHandler!
    
    var interactor: DonutInteractor!

    override func setUp() {
        super.setUp()
        
        mockOutput = MockOutput()
        mockHandler = MockHandler()
        
        interactor = DonutInteractor(output: mockOutput, scoresWebServiceHandler: mockHandler)
    }
    
    func testOutputGetsInformedAboutScoresRetrievalSuccess() {
        interactor.getScores()
                
        wait(for: [mockOutput.scoresRetrievalSucceededCalledExpectation], timeout: 0.1)
    }
    
    func testOutputGetsInformedAboutScoresRetrievalFailure() {
        interactor = DonutInteractor(output: mockOutput, scoresWebServiceHandler: MockHandler(shouldFail: true))
        
        interactor.getScores()
        
        wait(for: [mockOutput.scoresRetrievalFailedCalledExpectation], timeout: 0.1)
    }
}

extension DonutInteractorTests {
    class MockOutput: DonutInteractorOutput {
        var scoresRetrievalSucceededCalledExpectation = XCTestExpectation()
        var scoresRetrievalFailedCalledExpectation = XCTestExpectation()
        
        func scoresRetrievalSucceededWith(currentScore: Double, maxScore: Double) {
            scoresRetrievalSucceededCalledExpectation.fulfill()
        }
        
        func scoresRetrievalFailedWith(error: Error) {
            scoresRetrievalFailedCalledExpectation.fulfill()
        }
        
    }
    
    struct MockError: Error {
        
    }
    
    class MockHandler: CreditScoresWebServiceHandler {
        private let shouldFail: Bool
        
        override func getCreditScores(completionHandler: @escaping ((currentScore: Double, maxScore: Double)?, Error?) -> Void) {
            if shouldFail {
                completionHandler(nil, MockError())
            } else {
                completionHandler((0, 0), nil)
            }
        }
        
        init(shouldFail: Bool = false) {
            self.shouldFail = shouldFail
        }
    }
}
