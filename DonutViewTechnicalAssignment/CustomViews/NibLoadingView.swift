//
//  NibLoadingView.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import UIKit

class NibLoadingView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    func nibSetup() {
        backgroundColor = .clear
        
        guard let view = loadViewFromNib() else {
            return
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return nibView
    }
}
