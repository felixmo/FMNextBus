//
//  FMAgency.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


@class FMRoute;


/**
 Represents transit agencies
 */
@interface FMAgency : NSObject


///------------------------
/// @name Getting Agencies
///------------------------


/**
 On completion, an array containing all of the available transit agencies as FMAgency objects is given.
 */
+ (void)fetchAvailableAgenciesOnSuccess:(void(^)(NSArray *agencies))success failure:(void(^)(NSError *error))failure;


///-----------------------------
/// @name Initializing Agencies
///-----------------------------


+ (FMAgency *)agencyWithTag:(NSString *)tag;


///-----------------------------------
/// @name Accessing Agency Attributes
///-----------------------------------


/**
 The agency tag.
 
 This string is used to identify the transit agency in the NextBus system.
 */
@property (nonatomic, strong) NSString *tag;

/**
 The title of the transit agency.
 */
@property (nonatomic, strong) NSString *title;

/**
 The abbreviated title of the transit agency.
 
 Please note that not all feeds have abbreviated titles.
 */
@property (nonatomic, strong) NSString *shortTitle;

/**
 The title of the region served by the transit agency.
 */
@property (nonatomic, strong) NSString *regionTitle;


///-----------------------------
/// @name Getting Agency Routes
///-----------------------------


/**
 On completion, an array containing all of the routes for the transit agency as FMRoute objects is given
 */
- (void)fetchRoutesOnSuccess:(void(^)(NSArray *routes))success failure:(void(^)(NSError *error))failure;

/**
 On completion, return the requested route if found.
 */
- (void)fetchRouteWithTag:(NSString *)routeTag success:(void(^)(FMRoute *route))success failure:(void(^)(NSError *error))failure;


@end
