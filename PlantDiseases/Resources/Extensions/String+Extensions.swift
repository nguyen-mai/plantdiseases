//
//  String+Extensions.swift
//  PlantDiseases
//
//  Created by Apple on 2021/11/14.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
