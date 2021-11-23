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
						.frame(maxWidth: .infinity, alignment: .center).padding(.leading,-10)
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
	
	@State var passwordInEditMode = false
	@State var passwordValid = true
	@State var ispwdSecured = true
	
	var body: some View {
		ZStack{
			ScrollView{
				VStack{
					VStack{
						Group{
							Text("CMU Email").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
							
							HStack{
								Text(curUserVm.email)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
									.frame(maxWidth: .infinity, alignment: .leading)
							}
							Divider()
						}
						
						Group{
							Text("First name").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
							
							HStack{
								Text(curUserVm.first_name)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
									.frame(maxWidth: .infinity, alignment: .leading)
							}
							Divider()
						}
						
						Group{
							Text("Last name").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
							HStack{
								Text(curUserVm.last_name)
									.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
									.frame(maxWidth: .infinity, alignment: .leading)
							}
							Divider()
						}
						
						Group{
							
							Text("Campus location").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
							Text(curUserVm.campus_location)
								.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
								.frame(maxWidth: .infinity, alignment: .leading)
							Divider()
						}
						
						Group{
							Text("Password").font(.headline).foregroundColor(.black)
								.frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 10)
							HStack{
								if passwordInEditMode {
									if ispwdSecured {
										SecureField("Password", text: $curUserVm.password)
											.textFieldStyle(EditTextFieldStyle())
											.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
											.disableAutocorrection(true)
											.onChange(of: curUserVm.password, perform: {_ in
												passwordValid = isValidPassword(curUserVm.password)
											})
									} else{
										TextField("Password", text: $curUserVm.password)
											.textFieldStyle(EditTextFieldStyle())
											.foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
											.disableAutocorrection(true)
											.onChange(of: curUserVm.password, perform: {_ in
												passwordValid = isValidPassword(curUserVm.password)
											})
									}

								} else { if ispwdSecured {
										Text("•••••••••••").foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
											.frame(maxWidth: .infinity, alignment: .leading)
									} else {
										Text(curUserVm.password)
											.foregroundColor(Color(red: 95/255.0, green: 90/255.0, blue: 90/255.0, opacity: 1.0))
											.frame(maxWidth: .infinity, alignment: .leading)
									}
								}
								
								Button(action: {ispwdSecured.toggle()
								}) {Image(systemName: self.ispwdSecured ? "eye.slash" : "eye").accentColor(.gray)}
								Spacer(minLength: 15)
								Button(action: {
												if (passwordInEditMode){curUserVm.updatePwd(curUserVm.password)}
												self.passwordInEditMode.toggle()},
											 label: {
												Text(passwordInEditMode ? "Save" : "Edit").font(.system(size: 18)).fontWeight(.light)
													.foregroundColor(Color.blue)
											 })
									.opacity(passwordValid ? 1 : 0.3)
									.disabled(!passwordValid)
							}
							if (passwordValid == false){
								Text("Password must be 8-15 chars,must include at least 1 upper case, 1 lower case letter, and 1 number").font(.system(size: 16)).foregroundColor(Color(red: 128/255.0, green: 0/255.0, blue: 0/255.0, opacity: 1.0))
									.frame(maxWidth: .infinity, alignment: .leading)
							}else if (passwordInEditMode) {
								Text("Password criteria satisfied!").font(.system(size: 16)).foregroundColor(.green)
									.frame(maxWidth: .infinity, alignment: .leading)
							}
							
							Divider()
						}
						Spacer()
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


struct EditTextFieldStyle: TextFieldStyle {
	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding(10)
			.background(Color(red:237/255.0, green: 213/255.0, blue: 213/255.0, opacity: 1.0))
			.cornerRadius(5)
	}
}


func isValidPassword(_ password: String) -> Bool {
	let passwordRegx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
	let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
	return passwordCheck.evaluate(with: password)
}


