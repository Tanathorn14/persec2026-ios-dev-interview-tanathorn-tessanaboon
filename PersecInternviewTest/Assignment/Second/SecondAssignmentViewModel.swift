//
//  SecondAssignmentViewModel.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import Foundation

class SecondAssignmentViewModel {
    func sortStrings(_ input: [String]) -> [String] {
        return input.sorted { $0.localizedStandardCompare($1) == .orderedAscending }
    }
}

