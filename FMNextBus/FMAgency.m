//
//  FMAgency.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


#import "FMAgency.h"

// Parsers
#import "FMAgencyParser.h"
#import "FMRouteParser.h"


@implementation FMAgency


#pragma mark - Property synthesizations

@synthesize tag;
@synthesize title;
@synthesize shortTitle;
@synthesize regionTitle;


#pragma mark - Getting Agencies

+ (void)fetchAvailableAgenciesOnSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
        
    NSURLRequest *request = [NSURLRequest requestWithCommand:FMNextBusCommandAgencyList];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                               
                                                                                               FMAgencyParser *parser = [[FMAgencyParser alloc] init];
                                                                                               
                                                                                               XMLParser.delegate = parser;
                                                                                               BOOL successful = [XMLParser parse];
                                                                                               
                                                                                               if (successful) {
                                                                                                   // XML parsing was successful
                                                                                                                                                                                                                                                                                                         
                                                                                                   success([parser parsedFeeds]);
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


#pragma mark - Initializing Agencies

+ (FMAgency *)agencyWithTag:(NSString *)tag {
    
    FMAgency *agency = [[FMAgency alloc] init];
    agency.tag = tag;
    
    return agency;
}


#pragma mark - Getting Agency Routes

- (void)fetchRoutesOnSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    
    NSURLRequest *request = [NSURLRequest requestWithCommand:FMNextBusCommandRouteList
                                                andArguments:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              self.tag, FMNextBusParameterAgency,
                                                              nil]];
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                               
                                                                                               FMRouteParser *parser = [[FMRouteParser alloc] init];
                                                                                               
                                                                                               XMLParser.delegate = parser;
                                                                                               BOOL successful = [XMLParser parse];
                                                                                               
                                                                                               if (successful) {
                                                                                                   // XML parsing was successful
                                                                                                   
                                                                                                   success([parser parsedRoutes]);
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
