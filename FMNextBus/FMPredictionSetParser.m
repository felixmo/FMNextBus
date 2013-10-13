//
//  FMPredictionsParser.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "FMPredictionSetParser.h"

// Objects
#import "FMPrediction.h"
#import "FMPredictionSet.h"
#import "FMDirection.h"


#pragma mark - Private interface

@interface FMPredictionSetParser ()

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, strong) FMPredictionSet *predictionSet;
@property (nonatomic, strong) NSMutableArray *parsedPredictionSets;

@property (nonatomic, strong) FMDirection *currentDirection;
@property (nonatomic, strong) NSMutableArray *parsedDirections;

@property (nonatomic, strong) FMPrediction *currentPrediction;
@property (nonatomic, strong) NSMutableArray *parsedPredictionsForCurrentDirection;

@end


#pragma mark - Implementation

@implementation FMPredictionSetParser


#pragma mark - Property synthesizations

@synthesize currentElementValue;
@synthesize predictionSet;
@synthesize parsedPredictionSets;
@synthesize currentDirection;
@synthesize parsedDirections;
@synthesize parsedPredictionsForCurrentDirection;


#pragma mark - Initialization

- (id)init {
    
    if (self = [super init]) {
        
        parsedPredictionSets = [[NSMutableArray alloc] init];
        
        return self;
    }
    else {
        return nil;
    }
}


#pragma mark - Accessors

- (NSArray *)parsedPredictionss {
    return [NSArray arrayWithArray:parsedPredictionSets];
}


#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
    if ([elementName isEqualToString:@"predictions"]) {
        // New Predictions
        
        self.predictionSet = [[FMPredictionSet alloc] init];
        
        // Map retrieved Predictions attributes to Predictions object properties
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self.predictionSet respondsToSelector:NSSelectorFromString(key)])
                [self.predictionSet setValue:obj forKey:key];
        }];
    }
    
    if ([elementName isEqualToString:@"direction"]) {
        // New Direction
        
        self.currentDirection = [[FMDirection alloc] init];
        
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self.currentDirection respondsToSelector:NSSelectorFromString(key)])
                [self.currentDirection setValue:obj forKey:key];
        }];
    }
    
    if ([elementName isEqualToString:@"prediction"]) {
        
        self.currentPrediction = [[FMPrediction alloc] init];
        
        [attributeDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([self.currentPrediction respondsToSelector:NSSelectorFromString(key)])
                [self.currentPrediction setValue:obj forKey:key];
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
    
    if ([elementName isEqualToString:@"predictions"]) {
        // Done with Predictions entry – add the parsed Predictions object to our Predictionss array
        
        predictionSet.directions = parsedDirections;
        parsedDirections = nil;

        if ([predictionSet.directions count] > 0)
            [parsedPredictionSets addObject:predictionSet];
        
        predictionSet = nil;
    }
    
    if ([elementName isEqualToString:@"direction"]) {

        self.currentDirection.predictions = parsedPredictionsForCurrentDirection;
        parsedPredictionsForCurrentDirection = nil;
        
        if (!self.parsedDirections)
            parsedDirections = [[NSMutableArray alloc] init];
        
        [self.parsedDirections addObject:self.currentDirection];
        self.currentDirection = nil;
    }
    
    if ([elementName isEqualToString:@"prediction"]) {
        
        if (!parsedPredictionsForCurrentDirection)
            parsedPredictionsForCurrentDirection = [[NSMutableArray alloc] init];
        
        [parsedPredictionsForCurrentDirection addObject:self.currentPrediction];
        self.currentPrediction = nil;
    }
    
    currentElementValue = nil;
}

@end
