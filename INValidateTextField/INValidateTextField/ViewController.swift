


import UIKit



struct MoveKeyboard {
    static let KEYBOARD_ANIMATION_DURATION : CGFloat = 0.3
    static let MINIMUM_SCROLL_FRACTION : CGFloat = 0.2;
    static let MAXIMUM_SCROLL_FRACTION : CGFloat = 0.8;
    static let PORTRAIT_KEYBOARD_HEIGHT : CGFloat = 216;
    static let LANDSCAPE_KEYBOARD_HEIGHT : CGFloat = 162;
}


class ViewController: UIViewController,UITextFieldDelegate,ValidationFieldDelegate,UIAlertViewDelegate {

    //************************************************************************************************
    // MARK: Create Outlets and Proprty.
    //************************************************************************************************
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var DateofBirth: UITextField!
    @IBOutlet weak var MobileNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var Cpassword: UITextField!
    @IBOutlet weak var DOB: UIDatePicker!
    @IBOutlet weak var emailID: UITextField!

    var animateDistance:CGFloat!
    var validator = Validator()
    var databasePath = NSString()
    var Fields = ["Email","Phone","Password","Cpassword","UserID","fname","Lname","dob"]

    
    //*************************************************************************************************
    // MARK: viewDidLoad
    //*************************************************************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }


    func setUpUI(){

        emailID.delegate = self
        MobileNo.delegate = self
        password.delegate = self
        Cpassword.delegate = self
        UserName.delegate = self
        firstName.delegate = self
        LastName.delegate = self
        DateofBirth.delegate = self
        
        // MARK: Apply Validation on textfield.
        
        validator.registerFieldByKey(Fields[0],textField: emailID,rules: [.Required, .Email])
        
        validator.registerFieldByKey(Fields[1],textField: MobileNo,rules: [.Required, .PhoneNumber])
        
        validator.registerFieldByKey(Fields[2],textField: password,rules: [.Required, .Password])
        
        validator.registerFieldByKey(Fields[3],textField: Cpassword,rules: [.Required, .Password])
        
        validator.registerFieldByKey(Fields[4],textField: UserName,rules: [.Required, .MinLength])
        
        validator.registerFieldByKey(Fields[5],textField: firstName,rules: [.Required, .MaxLength])
        
        validator.registerFieldByKey(Fields[6],textField: LastName,rules: [.Required, .MaxLength])

    }
    
    //*************************************************************************************************
    // MARK: Use datePicker for valueChanged on textField.
    //*************************************************************************************************
    @IBAction func dobtext(sender: UITextField)
    {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    func handleDatePicker(sender: UIDatePicker)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        DateofBirth.text = dateFormatter.stringFromDate(sender.date)
    }
    //**************************************************************************************************
    // MARK: TextField Delegate Method For Moving Keyboard.
    //**************************************************************************************************
    func textFieldDidBeginEditing(textField: UITextField) {
        let textFieldRect : CGRect = self.view.window!.convertRect(textField.bounds, fromView: textField)
        let viewRect : CGRect = self.view.window!.convertRect(self.view.bounds, fromView: self.view)
        let midline : CGFloat = textFieldRect.origin.y + 0.5 * textFieldRect.size.height
        let numerator : CGFloat = midline - viewRect.origin.y - MoveKeyboard.MINIMUM_SCROLL_FRACTION * viewRect.size.height
        let denominator : CGFloat = (MoveKeyboard.MAXIMUM_SCROLL_FRACTION - MoveKeyboard.MINIMUM_SCROLL_FRACTION) * viewRect.size.height
        var heightFraction : CGFloat = numerator / denominator
        
        if heightFraction < 0.0 {
            heightFraction = 0.0
        } else if heightFraction > 1.0 {
            heightFraction = 1.0
        }
        let orientation : UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        if (orientation == UIInterfaceOrientation.Portrait || orientation == UIInterfaceOrientation.PortraitUpsideDown) {
            animateDistance = floor(MoveKeyboard.PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        } else {
            animateDistance = floor(MoveKeyboard.LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y -= animateDistance
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(NSTimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    func textFieldDidEndEditing(textField: UITextField) {
        var viewFrame : CGRect = self.view.frame
        viewFrame.origin.y += animateDistance
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(NSTimeInterval(MoveKeyboard.KEYBOARD_ANIMATION_DURATION))
        self.view.frame = viewFrame
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func DismissKeyboard(){
        emailID.resignFirstResponder()
        MobileNo.resignFirstResponder()
        UserName.resignFirstResponder()
        UserName.resignFirstResponder()
        LastName.resignFirstResponder()
        password.resignFirstResponder()
        Cpassword.resignFirstResponder()
        
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            emailID.resignFirstResponder()
            MobileNo.resignFirstResponder()
            UserName.resignFirstResponder()
            UserName.resignFirstResponder()
            LastName.resignFirstResponder()
            password.resignFirstResponder()
            Cpassword.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    //*******************************************************************************************************************************************//
                                                        // MARK: Validation Delegate Function.
    //*******************************************************************************************************************************************//
 
    func validationFieldFailed(key:String, error:ValidationError)
    {
        //set error textfield border to red.
        _ = UITextField(frame: CGRectMake(0.0, 0.0, 200.0, 44.0))
        error.textField.layer.cornerRadius = 8.0
        error.textField.layer.masksToBounds = true
        error.textField.layer.borderColor = UIColor.redColor().CGColor
        error.textField.layer.borderWidth = 2.0
        error.textField
    }
    
    func validationFieldSuccess(key:String, validField:UITextField)
    {
        //set valid textfield border to green
        _ = UITextField(frame: CGRectMake(0.0, 0.0, 200.0, 44.0))
        validField.layer.cornerRadius = 8.0
        validField.layer.masksToBounds = true
        validField.layer.borderColor = UIColor.greenColor().CGColor
        validField.layer.borderWidth = 2.0
        validField
    }
    @IBAction func validateField(sender: AnyObject)
    {
        switch (sender as! UITextField)
        {
        case emailID :
            validator.validateFieldByKey((Fields[0]), delegate: self)
            break
        case MobileNo :
            validator.validateFieldByKey((Fields[1]), delegate: self)
            break
        case password :
            validator.validateFieldByKey((Fields[2]), delegate: self)
            break
        case Cpassword :
            validator.validateFieldByKey((Fields[3]), delegate: self)
            break
        case UserName :
            validator.validateFieldByKey((Fields[4]), delegate: self)
            break
        case firstName :
            validator.validateFieldByKey((Fields[5]), delegate: self)
            break
        case LastName :
            validator.validateFieldByKey((Fields[6]), delegate: self)
            break
        default :
            print("no fields to validate")
        }
    }
    @IBAction func SubmitAction(sender: AnyObject)
        
    {
        if (firstName == nil || firstName.text == "")
        {
            validator.validateFieldByKey(Fields[5], delegate: self)
            let alert = UIAlertView(title: "Error", message: "Please Enter Your First Name", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
            
        else if (LastName == nil || LastName.text == "")
        {   validator.validateFieldByKey(Fields[6], delegate: self)
            let alertview = UIAlertView(title: "Error", message: "Please Enter Your Last Name", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else if (UserName == nil || UserName.text == "")
        {
            validator.validateFieldByKey(Fields[4], delegate: self)
            let alertview = UIAlertView(title: "Error", message: "UserID Short Should be 5 Char. ", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else if (MobileNo == nil || MobileNo.text == "")
        {
            validator.validateFieldByKey(Fields[1], delegate:self)
            let alertview = UIAlertView(title: "Error", message: "Please Enter Mobile No. and must be 10 digit ", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else if (emailID == nil || emailID.text == "")
        {
            validator.validateFieldByKey(Fields[0], delegate:self)
            let alertview = UIAlertView(title: "Error", message: "Please Enter Your Email Address", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else if (password == nil || password.text == "")
        {    validator.validateFieldByKey(Fields[2], delegate: self)
            let alertview = UIAlertView(title: "Error", message: "Please Enter Your Password ", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else  if (Cpassword == nil || Cpassword.text == "")
        {    validator.validateFieldByKey(Fields[3], delegate: self)
            let alertview = UIAlertView(title: "Error", message: "Please Enter Confirm Password ", delegate: self, cancelButtonTitle: "ok")
            alertview.show()
        }
        else if(password.text != Cpassword.text)
        {
            let alert = UIAlertView(title: "Alert", message: "Password And Confirm Password Should Be Same", delegate: self, cancelButtonTitle: "Cancel",otherButtonTitles: "Ok")
            alert.show()
            password.text = ""
            Cpassword.text = ""
        }
        else{
            
        }
    }
}

