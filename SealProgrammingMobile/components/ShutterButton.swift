import SwiftUI

struct ShutterButton: View{
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            ZStack{
                Circle()
                    .fill(.white)
                    .frame(width: 65, height: 65, alignment: .center)
                Circle()
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 75, height: 75, alignment: .center)
            }
        }
    }
}

struct ShutterButton_Previews: PreviewProvider {
    static var previews: some View {
        ShutterButton(action: {})
    }
}
