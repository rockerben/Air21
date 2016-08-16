//
//  A21BranchBox.h
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "A21BranchVO.h"
@interface A21BranchBox : UIView {
    UILabel *branch;
 
    
    UITextView *address;
    
    
    UILabel *city;
    UILabel *state;
    UILabel *zip;
 
    
    UILabel *branchLbl;
    UILabel *addressLbl;
    UILabel *cityLbl;
    UILabel *stateLbl;
    UILabel *zipLbl;
}



-(void) updateInfo:(A21BranchVO*) info;
-(void) clear;
@end
