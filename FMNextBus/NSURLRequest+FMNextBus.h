//
//  NSURLRequest+FMNextBus.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (FMNextBus)

+ (NSURLRequest *)requestWithCommand:(NSString *)command;
+ (NSURLRequest *)requestWithCommand:(NSString *)command andArguments:(NSDictionary *)args;

@end
