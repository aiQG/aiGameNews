//
//  WebCrawler.swift
//  TheGameNews
//
//  Created by 周测 on 3/12/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

//取得基本信息
import Foundation
//import Kanna
import Combine

struct CrawlerResult: Identifiable {
	var id: Int = -1
	var link: String = "https://aiqg.vip"
	var imageLink: String = "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png"
	var title: String = "NULL"
	var content: String = "null"
	var date: String = "***"
}


class WebCrawler: ObservableObject{
	var url: URL
	// (ID, Link, Image, Title, Content, Date)
	@Published var result: [CrawlerResult]?
	private(set) var isLoading = false
	
	private var cancellable: AnyCancellable?
	
	private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
	
	private let domain: String
	
	
	init(url: URL = URL(string: "https://www.wowchina.com/zh-cn/news.frag?page=1")!) {
		self.url = url
		self.result = []
		self.domain = "https://www.wowchina.com"
		self.call()
	}
	
	func call() {
		
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map{
				var output: [CrawlerResult]? = []
				// check state
				if let state = $0.response as? HTTPURLResponse {
					if state.statusCode != 200 {
						return output
					}
				} else {
					return output
				}
				let html = $0.data
				if let doc = try? HTML(html: html, encoding: .utf8) {
					var Link: [String?] = []
					
					for link in doc.xpath(#"//a[@class="Link NewsBlog-link"]"#) {
						Link += [self.domain + (link["href"] ?? "")]
					}
					
					var imageLink: [String?] = []
					for image in doc.xpath(#"//div[@class="Tile-bg"]"#) {
						let str = image["style"] ?? ""
						let temp = str[str.range(of: "\"//[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]\"", options: .regularExpression)!]
						
						imageLink += ["http:" + temp.replacingOccurrences(of: "\"", with: "")]
					}
					
					var title: [String?] = []
					for tt in doc.xpath(#"//div[@class="NewsBlog-title"]"#) {
						title += [tt.content ?? nil]
					}
					
					var content: [String?] = []
					for c in doc.xpath(#"//p[@class="NewsBlog-desc color-beige-medium font-size-xSmall"]"#) {
						content += [c.content ?? nil]
					}
					
					var date: [String?] = []
					for d in doc.xpath(#"//div[@class="NewsBlog-date LocalizedDateMount"]"#) {
						date += [d.content ?? nil]
					}
					// finally get tuples
					for i in 0..<max(Link.count, imageLink.count, title.count, content.count, date.count) {
						output!.append(
							CrawlerResult(id: i, link: Link[i] ?? "https://aiqg.vip",
										  imageLink: imageLink[i] ?? "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png",
										  title: title[i] ?? "NULL",
										  content: content[i] ?? "null",
										  date: date[i] ?? "**"))
					}
				}
				return output
		}
		.replaceError(with: nil)
		.subscribe(on: Self.imageProcessingQueue)
		.receive(on: DispatchQueue.main)
		.assign(to: \.result, on: self)
		
	}
	
	
	func cancel() {
		cancellable?.cancel()
	}
	
	private func onStart() {
		isLoading = true
	}
	
	private func onFinish() {
		isLoading = false
	}
	
}
