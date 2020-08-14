//
//  ListOfNotesViewController.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class ListOfNotesViewController: UIViewController {
    
    var tableView: UITableView!
    var presenter: ListOfNotesPresenterProtocol?
    let cellId = "noteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Заметки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        
        createTableView()
    }
    
    private func createTableView() {
        tableView =  UITableView(frame: view.bounds, style: .plain)
        view.addSubview(tableView)
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc private func addNewNote() {
        presenter?.addNewNote()
    }
}
//MARK: - UITableViewDataSource
extension ListOfNotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.listOfNotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard var cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId, for: indexPath) as? NoteCell else { return UITableViewCell() }
        cell = NoteCell(style: .subtitle, reuseIdentifier: NoteCell.reuseId)
        
        if  let note = presenter?.listOfNotes?[indexPath.row] {
            cell.configureCell(note: note)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListOfNotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = presenter?.listOfNotes?[indexPath.row]
        presenter?.tapOnNote(note: note)
    }
}
//MARK: - ListOfNotesViewProtocol
extension ListOfNotesViewController: ListOfNotesViewProtocol {
    func success() {
        self.presenter?.getData()
        self.tableView.reloadData()
    }
    func failure(error: Error) {
        self.showAlert(title: error.localizedDescription, message: "Проверьте соединение с сетью", titleButton: "Обновить данные") { [weak self] _ in
            self?.presenter?.getData()
            self?.tableView.reloadData()
        }
    }
}
