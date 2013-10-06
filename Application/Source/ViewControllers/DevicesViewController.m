//
//  ViewController.m
//  AirCast
//
//  Created by Andrew Theis on 8/24/13.
//  Copyright (c) 2013 Andrew Theis. All rights reserved.
//


#import "AppDelegate.h"
#import "DeviceSetupViewController.h"
#import "DevicesViewController.h"



@interface DevicesViewController () <GCKDeviceManagerListener>
{
    __weak IBOutlet UIActivityIndicatorView *_activityIndicatorView;
    
    __weak IBOutlet UILabel *_statusLabel;
    
    GCKDeviceManager *_deviceManager;
    
    NSMutableArray *_devices;
    
    NSUInteger _selectedDeviceRow;
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


#pragma mark - Object Control

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushDeviceSetupViewController"])
    {
        DeviceSetupViewController *deviceSetupVC = segue.destinationViewController;
        deviceSetupVC.device = _devices[_selectedDeviceRow];
    }
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _deviceManager  = [[GCKDeviceManager alloc] initWithContext:[[AppDelegate shared] googleCastContext]];
    [_deviceManager addListener:self];
    
    // Scan for 5 seconds.
    [self toggleScanning:self];
    [self performSelector:@selector(toggleScanning:) withObject:self afterDelay:5.0f];
}


#pragma mark - View Control

- (void)setTableHeaderViewHidden:(BOOL)hidden
{
    [UIView animateWithDuration:0.35f animations:^{
        
        CGRect tableHeaderFrame                 = self.tableView.tableHeaderView.frame;
        tableHeaderFrame.size.height            = hidden ? 0 : 44;
        self.tableView.tableHeaderView.frame    = tableHeaderFrame;
        self.tableView.tableHeaderView          = self.tableView.tableHeaderView;
    }];
}


- (IBAction)toggleScanning:(id)sender
{
    if (_deviceManager.scanning)
    {
        [_deviceManager stopScan];
        [_activityIndicatorView stopAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Scan";
        
        [self setTableHeaderViewHidden:YES];
    }
    else
    {
        [_deviceManager startScan];
        [_activityIndicatorView startAnimating];
        
        self.navigationItem.rightBarButtonItem.title = @"Stop Scan";
        
        [self setTableHeaderViewHidden:NO];
    }
}


#pragma mark - GCKDeviceManagerListener

- (void)deviceDidComeOnline:(GCKDevice *)device
{
    if (![_devices containsObject:device])  [_devices addObject:device];
    [self.tableView reloadData];
}


- (void)deviceDidGoOffline:(GCKDevice *)device
{
    [_devices removeObject:device];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *deviceTableCellID = @"DeviceTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deviceTableCellID];
    GCKDevice *device = _devices[indexPath.row];
    
    cell.textLabel.text = device.friendlyName;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedDeviceRow = indexPath.row;
}

@end