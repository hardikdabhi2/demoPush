//
//  ListViewController.swift
//  PushDemo_silent
//
//  Created by Hardik on 11/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func BtnActionBack(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated:true)
    }
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UserListCell"
        
        var cell:UserListCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? UserListCell
        if cell == nil{
            let nib:[Any] = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)!
            cell = (nib[0] as! UserListCell)
        }
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let SB = UIStoryboard.init(name: "Main", bundle: nil)
            let messageVc = SB.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(messageVc, animated: true)
    }
}
