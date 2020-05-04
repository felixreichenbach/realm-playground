//
//  MyDelegate.swift
//  StitchAPI
//
//  Created by Felix Reichenbach on 02.05.20.
//  Copyright © 2020 Felix Reichenbach. All rights reserved.
//

import Foundation
import StitchRemoteMongoDBService
import StitchCore

class MyChangeStream: ChangeStreamDelegate {
    typealias DocumentT = MyModel
    var changeStreamSession: ChangeStreamSession<MyModel>?
    
    let collection: RemoteMongoCollection<MyModel>
    
    init(collection: RemoteMongoCollection<MyModel>) {

        self.collection = collection
        // Add listener
        addWatchToCollection()
    }
    
    // Starts watching the items collection for changes
    func addWatchToCollection() {
        do {
            NSLog("Watching for changes");
            changeStreamSession = try collection.watch(delegate: self);
        } catch {
            NSLog("Stitch error: \(error)");
        }
    }
    
    func didReceive(event: ChangeEvent<DocumentT>) {
        NSLog("Event Received!")
        
    }
    
    func didReceive(streamError: Error) {
        NSLog("Did Receive Error")
    }
    
    func didOpen() {
        NSLog("Did Open!")
    }
    
    func didClose() {
        NSLog("Did Close!")
    }
}
