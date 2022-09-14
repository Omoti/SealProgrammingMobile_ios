import SwiftUI

struct IconButton: View{
    var image: Image
    var label: String
    var action: () -> Void
    
    var body: some View{
        Button(
            action: action
        ){
            VStack{
                image
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: .bottom)
                Text(label)
            }.frame(width: 80, height: 60, alignment: .center)
                .foregroundColor(.white)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(image: Image(systemName: "list.bullet"), label: "リスト", action: {})
            .background(.black)
    }
}
