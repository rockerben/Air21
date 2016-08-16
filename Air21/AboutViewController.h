//
//  AboutViewController.h
//
//  Air21 Mobile
//
//  Created by Ben Cortez on 12/05/11.
//  Copyright 2011 RedMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
{
    IBOutlet UIButton * goBack;
    IBOutlet UIButton * goURL;
    
    IBOutlet UIButton *fbBtn;
    IBOutlet UIButton *twitter;
}
- (IBAction)handleTwitter:(id)sender;
- (IBAction)handleFb:(id)sender;
@property (nonatomic, retain) IBOutlet UIButton *goBack;
@property (nonatomic, retain) IBOutlet UIButton *goURL;


- (IBAction) btnGoBack:(id)sender;
- (IBAction) btnGoUrl:(id)sender;
@end
