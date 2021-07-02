//
//  Utilities.swift
//  bottleshootinggame
//
//  Created by semra on 1.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit
class Utilities {
    
    static func textField(withPlaceHolder placeHolder: String) -> UITextField {
           let textField = UITextField();
           textField.textColor = .white;
           textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
           textField.font = UIFont.systemFont(ofSize: 16);
           return textField;
           
       }
}
extension UIImage {
    
    
    func rotate(_ radians: CGFloat) -> UIImage {
        let cgImage = self.cgImage!
        let LARGEST_SIZE = CGFloat(max(self.size.width, self.size.height))
        let context = CGContext.init(data: nil, width:Int(LARGEST_SIZE), height:Int(LARGEST_SIZE), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)!
        
        var drawRect = CGRect.zero
        drawRect.size = self.size
        let drawOrigin = CGPoint(x: (LARGEST_SIZE - self.size.width) * 0.5,y: (LARGEST_SIZE - self.size.height) * 0.5)
        drawRect.origin = drawOrigin
        var tf = CGAffineTransform.identity
        tf = tf.translatedBy(x: LARGEST_SIZE * 0.5, y: LARGEST_SIZE * 0.5)
        tf = tf.rotated(by: CGFloat(radians))
        tf = tf.translatedBy(x: LARGEST_SIZE * -0.5, y: LARGEST_SIZE * -0.5)
        context.concatenate(tf)
        context.draw(cgImage, in: drawRect)
        var rotatedImage = context.makeImage()!
        
        drawRect = drawRect.applying(tf)
        
        rotatedImage = rotatedImage.cropping(to: drawRect)!
        let resultImage = UIImage(cgImage: rotatedImage)
        return resultImage
        
    }
    
    
    func rotated(_ degrees: CGFloat) -> UIImage? {
        
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        
        // Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(origin: .zero, size: size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 0.0)
        
        guard let bitmap: CGContext = UIGraphicsGetCurrentContext(), let unwrappedCgImage: CGImage = cgImage else {
            return nil
        }
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width/2.0, y: rotatedSize.height/2.0)
        
        // Rotate the image context
        bitmap.rotate(by: degreesToRadians(degrees))
        
        bitmap.scaleBy(x: CGFloat(1.0), y: -1.0)
        
        let rect: CGRect = CGRect(
            x: -size.width/2,
            y: -size.height/2,
            width: size.width,
            height: size.height)
        
        bitmap.draw(unwrappedCgImage, in: rect)
        
        guard let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
extension UIStackView {
    func formatHorizontalStackView(withRespect originStackView : UIStackView){
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: originStackView.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: originStackView.trailingAnchor, constant: 0)
        ])
        self.axis = .horizontal
        //self.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        
        self.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        self.distribution = .equalSpacing
    }
}


