//
//  NSURLRequest+FMNextBus.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "NSURLRequest+FMNextBus.h"

@implementation NSURLRequest (FMNextBus)

+ (NSURLRequest *)requestWithCommand:(NSString *)command {
    
    return [NSURLRequest requestWithCommand:command andArguments:nil];
}

+ (NSURLRequest *)requestWithCommand:(NSString *)command andArguments:(NSDictionary *)args {
    
    NSMutableString *urlString = [NSMutableString stringWithString:@"http://webservices.nextbus.com/service/publicXMLFeed?"];
    [urlString appendFormat:@"command=%@", command];
    
    for (NSString *parameter in args) {
        [urlString appendFormat:@"&%@=%@", parameter, [args objectForKey:parameter]];
    }
    
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:60];
}

@end
