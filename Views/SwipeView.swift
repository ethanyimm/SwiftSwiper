import SwiftUI

struct SwipeView: View {
    @State private var offset: CGSize = .zero
    @State private var backgroundColor: Color = .white
    @State private var direction: SwipeDirection = .none
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.3), value: backgroundColor)
            
            Text(directionText)
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(10)
                .shadow(radius: 5)
                .offset(x: offset.width)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: offset)
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    if offset.width > 0 {
                        direction = .right
                        backgroundColor = .green
                    } else if offset.width < 0 {
                        direction = .left
                        backgroundColor = .red
                    }
                }
                .onEnded { _ in
                    offset = .zero
                }
        )
    }
    
    private var directionText: String {
        switch direction {
        case .left: return "Swiping Left"
        case .right: return "Swiping Right"
        default: return "Swipe Left or Right"
        }
    }
}