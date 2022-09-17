import SwiftUI

struct SealsScreen : View {
    var body: some View {
        List(){
            SealItem(index: 1, seal: Seal.forward)
        }
    }
}
