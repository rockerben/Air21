//
//  RCPackageSlider.h
//  Air21
//
//  Created by Phillip John Ardona on 6/5/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RCPackageSliderItem.h"
#import "RCPackageSliderDelegate.h"
#import "RCSliderItemDelegate.h"
@interface RCPackageSlider : UIView  <RCSliderItemDelegate>{
    NSArray *dataSource;
    NSMutableArray *items;
    UIView *box;
    float spacing;
    float padding;
    RCPackageSliderItem *selectedItem;
    id<RCPackageSliderDelegate> delegate;
}

@property(nonatomic, assign ) NSArray *dataSource;
@property(nonatomic, readonly) RCPackageSliderItem *selectedItem;
@property(nonatomic, assign) id<RCPackageSliderDelegate> delegate;

-(void) selectIndex:(int) index;

@end
