# NSExpandableView

Expandable SwiftUI View in a Card like style with 3D effect and scaling animation.

Do not use in List. Use `ScrollView` and `ForEach` to get a list like style.

Usage:

    var body: some View {
        ScrollView {
            NSExpandableView {
                Text("Title")
                    .bold()
                    .padding()
            } bottomContent: {
                Text("Message")
                    .padding([.leading, .trailing, .bottom])
            }
            Spacer()
        }
    }
