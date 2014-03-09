//
//  PCWebServiceLocationManager.h
//  Glenigan
//
//  Created by Phillip Caudell on 23/08/2012.
//  Copyright (c) 2012 madebyphill.co.uk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class PCSingleRequestLocationManager;

@interface PCSingleRequestLocationManager : NSObject

typedef void (^PCSingleRequestLocationCompletion)(CLLocation *location, NSError *error);

/**
 Requests a users current location and fires a completion block once it has established that an accurate location has been found, or that an error has occured
 @param completion The PCSingleRequestLocationCompletion block to be fired when the manager has found or failed to find the current location
 **/
- (void)requestCurrentLocationWithCompletion:(PCSingleRequestLocationCompletion)completion;

@end
