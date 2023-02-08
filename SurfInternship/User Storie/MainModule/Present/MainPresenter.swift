//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    func didTapSendButton()
    func didTapCell(at position: Int)
    var internPositions: [Internship]? { get }
    init(view: MainViewOutput, router: RouterProcotol)
}

protocol MainViewOutput: AnyObject {
    func showAlert(with title: String, _ description: String)
    func updateCollectionView()
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
        view?.showAlert(with: "Поздравляем!", "Ваша заявка успешно отправлена!")
    }
    
    #warning("убрать force unwrap!")
    
    func didTapCell(at position: Int) {
        let internship = internPositions![position]
        internPositions?.remove(at: position)
        let item = Internship(direction: internship.direction, isSelected: !internship.isSelected)
        internPositions?.insert(item, at: position)
        view?.updateCollectionView()
    }
}
