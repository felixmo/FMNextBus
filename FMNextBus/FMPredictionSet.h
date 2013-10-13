//
//  FMPredictions.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


/**
 A set of predictions for the different directions of a route, for a stop.
 */
@interface FMPredictionSet : NSObject


///-----------------------------------
/// @name Accessing Agency Attributes
///-----------------------------------


/**
 The available directions.
 
 An array of FMDirection objects.
 */
@property (nonatomic, strong) NSArray *directions;

/**
 The title of the route.
 */
@property (nonatomic, strong) NSString *routeTitle;

/**
 The route tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSNumber *routeTag;

/**
 The title of the stop.
 */
@property (nonatomic, strong) NSString *stopTitle;

/**
 The stop tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSNumber *stopTag;

@end
