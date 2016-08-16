//
//  A21EmailBox.m
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21EmailBox.h"
#import <QuartzCore/QuartzCore.h>
@interface A21EmailBox() 

-(void) updateStyle:(UILabel*) lbl;

@end

@implementation A21EmailBox

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( self ) {
        emailtag = (UILabel*) [self viewWithTag:1];
        email  = (UILabel*) [self viewWithTag:2];
        
        [self updateStyle: emailtag];
        [self updateStyle: email];
    }
    return self;
}
 
-(void) updateInfo:(A21BranchVO *)info {
    if( [info.email isEqualToString:@""] ) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    email.text = [NSString stringWithFormat:@"%@", info.email];
    
     
}

-(void)  clear {
    email.text = nil;
}

-(void) updateStyle:(UILabel *)lbl {
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
}

-(void) dealloc{
     /*
    [emailtag release];
    [email release];
     */
    [super dealloc];
}
@end
