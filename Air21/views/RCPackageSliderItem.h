//
//  RCPackageSliderItem.h
//  Air21
//
//  Created by Phillip John Ardona on 6/5/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RCSliderItemDelegate.h" 
 


@interface RCPackageSliderItem : UIView {
    NSDictionary *itemData;
    id<RCSliderItemDelegate>  slider;
    int index;
    float spacing;
    float padding;
   
}


@property(nonatomic, assign ) NSDictionary *itemData;

@property(nonatomic, assign) int index;
@property(nonatomic, assign) float spacing, padding;


-(id) initWithSlider:(id<RCSliderItemDelegate>) s;

 

@end
