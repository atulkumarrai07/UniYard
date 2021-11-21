import SwiftUI

struct PersonalView: View {
	@Environment(\.presentationMode) var personalPresentation: Binding<PresentationMode>
	
	var body: some View {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {personalPresentation.wrappedValue.dismiss()
					}){
						Image(systemName: "chevron.backward").resizable().frame(width: 15, height: 20, alignment: .center)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
					}
					
					Text("Personal").font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding()
				personalDetailsView()
			}//VStack
		}
	}
}

struct PersonalView_Previews: PreviewProvider {
	static var previews: some View {
		PersonalView()
	}
}

struct personalDetailsView: View {
	@StateObject var curUserVm = CurUserViewModel()
	
	var body: some View {
		ZStack{
			ScrollView{
				VStack{
					VStack{
						Group{
							Text("CMU Email").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
							
							HStack{
								TextField("CMU Email", text: $curUserVm.email)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
							}
							Divider()
						}
						
						Group{
							Text("First name").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
								
							HStack{
								TextField("First name", text: $curUserVm.first_name)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
							}
							Divider()
						}
						
						Group{
							Text("Last name").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
							HStack{
								TextField("Last name", text: $curUserVm.last_name)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
							}
							Divider()
						}
						
						Group{
							Text("Campus location").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
							CampusLocationPicker()
							Divider()
						}
						
						Group{
							Text("Password").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading)
							HStack{
								TextField("Password", text: $curUserVm.password)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
								Image(systemName: "square.and.pencil").resizable().frame(width:20, height: 20, alignment: .center)
									.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
							}
							Divider()
						}
						
						//Save button
						Button(action: {
						},
						label: {
							Text("Save").font(.system(size: 20, weight: .medium))
						})
						.frame(width: 300, height: 40, alignment: .center)
						.foregroundColor(.white)
						.background(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.cornerRadius(15)
						.padding(.vertical, 20)
						.padding(.horizontal, 50)
					}
					.frame(width: 334,height: 490 , alignment: .center)
					Spacer()
					
				}
				.padding()
				.background(Color(.systemBackground))
				.cornerRadius(20)
				
			}
		}.navigationBarHidden(true)
	}
}
