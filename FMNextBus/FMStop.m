//
//  FMStop.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "FMStop.h"

// Parsers
#import "FMPredictionSetParser.h"

// Objects
#import "FMRoute.h"
#import "FMAgency.h"
#import "FMPrediction.h"


@implementation FMStop

+ (FMStop *)stopWithId:(NSNumber *)stopId forAgency:(FMAgency *)agency onRoute:(FMRoute *)route {
    
    FMStop *stop = [[FMStop alloc] init];
    stop.agency = agency;
    stop.route = route;
    stop.stopId = stopId;
    
    return stop;
}

- (void)getPredictionsOnSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    NSURLRequest *request = [NSURLRequest requestWithCommand:FMNextBusCommandPredictions
                                                andArguments:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              self.stopId, FMNextBusParameterStopId,
                                                              self.agency.tag, FMNextBusParameterAgency,
                                                              nil]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                               
                                                                                               FMPredictionSetParser *parser = [[FMPredictionSetParser alloc] init];
                                                                                               
                                                                                               XMLParser.delegate = parser;
                                                                                               BOOL successful = [XMLParser parse];
                                                                                               
                                                                                               if (successful) {
                                                                                                   // XML parsing was successful
                                                                                                   
                                                                                                   success([parser parsedPredictionSets]);
                                                                                               }
                                                                                               else {
                                                                                                   // XML parsing failed.
                                                                                                   
                                                                                                   failure([XMLParser parserError]);
                                                                                               }
                                                                                           }
                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                                                               
                                                                                               failure(error);
                                                                                           }];
    [operation start];
}

@end
