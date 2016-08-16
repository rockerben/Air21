//
//  RateCalculatorViewController.h
//  Air21
//
//  Created by Phillip John Ardona on 5/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import <UIKit/UIKit.h>
 
#import <QuartzCore/QuartzCore.h>

#import "RCModelProxy.h"
#import "RCPackageSlider.h" 
#import "RCPackageSliderDelegate.h"
 


#define kA21Packaging 1
#define kA21OriginCity 2
#define kA21OriginBranch 3
#define kA21ToCity 4
#define kA21ToBranch 5
  

@interface RateCalculatorViewController : UIViewController <UIPickerViewDelegate , UITextFieldDelegate, RCPackageSliderDelegate > {
    
    IBOutlet UIView *view;
    
   // IBOutlet UITextField *packaging;
    
    IBOutlet UITextField *originCity;
    IBOutlet UITextField *originBranch;
     
    IBOutlet UITextField *toCity;
    IBOutlet UITextField *toBranch;
    
    IBOutlet UITextField *weight;
    IBOutlet UITextField *declaredValue;
    
    IBOutlet UITextView *price;
 
 
    
    
    IBOutlet UITextView *disclaimer;
    IBOutlet UIPickerView *packagingPicker;
    
    IBOutlet RCPackageSlider *packageSlider;
    
    
    // IBOutlet UIToolbar *toolbar;
    
   // RateCalculatorModel *model;
    
    
    UITextField *targetResponder ;
    
    
   
    
    
    RCModelProxy *model;
}

@property (nonatomic, assign) RCModelProxy *model;

 
-(IBAction) editText:(id)sender;
-(IBAction) editNormal:(id)sender;
-(IBAction) editNormalEnd:(id)sender;
@end
