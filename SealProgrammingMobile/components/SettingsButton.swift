import SwiftUI

struct SettingsButton: View{
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            Image(systemName: "gearshape.fill")
                .foregroundColor(.white)
                .font(.system(size: 20))
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(action: {}).background(.black)
    }
}
