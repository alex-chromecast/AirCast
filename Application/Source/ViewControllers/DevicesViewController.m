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
        _devices = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)dealloc
{
    [_deviceManager removeListener:self];
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _deviceManager  = [[GCKDeviceManager alloc] initWithContext:[[AppDelegate shared] googleCastContext]];
    [_deviceManager addListener:self];
    
    [self toggleScanning:self];
}


#pragma mark - View Control

- (IBAction)toggleScanning:(id)sender
{
    if (_deviceManager.scanning)
    {
        [_deviceManager stopScan];
        [_activityIndicatorView stopAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Scan";
        
        [UIView animateWithDuration:0.35f animations:^{
            
            CGRect tableHeaderFrame                 = self.tableView.tableHeaderView.frame;
            tableHeaderFrame.size.height            = 0;
            self.tableView.tableHeaderView.frame    = tableHeaderFrame;
            self.tableView.tableHeaderView          = self.tableView.tableHeaderView;
        }];
    }
    else
    {
        [_deviceManager startScan];
        [_activityIndicatorView startAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Stop Scan";
        
        [UIView animateWithDuration:0.35f animations:^{
            
            CGRect tableHeaderFrame                 = self.tableView.tableHeaderView.frame;
            tableHeaderFrame.size.height            = 44;
            self.tableView.tableHeaderView.frame    = tableHeaderFrame;
            self.tableView.tableHeaderView          = self.tableView.tableHeaderView;
        }];
    }
}


#pragma mark - GCKDeviceManagerListener

- (void)deviceDidComeOnline:(GCKDevice *)device
{
    if (![_devices containsObject:device]) [_devices addObject:device];
    [self.tableView reloadData];
}


- (void)deviceDidGoOffline:(GCKDevice *)device
{
    [_devices removeObject:device];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _devices.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *deviceTableCellID = @"DeviceTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deviceTableCellID];
    GCKDevice *device = _devices[indexPath.row];
    
    cell.textLabel.text = device.friendlyName;
    
    return cell;
}

@end