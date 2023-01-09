//
//  UserInputView.swift
//  listing-users
//
//  Created by Bernard Musaj on 4.1.23.
//

import SwiftUI

struct UserInputView: View {
    
    @Binding var name: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder).font(.title3).bold()
            TextField("Enter \(placeholder.lowercased())...", text: $name)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(.gray, style: StrokeStyle(lineWidth: 0.5)))
                
            
        }.padding()
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        StatefulPreviewWrapper("Test") { UserInputView(name: $0, placeholder: "First Name") }
        
    }
}

struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
