//
//  UILabel+Extension.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String?, font: UIFont? = .systemFont(ofSize: 12), textColor: UIColor = .gray, alignment: NSTextAlignment) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
    }
}
