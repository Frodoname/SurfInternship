//
//  Assembly.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createBaseModule(with router: RouterProcotol) -> UIViewController
    func createMainModule(router: RouterProcotol) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    
    func createBaseModule(with router: RouterProcotol) -> UIViewController {
        let view = BaseViewController()
        let presenter = BasePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(router: RouterProcotol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
