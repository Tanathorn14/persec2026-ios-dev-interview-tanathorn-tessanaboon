//
//  SecondAssignmentViewController.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import UIKit

class SecondAssignmentViewController: UIViewController {

    static let identifier = "SecondAssignmentViewController"

    required init() {
        super.init(nibName: SecondAssignmentViewController.identifier, bundle: Bundle(for: SecondAssignmentViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var textfield: UITextField!
    @IBOutlet var resultLabel: UILabel!

    private let viewModel = SecondAssignmentViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfield()
    }

    // MARK: - UserInterface
    private func setupTextfield() {
        self.textfield.placeholder = "ex: TH10, TH1, TH9"
        self.textfield.autocapitalizationType = .allCharacters

        self.textfield.delegate = self
        self.textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Action
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let inputText = textField.text, !inputText.isEmpty else {
            return
        }

        let inputArray = inputText.components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        let sortedArray = self.viewModel.sortStringsNaturally(inputArray)
        let resultString = sortedArray.joined(separator: ", ")
        self.resultLabel.text = "\(resultString)"
    }
}

extension SecondAssignmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            self.resultLabel.text = ""
            return true
        }

        var allowedCharacters = CharacterSet.uppercaseLetters
        allowedCharacters.formUnion(.decimalDigits)
        allowedCharacters.formUnion(CharacterSet(charactersIn: ", "))

        let typedCharacterSet = CharacterSet(charactersIn: string)

        return allowedCharacters.isSuperset(of: typedCharacterSet)
    }
}
