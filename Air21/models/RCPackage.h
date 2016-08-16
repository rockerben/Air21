//
//  RCPackage.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCModelBase.h"
@interface RCPackage : RCModelBase {
    int selectedIndex;
}

@property (nonatomic, assign) int selectedIndex;
-(NSString*) getSelected ;
-(NSString*) packageId;
-(RCVolume) volume;
@end
