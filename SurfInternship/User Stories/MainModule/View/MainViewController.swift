//
//  ViewController.swift
//  SurfInternship
//
//  Created by Fed on 05.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainViewInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
    }


}

extension MainViewController: MainViewOutput {

    
}

