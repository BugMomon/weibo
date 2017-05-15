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
    let tip = UILabel()
    
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
        //添加提示label
        setupTipLabel()
        
        //请求数据
//        loadRequest()
        
        //设置2个属性为了cell自适应高度
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        creatMjHeat()
        creatMjFooter()
        
    }
}

// MARK:- 下拉上拉更新
extension HomeViewController{
    func creatMjHeat() {
        let mjRefresh = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeViewController.loadNewStatuses))
        mjRefresh?.setTitle("下拉刷新", for: .idle)
        mjRefresh?.setTitle("正在刷新", for: .refreshing)
        mjRefresh?.setTitle("刷新完成", for: .noMoreData)
        tableView.mj_header = mjRefresh
        mjRefresh?.beginRefreshing()
    }
    
    func creatMjFooter() {
        let mjFooter = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction:#selector(HomeViewController.loadMoreStatuses))
        tableView.mj_footer = mjFooter
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
    
    // MARK:- 下拉刷新新的数据
    func loadNewStatuses() {
        loadRequest(isNewStatus: true)
    }
    // MARK:- 下拉加载更多
    func loadMoreStatuses() {
        print("loadMore")
        loadRequest(isNewStatus: false)
    }
    
    func loadRequest(isNewStatus : Bool) {
        //如果是下拉刷新
        var  since_id = 0
        var  max_id   = 0
        if isNewStatus {
            since_id = models.first?.homeStatuses?.mid ?? 0
        }else{
            max_id = models.last?.homeStatuses?.mid ?? 0
            max_id = max_id == 0 ? 0 : max_id - 1
        }
        
        NetworkTools.shareInstance.loadHomeViewData(since_id: since_id, max_id: max_id) { (result, error) in
            if let error = error{
                print(error)
                return
            }
            guard let resultArray = result else{
                return
            }
            var tempStatusArray = [HomeViewModel]()
            for dic in resultArray{
                let status = HomeStatuses.init(dict: dic )
                let model  = HomeViewModel.init(statuses: status)
                tempStatusArray.append(model)//需要在这里拼接model
            }
            //如果是新数据就添加到最上层  如果不是就放在数据的最后面
            if isNewStatus{
                self.models = tempStatusArray + self.models
            }else{
                self.models += tempStatusArray
            }
            
            //异步缓存下载单张配图
            //self.catch
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
//                    print("下载数据")
                }
            }
            sd_group.notify(queue: DispatchQueue.main, execute: {
//                print("刷新表格")
                //3.回到主线程刷新表格
                self.tableView.reloadData()
                
                //结束刷新
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                
                //展示更新提示条目
                
                let weiboCount = resultArray.count
                self.showTipLabel(count: weiboCount)
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
    
    //添加label提示
    func setupTipLabel() {
        
        navigationController?.navigationBar.insertSubview(tip, belowSubview: (navigationController?.navigationBar)!)
        tip.frame = CGRect(x: 0, y: 10, width: self.view.bounds.width, height: 32)
        tip.backgroundColor = UIColor.orange
        tip.textColor = UIColor.white
        tip.textAlignment = .center
        tip.font = UIFont.boldSystemFont(ofSize: 13)
        tip.isHidden = true
    }
    
    //展示
    func showTipLabel(count : Int){
        self.tip.text = count == 0 ? ("没有新数据") : ("更新了\(count)条微博")
        UIView.animate(withDuration: 1.0, animations: {
            self.tip.isHidden = false
            self.tip.frame.origin.y = 44
        }, completion: { (j) in
            UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseInOut, animations: {
                self.tip.frame.origin.y = 10
            }, completion: { (j) in
                self.tip.isHidden = true
            })
        })
        
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


















