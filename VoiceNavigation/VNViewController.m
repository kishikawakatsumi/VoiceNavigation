//
//  VNViewController.m
//  VoiceNavigation
//
//  Created by Kishikawa Katsumi on 12/03/09.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import "VNViewController.h"
#import <QuartzCore/QuartzCore.h>

static const NSTimeInterval VNDictationRepeatInterval = 3.0;

@interface VNViewController () {
    float count;
    CADisplayLink *displayLink;
}

@property (nonatomic, retain) id dictationController;

@end

@implementation VNViewController

@synthesize searchBar;
@synthesize webView;
@synthesize dictationView;
@synthesize resultLabel;
@synthesize micImageView;
@synthesize dictationIndicator;
@synthesize timerView;

@synthesize textInputView;
@synthesize dictationController;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.searchBar = nil;
    self.webView = nil;
    self.dictationView = nil;
    self.resultLabel = nil;
    self.micImageView = nil;
    self.dictationIndicator = nil;
    self.timerView = nil;
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    dictationView.layer.cornerRadius = 8.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(keyboardWillShow:) 
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(applicationWillEnterForeground:) 
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(applicationDidEnterBackground:) 
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(dictationRecordingDidEnd:) 
                                                 name:VNDictationRecordingDidEndNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(dictationRecognitionSucceeded:) 
                                                 name:VNDictationRecognitionSucceededNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(dictationRecognitionFailed:) 
                                                 name:VNDictationRecognitionFailedNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![textInputView isFirstResponder]) {
        [textInputView becomeFirstResponder];
    }
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

#pragma mark -

- (void)resetProgress {
    count = 0.0f;
    [timerView setProgress:count animated:NO];
}

- (void)showWaitingServerProcessIndicator {
    [dictationIndicator startAnimating];
    micImageView.hidden = YES;
}

- (void)hideWaitingServerProcessIndicator {
    [dictationIndicator stopAnimating];
}

- (void)startDictation {
    [dictationController performSelector:@selector(startDictation)];
    
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onTimer:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    [self resetProgress];
    micImageView.hidden = NO;
    resultLabel.text = nil;
}

- (void)stopDictation {
    [dictationController performSelector:@selector(stopDictation)];
    
    [displayLink invalidate];
    displayLink = nil;
    
    [self showWaitingServerProcessIndicator];
    micImageView.hidden = YES;
}

- (void)cancelDictation {
    [dictationController performSelector:@selector(cancelDictation)];
    
    [displayLink invalidate];
    displayLink = nil;
    
    [self resetProgress];
    micImageView.hidden = NO;
    resultLabel.text = nil;
}

#pragma mark -

- (NSString *)wholeTestWithDictationResult:(NSArray *)dictationResult {
    NSMutableString *text = [NSMutableString string];
    for (UIDictationPhrase *phrase in dictationResult) {
        [text appendString:phrase.text];
    }
    
    return text;
}

- (void)processDictationText:(NSString *)text {
    resultLabel.text = text;
    
    if ([text hasSuffix:[NSString stringWithUTF8String:"を検索"]]) {
        text = [text substringToIndex:[text length] - 3];

        searchBar.text = text; 
        
        NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/m?q=%@&ie=UTF-8&oe=UTF-8&client=safari",
                                                 [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [webView loadRequest:[NSURLRequest requestWithURL:searchURL]];
    } else if ([text isEqualToString:[NSString stringWithUTF8String:"戻る"]]) {
        [webView goBack];
    } else if ([text isEqualToString:[NSString stringWithUTF8String:"進む"]]) {
        [webView goForward];
    }
}

#pragma mark -

- (void)onTimer:(CADisplayLink *)sender {
    count += sender.duration / 10.0;
    [timerView setProgress:count animated:YES];
    if (count >= 1.0f) {        
        [self stopDictation];
    }
}

#pragma mark -

- (void)keyboardWillShow:(NSNotification *)notification {
    self.dictationController = [NSClassFromString(@"UIDictationController") performSelector:@selector(sharedInstance)];
    if (dictationController) {
        [self startDictation];
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    [self startDictation];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [self cancelDictation];
}

#pragma mark -

- (void)dictationRecordingDidEnd:(NSNotification *)notification {
}

- (void)dictationRecognitionSucceeded:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSArray *dictationResult = [userInfo objectForKey:VNDictationResultKey];
    
    NSString *text = [self wholeTestWithDictationResult:dictationResult];
    [self processDictationText:text];
    
    [self hideWaitingServerProcessIndicator];
    
    [self performSelector:@selector(startDictation) withObject:nil afterDelay:VNDictationRepeatInterval];
}

- (void)dictationRecognitionFailed:(NSNotification *)notification {
    resultLabel.text = @"-";
    
    [self hideWaitingServerProcessIndicator];
    
    [self performSelector:@selector(startDictation) withObject:nil afterDelay:VNDictationRepeatInterval];
}

@end
