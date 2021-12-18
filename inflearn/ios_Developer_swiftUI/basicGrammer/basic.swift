// MARK: - 9. ForEach
//struct LocationInfo: Hashable, Identifiable {
//    var id = UUID()
//    var city = ""
//    var weather = ""
//}
//
//struct ContentView: View {
//    @State private var Locations = [
//        LocationInfo(city: "Seoul", weather: "sunny"),
//        LocationInfo(city: "Busan", weather: "cloudy"),
//        LocationInfo(city: "Seoul", weather: "sunny"),
//        LocationInfo(city: "LA", weather: "rainy")
//    ]
//    var body: some View {
//        List {
//            ForEach(Locations, id: \.self) { location in
//                HStack {
//                    Text("\(location.city)")
//                    Text("\(location.weather)")
//                }
//            }
//
//            ForEach(Locations) { location in
//                HStack {
//                    Text("\(location.city)")
//                    Text("\(location.weather)")
//                }
//            }
//
//            ForEach(0..<Locations.count) { i in
//                HStack {
//                    Text("\( (i + 1))")
//                    Text("\(Locations[i].city)")
//                    Text("\(Locations[i].weather)")
//                }
//            }
//        }
//    }
//}

// MARK: - 10. List Section
//struct Animal: Identifiable {
//    let id = UUID()
//    let name: String
//    let index: Int
//}
//
//struct ContentView: View {
//
//    var animalList = [
//        Animal(name: "dog", index: 2),
//        Animal(name: "dog", index: 1),
//        Animal(name: "cat", index: 4),
//        Animal(name: "cat", index: 7),
//        Animal(name: "bird", index: 8),
//        Animal(name: "cat", index: 5),
//        Animal(name: "bird", index: 9),
//        Animal(name: "dog", index: 3),
//        Animal(name: "cat", index: 6)
//    ]
//
//    // dog: [Animal, Animal, Animal]
//    var animalGrouped: [String : [Animal]] {
//
//        var groupData = Dictionary(grouping: animalList) {
//            $0.name }
//        for (key, value) in groupData {
//            groupData[key] = value.sorted(by: { $0.index < $1.index })
//        }
//        return groupData
//    }
//
//    var groupKey: [String] {
//        animalGrouped.map( { $0.key } )
//    }
//
//    var body: some View {
//        List {
//            ForEach(groupKey, id: \.self) { animalKey in
//                Section {
//                    ForEach(animalGrouped[animalKey]!) { animal in
//                        HStack {
//                            Text("\(animal.index)")
//                            Text("\(animal.name)")
//                        }
//                    }
//                } header: {
//                    Text("\(animalKey)")
//                }
//
//            }
//        }
//    }
//}

// MARK: - 11. ViewModifier
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Main Title!")
//                .font(.largeTitle)
//                .foregroundColor(.black)
//                .bold()
//            Text("Sub Title!")
//                .modifier(TextMyStyle())
//            Text("Descripttion!")
//                .modifier(TextMyStyle(myColor: .red))
//            Text("Descripttion!")
//                .customFont(color: .orange)
//        }
//    }
//}
//
//struct TextMyStyle: ViewModifier {
//    var myWeight = Font.Weight.regular
//    var myFont = Font.title2
//    var myColor = Color.black
//
//    func body(content: Content) -> some View {
//        content
//            .font(myFont.weight(myWeight))
//            .foregroundColor(myColor)
//            .padding(.bottom, 20)
//            .font(myFont.italic()) // italic 사용 못한다고 볼 수 있지만 방법이 다를뿐 이런식으로 사용하면된다.
//    }
//}
//
//extension Text {
//    func customFont(color: Color) -> Text {
//        self
//            .font(.title2)
//            .bold()
//            .italic()
//            .foregroundColor(color)
//    }
//}

// MARK: - 12. Alert View
//struct ContentView: View {
//
//    @State private var isShowAlert = false
//    @State private var selectText = "x"
//
//    var body: some View {
//        VStack{
//            Spacer()
//            Button("show alert") {
//                isShowAlert.toggle()
//            }
//            .alert(isPresented: $isShowAlert) {
////                Alert(title: Text("alert title"), message: nil, dismissButton: .default(Text("s")))
//                let primaryButton = Alert.Button.default(Text("done")) {
//                    selectText = "done"
//                }
//
//                let secondaryButton = Alert.Button.default(Text("cancel")) {
//                    selectText = "cancel"
//                }
//                return Alert(title: Text("show alert"),
//                             primaryButton: primaryButton,
//                             secondaryButton: secondaryButton)
//            }
//            Spacer()
//            Text("\(isShowAlert.description)")
//            Spacer()
//            Text("\(selectText)")
//            Spacer()
//        }
//    }
//}

// MARK: - 13. WebView Basic
///* ContentView.swift */
//struct ContentView: View {
//    var body: some View {
//
////        WebView(url: "https://kirkim.github.io") // swiftUI로만 구현해서 사용
//        MyWebVC() // storyboard 사용해서 네비게이션컨트롤로 감싼형태(웹 제목을 따오기 위해)
//    }
//}
//
///* WebView.swift */
//import WebKit
//import SwiftUI
//
//struct WebView: UIViewRepresentable {
//
//    var url: String
//
//    func makeUIView(context: Context) -> some UIView {
//
//        let url = URL(string: self.url)
//        let request = URLRequest(url: url!)
//
//        let wkWebView = WKWebView()
//        wkWebView.load(request)
//
//        return wkWebView
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//
//    }
//}
//
//// UIViewController
//struct MyWebVC: UIViewControllerRepresentable {
//
//    func makeUIViewController(context: Context) -> some UIViewController {
//
//        let webVC = UIStoryboard(name: "WebViewController", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//
//        // 네비게이션으로 감싼 웹뷰로 만들어줄 수 있음, 제목이나 다른 커스텀 아이템 사용가능해짐
//        let navi = UINavigationController(rootViewController: webVC)
//
//        return navi
//
//    }
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//    }
//}
//
///* WebViewController.swift */
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, WKNavigationDelegate {
//
//    @IBOutlet weak var webView: WKWebView!
//
//    var url = "https://kirkim.github.io"
//
//    override func viewDidLoad() {
//        self.webView.navigationDelegate = self
//        self.webView.load(URLRequest(url: URL(string: url)!))
//    }
//
//    // data를 못가져올 수 있으니 didFinish(끝났을때) 가져오는 방식으로 한다.
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // get webView Title
//        self.webView.evaluateJavaScript("document.title") { (result, error) in
//            self.navigationItem.title = result as? String
//        }
//    }
//}

// MARK: - 14. WebView JS Bridge => swiftUI의 내용은 없음
// 13과 WebView.swift, ContentView.swift는 동일 => story보드방식으로 프로젝트를 생성했다면 필요없긴함.

///* WebViewController */
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, WKScriptMessageHandler {
//
//    var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let contentController = WKUserContentController()
//        contentController.add(self, name: "iPhoneInfo") // 이름을 찾아서 수신
//        contentController.add(self, name: "aaa") // 이름을 찾아서 수신
//        contentController.add(self, name: "bbb") // 이름을 찾아서 수신
//
//        let configuration = WKWebViewConfiguration()
//        configuration.userContentController = contentController
//
//        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
//        webView.navigationDelegate = self
//        webView.uiDelegate = self
//
//        self.view.addSubview(webView)
//
//        let localFile = Bundle.main.path(forResource: "TestWeb", ofType: "html")
//        let url = URL(fileURLWithPath: localFile!)
//
//        let request = URLRequest(url: url)
//
//        webView.load(request)
//    }
//
//    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//
//        if message.name == "iPhoneInfo" {
//            print(message.body) // web에서 보낸내용 확인가능
//            print("call native")
//        }
//    }
//}
//
//extension WebViewController: WKUIDelegate {
//    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
//        let alertController = UIAlertController(title: "js test", message: message, preferredStyle: .alert)
//        let doneAction = UIAlertAction(title: "확인", style: .default) { _ in
//            completionHandler()
//        }
//
//        alertController.addAction(doneAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//}
//
//extension WebViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("showAlert('hi')", completionHandler: nil)
//    }
//}
//
///* TestWeb.html */
//// 백엔드에서 구현할 코드를 html에서 사용하기 위해 버튼형식으로 구현한 것이다. 이 코드에서 핵심은 loadiPhonInfo()함수 내부의 코드이다.
//// 그 함수 내부의 구조에 대해 잘 이해하고 있다. 그냥 암기하자..
//<!DOCTYPE html>
//<html>
//    <head>
//        <title>JS TEXT</title>
//
//        <script type="text/javascript">
//
//            function showAlert(text){
//                alert('Java Script Test \n' + text)
//            }
//
//            function loadiPhoneInfo(){
//                window.webkit.messageHandlers.iPhoneInfo.postMessage('someParam');
//                window.webkit.messageHandlers.aaa.postMessage('someParam');
//                window.webkit.messageHandlers.bbb.postMessage('someParam');
//            }
//        </script>
//    </head>
//    <body>
//        <button style="font-size:50px;width:500px;height:200px" onclick='loadiPhoneInfo();'>iPhone Info</button></br>
//    </body>
//</html>

// MARK: - 15. 
