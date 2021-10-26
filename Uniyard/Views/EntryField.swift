//
//  EntryField.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 10/26/21.
//

import SwiftUI

struct EntryField: View {
  var sfSymbol:String
  var placeHolder:String
  var prompt:String
  var isSecure:Bool = false
  @Binding var field:String
  
    var body: some View {
      VStack(alignment: .leading)
      {
        HStack
        {
          Image(systemName: sfSymbol).foregroundColor(.gray).font(.headline).frame(width: 20)
          if(isSecure)
          {
            SecureField(placeHolder, text: $field)
          }
          else{
            TextField(placeHolder, text: $field)
          }
        }.autocapitalization(.none).padding(8).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray,lineWidth: 1))
        Text(prompt).fixedSize(horizontal: false, vertical: true).font(.caption).foregroundColor(.red)
      }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
      EntryField(sfSymbol: "lock", placeHolder: "Password", prompt: "Enter a valid password", field: .constant(""))
    }
}


struct SecureInputView: View {
  @Binding private var text: String
  @State private var isSecured: Bool = false
  private var title: String
  init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
  }
  var body: some View {
    ZStack(alignment: .trailing) {
      SecureField(title, text: $text).opacity(isSecured ? 0 : 1)
      if isSecured == true {
        TextField(title, text: $text)
      }
      Button(action: {
        isSecured.toggle()
      }) {
        Image(systemName: self.isSecured ? "eye" : "eye.slash")
          .accentColor(.gray)
      }
    }
  }
}
