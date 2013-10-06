//
//  AppDelegate.h
//  AirCast
//
//  Created by Andrew Theis on 8/24/13.
//  Copyright (c) 2013 Andrew Theis. All rights reserved.
//



@interface AppDelegate : UIResponder <UIApplicationDelegate>

+ (AppDelegate *)shared;

+ (NSString *)googleCastApplicationIdentifier;

@property (strong, nonatomic) GCKContext *googleCastContext;

@property (strong, nonatomic) UIWindow *window;

@end