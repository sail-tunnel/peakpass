
//
//  DashboardView.swift
//  peakpass
//
//  Created by 郑余靖 on 2023/4/18.
//

import SwiftUI

struct DashboardView: View {
    @State var showRuleModal = false
    @State var showProxyModal = false
    @State var showSiteModal = false
    @State var isMenuVisible = false
    
    @State var isOn = false
    
    @State var selection = "直连模式"
    
    let options = ["直连模式", "全局模式", "规则模式"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Form {
                        Section {
                            Toggle("开关", isOn: $isOn)
                        }
                        
                        Section {
                            
                            Picker("路由模式", selection: $selection) {
                                ForEach(options, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.automatic)
                            
                        } header: {
                            Text("通用")
                        }
                    }
                    .navigationBarTitle("Peak Pass")
                    .navigationBarItems(
                        trailing:
                            Menu {
                                Button(action: {
                                    // Handle menu item action
                                    isMenuVisible = false
                                    showRuleModal = !showRuleModal
                                    DashboardEvent().buttonTapped()
                                }) {
                                    Text("添加规则")
                                }
                                Button(action: {
                                    // Handle menu item action
                                    isMenuVisible = false
                                    showProxyModal = !showProxyModal
                                }) {
                                    Text("添加代理")
                                }
                                Button(action: {
                                    // Handle menu item action
                                    isMenuVisible = false
                                    showSiteModal = !showSiteModal
                                }) {
                                    Text("添加网站")
                                }
                            } label: {
                                Button(action: {
                                    isMenuVisible = true
                                }) {
                                    Image(systemName: "plus")
                                }
                            }
                            .menuStyle(BorderlessButtonMenuStyle())
                    )
                }
                .zIndex(1)
            }
        }
        .sheet(isPresented: $showRuleModal) {
            RuleCreateView()
        }
        .sheet(isPresented: $showSiteModal) {
            SiteCreateView()
        }
        .sheet(isPresented: $showProxyModal) {
            ProxyCreateView()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
