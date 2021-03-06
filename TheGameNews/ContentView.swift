//
//  ContentView.swift
//  TheGameNews
//
//  Created by 周测 on 3/11/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//
// 所有进入新闻的列表选项
import SwiftUI

struct ContentView: View {
	
	var body: some View {
		NavigationView {
			List {
				NavigationLink(destination: WoWNews()) {
					Image("WoWicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("魔兽世界(WoW)")
				}
				NavigationLink(destination: EFTNews()) {
					Image("EFTicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("逃离塔科夫(EFT) (需要代理)")
				}
				NavigationLink(destination: YDNews()) {
					Image("YDicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("云顶之弈")
				}
				NavigationLink(destination: EVENews()) {
					Image("EVEicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("星战前夜(EVE Online)")
				}
				NavigationLink(destination: WOWSNews()) {
					Image("WOWSicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("战舰世界(WOWS)")
				}
				NavigationLink(destination: WOTNews()) {
					Image("WOTicon")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 30, height: 30)
					Text("坦克世界(WOT)")
				}
			}
			.navigationBarTitle(Text("Content"))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
