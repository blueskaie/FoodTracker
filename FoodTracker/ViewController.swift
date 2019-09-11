//
//  ViewController.swift
//  FoodTracker
//
//  Created by isopooh on 9/9/19.
//  Copyright © 2019 isopooh Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.selectImageFromPhotoLibrary(gesture:)))
        photoImageView.addGestureRecognizer(tapGesture)
        photoImageView.isUserInteractionEnabled = true
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }

    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(gesture: UITapGestureRecognizer) {
        print("selectImageFromPhotoLibrary is called")
        
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a veiw controller that lets a user pick media from their photo libary
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is noticed when the user pics an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func setDefaultLabelText(_ sender: Any) {
        mealNameLabel.text = "Default Text"
    }
}

