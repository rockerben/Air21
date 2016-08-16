//
//  LocTableHeader.m
//  Air21
//
//  Created by Phillip John Ardona on 6/12/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "LocTableHeader.h"

@implementation LocTableHeader

- (id)initWithTitle:(NSString*) title
{
    self = [super initWithFrame:CGRectMake(0, 0, 320,40)];
    if (self) {
        
      
        
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0 blue:0 alpha:0.2];
        
        
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310,40)] autorelease];
        
        label.text = title;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.userInteractionEnabled = NO;
        
        UIFont *font =[UIFont fontWithName:@"Arial-BoldMT" size:16];
        
        label.font = font;
        [self addSubview: label];
        
        UIView *line = [[[UIView alloc] initWithFrame:CGRectMake(0, 38, 320, 2 )] autorelease];
        
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self addSubview: line];
        
    }
    return self;
}

 

@end
