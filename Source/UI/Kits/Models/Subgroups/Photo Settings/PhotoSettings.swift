//
//  PhotoSettings.swift
//  Slate
//
//  Created by John Coates on 8/23/17.
//  Copyright © 2017 John Coates. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreData

class PhotoSettings {
    var resolution: PhotoResolution = .notSet
    var frameRate: FrameRate = .notSet
    var burstSpeed: BurstSpeed = .notSet
    var priorities: PhotoSettingsPriorities = PhotoSettingsPriorities()
    
    lazy var constraintsResolver = PhotoSettingsConstraintsResolver(settings: self)
    
    var coreDataID: NSManagedObjectID?
    private var coreDataObject: PhotoSettingsCoreData?
    
    func databaseObject(withMutableContext context: NSManagedObjectContext) -> PhotoSettingsCoreData {
        let object: PhotoSettingsCoreData
        
        if let dbObject = coreDataObject {
            object = dbObject
        } else if let coreDataID = coreDataID {
            object = context.object(fromID: coreDataID)
        } else {
            object = context.insertObject()
        }
        coreDataObject = object
        object.resolution = DBPhotoResolution(resolution: resolution)
        object.frameRate = DBFrameRate(frameRate: frameRate)
        object.burstSpeed = DBBurstSpeed(burstSpeed: burstSpeed)
        object.priorities = DBPhotoSettingsPriorities(priorities: priorities)
        
        return object
    }
    
}

// MARK: - Core Data

@objc(PhotoSettingsCoreData)
class PhotoSettingsCoreData: NSManagedObject, Managed, DBObject {
    
    enum CodingKeys: String {
        case resolution
        case frameRate
        case burstSpeed
        case priorities
    }
    
    @NSManaged var resolution: DBPhotoResolution
    @NSManaged var frameRate: DBFrameRate
    @NSManaged var burstSpeed: DBBurstSpeed
    @NSManaged var priorities: DBPhotoSettingsPriorities
    
    class var entityName: String { return String(describing: self) }
    
    class func modelEntity(version: DataModel.Version, graph: DataModelGraph) -> DBEntity {
        let entity = KeyedDBEntity<PhotoSettingsCoreData>()
        entity.add(attribute: .resolution, type: .transformable)
        
        if version >= .two {
            entity.add(attribute: .frameRate, type: .transformable)
        }
        if version >= .three {
            entity.add(attribute: .priorities, type: .transformable)
        }
        if version >= .four {
            entity.add(attribute: .burstSpeed, type: .transformable)
        }
        
        return entity
    }
    
    class func entityPolicy(from: DataModel.Version,
                            to: DataModel.Version) -> NSEntityMigrationPolicy.Type? {
        if from == .one, to == .two {
            return PhotoSettingsAddFrameRate.self
        } else if from == .two, to == .three {
            return PhotoSettingsAddPriorities.self
        } else if from == .three, to == .four {
            return PhotoSettingsAddBurstSpeed.self
        }
        
        return nil
    }
    
    func instance() -> PhotoSettings {
        let instance = PhotoSettings()
        
        instance.coreDataID = objectID
        configureWithStandardProperties(instance: instance)
        return instance
    }
    
    func configureWithStandardProperties(instance: PhotoSettings) {
        instance.resolution = resolution.value
        instance.frameRate = frameRate.value
        instance.burstSpeed = burstSpeed.value
        instance.priorities = priorities.value
    }
    
}
