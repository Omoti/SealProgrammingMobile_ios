import SwiftUI

struct InfoButton: View{
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            Image(systemName: "info.circle")
                .foregroundColor(.white)
                .font(.system(size: 18))
        }
    }
}

struct InfoButton_Previews: PreviewProvider {
    static var previews: some View {
        InfoButton(action: {}).background(.black)
    }
}
