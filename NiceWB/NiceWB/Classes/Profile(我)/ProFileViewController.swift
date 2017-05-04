//
//  ProFileViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/23.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class ProFileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitroView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", titleName: "我的资料和信息都在这里修改，如果不能修改就糟糕了，哈哈哈哈哈哈哈😄")

          }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
