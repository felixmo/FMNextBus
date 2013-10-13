//
//  FMAgencyFeedParser.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//


#import "FMAgencyParser.h"


#pragma mark - Private interface

@interface FMAgencyParser ()

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, strong) FMAgency *feed;
@property (nonatomic, strong) NSMutableArray *feeds;

@end


#pragma mark - Implementation

@implementation FMAgencyParser


#pragma mark - Property synthesizations

@synthesize currentElementValue;
@synthesize feed;
@synthesize feeds;


#pragma mark - Initialization

- (id)init {
    
    if (self = [super init]) {
        
        feeds = [[NSMutableArray alloc] init];
        
        return self;
    }
    else {
        return nil;
    }
}


#pragma mark - Accessors

- (NSArray *)parsedFeeds {
    return [NSArray arrayWithArray:feeds];
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"agency"]) {
        // New feed
        
        feed = [[FMAgency alloc] init];
        
        // Map retrieved feed attributes to feed object properties
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([feed respondsToSelector:NSSelectorFromString(key)])
                [feed setValue:obj forKey:key];
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
    
    if ([elementName isEqualToString:@"agency"]) {
        // Done with feed entry – add the parsed feed object to our feed array
        [feeds addObject:feed];
        feed = nil;
    }
    
    currentElementValue = nil;
}

@end
