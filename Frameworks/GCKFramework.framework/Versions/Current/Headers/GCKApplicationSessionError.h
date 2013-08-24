// Copyright 2013 Google Inc.

/**
 * The error domain for GCKApplicationSession errors.
 */
extern NSString *const kGCKApplicationSessionErrorDomain;

#import "GCKError.h"

/**
 * Error code indicating that an application could not be started.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeFailedToStartApplication;

/**
 * Error code indicating that an application's information could not be queried.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeFailedToQueryApplication;

/**
 * Error code indicating that an application unexpectedly stopped.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeApplicationStopped;

/**
 * Error code indicating that an application channel could not be created.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeFailedToCreateChannel;

/**
 * Error code indicating that an application channel could not be connected.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeFailedToConnectChannel;

/**
 * Error code indicating that an application channel was unexpectedly disconnected.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeChannelDisconnected;

/**
 * Error code indicating that an application could not be stopped.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeFailedToStopApplication;

/**
 * Error code indicating that a protocol error has occurred.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorProtocol;

/**
 * Error code indicating a network I/O timeout.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorTimeout;

/**
 * Error code indicating that a channel cannot be opened because it is already connected.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorAlreadyConnected;

/**
 * Error code indicating an unknown error condition.
 *
 * @memberof GCKApplicationSessionError
 */
extern const NSInteger kGCKApplicationSessionErrorCodeUnknownError;

/**
 * A subclass of GCKError for GCKApplicationSession errors.
 *
 * @ingroup Sessions
 */
@interface GCKApplicationSessionError : GCKError

/** @cond INTERNAL */

- (id)initWithCode:(NSInteger)code additionalUserInfo:(NSDictionary *)userInfo;

+ (NSString *)localizedDescriptionForCode:(NSInteger)code;

/** @endcond */

@end
