//
//  FMStopTests.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-09-16.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "FMNextBus.h"


@interface FMStopTests : SenTestCase

@end

@implementation FMStopTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testGetPredictionsForSpecificStop
{
    FMStop *stop = [FMStop stopWithId:[NSNumber numberWithInt:845]
                            forAgency:[FMAgency agencyWithTag:@"ttc"]
                              onRoute:nil];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [stop getPredictionsOnSuccess:^(NSArray *predictionSets) {
        
        for (FMPredictionSet *set in predictionSets) {
            NSLog(@"--------------------------------------------------");
            NSLog(@"%@ @ %@", set.routeTag, set.stopTitle);
            NSLog(@"--------------------------------------------------");
            
            for (FMDirection *dir in set.directions) {
                NSLog(@"-> %@", dir.title);
                
                for (FMPrediction *prediction in dir.predictions) {
                    NSLog(@"* %i seconds", [prediction.seconds intValue]);
                }
                
                NSLog(@"--------------------------------------------------");
            }
        }
        
        STAssertTrue([predictionSets count] > 0, nil);
        
        dispatch_semaphore_signal(semaphore);
    }
                          failure:^(NSError *error) {
                              STFail([error description]);
                          }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

@end
