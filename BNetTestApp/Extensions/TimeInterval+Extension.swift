//
//  TimeInterval+Extension.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    func convertToTimeAndDate() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.current
        
        let interval = Double(self)
        let date = Date.init(timeIntervalSince1970: interval)
        let localDate = dateFormatter.string(from: date)
        
        return localDate
    }
}
