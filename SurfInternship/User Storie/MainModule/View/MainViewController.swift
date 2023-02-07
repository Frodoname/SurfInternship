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

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter.internPositions?.count as Any)
        return presenter.internPositions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("CONFIG WORKS")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectionCell.cellId, for: indexPath) as? DirectionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: presenter.internPositions?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 96, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.indexPathsForSelectedItems?.filter({ $0.section == indexPath.section }).forEach({ collectionView.deselectItem(at: $0, animated: false) })
        return true
        
    }
}

extension MainViewController: MainViewOutput {
    func showAlert(with title: String, _ description: String) {
        self.showAlert(alertText: title, alertMessage: description)
    }
}

