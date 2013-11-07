//
//  UZInputCandidateAccessory.h
//  InputCandidateView
//
//  Created by sonson on 2013/11/07.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UZInputCandidateAccessory;

/**
 * UZTextViewDelegate protocol is order to receive selecting a candidate messages for UZInputCandidateAccessory objects.
 * All of the methods in this protocol are optional.
 */
@protocol UZInputCandidateAccessoryDelegate <NSObject>
- (void)inputCandidateAccessory:(UZInputCandidateAccessory*)accessory selectedString:(NSString*)string;
@end

/**
 * The UZInputCandidateAccessory class implements input accessory view for keyboard to select candidates for inputing words.
 */
@interface UZInputCandidateAccessory : NSObject

/**
 * \name Public methods
 */

/**
 * Receiver's delegate.
 * The delegate is sent messages when a candidate are selected.
 *
 * See UZInputCandidateAccessoryDelegate Protocol Reference for the optional methods this delegate may implement.
 */
@property (nonatomic, assign) id <UZInputCandidateAccessoryDelegate> delegate;

/**
 * Returns the view that displays candidates
 * The views to be set to inputAccessoryView of a UITextField or UITextView object.
 */
@property (nonatomic, readonly) UIView *candidateAccessoryView;

/**
 * Sets the string items on the UZInputCandidateAccessory object's candidateAccessoryView.
 * \param strings The items to display on the UZInputCandidateAccessory object's candidateAccessoryView.
 */
- (void)setStrings:(NSArray*)strings;
@end
