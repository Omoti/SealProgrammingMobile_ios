import SwiftUI

struct SwitchCameraButton: View{
    var action: () -> Void

    var body: some View{
        Button(
            action: action
        ){
            ZStack{
                Image(systemName: "arrow.triangle.2.circlepath")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .frame(width: 50, height: 50, alignment: .center)
                Circle()
                    .stroke(.white, lineWidth: 2)
                    .frame(width: 55, height: 55, alignment: .center)
            }
        }
    }
}

struct SwitchCameraButton_Previews: PreviewProvider {
    static var previews: some View {
        SwitchCameraButton(action: {}).background(.black)
    }
}
