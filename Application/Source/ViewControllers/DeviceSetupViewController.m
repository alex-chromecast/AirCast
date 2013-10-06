//
//  DeviceViewController.m
//  AirCast
//
//  Created by Andrew Theis on 10/6/13.
//  Copyright (c) 2013 Andrew Theis. All rights reserved.
//


#import "AppDelegate.h"
#import "DeviceSetupViewController.h"



@interface DeviceSetupViewController () <GCKApplicationSessionDelegate>
{
    GCKApplicationSession *_applicationSession;
}

@end



@implementation DeviceSetupViewController

#pragma mark - Object Lifecycle

- (void)dealloc
{
    [_applicationSession endSession];
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _device.friendlyName;
    
    _applicationSession             = [[GCKApplicationSession alloc] initWithContext:[[AppDelegate shared] googleCastContext] device:_device];
    _applicationSession.delegate    = self;
    
    [_applicationSession startSessionWithApplication:[AppDelegate googleCastApplicationIdentifier]];
}


#pragma mark - GCKApplicationSessionDelegate

- (void)applicationSessionDidStart
{
    NSLog(@"Application session started.");
}


- (void)applicationSessionDidFailToStartWithError:(GCKApplicationSessionError *)error
{
    NSLog(@"Application session failed to start: %@", error);
}


- (void)applicationSessionDidEndWithError:(GCKApplicationSessionError *)error
{
    NSLog(@"Application session ended with error: %@", error);
}

@end