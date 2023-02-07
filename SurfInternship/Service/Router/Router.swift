//
//  Router.swift
//  SurfInternship
//
//  Created by Fed on 06.02.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyProtocol? { get set }
}

protocol RouterProcotol: RouterMain {
    func initialContoller()
}

final class Router: RouterProcotol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialContoller() {
        guard let navigationController,
              let mainViewController = assemblyBuilder?.createMainModule(router: self) else {
            return
        }
        navigationController.viewControllers.append(mainViewController)
    }
}
