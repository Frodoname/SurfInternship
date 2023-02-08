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
        
        mainView.upperCollectionView.delegate = self
        mainView.upperCollectionView.dataSource = self
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

// MARK: - CollectionView Delegate & Datasource

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
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
        return CGSize(width: 96, height: 44)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapCell(at: indexPath.row)
    }
}

// MARK: - Presenter Extension

extension MainViewController: MainViewOutput {
    func showAlert(with title: String, _ description: String) {
        self.showAlert(alertText: title, alertMessage: description)
    }
    
    func updateCollectionView() {
        mainView.upperCollectionView.performBatchUpdates {
            let indexSet = IndexSet(integersIn: 0...0)
            mainView.upperCollectionView.reloadSections(indexSet)
        }
    }
}

// MARK: - Actionextension

extension MainViewController: ApplyButtonProtocol {
    func applyButtonTapped() {
        presenter.didTapSendButton()
    }
}

