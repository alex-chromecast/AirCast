// Copyright 2013 Google Inc.

#import <Foundation/Foundation.h>

/**
 * The base class for all GCK framework errors.
 *
 * GCKError allows errors to be daisy chained together. The localized description of a GCKError
 * will include descriptions of any chained errors.
 *
 * @ingroup Utilities
 */
@interface GCKError : NSError

/** @cond INTERNAL */

/**
 * Designated initializer.
 */
- (id)initWithDomain:(NSString *)domain
                code:(NSInteger)code
  additionalUserInfo:(NSDictionary *)additionalUserInfo;

/**
 * Returns a localized description for a given error code.
 */
+ (NSString *)localizedDescriptionForCode:(NSInteger)code;

/** @endcond */

@end
