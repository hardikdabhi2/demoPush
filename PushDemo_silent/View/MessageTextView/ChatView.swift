//
//  ChatView.swift
//  PushDemo_silent
//
//  Created by Hardik on 11/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit

class ChatView: UIView,UITextViewDelegate {
    @IBOutlet weak var tv_message:UITextView!
    @IBOutlet weak var toolbar:UIToolbar!
    
    //This is for textview
    var previousRect = CGRect.zero
    
    func loadView()->ChatView{
        return  (Bundle.main.loadNibNamed("ChatView", owner: self, options: nil)![0] as? ChatView)!
    }
    
    func initView(withFrame frame:CGRect){
        self.frame = frame
        self.tv_message.inputAccessoryView = self.toolbar
        self.tv_message.delegate = self
    }
    
    @IBAction func btnActionDone(_ sender:UIButton)
    {
        self.tv_message.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        var count = numberOfLines(textView:self.tv_message!)
        
        
        //Detect new line in text view
        if(text == "\n"){
            count = count + 1
        }
        
        if(count >= 3 && count >= 2)
        {
            let data:[String: Int] = ["count": count]
            NotificationCenter.default.post(name: Notification.Name("setViewHeight"), object:data)
        }
        if(text == "")
        {
            if(count > 1)
            {
            let data:[String: Int] = ["count": count]
            NotificationCenter.default.post(name: Notification.Name("setViewHeight"), object:data)
            }
        }
        
        return true
    }
    
 
    
}



