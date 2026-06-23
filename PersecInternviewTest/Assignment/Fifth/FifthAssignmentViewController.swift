//
//  FifthAssignmentViewController.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import UIKit

class FifthAssignmentViewController: UIViewController {

    static let identifier = "FifthAssignmentViewController"

    required init() {
        super.init(nibName: FirstAssignmentViewController.identifier, bundle: Bundle(for: FirstAssignmentViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var textfield: UITextField!
    @IBOutlet var resultLabel: UILabel!

    private var viewModel = FifthAssignmentViewModel()

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
        guard let text = textField.text, !text.isEmpty, let number = Int(text) else {
            return
        }

        let intValue = self.viewModel.sortNumber(number)

        self.resultLabel.text = "\(intValue)"
    }
}

extension FifthAssignmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            self.resultLabel.text = ""
            return true
        }

        let allowedChar = CharacterSet(charactersIn: "0123456789")
        let typedChar = CharacterSet(charactersIn: string)

        return allowedChar.isSuperset(of: typedChar)
    }
}
