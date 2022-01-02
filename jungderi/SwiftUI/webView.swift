import SwiftUI
import WebKit

struct ContentView: View {

    var body: some View {
        NavigationView {
            HStack {
                Spacer()
                NavigationLink {
                    MyWebView("https://www.google.com")
                        .edgesIgnoringSafeArea(.all)
                } label: {
                    Text("Google")
                }
                Spacer()
                NavigationLink {
                    MyWebView("https://www.naver.com").edgesIgnoringSafeArea(.all)
                } label: {
                    Text("Naver")
                }
                Spacer()
                NavigationLink {
                    MyWebView("https://www.daum.net")
                        .edgesIgnoringSafeArea(.all)
                } label: {
                    Text("Daum")
                }
                Spacer()
            }.frame(width: .infinity, height: 40, alignment: .center)
        }
    }
}

struct MyWebView: UIViewRepresentable {
    let urlString: String

    init(_ urlString: String) {
        self.urlString = urlString
    }

    func makeUIView(context: Context) -> WKWebView{
        guard let url = URL(string: self.urlString) else {
            return WKWebView()
        }

        let webView = WKWebView()
        webView.load(URLRequest(url: url))

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

