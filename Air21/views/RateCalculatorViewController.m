//
//  RateCalculatorViewController.m
//  Air21
//
//  Created by Phillip John Ardona on 5/28/12.
//  Copyright (c) 2012 SAS. All rights reserved.
//

#import "RateCalculatorViewController.h"
#import "RCDimensionView.h"
@interface RateCalculatorViewController ()

 
 
-(void) selectDataSource;
-(void) updateRelatedFields;
-(void) disableTexts;
-(void) enableTexts;
-(void) disable:(UITextField*) target;
-(void) enable:(UITextField*) target;
-(void) tryCaculate;

 

-(void) showAlert;
-(void) showDimensionDialog;
-(void) createDropIcons:(UITextField*) target ;

 

-(NSString*) twoDecPlaces:(float) f;

@end

@implementation RateCalculatorViewController



@synthesize model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        model = [[RCModelProxy alloc] init];
        self.title = NSLocalizedString(@"Rate Calculator ", @"Rate Calculator");
        self.tabBarItem.image = [UIImage imageNamed:@"icon"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

 
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 

- (void)viewDidLoad
{
    
  
    NSLog(@"packageSlider %@" , packageSlider );
   [packagingPicker setHidden:YES];
    packagingPicker.delegate = self;
    
    packageSlider.dataSource = model.package.dataSource.content;
    packageSlider.delegate = self;
    //packaging.inputView = packagingPicker;
    //packaging.tag = kA21Packaging;
    
    originCity.inputView = packagingPicker;
    originCity.tag = kA21OriginCity;
    originBranch.inputView = packagingPicker;
    originBranch.tag = kA21OriginBranch;
    
    toCity.inputView = packagingPicker;
    toCity.tag = kA21ToCity;
    toBranch.inputView =  packagingPicker;
    toBranch.tag = kA21ToBranch;
    
    weight.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    declaredValue.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    
    weight.delegate = self;
    declaredValue.delegate = self;
       
    //[price setEnabled: NO];
     
    price.layer.cornerRadius = 5;
    [price.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.8] CGColor]];
    [price.layer setBorderWidth:1.0];
    price.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
      
    [weight setText: [self twoDecPlaces: model.weight]];
    [declaredValue setText: [self twoDecPlaces: model.declaredValue]];
    
    
    [originCity setText:[model.location getSelectedOrigin]];
    [originBranch setText: [model.subLocation getSelectedOrigin]];
     
    [toCity setText: [model.location getSelectedDest]];
    [toBranch setText: [model.subLocation getSelectedDest]];
    
    
     
    price.text = [NSString stringWithFormat: @"P %@",  [self twoDecPlaces: model.pricePHP]] ;
   
    
    
    [self createDropIcons: originCity ];
    [self createDropIcons: originBranch];
    [self createDropIcons: toCity];
    [self createDropIcons: toBranch];
    
    
    disclaimer.backgroundColor = [UIColor clearColor];
    [disclaimer setEditable: NO];
    
    [super viewDidLoad];
    
}

-(void) createDropIcons:(UITextField*) target  {
     
    NSString *path = [[[NSBundle mainBundle] bundleURL] path];
    NSString *imgSrc = [NSString stringWithFormat: @"%@/%@", path , @"assets/dropdown.png"];
    UIImage *icon = [UIImage imageWithContentsOfFile: imgSrc];
    
    UIImageView *iconImg = [[[UIImageView alloc] initWithImage: icon] autorelease];
    UIView *iconView = [[[UIView alloc] initWithFrame: CGRectMake(100,100,16,16)]autorelease]; 
     
    CGFloat tx = target.frame.origin.x + target.bounds.size.width - 16 - 2;
    CGFloat ty = target.frame.origin.y + 7.5;
   
 //   NSLog(@" Textfield X %f  Y %f Target %@ " , tx,  ty, target  );
    
    CGRect tBounds = CGRectMake(tx,  ty , 16, 16);
    iconView.frame = tBounds;
    [iconView setBackgroundColor: [UIColor whiteColor]];
    [iconView addSubview: iconImg]; 
 
    iconView.userInteractionEnabled = NO;
    UIView *pview = [target superview];
    
 
    [pview addSubview: iconView];
      
}

-(IBAction) editText:(id)sender  {
   
    targetResponder = (UITextField*) sender;
    model.targetField = targetResponder.tag;
      
    [self selectDataSource];
    [targetResponder becomeFirstResponder];
    [packagingPicker setHidden:NO];
    //[self disableTexts];
    
}

-(IBAction) editNormal:(id)sender  {
    targetResponder = (UITextField*) sender;
    [targetResponder becomeFirstResponder];
}

-(IBAction) editNormalEnd:(id)sender {
    if ( [targetResponder isEqual: weight] ) {
        model.weight = weight.text.floatValue;
    } else if( [targetResponder isEqual: declaredValue] )  {
        model.declaredValue = declaredValue.text.floatValue;
    }
    [targetResponder resignFirstResponder];
    [self tryCaculate];
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [ model pickerField: row];
}
 
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [model updateSelection: row];
    [targetResponder setText: [ model pickerField:row]  ];
    [self updateRelatedFields];
}
 
-(void) updateRelatedFields {
    if( model.targetField == kA21ToCity ) {
        [toBranch setText:  model.subLocation.firstDestinationCity];
    } else if( model.targetField == kA21OriginCity ) {
        [originBranch setText:  model.subLocation.firstOriginCity];
    }  
    [self tryCaculate];
}


-(void) tryCaculate {
     
    model.packageVolume = model.package.volume;
    if( !model.isAllowedWeight && ![[model.package packageId] isEqualToString:@"3"] ){
        [self showAlert];
        return;
    }
    if( [model calculate] ) {
        price.text = [NSString stringWithFormat: @"P %@",  [self twoDecPlaces: model.pricePHP]];
    } 
}
 
-(void) showAlert {
    NSString *title = @"Weight Exceeds Packaging Standard";
    NSString *max = [self twoDecPlaces: model.rates.currentMaxWeight];
    NSString *ptitle =  [model.package getSelected];
    NSString *message = [NSString stringWithFormat:@"%@ kg exceeds %@ kg, the maximum weight of %@ . Please select other packaging type or choose your own packaging.", weight.text , max , ptitle];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title  
                                                    message:message 
                                                   delegate:nil 
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void) showDimensionDialog { 
    UIAlertView *alert = [[[UIAlertView alloc] initWithFrame: CGRectMake(0, 0, 320, 240)] autorelease];
    
    
    alert.frame = CGRectMake(0, 0, 320, 240);
    
    RCDimensionView *dimview = [[[RCDimensionView alloc] init] autorelease];
    [alert addSubview: dimview];
    
    [alert show];
}
 
-(void) selectDataSource {
    packagingPicker.dataSource = (id<UIPickerViewDataSource>)  [model selectDataSource];
    [packagingPicker selectRow: [model selected]   inComponent:0 animated:NO];
    [packagingPicker reloadComponent:0];
     
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if( targetResponder != nil ) {
        [targetResponder resignFirstResponder];
        targetResponder = nil;
        [self enableTexts];
    }
}
 
-(void) packageSliderItemSelected:(RCPackageSliderItem *)item {
    int pindex = item.index;
    model.package.selectedIndex = pindex;
    
    [self tryCaculate];
 
}

-(void) disableTexts {
    
  //  [self disable: packaging];
    [self disable: originCity];
    [self disable: originBranch];
    [self disable: toCity];
    [self disable: toBranch];
    [self disable: weight];
    [self disable: declaredValue];
   
}

-(void) enableTexts {
  //  [self enable: packaging];
    [self enable: weight];
    [self enable: originCity];
    [self enable: originBranch];
    [self enable: toCity];
    [self enable: toBranch];
    [self enable: declaredValue];
}


-(void) enable:(UITextField *)target {
    [target setEnabled: YES];
    [target setUserInteractionEnabled: YES];
}
 
-(void) disable:(UITextField *)target {
   // [target setEnabled: NO];
    [target setUserInteractionEnabled: NO];
}
 
-(NSString*)  twoDecPlaces:(float)f {
    NSString *fstr = [NSString stringWithFormat:@"%f", f];
    NSRange  range = [fstr rangeOfString:@"."];
    range.length = range.location + 3;
    range.location = 0;
    NSString *rstr = [fstr substringWithRange: range];
    return  rstr;
}

 

/*
 * default ViewController methods
 */


/* 
 *THis method filters the keyboard input items
 
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber* candidateNumber;
    NSString* candidateString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    range = NSMakeRange(0, [candidateString length]);
    [numberFormatter getObjectValue:&candidateNumber forString:candidateString range:&range error:nil];
    if (([candidateString length] > 0) && (candidateNumber == nil || range.length < [candidateString length])) {
        return NO;
    }
    else 
    {
        return YES;
    }
}



-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [targetResponder resignFirstResponder];
    return YES;
}


- (void)viewDidUnload
{
    [disclaimer release];
    disclaimer = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}




 
-(void) dealloc {
    
   [view release];
     
    [originCity release];
    [originBranch release];
    
    [toCity release];
    [toBranch release];
    
    [weight release];
     [declaredValue release];
    
    [price release];
    
    
    [disclaimer release];
    [packagingPicker release];
    [packageSlider release];
    
    
    [model release];
    [disclaimer release];
    [super dealloc];
}

@end
