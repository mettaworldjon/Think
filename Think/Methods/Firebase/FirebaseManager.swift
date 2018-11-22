//
//  Login+Firebase.swift
//  Think
//
//  Created by Jonathan on 11/21/18.
//  Copyright © 2018 Jonathan. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager {
    
    // Private Init
    private init() {}
    
    // Shared Instants
    public static let shared = FirebaseManager()
}

// Login Method
extension FirebaseManager {
    public func login(name:String, email:String, password:String, image:UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { (User, error) in
            // Check For Errors
            if let safeError = error {
                print(safeError)
                return
            }
            print("USER CREATED")
            // Set User Data
            // Image
            let imageName = NSUUID().uuidString
            guard let uploadData = image.jpegData(compressionQuality: 0.1) else { return }
            let values = ["name":name, "email":email]
            self.uploadImage(image: uploadData, imageName: imageName, values: values as [String : AnyObject])
        }
    }
    
    fileprivate func uploadImage(image:Data, imageName:String, values:[String:AnyObject]) {
        // Profile Image Ref
        let profileImageRef = Storage.storage().reference().child("profile_images")
        let ref = profileImageRef.child("\(imageName).png")
        ref.putData(image, metadata: nil) { (_, error) in
            // Check Errors
            if let error = error {
                print(error)
                return
            }
            print("UPLOADED")
            // Fetch Image URL
            ref.downloadURL(completion: { (URL, error) in
                // Check Errors
                if let error = error {
                    print(error)
                    return
                }
                print("FOUND URL")
                // Set User Data for Database
                guard let url = URL else { return }
                var updatedValues = values
                updatedValues["profileImageURL"] = url.absoluteString as AnyObject
                self.setUserData(values: updatedValues)
            })
        }
    }
    
    fileprivate func setUserData(values:[String:AnyObject]) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("users").child(uid)
        ref.updateChildValues(values) { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            print("Shit Actually Works")
            SignUp.dispatchGroup.leave()
        }
    }
}
