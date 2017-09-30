//
//  OrderViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

public class OrderViewController: UIViewController {

    enum Section: Int {
        case card
        case shipping
        case contact
        case payment

        static var values: [Section] {
            return [.card, .shipping, .contact, .payment]
        }

        var text: String {
            switch self {
            case .card: return "カード"
            case .shipping: return "配送先"
            case .contact: return "連絡先"
            case .payment: return "支払い"
            }
        }
    }

    public var cancelBlock: (() -> Void)?

    private(set) lazy var orderView: OrderView = {
        let view: OrderView = OrderView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    @objc func cancel() {
        self.cancelBlock?()
    }

    // MARK: -


    private var window: UIWindow?

    public override func loadView() {
        super.loadView()
        self.view = orderView
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    public override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        guard let view: UIView = parent?.view else { return }
        self.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        self.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        self.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        self.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }

    private func showPaymentViewController() {
        let viewController: PaymentViewController = PaymentViewController()
        viewController.delegate = self
        viewController.dismiss = { [weak self] in
            self?.hidePaymentViewController()
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        self.window?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.view.window?.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
            self.view.window?.alpha = 0.8
            self.window?.transform = .identity
        }
        animator.startAnimation()
    }

    private func hidePaymentViewController() {
        let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.33, dampingRatio: 1) {
            self.view.window?.transform = .identity
            self.view.window?.alpha = 1
            self.window?.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        }
        animator.addCompletion { _ in
            self.window = nil
            self.view.window?.makeKey()
        }
        animator.startAnimation()
    }
}

extension OrderViewController: PaymentDelegate {
    func payment(_ payment: PaymentViewController, card: Card) {
        
    }
}

extension OrderViewController: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return Section.values.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: OrderViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        let section: Section = Section(rawValue: indexPath.section)!
        let title: String = section.text
        cell.titleLabel.text = title
        cell.detailLabel.text = "aweoifjapwoeifjawpoejfaopweijfpaowijefpaowiejfpaowiefjapwoeifjapwoiejfapoewifjapwoeifjapwoiefjpawoiefjapwoeijfpa"
        cell.backgroundView = nil
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }
}

extension OrderViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .card:
            self.showPaymentViewController()
        case .shipping: return
        case .contact: return
        case .payment: return
        }
    }
}
