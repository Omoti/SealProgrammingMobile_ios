import SwiftUI

struct AppInfoScreenView : View{
    @Binding var isPresented: Bool
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    HStack{
                        Text("バージョン")
                        Spacer()
                        Text(version)
                    }   
                }
            }
            .navigationBarTitle("アプリ情報")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: CloseButton(action: {
                isPresented = false
            }))
        }
    }
}

struct AppInfoScreenView_Previews: PreviewProvider {
    @State static var showingAppInfoScreenView = false
    
    static var previews: some View {
        AppInfoScreenView(isPresented: $showingAppInfoScreenView)
    }
}
