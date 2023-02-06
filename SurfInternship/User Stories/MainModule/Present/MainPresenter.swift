//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    init(view: MainViewOutput, router: RouterProcotol)
}

protocol MainViewOutput: AnyObject {
    
}

final class MainPresenter: MainViewInput {
    
    weak var view: MainViewOutput?
    var router: RouterProcotol?
    
    init(view: MainViewOutput, router: RouterProcotol) {
        self.view = view
        self.router = router
    }
    
}
