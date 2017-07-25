//
//  ViewController.swift
//  CameraTest
//
//  Created by Fateme' Kazemi on 4/31/1396 AP.
//  Copyright © 1396 Fateme' Kazemi. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet var PhotoViewer: UIImageView!
    
    var picker:UIImagePickerController!
    var pickerControllerDelegate:UIImagePickerControllerDelegate!
    var cameraViewController:CameraViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if(!(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)))
        {
            print("no device found")
        }
        
        self.picker=UIImagePickerController()
        self.cameraViewController = CameraViewController()
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    @IBAction func onTakePhoto(_ sender: Any) {
        
        self.picker.delegate=self
        self.picker.isEditing=true
        self.picker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(self.picker, animated: true, completion: nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            PhotoViewer.image=pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func onDisplayPhotos(_ sender: Any) {
        
        self.picker.delegate=self
        self.picker.isEditing=true
        self.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(self.picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

