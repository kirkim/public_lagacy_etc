import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
//            Divider().opacity(0)
            Rectangle().frame(height:0)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            ZStack {
                Rectangle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.red)
                    .zIndex(2)
                Rectangle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .zIndex(0)
                Rectangle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
                    .zIndex(3)

            }.padding(.top, 30)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
