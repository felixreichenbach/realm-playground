//
//  ViewModel.swift
//  StitchAPI
//
//  Created by Felix Reichenbach on 01.05.20.
//  Copyright © 2020 Felix Reichenbach. All rights reserved.
//
//  MongoDB Stich How To
//  https://github.com/mongodb/stitch-ios-sdk#installation
//

import Foundation
import StitchCore
import MongoSwift
import StitchRemoteMongoDBService

class ViewModel: ObservableObject {
    
    @Published var result: String = ""

    let stitch = Stitch.defaultAppClient!
    let mongoClient: RemoteMongoClient
    let coll: RemoteMongoCollection<MyModel>
    
    var myModel: MyModel?
    
    var myChangeStream: MyChangeStream?
    
    init() {
        // initialize the RemoteMongoClient
        self.mongoClient = try! stitch.serviceClient(
            fromFactory: remoteMongoClientFactory, withName: Constants.ATLAS_SERVICE_NAME
        )
        // Get the RemoteCollection
        self.coll = mongoClient.db(Constants.DATABASE).collection(Constants.COLLECTION, withCollectionType: MyModel.self)
        // Define user credentials
        let credential = UserPasswordCredential.init(withUsername: "demo@example.com", withPassword: "demo123")
        // Login with the credentials
        stitch.auth.login(withCredential: credential) { result in
          switch result {
          case .success:
              print("Successfully logged in")
              self.myChangeStream = MyChangeStream(collection: self.coll)
          case .failure(let error):
              print("Error logging in with email/password auth: \(error)")
          }
        }
    }
    
    func mongoRead() {
        coll.findOne() { result in
            switch result {
            case .success(let doc):
                self.myModel = doc!
                DispatchQueue.main.async {
                    self.result = self.myModel?.hello ?? "Default"
                }
            case .failure(let e):
                fatalError(e.localizedDescription)
            }
        }
    }
    
    func mongoWrite() {
        print("Write Stub")
        let newDoc = MyModel(_id: ObjectId(),
                             hello: "world",
                             test: 7
        )
        coll.insertOne(newDoc) { result in
            switch result {
            case .success(let doc):
                print("Result: \(doc)")
            case .failure(let e):
                fatalError(e.localizedDescription)
            }
        }
    }
    
}
