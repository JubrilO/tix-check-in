//
//  StringExtensions.swift
//  Business
//
//  Created by Jubril on 11/13/18.
//  Copyright © 2018 Paystack. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
