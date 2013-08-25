//
//  ViewController.m
//  AirCast
//
//  Created by Andrew Theis on 8/24/13.
//  Copyright (c) 2013 Andrew Theis. All rights reserved.
//


#import "AppDelegate.h"
#import "DevicesViewController.h"



@interface DevicesViewController () <GCKDeviceManagerListener>
{
    __weak IBOutlet UIActivityIndicatorView *_activityIndicatorView;
    
    __weak IBOutlet UILabel *_statusLabel;
    
    GCKDeviceManager *_deviceManager;
    
    NSMutableArray *_devices;
}

@end



@implementation DevicesViewController

#pragma mark - Object Lifecycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _deviceManager  = [[GCKDeviceManager alloc] initWithContext:[[AppDelegate shared] googleCastContext]];
        _devices        = [[NSMutableArray alloc] init];
    }
    
    return self;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self toggleScanning:self];
}


#pragma mark - View Control

- (IBAction)toggleScanning:(id)sender
{
    if (_deviceManager.scanning)
    {
        [_deviceManager stopScan];
        [_activityIndicatorView stopAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Start Scanning";
        _statusLabel.text = [NSString stringWithFormat:@"%i devices available", _devices.count];
    }
    else
    {
        [_deviceManager startScan];
        [_activityIndicatorView startAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Stop Scanning";
        _statusLabel.text = @"Scanning ...";
    }
}


#pragma mark - GCKDeviceManagerListener

- (void)deviceDidComeOnline:(GCKDevice *)device
{
    [_devices addObject:device];
    [self.tableView reloadData];
}


- (void)deviceDidGoOffline:(GCKDevice *)device
{
    [_devices removeObject:device];
    [self.tableView reloadData];
}

@end