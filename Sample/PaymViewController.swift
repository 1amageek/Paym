//
//  PaymViewController.swift
//  Sample
//
//  Created by 1amageek on 2017/09/21.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class PaymViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    lazy var cart: Cart = {
        return Cart(view: self.view)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "PaymViewCell", bundle: nil), forCellReuseIdentifier: "PaymViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension

        let milk: Milk = Milk()

        self.cart.add(milk)
        self.tableView.reloadData()

        let paymView: PaymView = PaymView(rootView: self.view, cart: self.cart)
        self.view.addSubview(paymView)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cart.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaymViewCell = tableView.dequeueReusableCell(withIdentifier: "PaymViewCell", for: indexPath) as! PaymViewCell
        return cell
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
