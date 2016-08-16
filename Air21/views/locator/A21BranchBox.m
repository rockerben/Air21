//
//  A21BranchBox.m
//  Air21
//
//  Created by Phillip John Ardona on 7/3/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "A21BranchBox.h"
#import <QuartzCore/QuartzCore.h>

@interface A21BranchBox() 

-(void) updateStyle:(UILabel*) lbl;

@end

@implementation A21BranchBox

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if( self ) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        
        branch = (UILabel*)[self viewWithTag:1];
        address = (UITextView*)[self viewWithTag:2];
        city = (UILabel*)[self viewWithTag:3];
        
        
        state = (UILabel*)[self viewWithTag:4];
        zip = (UILabel*)[self viewWithTag:5];
        
        branchLbl = (UILabel*)[self viewWithTag:6];
        addressLbl = (UILabel*)[self viewWithTag:7];
        cityLbl = (UILabel*)[self viewWithTag:8];
        stateLbl = (UILabel*)[self viewWithTag:9];
        zipLbl = (UILabel*)[self viewWithTag:10];
         
        
        [self updateStyle: branch];
        
        [self updateStyle: city];
        [self updateStyle: state];
        [self updateStyle: zip]; 
        
        [self updateStyle: branchLbl];
        [self updateStyle: addressLbl];
        [self updateStyle: cityLbl];
        [self updateStyle: stateLbl];
        [self updateStyle: zipLbl]; 
        
        address.textColor = [UIColor whiteColor];
        address.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) updateInfo:(A21BranchVO*) info {
    branch.text = info.air21;
    address.text = [NSString stringWithFormat:@"%@ , %@" , info.address1 , info.address2];
    city.text = [NSString stringWithFormat:@"%@", info.city];
    state.text = [NSString stringWithFormat:@"%@", info.country ];
    zip.text = [NSString stringWithFormat:@"%@", info.zip ];
}


-(void)  clear {
     
    branch.text = nil;
    address.text = nil;
    city.text = nil;
    state.text = nil;
    zip.text = nil;
}

-(void) updateStyle:(UILabel *)lbl {
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
}

-(void) dealloc {
    
    [super dealloc];
    
}
 
@end
