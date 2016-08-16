//
//  LocDtlViewController.h
//  Air21
//
//  Created by Ben Cortez on 2/06/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A21BranchVO.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "A21BranchBox.h"
#import "A21PhoneBox.h"
#import "A21HourBox.h"
#import "A21EmailBox.h"
@interface LocDtlViewController : UIViewController <CLLocationManagerDelegate> {
    
    
    IBOutlet A21BranchBox *branchBox;
    IBOutlet A21PhoneBox *phoneBox;
    IBOutlet A21HourBox *hourBox;
    IBOutlet A21EmailBox *emailBox;
    
    A21BranchVO *selectedBranch;
    
    CLLocationCoordinate2D  userCoordinate;
   

}
@property(nonatomic, assign) CLLocationCoordinate2D userCoordinate;
@property (nonatomic, assign) A21BranchVO *selectedBranch;


@end
