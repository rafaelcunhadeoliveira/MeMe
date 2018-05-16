//
//  ViewController.swift
//  MeMe
//
//  Created by Rafael Cunha de Oliveira on 20/04/18.
//  Copyright © 2018 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    struct Meme {
        var topString: String
        var bottomString: String
        var originalImage: UIImage
        var memedImage: UIImage
    }
    
    //MARK: - Constants
    let topText = "TOP"
    let bottomText = "BOTTOM"

    
    //MARK: - IBOutlets
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    //MARK: - Variables
    var textFields: [UITextField]!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFields = [self.bottomTextField, self.topTextField]
        self.shareButton.isEnabled = false
        self.setTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeForKeyboardNotifications()
    }
    
    //MARK: - Setup
    
    func setTextField(){
        let memeTextAttributes = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.strokeWidth.rawValue: -4,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40) as Any
            ] as [String : Any]
        
        for textField in self.textFields{
            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment = .center
        }
    }
    
    func subscribeForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    func unsubscribeForKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    //MARK: - Layout
    
    func hideBars(){
        self.toolBar.isHidden = true
        self.navBar.isHidden = true
    }
    
    func showBars(){
        self.toolBar.isHidden = false
        self.navBar.isHidden = false
    }
    
    //MARK: - IBActions
    
    @IBAction func presentAction(_ sender: UIButton) {
        self.shareButton.isEnabled = true
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sender.tag == 0 ? .camera : .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - ImagePickerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.memeImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: TextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.text == self.topText || textField.text == self.bottomText{
            textField.text = ""
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.keyboardWillHide()
        return true
    }
    
    //MARK: - Keyboard
    
    @objc func keyboardWillShow(_ notification: Notification){
        if self.bottomTextField.isFirstResponder{
           view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    //MARK: - Methods
    
    func generatedMemedImage() -> UIImage{
        
        self.hideBars()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.showBars()
        
        return memedImage
    }
    
    @IBAction func save(){
        let memedImage = [generatedMemedImage()]
//        let meme = Meme(topString: topTextField.text!, bottomString: bottomTextField.text!, originalImage: memeImage.image!, memedImage: memedImage)
        let activityViewController = UIActivityViewController(activityItems: memedImage, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }

}

