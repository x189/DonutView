//
//  DonutConfigurator.swift
//  DonutViewTechnicalAssignment
//
//  Created by Aleksandar Drazhev on 20.01.19.
//  Copyright © 2019 Aleksandar Drazhev. All rights reserved.
//

import UIKit

class DonutConfigurator {
    static func newDonutModule() -> UIViewController? {
        guard let view = UIStoryboard(name: "DonutStoryboard", bundle: nil).instantiateInitialViewController() as? DonutViewController else {
            return nil
        }
        
        let presenter = DonutPresenter(view: view)
        view.output = presenter
        
        let interactor = DonutInteractor(output: presenter, scoresWebServiceHandler: CreditScoresWebServiceHandler())
        presenter.interactor = interactor
        
        return view
    }
}
