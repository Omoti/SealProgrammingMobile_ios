import SwiftUI

struct SealsScreenView : View {
    @Environment(\.dismiss) private var dismiss
    let seals: [Seal]
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Spacer()
                CloseButton(action: {
                    dismiss()
                })
            }.padding(10)
                .background(Color("PrimaryColor"))
            ScrollViewReader {reader in
                List(){
                    ForEach(seals.indices.reversed(), id: \.self) { index in
                        SealItem(index: index + 1, seal: seals[index])
                            .listRowSeparatorTint(index % 10 == 0 ? .black : .clear)
                    }.onAppear(){
                        reader.scrollTo(0)
                    }
                }.listStyle(PlainListStyle())
            }
        }
    }
}
