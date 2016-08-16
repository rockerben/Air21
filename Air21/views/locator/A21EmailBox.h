//
//  A21EmailBox.h
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A21BranchVO.h"
@interface A21EmailBox : UIView {
    UILabel *emailtag;
    UILabel *email;
 
}
-(void) updateInfo:(A21BranchVO*) info;
-(void) clear;
@end
