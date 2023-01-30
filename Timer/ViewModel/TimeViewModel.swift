//
//  TimeViewModel.swift
//  Timer
//
//  Created by junhyeok KANG on 2023/01/30.
//


import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class TimeViewModel: ObservableObject {
    @Published var list = [TimeModel]()
    //() == empty
    
    func updateData(todoToUpdate: TimeModel) {
        
        // Get a refernce to the database
        let db = Firestore.firestore()
        
        // Set the data to update
        db.collection("timeModel").document("day1").setData(["totalSec":"Updated:\(todoToUpdate.totalSec)","staticTotalSec": "Updated:\(todoToUpdate.staticTotalSec)"], merge: true) { error in
            
            // Check for error
            if error == nil {
                // Get the new Data
                self.getData()
            }
        }
    }

    func addData(totalSec: Int, staticTotalSec: Int) {
        
        // Get a refernce to the database
        let db = Firestore.firestore()
        
        // Add a document to a collection
        db.collection("timeModel").addDocument(data: ["totalSec": totalSec, "staticTotalSec": staticTotalSec]) { error in
            
            // Check for errors
            if error == nil {
                // no error
                print("error");
                // Call get data to retrieve latest data
                self.getData()
            }
            
            else {
                // Handle the error
            }
        }
    }
    
    func getData() {
        
        // Get a refernce to the database
        let db = Firestore.firestore()
        
        //Read the documetns at a specific path
        db.collection("timeModel").getDocuments { snapchot, error in
            
            //check for errors
            if error == nil {
                // No Errors
                if let snapshot = snapchot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            return TimeModel(id: d.documentID,
                                             totalSec: d["totalSec"] as? Int ?? 0,
                                             staticTotalSec: d["staticTotalSec"] as? Int ?? 0)
                        }
                    }
                }
            }
            else {
                // Handle the error
                return
            }
        }
    }
    
}



