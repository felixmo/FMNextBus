//
//  FMPredictionsParser.h
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

@interface FMPredictionSetParser : NSObject <NSXMLParserDelegate>

- (NSArray *)parsedPredictionSets;

@end
