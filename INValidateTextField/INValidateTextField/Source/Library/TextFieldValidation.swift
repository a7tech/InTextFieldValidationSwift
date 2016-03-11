
import Foundation



//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class EmailValidation: Validation {
    
    let EMAIL_REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    
    func validate(value:String) -> (Bool, ValidationErrorType) {
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
        if emailTest.evaluateWithObject(value) {
            return (true, .NoError)
        }
        return (false, .Email)
    }
}

//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class FullNameValidation : Validation {
    
    func validate(value:String) -> (Bool, ValidationErrorType) {
        
        let nameArray:[String] = value.characters.split { $0 == " " }.map { String($0) }
        if nameArray.count == 2 {
            return (true, .NoError)
        }
        return (false, .FullName)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class MaxLengthValidation: Validation {
    let DEFAULT_MAX_LENGTH = 10
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if value.characters.count > DEFAULT_MAX_LENGTH {
            return (false, .MaxLength)
        }
        return (true, .NoError)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class MinLengthValidation: Validation {
    let DEFAULT_MIN_LENGTH = 5
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        if value.characters.count < DEFAULT_MIN_LENGTH {
            return (false, .MinLength)
        }
        return (true, .NoError)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class PasswordValidation : Validation {
    
    // Alternative Regexes
    
    // 8 characters. One uppercase. One Lowercase. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).{8,}$"
    //
    // no length. One uppercase. One lowercae. One number.
    // var PASSWORD_REGEX = "^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[a-z]).*?$"
    
    // 8 characters. one uppercase
    var PASSWORD_REGEX = "^(?=.*?[A-Z]).{8,}$"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        let passwordTes = NSPredicate(format: "SELF MATCHES %@", PASSWORD_REGEX)
        if passwordTes.evaluateWithObject(value) {
            return (true, .NoError)
        }
        return (false, .Password)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class PhoneNumberValidation: Validation {
    let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
    
    func validate(value: String) -> (Bool, ValidationErrorType) {
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        if phoneTest.evaluateWithObject(value) {
            return (true, .NoError)
        }
        return (false, .PhoneNumber)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class RequiredValidation: Validation {
    
    func validate(value:String) -> (Bool, ValidationErrorType) {
        if value.isEmpty {
            return (false, .Required)
        }
        return (true, .NoError)
    }
}
//********************************************************************************************************************************************
// MARK: ViewWillAppear
//********************************************************************************************************************************************

class ZipCodeValidation: Validation {
    
    let ZIP_REGEX = "\\d{5}"
    func validate(value: String) -> (Bool, ValidationErrorType) {
        let zipTest = NSPredicate(format: "SELF MATCHES %@", ZIP_REGEX)
        if zipTest.evaluateWithObject(value) {
            return (true, .NoError)
        }
        return (false, .ZipCode)
    }
}