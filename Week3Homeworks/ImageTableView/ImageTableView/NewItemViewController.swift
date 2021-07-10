//
//  NewItemViewController.swift
//  ImageTableView
//
//  Created by semra on 9.07.2021.
//  Copyright © 2021 semra. All rights reserved.
//

import UIKit
import CoreData

class NewItemViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var taskImage: UIImageView!
    
    @IBOutlet weak var itemNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self;
                
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let uuid = UUID()
        let text = itemNameField.text;
        if let manText = text , manText.count > 0 {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context =  appDelegate.persistentContainer.viewContext
            let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context);
            let image = taskImage.image?.jpegData(compressionQuality: 0.5);
            item.setValue(uuid, forKey: "id");
            item.setValue(text, forKey: "name");
            item.setValue(image, forKey: "image");
            do {
                try context.save()
            }catch{
                
            }
            
            self.navigationController?.popViewController(animated: true);
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Text cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
       
        
    }
    
}

extension NewItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            taskImage.contentMode = .scaleAspectFit
            taskImage.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

      
    
}
