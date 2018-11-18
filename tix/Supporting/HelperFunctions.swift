//
//  HelperFunctions.swift
//  Business
//
//  Created by Jubril on 11/8/18.
//  Copyright © 2018 Paystack. All rights reserved.
//

import Foundation

func delay(_ delay: Double, closure: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
