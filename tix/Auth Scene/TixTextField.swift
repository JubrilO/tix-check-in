//
//  TixTextField.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class TixTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderStyle = .none
        layer.cornerRadius = 5
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    let padding = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.newBounds(bounds)
    }
    
    fileprivate func newBounds(_ bounds: CGRect) -> CGRect {
        
        var newBounds = bounds
        newBounds.origin.x += padding.left
        newBounds.origin.y += padding.top
        newBounds.size.height -= padding.top + padding.bottom
        newBounds.size.width -= padding.left + padding.right
        return newBounds
    }
}
