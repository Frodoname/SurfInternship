//
//  BasePresenter.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

protocol BaseViewInput: AnyObject {
    func showMainView()
    init(view: BaseViewOutput, router: RouterProcotol)
}

protocol BaseViewOutput: AnyObject {
}

final class BasePresenter: BaseViewInput {
    
    weak var view: BaseViewOutput?
    var router: RouterProcotol?
    
    required init(view: BaseViewOutput, router: RouterProcotol) {
        self.view = view
        self.router = router
    }
    
    func showMainView() {
        router?.showMainViewController()
    }
}
