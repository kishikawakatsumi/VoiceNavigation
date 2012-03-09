//
//  VNTextInputView.h
//  VoiceNavigation
//
//  Created by Kishikawa Katsumi on 12/03/10.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const VNDictationRecordingDidEndNotification;
extern NSString * const VNDictationRecognitionSucceededNotification;
extern NSString * const VNDictationRecognitionFailedNotification;

extern NSString * const VNDictationResultKey;

@interface VNTextInputView : UIView<UITextInput, UIGestureRecognizerDelegate>

@end
