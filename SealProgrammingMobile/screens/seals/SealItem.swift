import SwiftUI

struct SealItem : View{
    let index: Int
    let seal: Seal

    var body: some View {
        HStack(alignment: .center, spacing: 10){
            ZStack{
                Circle()
                    .fill(Color(seal.color))
                    .frame(width: 25, height: 25, alignment: .center)
                Text(String(index)).foregroundColor(.white)
            }
            Text(seal.text)
            Spacer()
        }.padding(20)
    }
}

extension Color {
  init(_ hex: Int) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: 1.0
    )
  }
}

struct SealItem_Previews: PreviewProvider {
    static var previews: some View {
        SealItem(index: 1, seal: Seal.forward)
            .background(.blue)
    }
}
