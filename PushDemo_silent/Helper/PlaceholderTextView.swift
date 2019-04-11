//
//  PlaceholderTextView.swift
//  OldMe
//
//  Created by PreRit on 05/09/18.
//  Copyright © 2018 Sagar Prajapati (Rogers). All rights reserved.
//

import UIKit


@IBDesignable class UIPlaceholderTextView: UITextView {
    
    var placeholderLabel: UILabel?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshPlaceholder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name:NSNotification.Name(rawValue: "textchange"), object: nil)
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            refreshPlaceholder()
        }
    }
    
    @IBInspectable var placeholderColor: UIColor? = .darkGray {
        didSet {
            refreshPlaceholder()
        }
    }
    
    @IBInspectable var placeholderFontSize: CGFloat = 14 {
        didSet {
            refreshPlaceholder()
        }
    }
    
    func refreshPlaceholder() {
        if placeholderLabel == nil {
            placeholderLabel = UILabel()
            let contentView = self.subviews.first ?? self
            
            contentView.addSubview(placeholderLabel!)
            placeholderLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            placeholderLabel?.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: textContainerInset.left + 4).isActive = true
            placeholderLabel?.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: textContainerInset.right + 4).isActive = true
            placeholderLabel?.topAnchor.constraint(equalTo: contentView.topAnchor, constant: textContainerInset.top).isActive = true
            placeholderLabel?.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: textContainerInset.bottom)
        }
        placeholderLabel?.text = placeholder
        placeholderLabel?.textColor = placeholderColor
        placeholderLabel?.font = UIFont(name: "Raleway-Light", size: self.placeholderFontSize)
    }
    
    @objc func textChanged() {
        if self.placeholder?.isEmpty ?? true {
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            if self.text.isEmpty {
                self.placeholderLabel?.alpha = 1.0
            } else {
                self.placeholderLabel?.alpha = 0.0
            }
        }
    }
    
    override var text: String! {
        didSet {
            textChanged()
        }
    }
    
    @IBInspectable var CornerRadius:CGFloat = 0.0{
        didSet{
            
            self.layer.cornerRadius = self.CornerRadius;
            //self.clipsToBounds = self.CornerRadius > 0
        }
    }
    @IBInspectable var borderColor:UIColor!{
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
}
