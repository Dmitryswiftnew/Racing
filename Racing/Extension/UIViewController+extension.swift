
import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: title, style: .default) { _ in  // title в параметр чтоб было универсально 
            onOK?()
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Выйти в главное меню", style: .default)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}





