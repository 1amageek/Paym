//
//  PaymentViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/09.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
    }

    func sizeToFit() -> CGSize {
        self.tableView.reloadData()
        let contentSize: CGSize = self.tableView.contentSize
        self.view.bounds = CGRect(origin: .zero, size: contentSize)
        return contentSize
    }

    // MARK: -

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }

}
