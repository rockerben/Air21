//
//  A21PhoneBox.m
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21PhoneBox.h"
#import <QuartzCore/QuartzCore.h>

@interface A21PhoneBox() 

-(void) updateStyle:(UILabel*) lbl;
-(void) minusHeight;

@end


@implementation A21PhoneBox

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( self ) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        phone1 = (UILabel*)[self viewWithTag:1];
     
        phone2 = (UILabel*)[self viewWithTag:2];
        phone3 = (UILabel*)[self viewWithTag:3];
        title = (UILabel*)[self viewWithTag:4];
           NSLog(@"Title retain count %d" , phone3.retainCount ); 
        [self updateStyle: phone1];
        [self updateStyle: phone2];
        [self updateStyle: phone3];
        [self updateStyle: title];
        
    }
    return self;
}


-(void) updateInfo:(A21BranchVO *)info {
    int available = 0;
    
    phone1.text = info.telephone1;
    if( [info.telephone1 isEqualToString:@""] ) {
        available++;
        [self minusHeight];
    }
    phone2.text = info.telephone2;
    if( [info.telephone2 isEqualToString:@""] ) {
        available++;
        [self minusHeight];
    }
    phone3.text = info.telephone3;
    if( [info.telephone3 isEqualToString:@""] ) {
        available++;
        [self minusHeight];
    }
    if( available >= 3 ) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
}
 

-(void)  clear {
    phone1.text =nil;
    phone2.text = nil;
    phone3.text = nil;
    title.text = nil;
}

-(void) minusHeight {
    CGRect  bounds = self.frame;
   // bounds.size.height -= 20;
    self.frame = bounds;
}

-(void) updateStyle:(UILabel *)lbl {
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
}
 

-(void) dealloc {
    /*
    [phone1 release];
    
    [phone2 release];
    [phone3 release];
   
    [title release];
   */  
    [super dealloc];
    
}

@end
