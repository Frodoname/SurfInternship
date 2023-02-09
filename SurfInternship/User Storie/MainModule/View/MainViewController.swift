//
//  ViewController.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewInput!
    
    private lazy var mainView = MainView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Setup
    
    private func viewDidLoadSetup() {
        layoutSetup()
        
        mainView.bottomSheetView.upperCollectionView.delegate = self
        mainView.bottomSheetView.upperCollectionView.dataSource = self
        mainView.bottomSheetView.downCollectionView.delegate = self
        mainView.bottomSheetView.downCollectionView.dataSource = self
        mainView.delegate = self
    }
    
    private func layoutSetup() {
        [mainView].forEach {
            view.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Delegate & Datasource

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems(for: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectionCell.cellId, for: indexPath) as? DirectionCell else {
            return UICollectionViewCell()
        }
        configureCell(for: collectionView, cell, indexPath.row)
        return cell
    }
        
    #warning("сделать адаптивный по размеру ячейку")
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainView.bottomSheetView.upperCollectionView:
            return CGSize(width: 96, height: 44)
        case mainView.bottomSheetView.downCollectionView:
            let item = presenter.downInternPositions![indexPath.row].direction.title
            let itemWidth = item.size(withAttributes: [NSAttributedString.Key.font: FontScheme.regular]).width + 48
            return CGSize(width: itemWidth, height: 44)
        default:
            return CGSize(width: 96, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case mainView.bottomSheetView.upperCollectionView:
            presenter.didTapCellAtUpperCollectionView(at: indexPath.row)
        case mainView.bottomSheetView.downCollectionView:
            presenter.didTapCellAtDownCollectionView(at: indexPath.row)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

// MARK: - Presenter Extension

extension MainViewController: MainViewOutput {
    func showAlert(with title: String, _ description: String) {
        self.showAlert(alertText: title, alertMessage: description)
    }
    
    func updateUpperCollectionView() {
        mainView.bottomSheetView.upperCollectionView.performBatchUpdates {
            let indexSet = IndexSet(integersIn: 0...0)
            mainView.bottomSheetView.upperCollectionView.reloadSections(indexSet)
            let indexPath = IndexPath(row: 0, section: 0)
            mainView.bottomSheetView.upperCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    func updateDownCollectionView() {
        mainView.bottomSheetView.downCollectionView.performBatchUpdates {
            let indexSet = IndexSet(integersIn: 0...0)
            mainView.bottomSheetView.downCollectionView.reloadSections(indexSet)
        }
    }
}

// MARK: - Private Methods

extension MainViewController {
    private func numberOfItems(for collectionView: UICollectionView) -> Int {
        switch collectionView {
        case mainView.bottomSheetView.upperCollectionView:
            return presenter.upperInternPositions?.count ?? 0
        case mainView.bottomSheetView.downCollectionView:
            return presenter.downInternPositions?.count ?? 0
        default:
            return 0
        }
    }
    
    private func configureCell(for collectionView: UICollectionView, _ cell: DirectionCell, _ position: Int) {
        switch collectionView {
        case mainView.bottomSheetView.upperCollectionView:
            cell.configure(with: presenter.upperInternPositions?[position])
        case mainView.bottomSheetView.downCollectionView:
            cell.configure(with: presenter.downInternPositions?[position])
        default:
            break
        }
    }
}

// MARK: - Action Extension

extension MainViewController: ApplyButtonProtocol {
    func applyButtonTapped() {
        presenter.didTapSendButton()
    }
}

