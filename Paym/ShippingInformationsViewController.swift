//
//  ShippingInformationsViewController.swift
//  Paym
//
//  Created by 1amageek on 2017/07/20.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class ShippingInformationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private(set) lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: self.view.bounds, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.estimatedRowHeight = UITableViewAutomaticDimension
        view.register(UINib(nibName: "ShippingInformationsViewCell", bundle: nil), forCellReuseIdentifier: "ShippingInformationsViewCell")
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShippingInformationsViewCell = tableView.dequeueReusableCell(withIdentifier: "ShippingInformationsViewCell", for: indexPath) as! ShippingInformationsViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }

}
