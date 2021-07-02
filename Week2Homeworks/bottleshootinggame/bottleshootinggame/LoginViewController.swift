//
//  LoginViewController.swift
//  bottleshootinggame
//
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    var backgroundView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "login");
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        return imageView
    }();
     lazy var nickNameField: UITextField = {
            let textField = Utilities.textField(withPlaceHolder: "Nickname")
            textField.textAlignment = .center
            textField.autocapitalizationType = .none
            textField.textColor = UIColor.red;
            return textField;
    }()
    
    let startButton : UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("START", for: .normal);
        button.setTitleColor(UIColor.red, for: .normal);
        button.backgroundColor = .none
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20);
         button.addTarget(self, action: #selector(handleStartGame), for: .touchUpInside);
        
       
        return button;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        
        backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true;
        backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true;
        backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true;
        backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true;
        let stackView = UIStackView(arrangedSubviews : [nickNameField, startButton]);
       
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        stackView.axis = .vertical;
        stackView.distribution = .fillEqually
        stackView.spacing = 10;
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.widthAnchor.constraint(equalToConstant: 200)
            
            
        ])
    }
    @objc func handleStartGame(){
        let senderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "gameVC") as! ViewController;
        senderVC.modalPresentationStyle = .fullScreen
        let name = nickNameField.text;
        if let nickName = name , nickName.count > 0 {
            senderVC.nickName = nickName;
            present(senderVC, animated: true, completion: nil);
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Nickname cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}
