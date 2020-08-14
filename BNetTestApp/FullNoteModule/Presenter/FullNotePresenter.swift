//
//  FullNotePresenter.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

import Foundation

protocol FullNotePresenterViewProtocol: class {
    func showFullNote(note: Note)
}

protocol FullNotePresenterProtocol: class {
    init(view: FullNotePresenterViewProtocol, note: Note?, router: RouterProtocol)
    var note: Note? { get }
    func setNote()
}

class FullNotePresenter: FullNotePresenterProtocol {
    
    weak var view: FullNotePresenterViewProtocol!
    var router: RouterProtocol?
    var note: Note?
    
    required init(view: FullNotePresenterViewProtocol, note: Note?, router: RouterProtocol) {
        self.view = view
        self.note = note
        self.router = router
    }
    
    func setNote() {
        if let note = note {
            view.showFullNote(note: note)
        }
    }
}
