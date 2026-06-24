//
//  SixthAssignmentViewModel.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

class SixthAssignmentViewModel {
    func generateTribonacci(signature: [Int], n: Int) -> [Int] {
        guard n > 0 else { return [] }

        var result = signature
        
        if n <= result.count {
            return Array(result.prefix(n))
        }

        while result.count < n {
            let nextValue = result.suffix(3).reduce(0, +)
            result.append(nextValue)
        }

        return result
    }
}
