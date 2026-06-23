//
//  FifthAssignmentViewModel.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

class FifthAssignmentViewModel {
    func sortNumber(_ number: Int) -> Int {
        return Int(String(String(number).sorted(by: >))) ?? 0
    }
}

