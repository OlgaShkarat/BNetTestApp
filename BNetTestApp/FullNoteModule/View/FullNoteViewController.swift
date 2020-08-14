//
//  FullNoteViewController.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

class FullNoteViewController: UIViewController {
    
    private let noteNameLabel = UILabel(text: "Задача", font: .boldSystemFont(ofSize: 26), textColor: .systemBlue,  alignment: .center)
    
    private let noteTextView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.tintColor = .systemBlue
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    private let createdDateNoteLabel = UILabel(text: "", alignment: .right)
    private let modifieldDateNoteLabel = UILabel(text: "", alignment: .right)
    
    var presenter: FullNotePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setElements()
        presenter?.setNote()
    }
    
    //MARK: - Custom methods
    private func setElements() {
        
        let stackView = UIStackView(arrangedSubviews: [createdDateNoteLabel, modifieldDateNoteLabel], axis: .vertical, spacing: 10)
        
        noteNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(noteNameLabel)
        view.addSubview(noteTextView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            noteNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            noteNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: noteNameLabel.bottomAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
//MARK: - FullNotePresenterViewProtocol
extension FullNoteViewController: FullNotePresenterViewProtocol {
    
    func showFullNote(note: Note) {
        let createdDate = note.createdDate
        let modifiedDate = note.modifiedDate
        
        guard let cd = Double(createdDate)?.convertToTimeAndDate() else { return }
        guard let md = Double(modifiedDate)?.convertToTimeAndDate() else { return }
        
        noteTextView.text = note.note
        createdDateNoteLabel.text = "Дата создания: \(cd)"
        modifieldDateNoteLabel.text = "Дата изменения: \(md)"
    }
}
