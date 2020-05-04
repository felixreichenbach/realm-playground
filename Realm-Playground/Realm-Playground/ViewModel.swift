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
    @Published var counter: Int = 0

    let stitch = Stitch.defaultAppClient!
    let mongoClient: RemoteMongoClient
    let collection: RemoteMongoCollection<MyModel>
    
    var myModel: MyModel?
    
    var myChangeStream: MyChangeStream?
    
    init() {
        // initialize the RemoteMongoClient
        self.mongoClient = try! stitch.serviceClient(
            fromFactory: remoteMongoClientFactory, withName: Constants.ATLAS_SERVICE_NAME
        )
        // Get the RemoteCollection
        self.collection = mongoClient.db(Constants.DATABASE).collection(Constants.COLLECTION, withCollectionType: MyModel.self)
        // Define user credentials
        let credential = UserPasswordCredential.init(withUsername: Constants.STITCH_USERNAME, withPassword: Constants.STITCH_PASSWORD)
        // Login with the credentials
        stitch.auth.login(withCredential: credential) { result in
          switch result {
          case .success:
              print("Successfully logged in")
              self.myChangeStream = MyChangeStream(collection: self.collection, viewModel: self)
          case .failure(let error):
              print("Error logging in with email/password auth: \(error)")
          }
        }
    }
    
    func mongoRead(value: String) {
        collection.findOne(["greeting": value] as Document) { result in
            switch result {
            case .success(let doc):
                self.myModel = doc
                DispatchQueue.main.async {
                    self.result = String(describing: self.myModel?.random)
                    print("\(self.result))")
                }
            case .failure(let e):
                fatalError(e.localizedDescription)
            }
        }
    }
    
    func mongoWrite(value: String) {
        let newDoc = MyModel(_id: ObjectId(),
                             greeting: value,
                             random: Int.random(in: 0 ..< 10)
        )
        collection.insertOne(newDoc) { result in
            switch result {
            case .success(let doc):
                print("Result: \(doc)")
            case .failure(let e):
                fatalError(e.localizedDescription)
            }
        }
    }
    
}
