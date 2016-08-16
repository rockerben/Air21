//
//  RCPackageSlider.m
//  Air21
//
//  Created by Phillip John Ardona on 6/5/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCPackageSlider.h"
#import "RCPackageSliderItem.h"
@interface RCPackageSlider() 
-(void) initAppearance;
-(void) initSubviews;
-(void) initUIActions ;
-(UIView*) createImage :(NSString*) path;
@end

@implementation RCPackageSlider

@synthesize dataSource , selectedItem ,delegate;

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if( self ) {
        [self initAppearance];
        [self initSubviews];
        [self initUIActions];
        spacing = 6;
        padding = 3;
    }
    
    return self;
}

-(void) initAppearance {
    [self setBackgroundColor: [UIColor colorWithRed:0.0  green:0.0 blue:0.0 alpha:0.0]];
    [self setClipsToBounds: NO];
    
}

 
-(void) initSubviews  {
    box = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    box.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0];
    [self addSubview: box];
    
    CGRect iconFrame;
    CGRect sframe = self.frame;
    
    float pad = 1;
    
    UIView *leftIcon = [self createImage:@"assets/leftarrow.png"];
    iconFrame = leftIcon.frame;
    iconFrame.origin.x = sframe.origin.x + pad;
    iconFrame.origin.y =  (sframe.size.height - iconFrame.size.height ) / 2;
    leftIcon.frame = iconFrame;
    [self addSubview: leftIcon];
     
    UIView *rightIcon = [self createImage:@"assets/rightarrow.png"];
    iconFrame = rightIcon.frame;
    iconFrame.origin.x = sframe.origin.x + sframe.size.width - (iconFrame.size.width + pad);
    iconFrame.origin.y =  (sframe.size.height - iconFrame.size.height ) / 2;
    rightIcon.frame = iconFrame;
    [self addSubview: rightIcon];
    
    float overlayWidth = 110;
    UIView  *overlay = [[UIView alloc] initWithFrame: CGRectMake((self.frame.size.width - overlayWidth) /2 , -5 , overlayWidth, self.frame.size.height + 10)];
    [overlay autorelease];
    overlay.userInteractionEnabled = NO;
    overlay.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
    overlay.layer.cornerRadius = 5;
    overlay.tag = 5;
    [self addSubview: overlay];
    
}

-(UIView*) createImage :(NSString*) url {
    NSString *path =  [[[NSBundle mainBundle]bundleURL]path];
    UIImage *img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", path, url]];
    UIImageView *imgView = [[[UIImageView alloc] initWithImage:img] autorelease];
    
    UIView *iview = [[UIView alloc] initWithFrame: CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)];
    [iview autorelease];
    [iview addSubview: imgView];
    iview.userInteractionEnabled = NO;
    return iview;    
}

-(void) initUIActions  {
    
    
}
 
-(void) setDataSource:(NSArray *)value {
    dataSource = [value retain];
    CGRect boxFrame =  box.frame;
    items = [[NSMutableArray alloc] initWithCapacity:0];
    boxFrame.size.width = ((padding * 2 ) + ( 100 + spacing) * dataSource.count) - spacing;
    boxFrame.origin.x = 106;
    box.frame = boxFrame;
    for( int i= 0; i < dataSource.count; i++ ) {
        NSDictionary *itemData = [dataSource objectAtIndex:i];
        RCPackageSliderItem *item = [[[RCPackageSliderItem alloc] initWithSlider: (id<RCSliderItemDelegate>) self ] autorelease];
        item.spacing = spacing;
        item.padding = padding;
        item.index = i;
        item.itemData = itemData;
        if( i ==  0 ){
            selectedItem = item;
        }
        [items addObject:item];
        [box addSubview:item];
    }
    
}

-(void) selectIndex:(int)index {
    
}
 
 

-(void) swipeComplete {
    CGRect bframe = box.frame;
    float bx = bframe.origin.x ;
    float itemsize = 100 + spacing;
    float cx = self.frame.size.width / 2;
    float dx = cx - bx - padding;
    for( int i = 0 ; i < items.count; i++ ) {
        RCPackageSliderItem *item = [items objectAtIndex:i];
        CGRect iframe = item.frame;
        if( iframe.origin.x <= dx  && iframe.origin.x + itemsize >= dx ) {
            selectedItem = item;
            break;
        }
        
    }
    if( delegate != nil ) {
        
        [delegate packageSliderItemSelected: selectedItem];
    }
}

-(void) dealloc {
    [items release];
    [dataSource release];
    [box removeFromSuperview];
    [box release];
    [super dealloc];
}

@end
