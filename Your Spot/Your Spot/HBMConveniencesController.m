//
//  HBMConveniencesController.m
//  Your Spot
//
//  Created by Matthew Cheetham on 08/03/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "HBMConveniencesController.h"

@interface HBMConveniencesController ()

@property (nonatomic, strong) NSMutableArray *conveniences;

@end

@implementation HBMConveniencesController

static HBMConveniencesController *sharedController = nil;

+ (HBMConveniencesController *)sharedController
{
    @synchronized(self) {
        if (sharedController == nil) {
            sharedController = [[self alloc] init];
        }
    }
    return sharedController;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.conveniences = [NSMutableArray array];
        
    }
    return self;
}

@end
