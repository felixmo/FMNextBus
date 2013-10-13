//
//  FMRoute.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


@class FMAgency;


/**
 Represents transit agency routes
 */
@interface FMRoute : NSObject


///----------------------------------
/// @name Accessing Route Attributes
///----------------------------------


/**
 The route tag.
 
 This string is used to identify the route in the NextBus system.
 */
@property (nonatomic, strong) NSString *tag;

/**
 The agency.
 
 This object is used to identify the transit agency in the NextBus system.
 */
@property (nonatomic, strong) FMAgency *agency;

/**
 The title of the route.
 */
@property (nonatomic, strong) NSString *title;

/**
 The abbreviated title of the route.
 
 Please note that not all routes have abbreviated titles.
 */
@property (nonatomic, strong) NSString *shortTitle;

@end
