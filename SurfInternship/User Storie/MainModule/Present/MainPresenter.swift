//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    func didTapSendButton()
    var internPositions: [Internship]? { get }
    init(view: MainViewOutput, router: RouterProcotol)
}

protocol MainViewOutput: AnyObject {
    func showAlert(with title: String, _ description: String)
}

final class MainPresenter: MainViewInput {
    
    weak var view: MainViewOutput?
    var router: RouterProcotol?
    var internPositions: [Internship]?
    
    init(view: MainViewOutput, router: RouterProcotol) {
        self.view = view
        self.router = router
        internPositions = Internship.directionsOfInternship
    }
    
    func didTapSendButton() {
        view?.showAlert(with: "Поздравляем", "Ваша заявка успешно отправлена!")
    }
    
}
