//
//  ViewController.m
//  Bill Splitter
//
//  Created by Anthony Coelho on 2016-05-14.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.billAmountTextField.delegate = self;
    
    self.keyboardHidden = YES;
    
    [self addKeyboardObserver];
    
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:flexibleSpace, doneButton, nil]];
    [self.billAmountTextField setInputAccessoryView:keyboardToolbar];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapGesture];

}

- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (CGFloat)heightForNotification:(NSNotification *)notification {
    NSValue *keyboardInfo = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [keyboardInfo CGRectValue];
    return rect.size.height;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    

    
    [self calculateSplitAmount:textField];
    
    [self showTip];
    

    return YES;
}

- (void)showTip {
    
    self.tipAmount = [self.billAmountTextField.text floatValue] * 0.15;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: self.tipAmount]];
    
    
    self.tipLabel.text = [NSString stringWithFormat:@"Tip = %@", numberAsString];
    
   
    
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    //NSLog(@"%@",notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    
    if (self.keyboardHidden == YES) {
        [self adjustViewForKeyboardHeight:kbHeight];
        self.keyboardHidden = NO;
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    //NSLog(@"%@", notification.userInfo);
    CGFloat kbHeight = [self heightForNotification:notification];
    
    if (self.keyboardHidden == NO) {
        [self adjustViewForKeyboardHeight:-kbHeight];
        self.keyboardHidden = YES;;
    }
    
}

- (void)adjustViewForKeyboardHeight:(CGFloat)height {
    
    CGRect viewBounds = self.view.bounds;
    viewBounds.origin.y += height;
    //NSLog(@"%@", NSStringFromCGRect(viewBounds));
    self.view.bounds = viewBounds;
}

- (void) doneButtonPressed {
    
    [self.view endEditing:YES];
    
}

- (void)viewTapped:(UITapGestureRecognizer *)sender {
    if ([self.billAmountTextField isFirstResponder]) {
        [self.billAmountTextField resignFirstResponder];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)calculateSplitAmount:(id)sender {
    

    [self showTip];
    float splitAmount = ([self.billAmountTextField.text floatValue] + self.tipAmount) / self.slider.value;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    NSString *numberAsString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:splitAmount]];
    
    self.label.text = [NSString stringWithFormat:@"Each person has to pay: %@",numberAsString];
    
    
}
- (IBAction)sliderValueChanged:(UISlider *)slider {
    
    NSUInteger index = (NSUInteger)(slider.value);
    [slider setValue:index animated:NO];
    
    
    [self calculateSplitAmount:self.billAmountTextField];
    

}

@end
