//
//  MinLengthValidation.swift
//  Pingo
//
//  Created by Jeff Potter on 11/11/14.
//  Copyright (c) 2014 Byron Mackay. All rights reserved.
//

import Foundation

class MinLengthValidation: Validation {
    let DEFAULT_MIN_LENGTH = 5
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if value.characters.count < DEFAULT_MIN_LENGTH {
            return (false, .MinLength)
        }
        return (true, .NoError)
    }
}