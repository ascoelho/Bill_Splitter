//
//  ViewController.h
//  Bill Splitter
//
//  Created by Anthony Coelho on 2016-05-14.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property float tipAmount;


@property BOOL keyboardHidden;

@end

