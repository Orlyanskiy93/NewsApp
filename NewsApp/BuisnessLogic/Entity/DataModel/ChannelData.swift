//
//  ChannelData+CoreDataClass.swift
//  NewsApp
//
//  Created by Дмитрий Орлянский on 14.06.2021.
//
//

import Foundation
import CoreData

@objc(ChannelData)
public class ChannelData: NSManagedObject {

}

extension ChannelData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChannelData> {
        return NSFetchRequest<ChannelData>(entityName: "ChannelData")
    }

    @NSManaged public var title: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var newsData: NSSet?

}

// MARK: Generated accessors for newsData
extension ChannelData {

    @objc(addNewsDataObject:)
    @NSManaged public func addToNewsData(_ value: NewsItemData)

    @objc(removeNewsDataObject:)
    @NSManaged public func removeFromNewsData(_ value: NewsItemData)

    @objc(addNewsData:)
    @NSManaged public func addToNewsData(_ values: NSSet)

    @objc(removeNewsData:)
    @NSManaged public func removeFromNewsData(_ values: NSSet)

}

extension ChannelData : Identifiable {

}
