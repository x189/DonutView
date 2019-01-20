//
//  DonutView.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import UIKit

class DonutView: NibLoadingView {
    @IBOutlet private weak var currentScoreLabel: UILabel!
    @IBOutlet private weak var outOfMaxScoreLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var currentScore: String = "0" {
        didSet {
            updateCurrentScoreText()
        }
    }
    
    var maxScore: String = "0" {
        didSet {
            updateMaxScoreText()
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.size.width / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateCurrentScoreText()
        updateMaxScoreText()
    }
    
    func startAnimating() {
        currentScoreLabel.isHidden = true
        outOfMaxScoreLabel.isHidden = true
        
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
        currentScoreLabel.isHidden = false
        outOfMaxScoreLabel.isHidden = false
        
        activityIndicatorView.stopAnimating()
    }
    
    private func updateCurrentScoreText() {
        currentScoreLabel.text = currentScore
    }
    
    private func updateMaxScoreText() {
        outOfMaxScoreLabel.text = "out of \(maxScore)"
    }

}
