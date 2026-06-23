//
//  FirstAssignmentViewModel.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

class FirstAssignmentViewModel {
    init() { }

    func checkValidBrackets(_ input: String) -> Bool {
        var stack: [Character] = []

        let matchingText: [Character: Character] = [
            ")": "(",
            "]": "[",
            "}": "{"
        ]

        for char in input {
            if matchingText.values.contains(char) {
                stack.append(char)
            } else if let expectedOpenBracket = matchingText[char] {
                if stack.isEmpty || stack.last != expectedOpenBracket {
                    return false
                }
                stack.removeLast()
            }
        }

        return stack.isEmpty
    }
}

