//
//  FMPrediction.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


@class FMAgency;
@class FMRoute;
@class FMStop;


/**
 Represents a single vehicle prediction for a direction of a route, at a stop.
 */
@interface FMPrediction : NSObject


///---------------------------------------
/// @name Accessing Prediction Attributes
///---------------------------------------


/**
The agency this prediction belongs to.

This object is used to identify the transit agency in the NextBus system.
*/
@property (nonatomic, strong) FMAgency *agency;

/**
 The route this prediction belongs to.
 
 This object is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) FMRoute *route;

/**
 The stop this prediction belongs to.
 
 This object is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) FMStop *stop;

/**
 The predicted number of seconds before the arrival of the vehicle
 */
@property (nonatomic, strong) NSNumber *seconds;

/**
 The route tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSNumber *routeTag;

/**
 The stop tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSNumber *stopTag;

@end
