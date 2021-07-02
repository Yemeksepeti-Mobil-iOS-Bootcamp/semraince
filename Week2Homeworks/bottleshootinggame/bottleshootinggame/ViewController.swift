//
//  ViewController.swift
//  bottleshootinggame
//
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let  ballView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "baby");
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFit;
        return imageView;
    }();
    
    let scoreView: UIImageView = {
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "score-1");
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFit;
        return imageView;
    }();
    
    let carriageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "carriage (1)");
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFit;
        return imageView;
    }();
    
    let nickNameView: UIImageView = {
        let imageView = UIImageView();
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "number");
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFit;
        return imageView;
    }();
    
    var bottleView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "wine-bottle");
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var collisionAnimation: UIImageView = {
        let imageView = UIImageView();
        //imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = #imageLiteral(resourceName: "explosion-14272");
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView();
        imageView.image = #imageLiteral(resourceName: "background");
        imageView.contentMode = .scaleToFill
        return imageView
    }();
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "0"
        return label
    }();
    var nicknameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label
    }();
    
    var collisonCounter = 0;
    var speedPointLabel = UILabel();
    var anglePointLabel = UILabel();
    var locationPointLabel = UILabel();
    let speedSlider = UISlider();
    let angleSlider = UISlider();
    let locationSlider = UISlider();
    var screenHeight:CGFloat = 0.0;
    let actionButton = UIButton();
    
    lazy var collisionNames : [String] = ["explosion-14105", "explosion-14272", "explosion-14273"];

    var gameTimer: Timer?
    var animationTimer: Timer?
    var ballOriginXPosition = 10.0;
    var ballOriginYPosition = 0.0;
    var time = 0.008;
    var velocityX = 0.0;
    var velocityY = 0.0;
    var xPosition = 0.0
    var yPosition = 0.0;
    var carriageAngle = 0.0
    var carriageVelocity = 50
    var bottlePosition = 100.0
    var bottleDelta = 0.1;
    var totalScore = 0;
    var isCollided = false;
    var nickName = "";
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        configureUI();
    }
    func configureUI(){
        let screenRect = UIScreen.main.bounds
        nicknameLabel.text = nickName;
        screenHeight = screenRect.size.height + screenRect.origin.y
        view.addSubview(imageView)
        view.addSubview(carriageView);
        view.addSubview(scoreView);
        view.addSubview(nickNameView);
        view.addSubview(scoreLabel);
        view.addSubview(nicknameLabel);
        view.addSubview(bottleView);
        
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
        scoreView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true;
        scoreView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true;
        nickNameView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true;
        nickNameView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true;
        scoreView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true;
        scoreLabel.text = "0";
        //carriageView.image = carriageView.image?.rotated(CGFloat(-90))
        carriageView.frame = CGRect(x: 10, y: Double(screenHeight) - 150, width: 100  , height: 100 )
        bottleView.frame = CGRect(x: bottlePosition, y: Double(screenHeight) - 150,  width:80, height: 80);
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false;
        scoreLabel.topAnchor.constraint(equalTo: scoreView.topAnchor, constant: 5).isActive = true;
        scoreLabel.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor, constant: 0).isActive = true;
        scoreLabel.bottomAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: -5).isActive = true;
        scoreLabel.text = "0"
        scoreLabel.numberOfLines = 0;
        scoreLabel.font = UIFont(name: "Helvetica-Bold", size: 25 );
        scoreLabel.textColor = .white;
        nicknameLabel.topAnchor.constraint(equalTo: nickNameView.topAnchor, constant: 5).isActive = true;
        nicknameLabel.centerXAnchor.constraint(equalTo: nickNameView.centerXAnchor, constant: 0).isActive = true;
        nicknameLabel.bottomAnchor.constraint(equalTo: nickNameView.bottomAnchor, constant: -5).isActive = true;
       nicknameLabel.numberOfLines = 0;
       nicknameLabel.font = UIFont(name: "Helvetica-Bold", size: 25 );
       nicknameLabel.textColor = .white;
        
        
        
        speedSlider.addTarget(self, action: #selector(speedSliderValueDidChange(_:)), for: .valueChanged)
        let speedStackView = createHorizontalStackView(name: "Speed", minPoint: 0, maxPoint: 100, tintColor: UIColor.red, labelSlider: speedSlider, labelPoint: speedPointLabel);
        angleSlider.addTarget(self, action: #selector(angleSliderValueDidChange(_:)), for: .valueChanged)
        let scoreStackView = createHorizontalStackView(name: "Angle", minPoint: 0, maxPoint: 90, tintColor: UIColor.blue , labelSlider: angleSlider, labelPoint: anglePointLabel);
        locationSlider.addTarget(self, action: #selector(locationSliderValueDidChange(_:)), for: .valueChanged)
       
        let locationStackView = createHorizontalStackView(name: "Location", minPoint: 0, maxPoint: 1500, tintColor: UIColor.purple, labelSlider: locationSlider, labelPoint: locationPointLabel);
        
        actionButton.setBackgroundImage(UIImage(named: "button"), for: .normal)
        actionButton.setTitle("Throw", for: .normal);
        actionButton.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        actionButton.addTarget(self, action: #selector(actionButtonPressed(_:)) , for: .touchUpInside);
        
        let stackView = UIStackView(arrangedSubviews : [speedStackView, scoreStackView, locationStackView, actionButton]);
        stackView.spacing = 8.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        
        
        stackView.alignment = .center // .leading .firstBaseline .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 75),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -75),
            stackView.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: 10),
            
            
        ])
        
        
        scoreStackView.formatHorizontalStackView(withRespect: stackView)
        speedStackView.formatHorizontalStackView(withRespect: stackView);
        locationStackView.formatHorizontalStackView(withRespect: stackView);
        
       
        
    }
    
    @objc func speedSliderValueDidChange(_: AnyObject) {
        speedPointLabel.text = String(Int(speedSlider.value))
    }
    @objc func actionButtonPressed(_: AnyObject) {
        actionButton.isEnabled = false;
        carriageView.image = carriageView.image?.rotate(CGFloat(((360-carriageAngle)) * Double.pi/180));
       carriageView.image = carriageView.image?.rotate(CGFloat((Double(angleSlider.value))*(Double.pi/180)));
        carriageAngle = Double(angleSlider.value)
        
        
        let bottleNewPosition: Double = Double(bottlePosition) + Double(locationPointLabel.text!)!/10;
        bottleView.frame = CGRect(x: bottleNewPosition, y: Double(screenHeight) - 150,  width: 80, height: 80);
        velocityX = Double(speedPointLabel.text!)! * cos(carriageAngle*(Double.pi/180.0));
            velocityY  = Double(speedPointLabel.text!)! * sin(carriageAngle*(Double.pi/180.0));
       view.addSubview(ballView);
        xPosition = 0.0;
        yPosition = 0.0;
        ballView.frame = CGRect(x: carriageView.frame.maxX - 40 , y: carriageView.frame.minY, width: 40, height: 40)
        ballOriginXPosition = Double(ballView.frame.minX);
        ballOriginYPosition = Double(ballView.frame.minY);
        if(isCollided == true){
            bottleView.image = bottleView.image?.rotated(270);
        }
        gameTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        
    }
    @objc func angleSliderValueDidChange(_: AnyObject) {
        anglePointLabel.text = String(Int(angleSlider.value))
        
        
    }
    @objc func locationSliderValueDidChange(_: AnyObject) {
        locationPointLabel.text = String(Int(locationSlider.value))
    }
    
    func createHorizontalStackView(name: String , minPoint: Float, maxPoint: Float, tintColor: UIColor, labelSlider: UISlider, labelPoint: UILabel ) -> UIStackView {
        let labelName = UILabel();
        labelName.translatesAutoresizingMaskIntoConstraints = false;
        labelSlider.translatesAutoresizingMaskIntoConstraints = false;
        labelName.text = name;
        labelSlider.widthAnchor.constraint(equalToConstant: 96).isActive = true;
        labelSlider.minimumValue = minPoint;
        labelSlider.maximumValue = maxPoint;
        labelSlider.setValue(0 , animated: true);
        labelSlider.isContinuous = true
        labelSlider.tintColor = tintColor;
        labelPoint.translatesAutoresizingMaskIntoConstraints = false;
        labelPoint.text = String(0)
        
        let stackView = UIStackView(arrangedSubviews : [labelName, labelSlider, labelPoint]);
        
        return stackView;
        
    }
    
    @objc func runTimedCode(){
        
        xPosition = xPosition + velocityX*time;
        yPosition = yPosition + velocityY*time;
        ballView.frame = CGRect(x: ballOriginXPosition + Double(xPosition),
                                y: ballOriginYPosition - Double(yPosition) ,
                                width: 40,
                                height : 40);
        ballView.layoutIfNeeded()
        time = time + 0.001;
        
        velocityY =  Double(velocityY) - Double(10*time);
       
        //Detect collision
    
        if((ballView.frame.minX<bottleView.frame.maxX && ballView.frame.maxX>bottleView.frame.minX) && (ballView.frame.minY<bottleView.frame.maxY && ballView.frame.maxY>bottleView.frame.minY)){
            
            gameTimer?.invalidate()
            ballView.removeFromSuperview();
            
            bottleView.image = bottleView.image?.rotated(90)
            view.addSubview(collisionAnimation)
            collisionAnimation.frame = CGRect(x: bottleView.frame.minX - 100,
                                              y: bottleView.frame.minY - 100,
                                              width: 200, height: 200);
            isCollided = true;
            totalScore = totalScore + 1;
            scoreLabel.text = String(totalScore);
            animationTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(showCollissionAnimation), userInfo: nil, repeats: true)
            
        }
        
        else if(ballView.frame.minX >= UIScreen.main.bounds.width || ballView.frame.minX <= 0 ){
            ballView.removeFromSuperview();
            gameTimer?.invalidate()
            isCollided = false;
            actionButton.isEnabled = true;
            
        }
        
        else if(ballView.frame.minX <= UIScreen.main.bounds.width && ballView.frame.maxY >=      UIScreen.main.bounds.height){
            ballView.frame = CGRect(x: Double(ballView.frame.minX), y:  Double(ballView.frame.minY) - 60,  width: 40, height: 40);
            isCollided = false;
            gameTimer?.invalidate()
            actionButton.isEnabled = true;
            
            }
        
    }
    
    @objc func showCollissionAnimation(){
        collisionAnimation.image = UIImage(named: collisionNames[collisonCounter % 3]);
        collisonCounter = collisonCounter + 1;
        if(collisonCounter >= 12){
            animationTimer?.invalidate();
            actionButton.isEnabled = true;
            collisonCounter = 0;
            collisionAnimation.removeFromSuperview();
        }
        
    }

    
}



