import SwiftUI


struct SliderView: View {
  
  var width = UIScreen.main.bounds.width / 2
  
  @State
  var angle: Double = 0
  
  @State
  var value: Double = 0 // Value ranging from 0 to 100

  var body: some View {
    GeometryReader { geometry in
      let totalPadding: CGFloat = 60
      let width = geometry.size.width - totalPadding
      
      ZStack(alignment: .top) {
        ZStack {
          Circle()
            .trim(from: 0, to: 0.5)
            .stroke(Color.black.opacity(0.6), lineWidth: 40)
            .frame(width: width, height: width)
            .shadow(radius: 2, x: 5, y: 5)
          
          Circle()
            .trim(from: 0, to: angle / 360)
            .stroke(Color.appPurple, lineWidth: 40)
            .frame(width: width , height: width )
          
          Circle()
            .fill(Color.appOrange)
            .frame(width: 30, height: 30)
            .offset(x: (width) / 2, y: 1)
            .rotationEffect(.init(degrees: angle))
            .gesture(DragGesture().onChanged(onChange(value:)))
          
        }.rotationEffect(.init(degrees: 180))
//          .offset(y: 20)
        
        Text("\(Int(value)) Kg")
          .font(.system(size: 40))
          .font(.headline)
          .fontWeight(.bold)
          .padding(.top, 70)
      }.padding(.horizontal, totalPadding / 2)
    }
  }
  
  func onChange(value: DragGesture.Value) {
    let vector = CGVector(dx: value.location.x, dy: value.location.y)
//    12.5 = 25 circle raidus
    let radians = atan2(vector.dy - 12.5, vector.dx - 12.5)
    let tempAngle = radians * 180 / .pi
    let angle = tempAngle < 0 ? (360 + tempAngle) : tempAngle
//    since max slide is 0.8
//    0.8 * 36 = 288
    
    if angle <= 180 {
      self.value = angle
      withAnimation(.linear) {
        self.angle = Double(angle)
      }
    }
  }
}


#Preview {
  SliderView()
}
