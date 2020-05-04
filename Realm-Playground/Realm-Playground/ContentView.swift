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
    
    @State private var value: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Stitch SDK Demo App")
                    .fontWeight(.bold)
                    .padding(.bottom)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.green)
                Button(action: write) {
                    Text("Write")
                        .bold()
                }
                TextField("Provide a value: ", text: $value)
                    .frame(width: 280.0)
                Text("# Change Stream Events Received: \(viewModel.counter)")
                    .padding(.bottom)
                Button(action: read) {
                    Text("Read")
                        .bold()
                }
                Text(viewModel.result)
                    .padding(.bottom)
                    
            }

        }
    }
    
    func write() {
        viewModel.mongoWrite(value: value)
    }
    
    func read() {
        viewModel.mongoRead(value: value)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
