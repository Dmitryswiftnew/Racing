
import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   okTitle: String = "Restart",
                   onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in  // title в параметр чтоб было универсально
            onOK?()
        }
        
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Back to menu", style: .default) {
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
}





