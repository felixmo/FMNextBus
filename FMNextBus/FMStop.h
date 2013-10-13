//
//  FMStop.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


@class FMAgency;
@class FMRoute;


/**
 Represents a stop on a route
 */
@interface FMStop : NSObject


///--------------------------------
/// @name Accessing Stop Attributes
///--------------------------------


/**
The agency this stop belongs to.

This object is used to identify the transit agency in the NextBus system.
*/
@property (nonatomic, strong) FMAgency *agency;

/**
 The route this stop belongs to.
 
 This object is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) FMRoute *route;

/**
 The stop tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSString *tag;

/**
 The title of the stop.
 */
@property (nonatomic, strong) NSString *title;

/**
 The abbreviated title of the stop.
 
 Please note that not all stop have abbreviated titles.
 */
@property (nonatomic, strong) NSString *shortTitle;

/**
 The latitude of the stop.
 */
@property (nonatomic, strong) NSNumber *lat;

/**
 The longitude of the stop.
 */
@property (nonatomic, strong) NSNumber *lon;

/**
 An optional numeric identifier for the stop.
 
 Typically used for telephone or SMS systems. This property may not be avaliable on all transit agencies.
 */
@property (nonatomic, strong) NSNumber *stopId;


///-------------------------
/// @name Initializing Stops
///-------------------------


+ (FMStop *)stopWithId:(NSNumber *)stopId forAgency:(FMAgency *)agency onRoute:(FMRoute *)route;


///--------------------------
/// @name Getting Predictions
///--------------------------


- (void)getPredictionsOnSuccess:(void(^)(NSArray *predictionSets))success failure:(void(^)(NSError *error))failure;

@end
