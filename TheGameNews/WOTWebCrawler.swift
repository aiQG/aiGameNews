//
//  WOTWebCrawler.swift
//  TheGameNews
//
//  Created by 周测 on 3/20/20.
//  Copyright © 2020 aiQG_. All rights reserved.
//

import Foundation
//import Kanna
import Combine


class WOTWebCrawler: ObservableObject{
	var url: URL
	// (ID, Link, Image, Title, Content, Date)
	@Published var result: [CrawlerResult]?
	private(set) var isLoading = false
	
	private var cancellable: AnyCancellable?
	
	private static let imageProcessingQueue = DispatchQueue(label: "WOT-image-processing")
	
	private let domain: String
	
	
	init(url: URL = URL(string: "http://wot.kongzhong.com/zixun/new_1.html")!) {
		self.url = url
		self.result = []
		self.domain = "http://wot.kongzhong.com"
		self.call()
	}
	
	func call() {
		
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.map{
				var output: [CrawlerResult]? = []
				// check state
				if let state = $0.response as? HTTPURLResponse {
					if state.statusCode != 200 {
						//需要代理
						return output
					}
				} else {
					return output
				}
				let html = $0.data
				// gb2312编码
				let cfEncoding = CFStringEncodings.GB_18030_2000
				let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
				if let doc = try? HTML(html: html, encoding: .init(rawValue: encoding)) {
					var Link: [String?] = []
					for link in doc.xpath(#"//ul[@class="newsList"]/li/a"#) {
						Link += [link["href"] ?? ""]
					}
					
					let imageLink: [String?] = []
					//					for image in doc.xpath(#"//img[@itemprop="thumbnailUrl"]"#) {
					//						imageLink += [self.domain + (image["src"] ?? "")]
					//					}
					
					var title: [String?] = []
					for tt in doc.xpath(#"//ul[@class="newsList"]/li/a/span"#) {
						title += [tt.content ?? nil]
					}
					
					let content: [String?] = []
					//					for c in doc.xpath(#"//div[@class="description"]"#) {
					//						content += [c.content ?? nil]
					//					}
					
					var date: [String?] = []
					for d in doc.xpath(#"//ul[@class="newsList"]/li/a/i"#) {
						date += [d.content ?? nil]
					}
					
					// finally get tuples
					
					for i in 0..<max(Link.count, imageLink.count, title.count, content.count, date.count) {
						output!.append(
							CrawlerResult(id: i, link: Link.count > i ? Link[i]! : "https://aiqg.vip",
										  imageLink: imageLink.count > i ? imageLink[i]! : "https://raw.githubusercontent.com/aiQG/aiQG.github.io/master/assets/images/blacktocat.png",
										  title: title.count > i ? title[i]! : "NULL",
										  content: content.count > i ? content[i]! : "null",
										  date: date.count > i ? date[i]! : "**"))
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

