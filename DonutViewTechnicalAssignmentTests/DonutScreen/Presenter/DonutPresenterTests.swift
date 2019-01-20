//
//  DonutPresenterTests.swift
//  DonutViewTechnicalAssignmentTests
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import XCTest

class DonutPresenterTests: XCTestCase {
    var mockInteractor: MockInteractor!
    var mockView: MockView!
    
    var presenter: DonutPresenter!
    

    override func setUp() {
        super.setUp()
        
        mockInteractor = MockInteractor()
        mockView = MockView()
        
        presenter = DonutPresenter(view: mockView)
        presenter.interactor = mockInteractor
    }
    
    func testHideLoadingAndUpdateScoresGetCalledAfterScoresRetrievalSuccess() {
        presenter.scoresRetrievalSucceededWith(currentScore: 100, maxScore: 1000)
        
        wait(for: [mockView.hideLoadingIndicatorCalledExpectation, mockView.updateScoresCalledExpectation], timeout: 0.1)
    }
    
    func testHideLoadingAndShowAlertGetCalledAfterScoresRetrievalFailure() {
        presenter.scoresRetrievalFailedWith(error: MockError())
        
        wait(for: [mockView.hideLoadingIndicatorCalledExpectation, mockView.showAlertCalledExpectation], timeout: 0.1)
    }
    
    func testLoadScoresGetsCalledAfterViewIsReady() {
        presenter.viewIsReady()
        
        wait(for: [mockInteractor.getScoresCalledExpectation], timeout: 0.1)
    }
    
    func testLoadScresGetsCalledAfterRetryIsTapped() {
        presenter.retryTapped()
        
        wait(for: [mockInteractor.getScoresCalledExpectation], timeout: 0.1)
    }
}

extension DonutPresenterTests {
    class MockInteractor: DonutInteractorInput {
        var getScoresCalledExpectation = XCTestExpectation()
        
        func getScores() {
            getScoresCalledExpectation.fulfill()
        }
    }
    
    class MockView: DonutViewInput {
        var showLoadingIndicatorCalledExpectation = XCTestExpectation()
        var hideLoadingIndicatorCalledExpectation = XCTestExpectation()
        var showAlertCalledExpectation = XCTestExpectation()
        var updateScoresCalledExpectation = XCTestExpectation()
        
        func showLoadingIndicator() {
            showLoadingIndicatorCalledExpectation.fulfill()
        }
        
        func hideLoadingIndicator() {
            hideLoadingIndicatorCalledExpectation.fulfill()
        }
        
        func showAlertWith(message: String) {
            showAlertCalledExpectation.fulfill()
        }
        
        func updateScoresWith(currentScore: String, maxScore: String) {
            updateScoresCalledExpectation.fulfill()
        }
    }
    
    struct MockError: Error {
        
    }
}
