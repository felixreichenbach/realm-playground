# Realm-Playground

## Prerequisits

- Install Xcode: https://developer.apple.com/xcode/
- Install CocoaPods: https://realm.io/docs/swift/latest

## Deployment Procedure

- Clone repo
- Change into the Realm-Playground folder: ```cd Realm-Playground```
- Update the pods ```pod update``` 
- open farms2.xcworkspace with Xcode
- Selet the Constants.swift file
- Adjust your Stitch parameters

## Demo

- Start the iPhone simulator in Xcode
- Check the console output if the application was successfully initialized
- Fill in a piece of text into the text field and push the write button
- Pushing the Write button will trigger a change stream event if "World" is put into the field
- Pushing the Read button reads a document from MongoDB and uses the text in the text field as filter criteria. The random number which was generated when writing the document will be displayed
- Add or change a document in the collection itself and watch the changestream log an event in the Xcode console

