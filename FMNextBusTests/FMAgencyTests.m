//
//  FMAgencyFeedTests.m
//  FMNextBus
//
//  Created by Felix Mo on 2013-07-28.
//  Copyright (c) 2013 Felix Mo. All rights reserved.
//

#import "FMAgencyTests.h"
#import "FMNextBus.h"


@implementation FMAgencyTests

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

- (void)testFetchAvailableFeeds {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [FMAgency fetchAvailableAgenciesOnSuccess:^(NSArray *feeds) {
        
        NSLog(@"-------------------------");
        NSLog(@"     FETCHED %i FEEDS ", [feeds count]);
        NSLog(@"-------------------------");
        
        for (FMAgency *feed in feeds) {
            NSLog(@"| AGENCY FEED");
            NSLog(@"|   tag: %@", feed.tag);
            NSLog(@"|   title: %@", feed.title);
            NSLog(@"|   shortTitle: %@", feed.shortTitle);
            NSLog(@"|   regionTitle: %@", feed.regionTitle);
            NSLog(@"-------------------------\n");
        }
        
        STAssertTrue([feeds count] > 0, nil);
        
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
