//
//  A21HourBox.m
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21HourBox.h"
#import <QuartzCore/QuartzCore.h>

@interface A21HourBox() 

-(void) updateStyle:(UILabel*) lbl;
-(void) hideOrDisplay:(UILabel*) target day:(NSString*) day  hour:(NSString*) hour;
@end

@implementation A21HourBox

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( self ) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
       
        titleLbl =  (UILabel*) [self viewWithTag:1];
        hour1 =  (UILabel*) [self viewWithTag:2];
        hour2 =  (UILabel*) [self viewWithTag:3];
        hour3 =  (UILabel*) [self viewWithTag:4];
        hour4 =  (UILabel*) [self viewWithTag:5];
        
        [self updateStyle: titleLbl];
        [self updateStyle: hour1];
        [self updateStyle: hour2];
        [self updateStyle: hour3];
        [self updateStyle: hour4];
        
    }
    return self;
}

-(void) updateInfo:(A21BranchVO*) info {
    [self hideOrDisplay:hour1 day:info.day1 hour:info.hours1];
    [self hideOrDisplay:hour2 day:info.day2 hour:info.hours2];
    [self hideOrDisplay:hour3 day:info.day3 hour:info.hours3];
    [self hideOrDisplay:hour4 day:info.day4 hour:info.hours4];
}

-(void)  clear {
    titleLbl.text = nil;
    hour1.text = nil;
    hour2.text = nil;
    hour3.text = nil;
    hour4.text = nil;
}

-(void) hideOrDisplay:(UILabel*) target day:(NSString*) day  hour:(NSString*) hour {
    if( [day isEqualToString:@"" ] ){
        target.hidden = YES;
    } 
    
    if( [hour isEqualToString:@""] ) {
        target.text = [NSString stringWithFormat:@"%@" , day   ];
    } else {
        target.text = [NSString stringWithFormat:@"%@, %@" , day , hour ];
    }
    
}
 

-(void) updateStyle:(UILabel *)lbl {
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
}

-(void) dealloc {
    /*
    [titleLbl release];
   
     [hour1 release];
    [hour2 release];
   
    [hour3 release];
    [hour4 release];
    */
    [super dealloc];
}

@end
