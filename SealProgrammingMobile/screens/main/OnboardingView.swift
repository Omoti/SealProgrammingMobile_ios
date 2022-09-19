import SwiftUI

struct OnboardingView: View{
    var body: some View{
        VStack(alignment: .center){
            Spacer()
            Text("シールプログラミングへようこそ")
                .font(.title2)
            VStack(alignment: .leading){
                Text("1. カメラでシールをとる")
                Text("2. カードックにつなぐ")
                Text("3. プログラムをおくる")
            }.font(.body)
                .padding(10)
            Image("AppLogo")
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
