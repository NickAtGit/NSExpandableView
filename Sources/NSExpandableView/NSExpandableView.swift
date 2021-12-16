import SwiftUI

@available(iOS 13.0, *)
public struct NSExpandableView<TopContent: View, BottomContent: View>: View {
    private let topContent: () -> TopContent
    private let bottomContent: () -> BottomContent
    private let cornerRadius: CGFloat
    private let roundedCornerStyle: RoundedCornerStyle
    @State private var isExpanded = false
    
    public init(@ViewBuilder topContent: @escaping () -> TopContent,
                @ViewBuilder bottomContent: @escaping () -> BottomContent,
                cornerRadius: CGFloat = 10,
                roundedCornerStyle: RoundedCornerStyle = .circular) {
        self.topContent = topContent
        self.bottomContent = bottomContent
        self.cornerRadius = cornerRadius
        self.roundedCornerStyle = roundedCornerStyle
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: roundedCornerStyle)
                .foregroundColor(Color(.secondarySystemBackground))
            VStack(alignment: .leading) {
                HStack {
                    topContent()
                    Spacer()
                    Image(systemName: "chevron.down")
                        .padding(.trailing)
                        .imageScale(.large)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }

                VStack {
                    if isExpanded {
                        bottomContent()
                    }
                }
                .frame(maxWidth: .infinity)
                .rotation3DEffect(.degrees(isExpanded ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                .scaleEffect(isExpanded ? 1 : 0.4)
                .animation(.spring(), value: isExpanded)
            }
        }
        .contentShape(Rectangle())
        .animation(.spring(), value: isExpanded)
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
}
