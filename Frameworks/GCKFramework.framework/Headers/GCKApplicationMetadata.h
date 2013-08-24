// Copyright 2013 Google Inc.

#import <Foundation/Foundation.h>

/**
 * Metadata about a first-screen application.
 *
 * @ingroup Sessions
 */
@interface GCKApplicationMetadata : NSObject<NSCopying>

/** The application's name. */
@property(nonatomic, copy, readonly) NSString *name;

/** The application's human-readable title. */
@property(nonatomic, copy, readonly) NSString *title;

/** The URL of the application's icon. */
@property(nonatomic, copy, readonly) NSURL *iconURL;

/**
 * Designated initializer. Constructs a new ApplicationMetadata object with the supplied property
 * values.
 *
 * @param name The name of the application.
 * @param title The title of the application (for display purposes).
 * @param iconURL A URL to the application icon.
 * @param supportedProtocolNamespaces The namespace names of the message protocols that this
 * application supports.
 */
- (id)initWithName:(NSString *)name
                 title:(NSString *)title
               iconURL:(NSURL *)iconURL
    supportedProtocols:(NSArray *)supportedProtocolNamespaces;

/**
 * Tests if this application supports the message protocol with the given namespace.
 *
 * @param protocolNamespace The protocol namespace.
 */
- (BOOL)doesSupportProtocol:(NSString *)protocolNamespace;

@end
