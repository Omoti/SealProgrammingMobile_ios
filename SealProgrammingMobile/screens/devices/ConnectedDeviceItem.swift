import SwiftUI

struct ConnectedDeviceItem: View{
    var name: String
    var action: () -> Void
    
    var body: some View{
        HStack(alignment: .center){
            Image("BluetoothIconConnected")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color("PrimaryColor"))
                .scaledToFit()
                .frame(width: 25, height: 25, alignment: .bottom)
            Text(name).font(.headline)
            Spacer()
            Button(action: action){
                Text("きる").foregroundColor(.red)
            }
        }.padding(10)
    }
}

struct ConnectedDeviceItem_Previews: PreviewProvider {
    static var previews: some View {
        FoundDeviceItem(name:"name", action: {})
    }
}

