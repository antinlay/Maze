#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"school21.Maze";

/// The "AccentColor" asset catalog color resource.
static NSString * const ACColorNameAccentColor AC_SWIFT_PRIVATE = @"AccentColor";

/// The "AccentReverseColor" asset catalog color resource.
static NSString * const ACColorNameAccentReverseColor AC_SWIFT_PRIVATE = @"AccentReverseColor";

/// The "PathColor" asset catalog color resource.
static NSString * const ACColorNamePathColor AC_SWIFT_PRIVATE = @"PathColor";

#undef AC_SWIFT_PRIVATE
