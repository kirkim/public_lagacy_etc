import SwiftUI

struct ContentView: View {
    
    private let today = Date()
    
//    func dateFormatter() -> DateFormatter {
//        let formater = DateFormatter()
//
//        formmater.dateFormat = "YYYY년 MM월 d일 (EEEE)"
////        formater.dateStyle = .full
//
//        return formmater
//    }
    
    static let dateFormater: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        return formater
    }()
    
    var body: some View {
        VStack {
            
            Text("Turtles are an order of reptiles known as Testudines, characterized by a shell developed mainly from their ribs. Modern turtles are divided into two major groups, the side-necked turtles and hidden neck turtles which differ in the way the head retracts. There are 360 living and recently extinct species of turtles, including tortoises and terrapins. They are found on most continents, some islands and much of the ocean. Like other reptiles, birds, and mammals, they breathe air and do not lay eggs underwater, although many species live in or around water. Genetic evidence typically places them in close relation to crocodilians and birds.")
                .tracking(0.5)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .lineLimit(7)
                .lineSpacing(13)
                .shadow(color: .orange, radius: 1.2, x: 5, y: 7)
                .truncationMode(.tail)
                .padding()
            
                .background(.yellow)
                .cornerRadius(20)
                .padding()
            
                .background(.green)
                .cornerRadius(10)
                .padding(.bottom, 30)
            
            Text("안녕하세요")
                .foregroundColor(.white)
                .padding()
                .background(.blue)
            Text("오늘의 날짜입니다: \(today, formatter: ContentView.dateFormater)")
        }.padding(30)
    }
}

