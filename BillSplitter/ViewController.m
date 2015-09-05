//
//  ViewController.m
//  BillSplitter
//
//  Created by Alp Eren Can on 05/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSlider;
@property (weak, nonatomic) IBOutlet UILabel *splitAmountLabel;

@property (strong, nonatomic) UIToolbar *accessoryView;
@property (strong, nonatomic) NSNumberFormatter *formatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.billAmountTextField.delegate = self;
    
    self.accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(calculateSplitAmount)];
    
    [self.accessoryView setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                 target:nil
                                                                                 action:nil],
                                   done]];
    
    self.billAmountTextField.inputAccessoryView = self.accessoryView;
    
    self.splitAmountLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateSplitAmount {
    
    self.formatter = [NSNumberFormatter new];
    
    self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumber *billAmount = [self.formatter numberFromString:self.billAmountTextField.text]; //[NSDecimalNumber decimalNumberWithString:self.billAmountTextField.text];
    
    NSNumber *splitAmount = @(billAmount.floatValue / (ceilf(self.numberOfPeopleSlider.value)));
    
    self.formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    
    self.splitAmountLabel.text = [NSString stringWithFormat:@"Everybody pays: %@", [self.formatter stringFromNumber:splitAmount]];
    
    [self.billAmountTextField resignFirstResponder];
    
}

- (IBAction)setSliderValue:(UISlider *)sender {
    [sender setValue:(ceilf(sender.value)) animated:YES];
    [self calculateSplitAmount];
}

@end
