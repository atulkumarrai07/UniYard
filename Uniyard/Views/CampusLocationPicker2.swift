//
//  CampusLocationPicker2.swift
//  Uniyard
//
//  Created by Atul Kumar Rai on 10/27/21.
//

import SwiftUI

struct CampusLocationPicker2: View {
  @State var location:Binding<String>
  @Environment(\.presentationMode) var campusLocationPicker: Binding< PresentationMode>
  
    var body: some View {
      VStack{
        HStack{
          Spacer()
          Button("Done"){
            self.campusLocationPicker.wrappedValue.dismiss()
          }
        }.padding()
        Picker("", selection: location) {
                   ForEach(["Pittsburgh","Australia","Qatar", "Africa"], id: \.self) {
                       Text("\($0)")
                   }
               }
        Spacer()
      }
    }
}

//struct CampusLocationPicker2_Previews: PreviewProvider {
//    static var previews: some View {
//      CampusLocationPicker2(location: "A")
//    }
//}
