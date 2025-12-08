
import Foundation
import UIKit


class RecordsViewController: UIViewController {
    
    private let buttonBack: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - конфигурируем UI
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(buttonBack)
        buttonBack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(40)
        }
        
        let backButtonAction = UIAction { _ in
            self.backButtonPressed()
        }
        buttonBack.addAction(backButtonAction, for: .touchUpInside)
        
        
    }
    
    
    
    
    
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
}

