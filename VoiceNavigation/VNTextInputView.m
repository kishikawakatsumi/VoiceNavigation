//
//  VNTextInputView.m
//  VoiceNavigation
//
//  Created by Kishikawa Katsumi on 12/03/10.
//  Copyright (c) 2012 Kishikawa Katsumi. All rights reserved.
//

#import "VNTextInputView.h"

NSString * const VNDictationRecordingDidEndNotification = @"VNDictationRecordingDidEndNotification";
NSString * const VNDictationRecognitionSucceededNotification = @"VNDictationRecognitionSucceededNotification";
NSString * const VNDictationRecognitionFailedNotification = @"VNDictationRecognitionFailedNotification";

NSString * const VNDictationResultKey = @"VNDictationResultKey";

@implementation VNTextInputView

#pragma mark C-

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)resignFirstResponder {
	return [super resignFirstResponder];
}

#pragma mark -

- (UIView *)inputView {
    return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
}

#pragma mark UIKeyInput methods

- (void)deleteBackward {
    
}

- (BOOL)hasText {
    return NO;
}

- (void)insertText:(NSString *)text {
    
}

#pragma mark UITextInput methods

- (NSString *)textInRange:(UITextRange *)range {
    return nil;
}

- (void)replaceRange:(UITextRange *)range withText:(NSString *)text {

}

/* Text may have a selection, either zero-length (a caret) or ranged.  Editing operations are
 * always performed on the text from this selection.  nil corresponds to no selection. */

- (UITextRange *)selectedTextRange {
    return nil;
}

- (void)setSelectedTextRange:(UITextRange *)selectedTextRange {
    
}

/* If text can be selected, it can be marked. Marked text represents provisionally
 * inserted text that has yet to be confirmed by the user.  It requires unique visual
 * treatment in its display.  If there is any marked text, the selection, whether a
 * caret or an extended range, always resides witihin.
 *
 * Setting marked text either replaces the existing marked text or, if none is present,
 * inserts it from the current selection. */ 

- (UITextRange *)markedTextRange {
    return nil;
}

- (NSDictionary *)markedTextStyle {
    return nil;
}

- (void)setMarkedTextStyle:(NSDictionary *)markedTextStyle {
    
}

- (void)setMarkedText:(NSString *)markedText selectedRange:(NSRange)selectedRange {
    
}

- (void)unmarkText {

}

/* The end and beginning of the the text document. */
- (UITextPosition *)beginningOfDocument {
    return nil;
}

- (UITextPosition *)endOfDocument {
    return nil;
}

- (UITextRange *)textRangeFromPosition:(UITextPosition *)fromPosition toPosition:(UITextPosition *)toPosition {
    return nil;
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position offset:(NSInteger)offset {
    return nil;
}

- (UITextPosition *)positionFromPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
    return nil;
}

/* Simple evaluation of positions */
- (NSComparisonResult)comparePosition:(UITextPosition *)position toPosition:(UITextPosition *)other {
    return 0;
}

- (NSInteger)offsetFromPosition:(UITextPosition *)from toPosition:(UITextPosition *)toPosition {
    return 0;
}

/* A system-provied input delegate is assigned when the system is interested in input changes. */
- (id<UITextInputDelegate>)inputDelegate {
    return nil;
}

- (void)setInputDelegate:(id<UITextInputDelegate>)inputDelegate {
    
}

/* A tokenizer must be provided to inform the text input system about text units of varying granularity. */
- (id<UITextInputTokenizer>)tokenizer {
    return nil;
}

/* Layout questions. */
- (UITextPosition *)positionWithinRange:(UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction {
    return nil;
}

- (UITextRange *)characterRangeByExtendingPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction {
    return nil;
}

/* Writing direction */
- (UITextWritingDirection)baseWritingDirectionForPosition:(UITextPosition *)position inDirection:(UITextStorageDirection)direction {
    return 0;
}

- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(UITextRange *)range {

}

/* Geometry used to provide, for example, a correction rect. */
- (CGRect)firstRectForRange:(UITextRange *)range {
    return CGRectZero;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}

/* Hit testing. */
- (UITextPosition *)closestPositionToPoint:(CGPoint)point {
    return nil;
}

- (UITextPosition *)closestPositionToPoint:(CGPoint)point withinRange:(UITextRange *)range {
    return nil;
}

- (UITextRange *)characterRangeAtPoint:(CGPoint)point {
    return nil;
}

#pragma mark -

- (void)insertDictationResult:(NSArray *)dictationResult {
    [[NSNotificationCenter defaultCenter] postNotificationName:VNDictationRecognitionSucceededNotification
                                                        object:self 
                                                      userInfo:[NSDictionary dictionaryWithObject:dictationResult forKey:VNDictationResultKey]];
}

- (void)dictationRecordingDidEnd {
    [[NSNotificationCenter defaultCenter] postNotificationName:VNDictationRecordingDidEndNotification object:self];
}

- (void)dictationRecognitionFailed {
    [[NSNotificationCenter defaultCenter] postNotificationName:VNDictationRecognitionFailedNotification object:self];
}

@end
