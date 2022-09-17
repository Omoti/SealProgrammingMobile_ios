import SwiftUI

struct SealsScreenView : View {
    let seals: [Seal]
    
    var body: some View {
        VStack{
            ScrollViewReader {reader in
                List(){
                    ForEach(seals.indices.reversed(), id: \.self) { index in
                        SealItem(index: index + 1, seal: seals[index])
                    }.onAppear(){
                        reader.scrollTo(0)
                    }
                    
                }
            }
        }
    }
}
