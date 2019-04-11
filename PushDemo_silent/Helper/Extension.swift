//
//  Extension.swift
//  PushDemo_silent
//
//  Created by Hardik on 11/04/19.
//  Copyright © 2019 HardikDabhi. All rights reserved.
//

import UIKit


func numberOfLines(textView: UITextView) -> Int {
    let layoutManager = textView.layoutManager
    let numberOfGlyphs = layoutManager.numberOfGlyphs
    var lineRange: NSRange = NSMakeRange(0, 1)
    var index = 0
    var numberOfLines = 0
    
    while index < numberOfGlyphs {
        layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
        index = NSMaxRange(lineRange)
        numberOfLines += 1
    }
    return numberOfLines
}

