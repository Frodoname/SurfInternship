//
//  ViewController.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewInput!
    
    // MARK: - UI Elements
    
    private lazy var mainView = MainView()
    
    // MARK: - Local Constants
    
    private enum CellSize {
        static let height: CGFloat = 44
        static let width: CGFloat = 96
        static let extensionConstant: CGFloat = 48
    }
    
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
        
        mainView.bottomSheetView.collectionView.delegate = self
        mainView.bottomSheetView.collectionView.dataSource = self
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
        return presenter.internPositions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectionCell.cellId, for: indexPath) as? DirectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: presenter.internPositions?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateSizeForItem(for: collectionView, indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return presenter.didTapCell(at: indexPath.row)
    }
}

// MARK: - Presenter Extension

extension MainViewController: MainViewOutput {
    func showAlert(with title: String, _ description: String) {
        self.showAlert(alertText: title, alertMessage: description)
    }
    
    func updateCollectionView() {
        mainView.bottomSheetView.collectionView.performBatchUpdates {
            let indexSet = IndexSet(integersIn: 0...0)
            mainView.bottomSheetView.collectionView.reloadSections(indexSet)
            let indexPath = IndexPath(row: 0, section: 0)
            mainView.bottomSheetView.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
}

// MARK: - Private Methods

extension MainViewController {
    private func calculateSizeForItem(for collectionView: UICollectionView, _ position: Int) -> CGSize {
        guard let item = presenter.internPositions?[position].direction.title else {
            return CGSize(width: CellSize.width, height: CellSize.height)
        }
        let itemWidth = item.size(withAttributes: [NSAttributedString.Key.font: FontScheme.regular]).width + CellSize.extensionConstant
        return CGSize(width: itemWidth, height: CellSize.height)
    }
}

// MARK: - Action Extension

extension MainViewController: ApplyButtonProtocol {
    func applyButtonTapped() {
        presenter.didTapSendButton()
    }
}

