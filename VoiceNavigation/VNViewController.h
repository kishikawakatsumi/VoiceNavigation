//
//  VNViewController.h
//  VoiceNavigation
//
//  Created by Kishikawa Katsumi on 12/03/09.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VNTextInputView.h"

@interface VNViewController : UIViewController

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIView *dictationView;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;
@property (nonatomic, retain) IBOutlet UIImageView *micImageView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *dictationIndicator;
@property (nonatomic, retain) IBOutlet UIProgressView *timerView;

@property (nonatomic, retain) IBOutlet VNTextInputView *textInputView;

@end
