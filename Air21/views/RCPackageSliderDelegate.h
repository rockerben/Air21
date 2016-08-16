//
//  RCPackageSliderDelegate.h
//  Air21
//
//  Created by Phillip John Ardona on 6/5/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCPackageSliderItem.h"

@protocol RCPackageSliderDelegate <NSObject>


-(void) packageSliderItemSelected:(RCPackageSliderItem*) item;

@end
