//
//  EditRecipeViewController.swift
//  Champion Chicken
//
//  Created by Erick Enriquez on 11/4/19.
//  Copyright © 2019 Erick Enriquez. All rights reserved.
//

import UIKit
import CoreData
class EditRecipeViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    let picker = UIImagePickerController();
    var object:Recipe_entity?
    @IBOutlet weak var fNameTextfield: UITextField!
    @IBOutlet weak var serving_size_textfield: UITextField!
    @IBOutlet weak var ready_in_textfield: UITextField!
    @IBOutlet weak var details_textfield: UITextField!
    @IBOutlet weak var Image_view: UIImageView!
    
 
        //handle to NSManaged object
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fNameTextfield.text = object?.food_name
        serving_size_textfield.text = object?.serving_size
        ready_in_textfield.text = object?.ready_in
        details_textfield.text = object?.steps
        if object?.image == nil{
            Image_view.image = nil
        }
        else{
            
            let image  = UIImage(data: (object?.image as Data?)!)
            Image_view.image = image

        }
         picker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save_changes(_ sender: Any) {
        if fNameTextfield.text?.isEmpty == false && serving_size_textfield.text?.isEmpty == false && ready_in_textfield.text?.isEmpty == false && details_textfield.text?.isEmpty == false{
            object?.food_name = fNameTextfield.text
            object?.serving_size = serving_size_textfield.text
            object?.ready_in = serving_size_textfield.text
            object?.steps = details_textfield.text
            do {//save the context
                try self.managedObjectContext.save()
                
            } catch let error {
            }
            
        }
    }
    
    
    
    @IBAction func add_image(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
            print("No camera")
        }
        
       
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //imageView.contentMode = .scaleAspectFit
            Image_view.image = pickedImage
         // object?.image = pickedImage.pngData()! as NSData
             object?.image = pickedImage.jpegData(compressionQuality: 1)! as NSData
            do{
                try self.managedObjectContext.save()
            }
                catch{
                    print("ERROR SAVING IMAGE")
                }
            
            print("DONE PICKING IMAGE")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
