//
//  RCDimensionView.m
//  Air21
//
//  Created by Phillip John Ardona on 6/6/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCDimensionView.h"
@interface RCDimensionView ()  

-(void) createFields;
-(void) handleOk:(UIControlEvents*) event;
@end

@implementation RCDimensionView

- (id)init 
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 240)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        // Initialization code
        [self createFields];
    }
    return self;
}


-(void) createFields {
    UIButton *ok =      [UIButton buttonWithType: UIButtonTypeRoundedRect];
    ok.frame = CGRectMake(0, 0, 80, 31);
    [ok setTitle:  @"HELLO"  forState: UIControlStateNormal];
    
    [ok addTarget: self action:@selector(handleOk:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: ok];
}
 

-(void) handleOk:(UIControlEvents*) event {
    NSLog(@"button click ");
    
    UIAlertView *view = (UIAlertView*) self.superview;
    [view resignFirstResponder];
    [view removeFromSuperview];
}
@end
