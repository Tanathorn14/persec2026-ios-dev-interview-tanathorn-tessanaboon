//
//  ViewController.swift
//  PersecInternviewTest
//
//  Created by Tanathorn Tessanaboon on 23/6/2569 BE.
//

import UIKit

class ViewController: UIViewController {

    private let segmentedControl: UISegmentedControl = {
        let items = ["No.1", "No.2", "No.3", "No.4", "No.5", "No.6"]
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .systemGray6
        sc.selectedSegmentTintColor = .systemBlue

        sc.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        sc.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)

        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var questionViewControllers: [UIViewController] = []
    private var currentChildVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Logic Interview Test"

        self.setupLayout()
        self.setupTarget()
        self.initQuestionViewControllers()

        self.switchToViewController(at: 0)
    }

    private func setupLayout() {
        self.view.addSubview(segmentedControl)
        self.view.addSubview(containerView)

        NSLayoutConstraint.activate([
            self.segmentedControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            self.segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            self.segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 40),

            // ให้ Container View กินพื้นที่ที่เหลือทั้งหมดด้านล่าง
            self.containerView.topAnchor.constraint(
                equalTo: self.segmentedControl.bottomAnchor,
                constant: 10
            ),
            self.containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupTarget() {
        self.segmentedControl.addTarget(self, action: #selector(self.segmentChanged(_:)), for: .valueChanged)
    }

    // 4. ผูกคลาสย่อยทั้ง 6 เข้ากับ Array
    private func initQuestionViewControllers() {
        self.questionViewControllers = [
            FirstAssignmentViewController()
//            Question2ViewController(),
//            Question3ViewController(),
//            Question4ViewController(),
//            Question5ViewController(),
//            Question6ViewController(),
        ]
    }

    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        self.switchToViewController(at: sender.selectedSegmentIndex)
    }

    // 5. ระบบสลับหน้าจอ Child View Controller
    private func switchToViewController(at index: Int) {
        let targetVC = self.questionViewControllers[index]

        if self.currentChildVC == targetVC { return }

        if let previousVC = self.currentChildVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }

        addChild(targetVC)
        targetVC.view.frame = self.containerView.bounds
        targetVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.containerView.addSubview(targetVC.view)
        targetVC.didMove(toParent: self)

        self.currentChildVC = targetVC
    }
}
