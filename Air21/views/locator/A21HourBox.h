//
//  A21HourBox.h
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A21BranchVO.h"
@interface A21HourBox : UIView {
    UILabel *titleLbl;
    UILabel *hour1;
    UILabel *hour2;
    UILabel *hour3;
    UILabel *hour4;
    
}

-(void) updateInfo:(A21BranchVO*) info;
-(void) clear;
@end
