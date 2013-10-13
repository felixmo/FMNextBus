//
//  FMStopParser.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "FMStopParser.h"
#import "FMStop.h"

#pragma mark - Private interface

@interface FMStopParser ()

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, strong) FMStop *stop;
@property (nonatomic, strong) NSMutableArray *stops;

@end


#pragma mark - Implementation

@implementation FMStopParser


#pragma mark - Property synthesizations

@synthesize currentElementValue;
@synthesize stop;
@synthesize stops;


#pragma mark - Initialization

- (id)init {
    
    if (self = [super init]) {
        
        stops = [[NSMutableArray alloc] init];
        
        return self;
    }
    else {
        return nil;
    }
}


#pragma mark - Accessors

- (NSArray *)parsedStops {
    return [NSArray arrayWithArray:stops];
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"stop"]) {
        // New Stop
        
        self.stop = [[FMStop alloc] init];
        
        // Map retrieved Stop attributes to Stop object properties
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self.stop respondsToSelector:NSSelectorFromString(key)])
                [self.stop setValue:obj forKey:key];
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
    
    if ([elementName isEqualToString:@"Stop"]) {
        // Done with Stop entry – add the parsed Stop object to our Stop array
        [stops addObject:stop];
        stop = nil;
    }
    
    currentElementValue = nil;
}

@end
