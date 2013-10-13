//
//  FMStop.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


@class FMAgency;
@class FMRoute;


@interface FMStop : NSObject

@property (nonatomic, strong) FMAgency *agency;
@property (nonatomic, strong) FMRoute *route;

@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *shortTitle;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lon;
@property (nonatomic, strong) NSNumber *stopId;

+ (FMStop *)stopWithId:(NSNumber *)stopId forAgency:(FMAgency *)agency onRoute:(FMRoute *)route;

- (void)getPredictionsOnSuccess:(void(^)(NSArray *predictionSets))success failure:(void(^)(NSError *error))failure;

@end
