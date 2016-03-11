//
//  FullNameValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/19/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation


class FullNameValidation : Validation {

    func validate(value:String) -> (Bool, ValidationErrorType) {
        
        let nameArray:[String] = value.characters.split { $0 == " " }.map { String($0) }
        if nameArray.count == 2 {
            return (true, .NoError)
        }
        return (false, .FullName)
    }
}