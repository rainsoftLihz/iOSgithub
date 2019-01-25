//
//  TableTestViewController.swift
//  SwiftT
//
//  Created by rainsoft on 2018/11/30.
//  Copyright © 2018年 jzt. All rights reserved.
//

import UIKit

class TableTestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,choseBackDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIt = "cekkId";
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIt);
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIt);
            cell?.selectionStyle = .none;
        }
        
        cell?.textLabel?.text = String(format: "1222%d", indexPath.row);
        cell?.detailTextLabel?.text = String(format: "1222%d", indexPath.row);
        
        let line : UIView = UIView();
        line.backgroundColor = UIColor.red;
        line.frame = CGRect(x: 22, y: (cell?.frame.size.height)!-0.5, width: UIScreen.main.bounds.width-22 , height: 0.5);
        cell?.addSubview(line);
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let delegateVC : DelegateViewController = DelegateViewController();
        delegateVC.delegate = (self as choseBackDelegate);
        self.present(delegateVC, animated: true,completion: nil);
    }
    
    func choseBack(name: String, passwd: String) {
        print("name:\(name),passwd:\(passwd)")
    }
    
    let header = MJRefreshNormalHeader();
    let footer = MJRefreshAutoNormalFooter();
    let table = UITableView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20), style: .plain);
    override func viewDidLoad() {
        super.viewDidLoad()

        table.separatorStyle = .none;
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.gray;
        self.view.addSubview(table);
        
        table.mj_footer = footer;
        table.mj_header = header;
        
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshHeader));
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(refreshFooter));
    }
    
    @objc func refreshHeader()  {
        
        //延时执行
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.table.mj_header.endRefreshing();
        }
    }

    @objc func refreshFooter()  {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
            self.table.mj_footer.endRefreshingWithNoMoreData();
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
