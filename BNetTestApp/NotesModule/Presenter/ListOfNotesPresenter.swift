//
//  ListOfNotesPresenter.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol ListOfNotesViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol ListOfNotesPresenterProtocol: class {
    var sessionId: String? { get set }
    var listOfNotes: [Note]? { get set }
    init(view: ListOfNotesViewProtocol, networkFetcherService: NetworkDataFetherProtocol, router: RouterProtocol)
    func getData()
    func addNewNote()
    func tapOnNote(note: Note?)
}

class ListOfNotesPresenter: ListOfNotesPresenterProtocol {
    
    weak var view: ListOfNotesViewProtocol?
    var networkFetcherService: NetworkDataFetherProtocol?
    var router: RouterProtocol?
    var sessionId: String?
    var listOfNotes: [Note]?
    let userDefaults = UserDefaults.standard
    
    required init(view: ListOfNotesViewProtocol, networkFetcherService: NetworkDataFetherProtocol, router: RouterProtocol) {
        self.view = view
        self.networkFetcherService = networkFetcherService
        self.router = router
        getData()
    }
    func addNewNote() {
        router?.showAddNewNoteViewController(session: sessionId ?? "")
    }
    
    func tapOnNote(note: Note?) {
        router?.showFullNoteViewController(note: note)
    }
    
    func getData() {
        sessionId = userDefaults.string(forKey: "sessionId")
        if sessionId == nil  {
            checkSession()
        } else {
            getNotes()
        }
    }
    
    func checkSession() {
        self.networkFetcherService?.getSession(completion: { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let session):
                self.sessionId = session?.data?.session
                self.userDefaults.set(self.sessionId, forKey: "sessionId")
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        })
    }
    
    func getNotes() {
        self.networkFetcherService?.getNotes(session: self.sessionId ?? "", completion: { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let notes):
                guard let notes = notes?.notes else { return }
                self.listOfNotes = notes.first
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        })
    }
}
