//
//  ContentView.swift
//  Realm-Playground
//
//  Created by Felix Reichenbach on 04.05.20.
//  Copyright © 2020 Felix Reichenbach. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: read) {
                Text("Read")
            }
            Button(action: write) {
                Text("Write")
            }
            Text(viewModel.result)
        }
    }
    
    func write() {
        viewModel.mongoWrite()
    }
    
    func read() {
        viewModel.mongoRead()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
