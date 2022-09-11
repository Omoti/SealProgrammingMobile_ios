import Foundation
import SwiftUI

struct FoundDeviceItem: View{
    var name: String
    var action: () -> Void
    
    var body: some View{
        HStack{
            Text(name).font(.headline)
            Spacer()
            Button(action: action){
                Text("つなぐ")
            }
        }.padding(10)
    }
}

struct FoundDeviceItem_Previews: PreviewProvider {
    static var previews: some View {
        FoundDeviceItem(name:"name", action: {})
    }
}
