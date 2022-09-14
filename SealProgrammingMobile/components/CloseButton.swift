import SwiftUI

struct CloseButton: View{
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: 25))
        }
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton(action: {}).background(.black)
    }
}
