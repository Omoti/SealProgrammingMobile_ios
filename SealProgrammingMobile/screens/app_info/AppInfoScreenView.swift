import SwiftUI

struct AppInfoScreenView : View{
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView{
            VStack{
                Text("a")
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
