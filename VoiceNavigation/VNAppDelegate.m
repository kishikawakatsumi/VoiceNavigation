//
//  VNAppDelegate.m
//  VoiceNavigation
//
//  Created by Kishikawa Katsumi on 12/03/09.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import "VNAppDelegate.h"

@implementation VNAppDelegate

@synthesize window;

- (void)dealloc {
    self.window = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

@end
