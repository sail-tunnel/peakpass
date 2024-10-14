
//
//  SwiftUIView.swift
//  peakpass
//
//  Created by 郑余靖 on 2023/4/18.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    let effect: UIVisualEffect
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}

struct AppTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }
            Text("Second View")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }
        }
        .background(
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
                .edgesIgnoringSafeArea(.all)
        )
    }
}


struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
