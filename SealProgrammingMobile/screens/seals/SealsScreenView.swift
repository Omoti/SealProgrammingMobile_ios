import SwiftUI

struct SealsScreenView : View {
    let seals: [Seal]
    
    var body: some View {
        if seals.count > 0 {
            ScrollViewReader {reader in
                List(){
                    ForEach(seals.indices.reversed(), id: \.self) { index in
                        SealItem(index: index + 1, seal: seals[index])
                            .listRowSeparatorTint((index > 0 && index % 10 == 0) ? .black : .clear)
                    }.onAppear(){
                        reader.scrollTo(0)
                    }
                }.listStyle(PlainListStyle())
            }
        }else{
            VStack{
                Text("シールがありません")
                    .foregroundColor(.black)
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            ).background(.white)
        }
    }
}
