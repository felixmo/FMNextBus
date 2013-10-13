//
//  FMRouteTests.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-29.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "FMRouteTests.h"
#import "FMNextBus.h"


@implementation FMRouteTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testFetchRoutesForTTC {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    FMAgency *ttc = [FMAgency agencyWithTag:@"ttc"];
    [ttc fetchRoutesOnSuccess:^(NSArray *routes) {
        
        NSLog(@"-------------------------");
        NSLog(@"    FETCHED %i ROUTES ", [routes count]);
        NSLog(@"-------------------------");
        
        for (FMRoute *route in routes) {
            NSLog(@"| ROUTE");
            NSLog(@"|   tag: %@", route.tag);
            NSLog(@"|   title: %@", route.title);
            NSLog(@"|   shortTitle: %@", route.shortTitle);
            NSLog(@"-------------------------\n");
        }
        
        STAssertTrue([routes count] > 0, nil);
        
        dispatch_semaphore_signal(semaphore);
    }
                      failure:^(NSError *error) {
                          STFail([error description]);
                      }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
}

- (void)testFetchSpecifcRouteFromTTC {
 
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    FMAgency *ttc = [FMAgency agencyWithTag:@"ttc"];
    [ttc fetchRouteWithTag:@"509"
                   success:^(FMRoute *route) {
                       NSLog(@"-------------------------");
                       NSLog(@"      FETCHED ROUTE      ");
                       NSLog(@"-------------------------");
                       NSLog(@"| ROUTE");
                       NSLog(@"|   tag: %@", route.tag);
                       NSLog(@"|   title: %@", route.title);
                       NSLog(@"|   shortTitle: %@", route.shortTitle);
                       NSLog(@"-------------------------\n");
                       
                       STAssertTrue(route != nil, nil);
                       
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
