//
//  OverlayViewController.h
//  Air21
//
//  Created by Ben Cortez on 2/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocTblViewController;

@interface OverlayViewController : UIViewController {

LocTblViewController * rvController;
}


@property (nonatomic, retain) LocTblViewController *rvController;

@end