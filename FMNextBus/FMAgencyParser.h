//
//  FMAgencyFeedParser.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


#import "FMAgency.h"


@interface FMAgencyParser : NSObject <NSXMLParserDelegate>

- (NSArray *)parsedFeeds;

@end