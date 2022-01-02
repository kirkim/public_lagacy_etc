import SwiftUI

struct ContentView: View {
    
    @State private var isClickedView = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    MyVstackView()
                    MyVstackView(isClickedView: $isClickedView)
                    MyVstackView(isClickedView: $isClickedView)
                    MyVstackView(isClickedView: $isClickedView)
                }
                .padding(isClickedView ? 40 : 10)
                .background(isClickedView ? .yellow : .blue)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.isClickedView.toggle()
                    }
                }
                NavigationLink {
                    MySecondView()
                } label: {
                    Text("다음화면")
                        .font(.system(size: 30, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.red)
                }
                .padding(.top, 50)
            }

        }
        
    }
}

struct MyVstackView: View {
    
    @Binding var isClickedView: Bool
    
    init(isClickedView: Binding<Bool> = .constant(false)) {
        _isClickedView = isClickedView
    }
    
    var body: some View {
        VStack {
            ForEach(1..<4) { i in
                Text("\(i)!")
                    .fontWeight(.bold)
                    .font(.system(size: 60))
                    .foregroundColor(isClickedView ? .orange : .white)
            }
        }
        .background(isClickedView ? .red : .green)
    }
}

struct MySecondView: View {
    
    @State private var index: Int = 0
    private let bgColor = [
        Color.red,
        Color.blue,
        Color.yellow,
        Color.brown,
        Color.green
    ]
    
    var body: some View {
        VStack {
            Text("배경 아이템 인덱스 \(self.index)")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(self.bgColor[index])
        .onTapGesture {
            self.index = (self.index + 1) % 5
        }
    }
}
