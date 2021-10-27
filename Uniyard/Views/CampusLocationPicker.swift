//
//  CampusLocationPicker.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/26/21.
//

import SwiftUI

struct CampusLocationPicker: View {
  @State var expand = false
  @State var selectedOption = "Pittsburgh"
  var body: some View{
    VStack(alignment: .leading){
      HStack{
        Text("\(selectedOption)")
          .fontWeight(.semibold)
          .foregroundColor(.gray)
          .frame(alignment: .leading)
        Image(systemName: expand ? "chevron.up": "chevron.down")
          .resizable()
          .frame(width: 13, height: 6, alignment: .leading)
          .foregroundColor(.black)
          .frame(alignment: .leading)
      }.onTapGesture {
        self.expand.toggle()
      }
      if(expand){
        Button(action: {
          print("Pittsburgh")
          self.selectedOption = "Pittsburgh"
          self.expand.toggle()
        }){
          Text("Pittsburgh")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Australia")
          self.selectedOption = "Australia"
          self.expand.toggle()
        }){
          Text("Australia")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Qatar")
          self.selectedOption = "Qatar"
          self.expand.toggle()
        }){
          Text("Qatar")
            .padding(10)
        }.foregroundColor(.black)
        Button(action: {
          print("Africa")
          self.selectedOption = "Africa"
          self.expand.toggle()
        }){
          Text("Africa")
            .padding(10)
        }.foregroundColor(.black)
      }
    }.padding()
    .cornerRadius(15)
    //    .shadow(color: .gray, radius: 5)
    .animation(.spring())
  }
//  @Binding var location: String
//  @Binding var showSelector: Bool
//  let locations = ["Pittsburgh","Africa","Australia"]
//    var body: some View {
//      ZStack{
//        Color(.black).opacity(0.04)
//          .ignoresSafeArea()
//        VStack{
//          ScrollView(showsIndicators: false){
//            VStack(spacing:10){
//              ForEach(locations, id: \.self) { loc in
//                Button{
//                  location = loc
//                  withAnimation(.easeIn)
//                  {
//                    showSelector = false
//                  }
//                } label:{
//                  Text(String(loc))
//                    .foregroundColor(.black)
//                }
//              }
//            }
//          }
//          .frame(height: 80)
//        }
//        .frame(width:250,alignment: .leading)
//        .padding()
//        .background(Color(.secondarySystemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
//        .shadow(color: Color.black.opacity(0.05), radius: 5, x: -5, y: -5)
//      }
//    }
}

struct CampusLocationPicker_Previews: PreviewProvider {
    static var previews: some View {
      CampusLocationPicker()
    }
}
