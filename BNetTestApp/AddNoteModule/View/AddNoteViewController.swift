//
//  AddNoteViewController.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    var presenter: AddNotePresenterProtocol?
    
    private let textView: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.tintColor = .systemBlue
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setBarButtons()
        setConstraints()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        textView.becomeFirstResponder()
    }
    
    private func setBarButtons() {
        let saveNoteButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNoteButtonTapped))
        let cancelNoteButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelNoteButtonTapped))
        
        navigationItem.leftBarButtonItems = [cancelNoteButton]
        navigationItem.rightBarButtonItems = [saveNoteButton]
    }
    
    @objc private func saveNoteButtonTapped() {
        if !textView.text.isEmpty {
            presenter?.addNoteToList(userText: textView.text)
        }
    }
    
    @objc private func cancelNoteButtonTapped() {
        presenter?.popToRootViewController()
    }
    
    private func setConstraints() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - AddNoteViewProtocol
extension AddNoteViewController: AddNoteViewProtocol {
    func showError(error: Error) {
        self.showAlert(title: error.localizedDescription, message: "Проверьте соединение с сетью", titleButton: "OK")
    }
}
