//
//  FMRouteParser.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


#import "FMRouteParser.h"


#pragma mark - Private interface

@interface FMRouteParser ()

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, strong) FMRoute *route;
@property (nonatomic, strong) NSMutableArray *routes;

@end


#pragma mark - Implementation

@implementation FMRouteParser


#pragma mark - Property synthesizations

@synthesize currentElementValue;
@synthesize route;
@synthesize routes;


#pragma mark - Initialization

- (id)init {
    
    if (self = [super init]) {
        
        routes = [[NSMutableArray alloc] init];
        
        return self;
    }
    else {
        return nil;
    }
}


#pragma mark - Accessors

- (NSArray *)parsedRoutes {
    return [NSArray arrayWithArray:routes];
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"route"]) {
        // New route
        
        route = [[FMRoute alloc] init];
        
        // Map retrieved route attributes to route object properties
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [route setValue:obj forKey:key];
        }];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [currentElementValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"body"]) {
        // Reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"route"]) {
        // Done with route entry – add the parsed route object to our route array
        [routes addObject:route];
        route = nil;
    }
    
    currentElementValue = nil;
}

@end
