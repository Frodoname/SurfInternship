//
//  Assembly.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createMainModule(router: RouterProcotol) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    
    func createMainModule(router: RouterProcotol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
