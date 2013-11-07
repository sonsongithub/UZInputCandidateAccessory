//
//  ViewController.m
//  InputCandidateView
//
//  Created by sonson on 2013/11/07.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "ViewController.h"

#import "UZInputCandidateAccessory.h"

@interface ViewController () <UZInputCandidateAccessoryDelegate> {
	UZInputCandidateAccessory *_accessory;
}
@end

@implementation ViewController

- (void)inputCandidateAccessory:(UZInputCandidateAccessory *)accessory selectedString:(NSString *)string {
	[_textView insertText:string];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_accessory = [[UZInputCandidateAccessory alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
	_textView.inputAccessoryView = _accessory.candidateAccessoryView;
	[_accessory setStrings:@[@"hoge", @"iPhone", @"www.yahoo.co.jp", @"iPhone", @"www.yahoo.co.jp", @"iPhone", @"www.yahoo.co.jp"]];
	_accessory.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
