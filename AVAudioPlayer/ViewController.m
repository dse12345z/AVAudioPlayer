//
//  ViewController.m
//  AVAudioPlayer
//
//  Created by daisuke on 2014/11/10.
//  Copyright (c) 2014年 Daisuke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	[AVAudioPlayer playMP3Name:@"Westlife - My Love" completion: ^{
	    // play finish do something ...
	}];
}

@end
