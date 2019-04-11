//
//  ChatViewController.swift
//  PushDemo_silent
//
//  Created by Hardik on 11/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit

struct Message {
    var message:String?
    var id:Int
}

class ChatViewController: UIViewController {
    
    var arrayMessageList = [Message]()
    var chatview  = ChatView()
    var keyboardHeigh = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
            self.arrayMessageList = [
                        Message.init(message: "sdhsad", id:0),
                        Message.init(message: "sd hsad", id:1),
                        Message.init(message: "sd hsad sad asdh a asdh asdhsa asdh asdh asd ", id:2),
                        Message.init(message: "sdhsad asdh as ehwawae wqe qwe", id:3),
                        Message.init(message: "sd wqeh qwe qwh hsad", id:4),
                        Message.init(message: "s wq pwque qwe dhsad", id:5),
                        Message.init(message: "sdhs wqe uqw ad", id:6),
                        Message.init(message: "s we wqe dhsad", id:7),
                        Message.init(message: "s we qwq dhsad", id:8),
                        Message.init(message: "sdh wqw eqwe qw sad", id:9),
                        Message.init(message: "sdh wqw eqwe qw sad sadh aklshdklasghd lasdlasdg las ldasgasasd galgaelw ", id:10),
                        Message.init(message: "sdh wqw eqwe qw sad sadh aklshdklasghd lasdlasdg las ldasgasasd galgaelw,sdh wqw eqwe qw sad sadh aklshdklasghd lasdlasdg las ldasgasasd galgaelw", id:11),
                                        ]
        // Do any additional setup after loading the view.
        self.chatview  = ChatView().loadView()
        self.chatview.initView(withFrame:CGRect(x: 0, y:self.view.frame.height-50, width:self.view.frame.width, height: 50))
        self.view.addSubview(self.chatview)
        
//        self.chatview.tv_message.inputAccessoryView = self.toolBar
        
//        self.chatview.initView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setViewHeight(notification:)), name: Notification.Name("setViewHeight"), object: nil)

        
    }
    
    //MARK: - Observer Methods
    
    @objc func setViewHeight(notification: Notification) {
        // Take Action on Notification
        print(notification)
        
        if let dict = notification.object as! NSDictionary? {
            if let count = dict["count"] as? Int{
                print("Count is :===>",count)
                if(count<=3){self.setHeight(count: count)}
            }
        }
    }
    
    private func setHeight(count:Int){
        let finalHeight = CGFloat((count*30))
        self.chatview.frame = CGRect(x: 0, y:self.view.frame.height - (finalHeight + CGFloat(self.keyboardHeigh)), width:self.view.frame.width, height: finalHeight)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show",keyboardSize.height)
            
            self.keyboardHeigh = Int(keyboardSize.height)
                
            self.chatview.frame = CGRect(x: 0, y:self.view.frame.height-(keyboardSize.height+50), width:self.view.frame.width, height: 50)
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.keyboardHeigh = 0
            self.chatview.frame = CGRect(x: 0, y:self.view.frame.height-50, width:self.view.frame.width, height: 50)
        }
    }
    
    
    @IBAction func btnActionHide(_ sender:UIButton)
    {
      self.chatview.tv_message.resignFirstResponder()
    }


    func estimatedHeightOfLabel(text: String) -> CGFloat {
        
        let size = CGSize(width: (view.frame.width / 2) - 18, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let height = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        print("Estimate height is",height)
        if(height <= 20){
            return 45
        }
        else{
        return height + 45
        }
    }
    @IBAction func BtnActionBack(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated:true)
    }
}


extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMessageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "MessageListCell"
        
        var cell:MessageListCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? MessageListCell
        if cell == nil{
            let nib:[Any] = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)!
            cell = (nib[0] as! MessageListCell)
        }
        cell?.selectionStyle = .none
        if(indexPath.row % 2 == 0){
            cell?.viewSender.isHidden = true
            cell?.viewReceiver.isHidden = false
            cell?.labelReceive.text! = self.arrayMessageList[indexPath.row].message!
        }
        else{
            cell?.viewReceiver.isHidden = true
            cell?.viewSender.isHidden = false
            cell?.labelSend.text! = self.arrayMessageList[indexPath.row].message!
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.estimatedHeightOfLabel(text:self.arrayMessageList[indexPath.row].message!)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

