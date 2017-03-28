//
//  ViewController.swift
//  memeMe
//
//  Created by Joseph Park on 2/20/17.
//  Copyright © 2017 Joseph Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topNavBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    let picker = UIImagePickerController()
    var memeSentFromMain: Meme?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Life Cycle func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField(textField: topTextField)
        configureTextField(textField: bottomTextField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let memeFromDetail = memeSentFromMain as Meme! {
            imagePickerView.image = memeFromDetail.image
        }
       
        // if there's an image in the imageView, enable the share button
        if let _ = imagePickerView.image {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        //To enable or disable camera bar button if camera is available for use or not
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()

        func textFieldDidBeginEditing(textField: UITextField) {
            if textField.text == "TOP" || textField.text == "BOTTOM" {
                topTextField.text = ""
            }
        }
    }
    
    
    //MARK: - Meme related
    
    func generateMemedImage() -> UIImage {
        //Hide Toolbar And Navigation Bar
        topNavBar.isHidden = true
        toolbar.isHidden = true
        
        // Render View To An Image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show Toolbar and Navigation Bar
        topNavBar.isHidden = false
        toolbar.isHidden = false
        
        return memedImage
    }
    
    func save() {
        // Create The Meme
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image, memedImage: memedImage)
        
        //TODO: Add to memes array in AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)

        
        topTextField.isHidden = true
        bottomTextField.isHidden = true
        
    }

    //MARK: Album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)

    }
    
    
    //MARK: Take Photo and use that from camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker, animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera() {
        let alertVC = UIAlertController(title: "No Camera Available", message: "No camera is available on this device", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }

    
    //MARK: - Delegate for UIImagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
            imagePickerView.contentMode = .scaleAspectFit
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    //MARK: - Text related
    func configureTextField(textField: UITextField) {
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -4] as [String : Any]
        
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        textField.textAlignment = .center
        textField.delegate = self
    
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Keyboard
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            print("keyboardWillShow Bottom")
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            print("keyboardWillHide Bottom")
            view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - Share
    @IBAction func share(_ sender: Any) {
        //generate a memed image
        let memedImage = generateMemedImage()
        
        //define an instance of ActivityViewController
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        // pass the ActivityViewController a memedImage as an activity item
        activityVC.completionWithItemsHandler = { activity, success, items, error in
            self.save()
            self.dismiss(animated: true, completion: nil)
        }
        //present the VC
        present(activityVC, animated: true, completion: nil)
    }
    
    //MARK: - Cancel
    @IBAction func cancel(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        self.imagePickerView.image = nil
    }
    

}
