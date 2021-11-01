//
//  ItemDetailsSell.swift
//  Uniyard
//
//  Created by Aaratrika Chakraborty on 10/27/21.
//

import SwiftUI

struct ItemDetailsSell: View {
    var body: some View {
      ZStack{
        Color(red: 214/255.0, green: 158/255.0, blue: 158/255.0, opacity: 1.0)
          .ignoresSafeArea(.all)
//        NavigationLink(
//          destination: Login(loginModel: loginModel),
//          isActive: $signupvmodel.displayLogin,
//          label: {
//            Text("")
//          })
        VStack{
        HStack {
             Button(action: {})
             {
              Image(systemName: "chevron.backward").resizable().frame(width: 20, height: 30, alignment: .center).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
             }
             Text("Item Details")
              .font(.largeTitle)
              .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
              .fontWeight(.heavy)
              .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
            }
          ItemDetails()
          CardDetails()
//        HStack{
//          Text("Status: ").bold().font(.title3)
//          Text("Available").font(.title3)
//        }
      }
    }
  }
}
  
struct ItemDetails: View {
  var body: some View {
    TabView {
      ForEach(0 ..< 5) {_ in
        Image(uiImage: #imageLiteral(resourceName: "Login_logo"))
          .resizable()
          .aspectRatio(2, contentMode: .fit)
          .cornerRadius(32)
      }
      .padding()
    }
    .frame(width: UIScreen.main.bounds.width)
    .tabViewStyle(PageTabViewStyle())
  }
}
struct CardDetails: View {
  //take 
  @StateObject var itemdetailvmodel = ItemDetailViewModel()
  var body: some View {
    ZStack{
    VStack{
      VStack{
        HStack{
          Text("[Sell]").foregroundColor(.blue).font(.title2)
          Text("iPad 2020")
            .font(.title)
            .fontWeight(.bold)
            .frame(alignment: .leading)
          Button(action: itemdetailvmodel.toggled){
          Image(systemName: itemdetailvmodel.showBookmarkSelector ? "bookmark.fill" :"bookmark").font(.system(size: 25.0, weight: .bold)).frame(width: 120, height: 50, alignment: .trailing)
            .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
        }
        }
        HStack{
          Text("$1200.00").font(.title2).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).bold()
            .frame(width:104,alignment: .leading)
          Text("List Date: 2019-09-31").font(.subheadline).foregroundColor(.gray).frame(width:220,alignment: .trailing)
        }
        Group{
          Spacer()
          IndividualCardDetails("Status:", text: "Available" )
          Spacer()
          IndividualCardDetails("Condition:", text: "Available" )
        }
        Group{
          Spacer()
          IndividualCardDetails("Category:", text: "Available" )
          Spacer()
          IndividualCardDetails("Zipcode:", text: "Available" )
          Spacer()
          IndividualCardDetails("Delivery:", text: "Available" )
          Spacer()
        }
        Group{
          IndividualCardDetails("Location:", text: "Available" )
          Spacer()
          IndividualCardDetails("Pickup/nAddress:", text: "Available" )
          Spacer()
          IndividualCardDetails("Earliest Available:", text: "Available" )
          Spacer()
          Text("Description:").bold().font(.subheadline).frame(width:330,alignment: .leading)
          Spacer()
          Text("Data says info about the product and more lines of product info inserted here.").padding().font(.subheadline)
            .background(Color(red: 229/255.0, green: 229/255.0, blue: 229/255.0, opacity: 1.0))
            .cornerRadius(20)
            .frame(width: 330, alignment: .center)
            .fixedSize(horizontal: false, vertical: true)
          Button(action: {}
                 , label: {
                  Text("Chat")
                 })
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 50)
            .background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            .cornerRadius(15)
        }
      }.padding(.top)
      .frame(width: 334,height: 490 , alignment: .leading)
      Spacer()
//      BottomBarNav().frame(width: 400).navigationBarHidden(true).onAppear()
    }.padding()
    .background(Color(.systemBackground))
    .cornerRadius(20)
    
  }
 }
}
struct IndividualCardDetails: View {
  
    private var caption:String
  private var text:String
//    @Binding var text:String
  
  init(_ caption: String, text: String) {
    self.caption = caption
  //  self._text = text
    self.text = text
  }
      var body: some View {
        VStack(alignment: .leading){
          
        HStack
          {
          Text(caption).bold().font(.subheadline).frame(alignment: .leading)
          Text(text).font(.subheadline).frame(width:130,alignment: .leading)
          Spacer()
        }
      }
    }
}
struct ItemDetailsSell_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsSell()
    }
}
