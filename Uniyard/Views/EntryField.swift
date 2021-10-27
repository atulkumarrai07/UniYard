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
  @Binding var field:String
  
    var body: some View {
      VStack(alignment: .leading)
      {
        HStack
        {
          Image(systemName: sfSymbol).foregroundColor(.gray).font(.headline).frame(width: 20)
          if(placeHolder == "Password")
          {
            SecureInputView(placeHolder, text: $field)
          }
          else{
            TextField(placeHolder, text: $field).disableAutocorrection(true)
          }
        }.autocapitalization(.none).padding(8).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray,lineWidth: 1))
        Text(prompt).fixedSize(horizontal: false, vertical: true).font(.caption).foregroundColor(.red)
      }
    }
}

struct EntryFieldSignUp: View {
  var placeHolder:String
  var prompt:String
  @Binding var field:String
  
    var body: some View {
      VStack(alignment: .leading)
      {
        TextField(placeHolder, text: $field)
              .padding(.horizontal)
              .frame(alignment: .leading)
              .background(Color.white)
              .autocapitalization(.none)
        Divider()
          .padding(.horizontal, 15)
         // .padding(.bottom)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
          .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
      HStack
      {
          
        Text(prompt).fixedSize(horizontal: true, vertical: false)
          .font(.caption)
          .foregroundColor(.red)
          .transition(AnyTransition.opacity.animation(.easeIn))
          .padding(.horizontal,15)
          Spacer()
      }
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
      SecureField(title, text: $text).opacity(isSecured ? 0 : 1).disableAutocorrection(true)
      if isSecured == true {
        TextField(title, text: $text).disableAutocorrection(true)
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

struct SecureInputViewSignUp: View {
 @Binding private var text: String
 var prompt:String
 @State private var isSecured: Bool = false
 private var title: String
 init(_ title: String, prompt: String, text: Binding<String>) {
  self.title = title
  self._text = text
  self.prompt = prompt
 }
 var body: some View {
  VStack{
   ZStack(alignment: .trailing) {
    SecureField(title, text: $text).opacity(isSecured ? 0 : 1).disableAutocorrection(true)
    if isSecured == true {
     TextField(title, text: $text).disableAutocorrection(true)
    }
    Button(action: {
     isSecured.toggle()
    }) {
     Image(systemName: self.isSecured ? "eye" : "eye.slash")
      .accentColor(.gray)
    }
   }.padding(.horizontal)
   Divider()
    .padding(.horizontal, 15)
    // .padding(.bottom)
    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
    .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
   HStack
   {
    Text(prompt).fixedSize(horizontal: true, vertical: false)
     .font(.caption)
     .foregroundColor(.red)
     .transition(AnyTransition.opacity.animation(.easeIn))
     .padding(.horizontal)
     .padding(.vertical,5)
     Spacer()
   }
  }
 }
}
