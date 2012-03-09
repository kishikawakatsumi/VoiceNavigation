//
//  VNViewController.m
//  VoiceNavigation
//
//  Created by 岸川 克己 on 12/03/09.
//  Copyright (c) 2012年 Kishikawa Katsumi. All rights reserved.
//

#import "VNViewController.h"

@interface VNViewController ()

@end

@implementation VNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
