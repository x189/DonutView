//
//  DonutViewController.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import UIKit

protocol DonutViewInput: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showAlertWith(message: String)
    func updateScoresWith(currentScore: String, maxScore: String)
}

protocol DonutViewOutput {
    func viewIsReady()
    func retryTapped()
}

class DonutViewController: UIViewController {
    var output: DonutViewOutput!
    
    @IBOutlet private weak var donutView: DonutView!
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] (_) in
            self?.output.retryTapped()
        }))
        
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donutView.startAnimating()
        output.viewIsReady()
    }
}

extension DonutViewController: DonutViewInput {
    func showLoadingIndicator() {
        donutView.startAnimating()
    }
    
    func hideLoadingIndicator() {
        donutView.stopAnimating()
    }
    
    func showAlertWith(message: String) {
        alertController.message = message
        present(alertController, animated: true, completion: nil)
    }
    
    func updateScoresWith(currentScore: String, maxScore: String) {
        donutView.stopAnimating()
        donutView.currentScore = currentScore
        donutView.maxScore = maxScore
    }
}
