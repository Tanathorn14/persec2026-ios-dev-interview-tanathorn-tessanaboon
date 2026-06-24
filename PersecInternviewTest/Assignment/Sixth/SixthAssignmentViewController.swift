//
//  SixthAssignmentViewController.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import UIKit

class SixthAssignmentViewController: UIViewController {

    static let identifier = "SixthAssignmentViewController"

    required init() {
        super.init(nibName: SixthAssignmentViewController.identifier, bundle: Bundle(for: SixthAssignmentViewController.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBOutlet var triboTextfield: UITextField!
    @IBOutlet var resultCountTextfield: UITextField!
    @IBOutlet var resultLabel: UILabel!

    private let viewModel = SixthAssignmentViewModel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupResultLabel()
        self.setupTextfield()
    }

    // MARK: - UserInterface
    private func setupResultLabel() {
        self.resultLabel.text = "Answer =>"
    }

    private func setupTextfield() {
        self.triboTextfield.delegate = self
        self.resultCountTextfield.delegate = self

        self.triboTextfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.resultCountTextfield.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }

    // MARK: - Action
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let signatureText = self.triboTextfield.text ?? ""
        let countText = self.resultCountTextfield.text ?? ""

        guard !signatureText.isEmpty, !countText.isEmpty, let nValue = Int(countText) else {
            self.resultLabel.text = "Answer =>"
            return
        }

        let signatureArray = signatureText.components(separatedBy: ",")
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }

        let resultArray = self.viewModel.generateTribonacci(signature: signatureArray, n: nValue)

        let resultString = resultArray.map { String($0) }.joined(separator: ", ")
        self.resultLabel.text = "Answer => [ \(resultString) ]"
    }
}

extension SixthAssignmentViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }

        if textField == self.triboTextfield {
            let allowedChar = CharacterSet(charactersIn: "0123456789, ")
            let typedChar = CharacterSet(charactersIn: string)
            return allowedChar.isSuperset(of: typedChar)

        } else if textField == self.resultCountTextfield {
            let allowedChar = CharacterSet(charactersIn: "0123456789")
            let typedChar = CharacterSet(charactersIn: string)
            return allowedChar.isSuperset(of: typedChar)
        }

        return true
    }
}
