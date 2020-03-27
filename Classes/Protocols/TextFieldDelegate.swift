import UIKit

@objc
public protocol TextFieldDelegate: NSObjectProtocol {
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldBeginEditing(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidBeginEditing(_ textField: TextField)
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldEndEditing(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldDidEndEditing(_ textField: TextField)
    
    @objc @available(iOS 10.0, *)
    optional func textFieldDidEndEditing(_ textField: TextField, reason: TextField.DidEndEditingReason)
    
    @objc @available(iOS 2.0, *)
    optional func textField(_ textField: TextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldClear(_ textField: TextField) -> Bool
    
    @objc @available(iOS 2.0, *)
    optional func textFieldShouldReturn(_ textField: TextField) -> Bool
}
