//
//  AboutViewController.h
//  Air21
//
//  Created by Ben Cortez on 7/01/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
{
IBOutlet UIButton * goBack;
}
@property (nonatomic, retain) IBOutlet UIButton *goBack;


- (IBAction) btnGoBack:(id)sender;
@end
