//
//  BaseViewController.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

final class BaseViewController: UIViewController {
    
    var presenter: BaseViewInput!
    
    private lazy var backgroundImage: UIImageView = {
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerSetup()
    }
    
    // MARK: - ViewController Setup
    
    private func viewControllerSetup() {
        presenter.showMainView()
        view.backgroundColor = .red
        layoutSetup()
    }
    
    private func layoutSetup() {
        [backgroundImage].forEach {
            view.addSubview($0)
            $0.prepareForAutoLayOut()
        }
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

extension BaseViewController: BaseViewOutput {
    
    
    
}
