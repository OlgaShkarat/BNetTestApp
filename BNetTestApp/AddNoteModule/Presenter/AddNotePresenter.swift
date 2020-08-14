//
//  AddNotePresenter.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol AddNoteViewProtocol: class {
    func showError(error: Error)
}

protocol AddNotePresenterProtocol: class {
   init(router: RouterProtocol, view: AddNoteViewProtocol, networkFetcherService: NetworkDataFether, session: String)
    func addNoteToList(userText: String)
    func popToRootViewController()
}

class AddNotePresenter: AddNotePresenterProtocol {
    
    weak var view: AddNoteViewProtocol!
    var router: RouterProtocol?
    let networkFetcherService: NetworkDataFetherProtocol?
    var session: String?
    
    required init(router: RouterProtocol, view: AddNoteViewProtocol, networkFetcherService: NetworkDataFether, session: String) {
        self.view = view
        self.networkFetcherService = networkFetcherService
        self.router = router
        self.session = session
    }
    
    func addNoteToList(userText: String) {
        networkFetcherService?.createNewNote(session: session ?? "", userText: userText) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(_):
                self.popToRootViewController()
            case .failure(let error):
                self.view.showError(error: error)
            }
        }
    }
    
    func popToRootViewController() {
        self.router?.popToRootViewController()
    }
}
