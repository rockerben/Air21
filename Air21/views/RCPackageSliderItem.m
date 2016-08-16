//
//  RCPackageSliderItem.m
//  Air21
//
//  Created by Phillip John Ardona on 6/5/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RCPackageSliderItem.h"

@interface  RCPackageSliderItem()  

-(void) renderImage;
-(void) renderText;
//-(void) renderOverlay;

-(void) handleTap:(UITapGestureRecognizer*) rec;
-(void) handleSwipe:(UISwipeGestureRecognizer*) rec;
-(void) handleSwipeLeft:(UISwipeGestureRecognizer*)rec;
@end

@implementation RCPackageSliderItem



@synthesize itemData, index , spacing, padding;

-(id) initWithSlider:(id<RCSliderItemDelegate>) s {
    self = [super initWithFrame: CGRectMake(0, 0, 100 , 90)];
    
    
    if( self ) {
        slider =  s;
       // self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.3];
       // self.layer.cornerRadius  = 0.5;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(handleTap:)] autorelease];
        [self addGestureRecognizer: tap];
     
        UISwipeGestureRecognizer *swipe = [[[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(handleSwipe:) ] autorelease];
    
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipe];
        
        
        UISwipeGestureRecognizer *swipeLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget: self  action:@selector(handleSwipeLeft:)] autorelease];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        
        [UIView setAnimationDelegate: self];
    }
    
    
    return self;
}

-(void) handleTap:(UITapGestureRecognizer *)rec {
    /*
    if( slider != nil ) {
        [slider itemSelected: self];
    }
    */
}

-(void) handleSwipe:(UISwipeGestureRecognizer *)rec {
    
    UIView *box = self.superview;
    CGRect bframe = box.frame;
    CGRect iframe = self.frame;
    
    if( bframe.origin.x >= ((320 - 100 ) /2) - ( padding + spacing) ) {
        return;
    }
      
    float nextX = iframe.size.width + (spacing  ) ;
    [UIView beginAnimations:@"boxMainRight" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView  setAnimationDuration: 0.5];
    box.transform  = CGAffineTransformTranslate ( box.transform , nextX , bframe.origin.y);

    [UIView commitAnimations];
    
    
}

-(void) handleSwipeLeft:(UISwipeGestureRecognizer *)rec {
    UIView *box = self.superview;
    CGRect bframe = box.frame;
    CGRect iframe = self.frame;
    
    float limit =  ( 320 - 100 ) / 2  + ( 100 + padding + spacing ) ;
    if(   (bframe.origin.x + bframe.size.width ) <=  limit ) {
        return;
    }
    
    float nextX =  - (iframe.size.width + (spacing ))  ;
    [UIView beginAnimations:@"boxMainLeft" context:nil];
     [UIView setAnimationDelegate:self];
    [UIView  setAnimationDuration: 0.5];
    box.transform  = CGAffineTransformTranslate ( box.transform , nextX   , bframe.origin.y);
    
    [UIView commitAnimations];
}
 

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (  slider != nil ) {
        [slider swipeComplete];
    }
}



-(void) setItemData:(NSDictionary *)value {
    itemData = [value retain];
    [self renderImage];
    [self renderText];
}


-(void) renderImage {
    NSString *path = [[[NSBundle mainBundle] bundleURL] path];
    NSString *itemImg = [itemData valueForKey:@"img"];
    NSString *imgSrc = [NSString stringWithFormat: @"%@/%@", path ,itemImg];
    UIImage *image = [UIImage imageWithContentsOfFile: imgSrc];
    UIImageView *iview = [[[UIImageView alloc]initWithImage: image ] autorelease];
       
    UIView *icon = [[UIView alloc] initWithFrame: CGRectMake(10, 2 ,  80, 80 ) ];
    [icon addSubview:iview];
    icon.userInteractionEnabled = NO;
    [self addSubview: icon];
    [icon release];
}

 
 

-(void) setIndex:(int)i  {
    index = i;
    CGRect  tframe = self.frame;
    tframe.origin.x = padding + (tframe.size.width * (float)index) + (  spacing * (float)index ) ;
    self.frame = tframe;
     
}

-(void) renderText {
    NSString *title = [itemData valueForKey:@"title"];
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 65, 100, 22)] autorelease];
    [label setText: title];
    label.layer.cornerRadius = 10;
    
    
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha: 0];
    
    UIFont *font = [UIFont fontWithName:@"Arial Rounded MT Bold" size: 11];
     
    label.textColor = [UIColor whiteColor];
    label.font = font;
    label.textAlignment = UITextAlignmentCenter;
    [self addSubview: label];
    label.userInteractionEnabled = NO;
}


-(void) dealloc {
    
    [itemData release];
    [super dealloc];
}

@end
