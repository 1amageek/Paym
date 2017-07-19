//
//  OrderViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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

    var cancelBlock: (() -> Void)?

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.backgroundView = self.backgroundView
        view.contentInset = UIEdgeInsetsMake(0, 0, 56, 0)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return view
    }()

    private(set) lazy var backgroundView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = self.view.frame
        return view
    }()

    private(set) lazy var paymentButtonView: PaymentButtonView = {
        let view: PaymentButtonView = PaymentButtonView()
        view.paymentBlock = {

        }
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .clear
        self.view.addSubview(tableView)
        self.view.addSubview(paymentButtonView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    override func viewDidLayoutSubviews() {
        self.backgroundView.frame = self.view.bounds
    }

    @objc func cancel() {
        self.cancelBlock?()
    }

    func calculateSize() -> CGSize {
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        var contentSize: CGSize = self.tableView.contentSize
        contentSize.height += self.navigationController?.navigationBar.bounds.height ?? 0
        contentSize.height += 56
        return contentSize
    }

    // MARK: -

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.values.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let title: String = Section(rawValue: indexPath.section)!.text
        cell.textLabel?.text = title
        cell.backgroundView = nil
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: PaymentViewController = PaymentViewController()
        //self.navigationController?.pushViewController(viewController, animated: true)
        self.present(viewController, animated: true, completion: nil)
    }

}
