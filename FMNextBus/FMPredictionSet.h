//
//  FMPredictions.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

@interface FMPredictionSet : NSObject

@property (nonatomic, strong) NSArray *directions;

@property (nonatomic, strong) NSString *routeTitle;
@property (nonatomic, strong) NSNumber *routeTag;

@property (nonatomic, strong) NSString *stopTitle;
@property (nonatomic, strong) NSNumber *stopTag;

@end
