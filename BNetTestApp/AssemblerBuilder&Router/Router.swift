//
//  Router.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

protocol RouterMainProtocol {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblerBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func showListOfNotesViewController()
    func showAddNewNoteViewController(session: String)
    func popToRootViewController()
    func showFullNoteViewController(note: Note?)
}

class Router: RouterProtocol {

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblerBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblerBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showListOfNotesViewController() {
        if let navigationController = navigationController {
            guard let listOfNotesViewController = assemblyBuilder?.createListOfNotesModule(router: self) else { return }
            navigationController.viewControllers = [listOfNotesViewController]
        }
    }
    
    func showAddNewNoteViewController(session: String) {
        if let navigationController = navigationController {
            guard let addNewNoteViewController = assemblyBuilder?.createAddNewNoteModule(session: session, router: self) else { return }
            navigationController.pushViewController(addNewNoteViewController, animated: true)
        }
    }
    
    func popToRootViewController() {
        if let navController = navigationController {
            navController.popToRootViewController(animated: true)
        }
    }
    
    func showFullNoteViewController(note: Note?) {
        if let navigationController = navigationController {
            guard let fullNoteViewController = assemblyBuilder?.createFullNoteModule(note: note, router: self) else { return }
            navigationController.pushViewController(fullNoteViewController, animated: true)
        }
    }
}
