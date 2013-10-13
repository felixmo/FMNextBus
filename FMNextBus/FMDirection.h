//
//  FMDirection.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


/**
 Represents a single direction for a route.
 */
@interface FMDirection : NSObject


///-------------------------------------
/// @name Accessing Direction Attributes
///-------------------------------------


/**
 The available predictions.
 
 An array of FMPrediction objects.
 */
@property (nonatomic, strong) NSArray *predictions;

/**
 The title of the direction.
 */
@property (nonatomic, strong) NSString *title;

@end
