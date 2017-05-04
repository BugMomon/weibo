//
//  HomeViewController.swift
//  NiceWB
//
//  Created by HongWei on 2017/3/23.
//  Copyright © 2017年 HongWei. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    //设置title的按钮
    lazy var titleBtn : Titlebutton = Titlebutton()
    lazy var models : [HomeViewModel] = [HomeViewModel]() // 创建一个存储模型的数组
    var i : Int = 0
    
    //用[weak self] 解决了循环引用
    lazy var titleAnimator :TitleViewAnimator = TitleViewAnimator{[weak self](isPresented) in
        self?.titleBtn.isSelected = isPresented
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置旋转图片动画
        visitroView.addRotationAnimation()
        
        if !islogin {return}
        //设置首页里面的导航栏按钮
        setupHomeNavigationItems()
        
        //请求数据
//        loadRequest()
        
        //设置2个属性为了cell自适应高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        let mj = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.hahah))
        mj?.setTitle("rrrrrrr", for: .idle)
        mj?.setTitle("inininin", for: .refreshing)
        mj?.setTitle("outoutout", for: .noMoreData)
        tableView.mj_header = mj
    }
}

extension HomeViewController{
    func hahah() {
        loadRequest()
    }
}

// MARK:- tableView的delegate
extension HomeViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! HomeViewCell
        let model = models[indexPath.row]
        cell.viewModel = model
        cell.content.text = model.homeStatuses?.text
        
        return cell
    }
}

// MARK:- 请求数据
extension HomeViewController{
    func loadRequest() {
        NetworkTools.shareInstance.loadHomeViewData { (result, error) in
            if let error = error{
                print(error)
                return
            }
            guard let result = result else{
                return
            }
            guard let resultArray = result["statuses"] else{
                return
            }
            for dic in (resultArray as? Array<Any>)!{
                let status = HomeStatuses.init(dict: dic as! [String : AnyObject])
                let model  = HomeViewModel.init(statuses: status)
                self.models.append(model)
            }
            
            //异步缓存下载单张配图
//            self.catch
            //0.创建group
            let sd_group = DispatchGroup()

            for model in self.models{
                for url in model.picUrls!{
                    //1.一旦开始异步操作的时候，进入组
                    sd_group.enter()
                    //缓存图片到内存
                    SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (_, _, _, _, _) in
                    })
                    //2.离开组
                    sd_group.leave()
                    print("下载数据")
                }
            }
            sd_group.notify(queue: DispatchQueue.main, execute: {
                print("刷新表格")
                //3.回到主线程刷新表格
                self.tableView.reloadData()
            })
        }
    }
}

// MARK:- 设置UI
extension HomeViewController{
    
    // MARK:- 设置首页里面的导航栏按钮
    func setupHomeNavigationItems() {
        
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(ImageName: "navigationbar_friendattention")
         navigationItem.rightBarButtonItem =
            UIBarButtonItem(ImageName: "navigationbar_pop")
        
        //设置title按钮
        navigationItem.titleView = titleBtn
        titleBtn.setTitle(UserAccountViewModel.shareInstance.account?.screen_name, for: .normal)
        titleBtn.addTarget(self, action:#selector(titleBtnClick(btn:)), for: .touchUpInside)
    }
}

// MARK:- 点击事件
extension HomeViewController{
    func titleBtnClick(btn:UIButton) {
        
        let titleVc = TitleViewController()
        
        titleVc.modalPresentationStyle = .custom
        titleVc.transitioningDelegate = titleAnimator
        titleAnimator.pvframe = CGRect(x: 135, y: 55, width: 180, height: 250)
        present(titleVc, animated: true, completion: nil)
    }
}


















