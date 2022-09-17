import SwiftUI

struct SealsScreenView : View {
    let seals: [Seal]
    
    var body: some View {
        List(){
            ForEach(seals, id: \.self) { seal in
                SealItem(index: 1, seal: seal)
            }
        }
    }
}
