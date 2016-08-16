//
//  RCLocationVO.h
//  Air21
//
//  Created by Phillip John Ardona on 5/31/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCModelBase.h"
@interface RCLocationVO : RCModelBase  {
    int originIndex;
    int destIndex;
}
    
@property(nonatomic, assign) int originIndex, destIndex;
-(NSString*) zone:(int) index; 
-(NSString*) locId:(int) index;
-(NSString*) title:(int) index;

-(int) locIndex:(NSString*) locId; 
-(NSString*) getSelectedOrigin ;
-(NSString*) getSelectedDest;
@end
