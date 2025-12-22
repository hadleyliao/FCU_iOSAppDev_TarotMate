import SwiftUI

struct CustomHeaderView: View {
    let title: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("PrimaryText"))
                .padding(.top, 20) // Consistent top padding for all headers
            
            Divider()
                .background(Color("ListItemBackground"))
                .padding(.horizontal)
                .padding(.bottom)
        }
    }
}

#Preview {
    CustomHeaderView(title: "預覽標題")
        .background(Color("AppBackground"))
}
