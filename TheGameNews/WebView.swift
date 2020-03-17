//
//  WebView.swift
//  TheGameNews
//
//  Created by 周测 on 3/16/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
	
	var request: CrawlerResult
	
	init(request: CrawlerResult = CrawlerResult()) {
		self.request = request
	}
	
	func makeUIView(context: Context) -> WKWebView  {
		return WKWebView()
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {
		uiView.load(URLRequest(url: URL(string: request.link) ?? URL(string: CrawlerResult().link)! ))
	}
	
}

struct WebView_Previews: PreviewProvider {
	static var previews: some View {
		WebView()
	}
}
