//
//  FirstAssignmentViewController.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import UIKit

class FirstAssignmentViewController: UIViewController {

    static let identifier = "FirstAssignmentViewController"

    required init() {
        super.init(nibName: FirstAssignmentViewController.identifier, bundle: Bundle(for: FirstAssignmentViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var textfield: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    private let viewModel = FirstAssignmentViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfield()
    }

    // MARK: - UserInterface
    private func setupTextfield() {
        self.textfield.delegate = self
        self.textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    // MARK: - Action

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let inputText = textField.text, !inputText.isEmpty else {
            return
        }

        let isValid = self.viewModel.checkValue(inputText)

        if isValid {
            self.resultLabel.text = "True"
        } else {
            self.resultLabel.text = "False"
        }
    }
}

extension FirstAssignmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            self.resultLabel.text = ""
            return true
        }

        let allowedCharacters = CharacterSet(charactersIn: "()[]{}")
        let typedCharacterSet = CharacterSet(charactersIn: string)

        return allowedCharacters.isSuperset(of: typedCharacterSet)
    }
}
