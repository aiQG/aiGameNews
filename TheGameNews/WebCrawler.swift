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
	@Published var result: [CrawlerResult] {
		didSet {
			print("aaa")
		}
	}
	
	init(url: URL = URL(string: "https://www.wowchina.com/zh-cn/news.frag?page=1")!) {
		self.url = url
		self.result = []
		self.call()
	}
	
	func call() {
		let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
			guard let html = data else { return }
			if let doc = try? HTML(html: html, encoding: .utf8) {
				var Link: [String?] = []
				
				for link in doc.xpath(#"//a[@class="Link NewsBlog-link"]"#) {
					Link += [link["href"] ?? nil]
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
					self.result.append(
						CrawlerResult(id: i, link: Link[i] ?? "https://aiqg.vip",
									  imageLink: imageLink[i] ?? "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png",
									  title: title[i] ?? "NULL",
									  content: content[i] ?? "null",
									  date: date[i] ?? "**"))
				}
			}
		}
		task.resume()
		sleep(10)
		print("endd")
	}
}
