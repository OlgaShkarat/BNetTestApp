//
//  AssemblerBuilder.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

protocol AssemblerBuilderProtocol {
    func createListOfNotesModule(router: RouterProtocol) -> UIViewController
    func createAddNewNoteModule(session: String, router: RouterProtocol) -> UIViewController
    func createFullNoteModule(note: Note?, router: RouterProtocol) -> UIViewController
}

class AssemblerModuleBuilder: AssemblerBuilderProtocol {
    
    func createListOfNotesModule(router: RouterProtocol) -> UIViewController {
        let view = ListOfNotesViewController()
        let networkFetcherService =  NetworkDataFether()
        let presenter = ListOfNotesPresenter(view: view, networkFetcherService: networkFetcherService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createAddNewNoteModule(session: String, router: RouterProtocol) -> UIViewController {
        let view = AddNoteViewController()
        let networkFetcherService =  NetworkDataFether()
        let presenter = AddNotePresenter(router: router, view: view, networkFetcherService: networkFetcherService, session: session)
        view.presenter = presenter
        return view
    }
    
    func createFullNoteModule(note: Note?, router: RouterProtocol) -> UIViewController {
        let view = FullNoteViewController()
        let presenter = FullNotePresenter(view: view, note: note, router: router)
        view.presenter = presenter
        return view
    }
}
