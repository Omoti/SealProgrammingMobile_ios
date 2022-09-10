import SwiftUI
import Foundation

struct CircleButton: View{
    var image: Image
    var label: String
    var color: Color
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            VStack{
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .bottom)
                Text(label)
            }.frame(width: 60, height: 60, alignment: .center)
                .padding(10)
                .background(color)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}
