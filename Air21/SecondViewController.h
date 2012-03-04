//
//  SecondViewController.h
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//


#import <UIKit/UIKit.h>



@interface SecondViewController : UIViewController
{
    IBOutlet UITextField * textField;
    NSString *IVCode;
}
@property (nonatomic, retain) IBOutlet UITextField * _textField;
@property (nonatomic, retain) NSString * code;

- (IBAction) btnMoveTo:(id)sender;
+ (NSString*)response;




@end
