//
//  FirebaseManager.swift
//  Mooc2022
//
//  Created by Trieu Le on 25/07/2022.
//

import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    let ref = Database.database().reference()
    
    func fetchFavorite(completion : @escaping (DataSnapshot?) -> Void) {
        guard let userID = LoginService.shared.currentUser?.uid else {
            completion(nil)
            return
        }
        ref.child("Favorites/\(userID)").getData { (error, snapshot) in
            if let error = error {
                Log.debug.out("Error getting data \(error)")
                return
            }
            
            if let data = snapshot, data.exists() {
                completion(data)
            } else {
                Log.debug.out("No data available")
            }
        }
    }
    
    func fetchPopularMovies(completion : @escaping (DataSnapshot) -> Void) {
        ref.child("Popular").getData { (error, snapshot) in
            if let error = error {
                Log.debug.out("Error getting data \(error)")
                return
            }
            
            if let data = snapshot, data.exists() {
                completion(data)
            } else {
                Log.debug.out("No data available")
            }
        }
    }
    
    func fetchUser(completion: @escaping (DataSnapshot) -> Void) {
        
        if let currentUser = LoginService.shared.currentUser {
            self.ref.child("UserProfiles").child(currentUser.uid).getData { (error, snapshot) in
                if let error = error {
                    Log.debug.out("Error getting data \(error)")
                    return
                }
                
                if let data = snapshot, data.exists() {
                    completion(data)
                } else {
                    Log.debug.out("No data available")
                }
            }
        }
    }
    
    // MARK: - User firebase
    func insertUser(user: UserProfile, completion: @escaping (Bool) -> Void) {
        ref.child("UserProfiles/\(user.userId)").observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let _ = self else { return }
            var result = false
            if snapshot.exists() {
                result = self!.updateUser(user: user, isNewUser: false)
            } else {
                result = self!.updateUser(user: user, isNewUser: true)
            }
            if result {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func insertFavorite(movies: [MovieModel]) {
        guard let userID = LoginService.shared.currentUser?.uid else {
            return
        }
        let path = "Favorites/\(userID)"
        movies.forEach({ movie in
            guard movie.id != nil else {
                return
            }
            ref.child(path).child((String(describing: movie.id!))).setValue(true) {
              (error:Error?, ref:DatabaseReference) in
              if let error = error {
                print("Data could not be saved: \(error).")
              } else {
                print("Data saved successfully!")
              }
            }
        })
    }
    
    private func updateUser(user: UserProfile, isNewUser: Bool) -> Bool {
        if let currentUser = LoginService.shared.currentUser, currentUser.uid == user.userId {
            self.ref.child("UserProfiles").child(currentUser.uid).child("name").setValue(user.name)
            self.ref.child("UserProfiles").child(currentUser.uid).child("email").setValue(user.email)
            self.ref.child("UserProfiles").child(currentUser.uid).child("phone_number").setValue(user.phoneNumber)
            self.ref.child("UserProfiles").child(currentUser.uid).child("img_avatar_url").setValue(user.imgAvatarUrl)
            self.ref.child("UserProfiles").child(currentUser.uid).child("is_new_user").setValue(isNewUser ? 1 : 0)
            return true
        }
        return false
    }
    
    // MARK: - Parse Model
    
    func parseUser(userID: String, dataSnapshot: DataSnapshot) -> UserProfile {
        let object = dataSnapshot.value as AnyObject
        
        let name = object["name"] as! String
        let email = object["email"] as! String
        let phoneNumber = object["phone_number"] as! String
        let imgAvatarUrl = object["img_avatar"] as! String
        let isNewUser = object["is_new_user"] as! Int
        
        return UserProfile(userId: userID, name: name, email: email, phoneNumber: phoneNumber, imgAvatarUrl: imgAvatarUrl, isNewUser: isNewUser == 1 ? true : false)
    }
}

struct UserProfile {
    var userId: String
    var name: String?
    var email: String?
    var phoneNumber: String?
    var imgAvatarUrl: String?
    var isNewUser: Bool?
}
