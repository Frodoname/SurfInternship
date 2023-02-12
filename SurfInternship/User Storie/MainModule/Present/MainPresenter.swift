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
    
    private enum Text {
        static let alertTitle = "Поздравляем!"
        static let alertMessage = "Ваша заявка успешно отправлена"
    }
    
    init(view: MainViewOutput, router: RouterProcotol) {
        self.view = view
        self.router = router
        initSetup()
    }
    
    func didTapSendButton() {
        view?.showAlert(with: Text.alertTitle, Text.alertMessage)
    }
        
    func didTapCell(at position: Int) {
        arrayUpdate(for: &internPositions, position)
        view?.updateCollectionView()
    }
}

// MARK: - Private methods

extension MainPresenter {
    private func arrayUpdate(for array: inout [Internship]?, _ selectedPosition: Int) {
        if let internship = array?[selectedPosition] {
            for index in 0...(array?.count ?? 1) - 1 {
                array?[index].isSelected = false
            }
            array?[selectedPosition].isSelected = !internship.isSelected
            if let index = array?.firstIndex(where: {$0 == array?[selectedPosition]}) {
                array?.swapAt(index, 0) 
            }
        }
    }
    
    private func initSetup() {
        internPositions = Internship.directionsOfInternship
    }
}
