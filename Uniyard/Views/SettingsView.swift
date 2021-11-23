import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var loginModel:LoginModel
	@Environment(\.presentationMode) var settingPresentation: Binding< PresentationMode>
	@StateObject var curUserViewModel: CurUserViewModel
	
	var body: some View {
		ZStack{
			Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0).ignoresSafeArea(.all)
			VStack{
				HStack {
					Button(action: {
						settingPresentation.wrappedValue.dismiss()
					}){
						Image(systemName: "chevron.backward").resizable().frame(width: 15, height: 20, alignment: .center)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0)).padding()
					}
					
					Text("Settings").font(.system(size: 25, weight: .heavy))
						.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-20)
				}.padding()
				
				ZStack{
					VStack{
						VStack(spacing: 0){
							//Notification
							HStack {
								Image(systemName: "bell.circle")
									.frame(width: 40)
									.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
									.font(.system(size: 30))
								
								Toggle(isOn: $curUserViewModel.notification_on) {
									Text("Push notifications").font(.title3)
								}
								
								Text(curUserViewModel.notification_on ? "ON" : "OFF").font(.system(size: 18))
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
							}
							.padding(EdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0))
							Divider()
							
							//App version
							HStack {
								Image(systemName: "simcard.2")
									.frame(width: 40)
									.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
									.font(.system(size: 30))
								
								Text("App version").font(.title3)
								Spacer() // Spread the Text and Image apart
								
								Text("1.0").font(.system(size: 18))
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
							}
							.padding(EdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0))
							Divider()
							
						}.frame(width: 334,alignment: .center)
						Spacer()
						
					}.padding()
					.background(Color(.systemBackground))
					.cornerRadius(20)
				}.navigationBarHidden(true)
				
			}//VStack
		}
	}
}

struct settingDetailsView: View {
	@StateObject var curUserViewModel: CurUserViewModel
	
	var body: some View {
		ZStack{
			VStack{
				VStack(spacing: 0){
					//Notification
					HStack {
						Image(systemName: "bell.circle")
							.frame(width: 40)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
							.font(.system(size: 30))
						
						Toggle(isOn: $curUserViewModel.notification_on) {
							Text("Push notifications").font(.title3)
						}
						
						Text(curUserViewModel.notification_on ? "On" : "OFF").font(.title3)
						
					}
					.padding(EdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0))
					Divider()
					
					//App version
					HStack {
						Image(systemName: "simcard.2")
							.frame(width: 40)
							.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
							.font(.system(size: 30))
						
						Text("App version").font(.title3)
						Spacer() // Spread the Text and Image apart
						
						Text("1.0").font(.system(size: 16))
							.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
					}
					.padding(EdgeInsets(top: 17, leading: 0, bottom: 17, trailing: 0))
					Divider()
					
				}.frame(width: 334,alignment: .center)
				Spacer()
				
			}.padding()
			.background(Color(.systemBackground))
			.cornerRadius(20)
		}.navigationBarHidden(true)
	}
}

