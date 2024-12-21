import SwiftUI
import WebKit

struct ContentView: View {

    var body: some View {
        NavigationView {
            ZStack {
                Image("myImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(y: -500)
                VStack {
                    NavigationLink(destination: {
                        MyWebView("https://www.google.com")
                            .edgesIgnoringSafeArea(.all)
                    }, label: {
                        ProfileView()
                    })
                    Image(systemName: "bolt.circle")
                        .font(.system(size: 200))
                        .foregroundColor(.yellow)
                        .shadow(color: .gray, radius: 1, x: 8, y: 8)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("프로필"))
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Image("person1")
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay(
                Circle().foregroundColor(.black)
                    .opacity(0.4)
            )
            .overlay(
                Circle().stroke(.teal, lineWidth: 8)
                    .padding()
            )
            .overlay(
                Circle().stroke(.yellow, lineWidth: 8)
            )
            .overlay(
                Text("안녕")
                    .foregroundColor(.white)
                    .font(.system(size: 50))
            )
    }
}

struct MyWebView: UIViewRepresentable {
    private let url: String
    
    init (_ url: String) {
        self.url = url
    }
    func makeUIView(context: Context) -> some WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<MyWebView>) {
    }
}
