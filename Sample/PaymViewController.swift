//
//  PaymViewController.swift
//  Sample
//
//  Created by 1amageek on 2017/09/21.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class PaymViewController: UITableViewController {

    var cart: Cart = Cart()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cart.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }

}
