//
//  OrderViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/14.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cancelBlock: (() -> Void)?

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.backgroundView = self.backgroundView
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return view
    }()

    private(set) lazy var backgroundView: UIVisualEffectView = {
        let view: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        view.frame = self.view.frame
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .clear
        self.view.addSubview(tableView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    }

    override func viewDidLayoutSubviews() {
        self.backgroundView.frame = self.view.bounds
    }

    @objc func cancel() {
        self.cancelBlock?()
    }

    // MARK: -

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = "aaa"
        cell.backgroundView = nil
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: PaymentViewController = PaymentViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
