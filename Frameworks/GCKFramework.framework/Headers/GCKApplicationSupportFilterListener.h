// Copyright 2013 Google Inc.

#import <Foundation/Foundation.h>

#import "GCKDeviceManager.h"

@class GCKContext;
@class GCKDevice;

/**
 * An implementation of GCKDeviceManagerListener that filters devices based on whether they support
 * a given application. The listener passes the filtered results to another, downstream listener.
 *
 * @ingroup Discovery
 */
@interface GCKApplicationSupportFilterListener : NSObject <GCKDeviceManagerListener>

/**
 * Designated initializer. Constructs a new GCKApplicationSupportFilterListener with the given
 * context, application name, and downstream listener.
 *
 * @param context The context.
 * @param applicationName The name of the application that must be supported.
 * @param protocolNamespaces The namespaces of any protocols that the application must support. May
 * be <code>nil</code>.
 * @param listener The downstream listener which should receive the filtered notifications.
 */
- (id)initWithContext:(GCKContext *)context
      applicationName:(NSString *)applicationName
            protocols:(NSArray *)protocolNamespaces
   downstreamListener:(id<GCKDeviceManagerListener>)listener;

/**
 * Delegates directly to the downstream listener.
 */
- (void)scanStarted;

/**
 * If the device is accepted by the filter, notifies the downstream listener that the device has
 * come online. Otherwise, does nothing.
 */
- (void)deviceDidComeOnline:(GCKDevice *)device;

/**
 * If the device was previously accepted by this filter, notifies the downstream listener that it
 * has gone offline.
 */
- (void)deviceDidGoOffline:(GCKDevice *)device;

/**
 * Delegates directly to the downstream listener.
 */
- (void)scanStopped;

@end
