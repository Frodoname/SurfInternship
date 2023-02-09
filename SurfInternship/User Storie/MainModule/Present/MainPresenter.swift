//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import Foundation

protocol MainViewInput: AnyObject {
    func didTapSendButton()
    func didTapCellAtUpperCollectionView(at position: Int)
    func didTapCellAtDownCollectionView(at position: Int)
    var upperInternPositions: [Internship]? { get }
    var downInternPositions: [Internship]? { get }
    init(view: MainViewOutput, router: RouterProcotol)
}

protocol MainViewOutput: AnyObject {
    func showAlert(with title: String, _ description: String)
    func updateUpperCollectionView()
    func updateDownCollectionView()
}

final class MainPresenter: MainViewInput {
    
    weak var view: MainViewOutput?
    var router: RouterProcotol?
    var upperInternPositions: [Internship]?
    var downInternPositions: [Internship]?
    
    init(view: MainViewOutput, router: RouterProcotol) {
        self.view = view
        self.router = router
        initSetup()
    }
    
    func didTapSendButton() {
        view?.showAlert(with: "Поздравляем!", "Ваша заявка успешно отправлена")
    }
    
    #warning("убрать force unwrap!")
    
    func didTapCellAtUpperCollectionView(at position: Int) {
        let internship = upperInternPositions![position]
        upperInternPositions?.removeAll()
        upperInternPositions = Internship.directionsOfInternship
        
        let item = Internship(direction: internship.direction, isSelected: !internship.isSelected)
        
        if let index = upperInternPositions?.firstIndex(where: { $0 == internship }) {
            upperInternPositions?[index] = item
            upperInternPositions?.swapAt(index, 0)
        }
        
        view?.updateUpperCollectionView()
    }
    
    func didTapCellAtDownCollectionView(at position: Int) {
        let internship = downInternPositions![position]
        downInternPositions?.removeAll()
        downInternPositions = Internship.directionsOfInternship
        
        let item = Internship(direction: internship.direction, isSelected: !internship.isSelected)
        
        if let index = downInternPositions?.firstIndex(where: { $0 == internship }) {
            downInternPositions?[index] = item
            downInternPositions?.swapAt(index, 0)
        }
        
        view?.updateDownCollectionView()
    }
}

// MARK: - Private methods

extension MainPresenter {
    private func clearSelection() {
        upperInternPositions?.removeAll()
        upperInternPositions = Internship.directionsOfInternship
    }
    
    private func arrayUpdate(for array: inout [Internship]?, with position: Int) {
        let internship = upperInternPositions![position]
        upperInternPositions?.remove(at: position)
        let item = Internship(direction: internship.direction, isSelected: !internship.isSelected)
        upperInternPositions?.insert(item, at: position)

    }
    
    private func initSetup() {
        upperInternPositions = Internship.directionsOfInternship
        downInternPositions = Internship.directionsOfInternship
    }
}
