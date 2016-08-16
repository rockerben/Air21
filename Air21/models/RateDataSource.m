//
//  PackagingDataSource.m
//  Air21
//
//  Created by Phillip John Ardona on 5/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RateDataSource.h"

@implementation RateDataSource

@synthesize content , selectedIndex , overrideCount;
-(id) initWithContent: (NSArray*) c {
    self = [super init];
    if( self) {
        overrideCount = -1;
        content = [c retain];
    }
    return self;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if( overrideCount != -1 ) {
        return overrideCount;
    }
    return [content count];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(void) dealloc {
    [content release];
    [super dealloc];
}
 
@end
