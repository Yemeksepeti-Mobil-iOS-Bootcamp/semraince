import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        setupMiddleButton()
        self.tabBar.barTintColor = .systemGreen
        self.tabBar.tintColor = .green
        self.navigationController?.navigationBar.isHidden = true;
       
    }
    
    
    func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width/2) - 30, y: -25, width: 60, height: 60))
        middleButton.setBackgroundImage(UIImage(named: "forest"), for: .normal)
        self.tabBar.addSubview(middleButton)
        middleButton.addTarget(self, action: #selector(middleButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
    }
    
    @objc func middleButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
}
