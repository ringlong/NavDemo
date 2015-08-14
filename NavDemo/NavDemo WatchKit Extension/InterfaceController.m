//
//  InterfaceController.m
//  NavDemo WatchKit Extension
//
//  Created by Ryan on 15/5/28.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@property (assign, nonatomic) float num;
@property (weak, nonatomic) IBOutlet WKInterfaceSlider *slide;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *guessLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *resultLabel;

- (IBAction)startGuess;
- (IBAction)updateGuess:(float)value;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)addMenuItemWithImage:(UIImage *)image title:(NSString *)title action:(SEL)action {
    
}

- (IBAction)startGuess {
    float a = 5;
    if (a == _num) {
        [self.resultLabel setText:@"success"];
    } else {
        [self.resultLabel setText:@"wrong"];
    }
}

- (IBAction)updateGuess:(float)value {
    [self.guessLabel setText:[NSString stringWithFormat:@"You guess is %.0f", value]];
    _num = value;
}

@end



