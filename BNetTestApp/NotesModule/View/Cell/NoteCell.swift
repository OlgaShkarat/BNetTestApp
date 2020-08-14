//
//  NoteCell.swift
//  BNetTestApp
//
//  Created by Ольга on 13.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    static let reuseId = "noteCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(note: Note) {
        textLabel?.text = String(note.note.prefix(200))
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        detailTextLabel?.textColor = .gray
        let currentDate = Double(note.createdDate)?.convertToTimeAndDate()
        let modifiedDate = Double(note.modifiedDate)?.convertToTimeAndDate()
        textLabel?.text = note.note
        
        if currentDate == modifiedDate {
            detailTextLabel?.text = "Дата создания: \(currentDate ?? "")"
        } else {
            detailTextLabel?.text = "Дата изменения: \(modifiedDate ?? "")"
        }
    }
}
