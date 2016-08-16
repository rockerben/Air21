//
//  LocTableCell.m
//  Air21
//
//  Created by Phillip John Ardona on 6/12/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "LocTableCell.h"

@implementation LocTableCell

 
-(id) initWithBranch:(A21BranchVO *)branch {
    self = [super initWithFrame: CGRectMake(0, 0, 320, 42)];
    if( self ) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1];
        
        UILabel *address = [[[UILabel alloc]initWithFrame:CGRectMake(20,0,300, 40)] autorelease]; 
        address.backgroundColor = [UIColor clearColor];
        [self addSubview: address];
        
      
        address.textColor = [UIColor whiteColor];
        
        UIFont *font = [UIFont fontWithName:@"Arial" size:12];
        address.font = font;
        
        NSString *content =[NSString stringWithFormat:@"%@, %@", branch.address1, branch.city];
          address.text = content;
    }
    return self;
}
 
@end
