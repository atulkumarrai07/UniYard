
import SwiftUI

struct CreateSellView: View {
  @Environment(\.presentationMode) var createSellPresentation: Binding<PresentationMode>
  
  @StateObject var item_vm = ItemsViewModel()
  
  var conditionList = ["New", "Almost new", "Very good", "Good", "Acceptable"]
  
  var categoryList=["Clothing", "Books", "Computers",
                      "Electronics", "Furniture", "Home appliances",
                       "Jewelley, watches", "Music instruments", "Phones",
                       "Sporting goods", "Tools", "Toys, games", "Other"]
    
  var locationList = ["Pittsburgh","Australia","Qatar", "Africa"]
  
  //set a date range
  var dateRange: ClosedRange<Date> {
    let min_date = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    
    let max_date = Calendar.current.date(byAdding: .day, value: 365, to: Date())!
    return min_date...max_date
  }
  
  var body: some View {
      ZStack{
				Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
        VStack{
          HStack {
            Button(action: {
							UIApplication.shared.endEditing()
              self.createSellPresentation.wrappedValue.dismiss()
							
            }){
              Image(systemName: "chevron.backward").resizable()
                .frame(width: 15, height: 20, alignment: .center)
                .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
            }
            Text("Sell an Item")
              .font(.system(size: 25, weight: .heavy))
              .foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
              .frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
          }.padding()//Hstack
  
          // item image
      
          TabView {
             ForEach(0 ..< 5) {_ in
              Image(uiImage: #imageLiteral(resourceName: "Login_logo"))
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
                .frame(height: 200)
             }
            }
          .frame(width: 300, height: 200, alignment: .center)
          .tabViewStyle(PageTabViewStyle())
          .cornerRadius(54.0).padding(.bottom)
          
          
          //post details
          Form {
            Section(header: Text("Title")) {
              TextEditor(text: $item_vm.title)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
            Section(header: Text("Pickup address")) {
              TextEditor(text: $item_vm.pickUpAddress)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
            Section(header: Text("Price (USD)")) {
              TextField("$0.00", text: $item_vm.price)
                .keyboardType(.decimalPad)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
            Section {
              Picker("Condition", selection: $item_vm.conditionSelection) {
                ForEach(conditionList, id: \.self) {
                  Text($0)
                }}
              
              Picker("Category", selection: $item_vm.categorySelection) {
                ForEach(categoryList, id: \.self) {
                  Text($0)
                }}
              
              DatePicker("Earliest available", selection: $item_vm.availableDate,
                         in: dateRange, displayedComponents: .date)
              
              Toggle(isOn: $item_vm.delivertRequest) {
                Text("Delivery request")
              }
              
              Picker("Location", selection: $item_vm.locationSelection) {
                ForEach(locationList, id: \.self) {
                  Text($0)
                }}
            }.textCase(nil)
            .font(.system(size: 18))
            
            
            Section(header: Text("Item description")) {
              TextEditor(text: $item_vm.description)
            }.textCase(nil)
            .font(.system(size: 18))
            .foregroundColor(.black)
            
          }//form
          .cornerRadius(15)
          .padding(.leading, 20)
          .padding(.trailing, 20)
          
          Button(action: {item_vm.createSellPost();
          }
          , label: {
            Text("Post")
              .frame(width: 300, height: 50, alignment: .center)
              .font(.system(size: 25, weight: .heavy))
              .foregroundColor(.white)
              .background(Color(red: 128/255.0,
                                green: 0/255.0,
                                blue: 0/255.0, opacity: 1.0))
              .cornerRadius(15)
          })
          .padding(.vertical, 10)
          .padding(.horizontal, 50)
          .opacity(((!item_vm.title.isEmpty) && (!item_vm.description.isEmpty)) ? 1 : 0.6)
          .disabled((item_vm.title.isEmpty || item_vm.description.isEmpty))
          .alert(isPresented:$item_vm.availableStatus)
          {
            Alert(title: Text("Success"),
                  message: Text("A sell post has been created!"),
                  dismissButton: .default(Text("OK")))
          }
          
        }.onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
      }.navigationBarHidden(true)
  }
  
}

struct CreateSellView_Previews: PreviewProvider {
  static var previews: some View {
    CreateSellView()
  }

}


