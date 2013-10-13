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


@interface FMPrediction : NSObject

@property (nonatomic, strong) FMAgency *agency;
@property (nonatomic, strong) FMRoute *route;
@property (nonatomic, strong) FMStop *stop;

@property (nonatomic, strong) NSNumber *seconds;
@property (nonatomic, strong) NSNumber *routeTag;
@property (nonatomic, strong) NSNumber *stopTag;

@end
