//
//  NewsItemData+CoreDataClass.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 14.06.2021.
//
//

import Foundation
import CoreData

@objc(NewsItemData)
public class NewsItemData: NSManagedObject {

}

extension NewsItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsItemData> {
        return NSFetchRequest<NewsItemData>(entityName: "NewsItemData")
    }

    @NSManaged public var imageUrlString: String?
    @NSManaged public var newsItemDescription: String?
    @NSManaged public var newsItemTitle: String?
    @NSManaged public var channelData: ChannelData?

}

extension NewsItemData : Identifiable {

}
