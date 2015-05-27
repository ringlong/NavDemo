//
//  LoginViewController.m
//  NavDemo
//
//  Created by Ryan on 15/4/25.
//  Copyright (c) 2015年 BitAuto. All rights reserved.
//

#import "LoginViewController.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"
#import "MessageLayer.h"
#import "POP.h"
#import "EYToolkit.h"
#import "NetworkManager.h"
#import "AnimationButton.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIView *testView;

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) RACCommand *loginCommand;

- (IBAction)login:(UIButton *)sender;
- (IBAction)test:(UILongPressGestureRecognizer *)sender;


@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title = @"login";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    @weakify(self)
//    RAC(self.login, enabled) = [RACSignal combineLatest:@[self.userName.rac_textSignal, self.password.rac_textSignal] reduce:^(NSString *userName, NSString *password){
//        @strongify(self)
//        self.name = userName;
//        return @(userName.length > 6 && password.length > 6);
//    }];
    
//    [[RACObserve(self, name)
//      filter:^BOOL(NSString *name) {
//        return [name hasPrefix:@"x"];
//    }]
//     subscribeNext:^(NSString *x) {
//        NSLog(@"%@", x);
//    }];
    
    [[self.userName.rac_textSignal startWith:@"key is > 3"] filter:^BOOL(NSString *value) {
        NSLog(@"OK");
        return value.length > 3;
    }];
    
    self.login.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.userName.rac_textSignal, self.password.rac_textSignal] reduce:^(NSString *userName, NSString *password){
        return @(userName.length > 6 && password.length > 6);
    }] signalBlock:^RACSignal *(UIButton *input) {
        NSLog(@"button pressed : %@", input);
        return [RACSignal empty];
    }];
    /*
    NSArray *strings = @[@"asassasa", @"a", @"bbbb", @"ac"];
    RACSequence *results = [[strings.rac_sequence filter:^BOOL(NSString *value) {
        return value.length >= 2;
    }] map:^id(NSString *string) {
        return [string stringByAppendingString:@"tt"];
    }];
    
    NSLog(@"%@", results.array);
     */
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testRequest)];
    
    AnimationButton *button = [[AnimationButton alloc] initWithFrame:CGRectMake(200, 200, 54, 64)];
    [button addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)showMenu:(AnimationButton *)sender {
    sender.showMenu = !sender.showMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TIPS" message:@"Attention Please" delegate:nil cancelButtonTitle:@"CANCLE" otherButtonTitles:@"OK", @"TEST", nil];
    [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *index) {
        if (index.integerValue == 1) {
            [self testOpacityAnimation];
        } else if (index.integerValue == 0){
            
        } else {
            NSLog(@"TEST");
        }
    }];
    [alert show];
}

- (IBAction)test:(UILongPressGestureRecognizer *)sender {
    UIView *snapView = nil;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            snapView = [self.testView snapshotViewAfterScreenUpdates:YES];
            CGPoint startPoint = [sender locationInView:self.view];
            snapView.frame = self.testView.frame;
            snapView.center = CGPointMake(startPoint.x + 100, startPoint.y + 100);
            [self.view addSubview:snapView];
            snapView.layer.anchorPoint = startPoint;
            snapView.transform = CGAffineTransformMakeRotation(M_PI / 30);
//            self.testView.hidden = YES;
            self.testView.origin = startPoint;
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint changePoint = [sender locationInView:self.view];
            [UIView animateWithDuration:0.05 animations:^{
                self.testView.layer.position = changePoint;
            }];
        }
            break;
        case UIGestureRecognizerStateEnded:
            self.testView.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)testAnimation {
    NSInteger height = CGRectGetHeight(self.view.bounds);
    NSInteger width = CGRectGetWidth(self.view.bounds);
    
    CGFloat centerX = arc4random() % height;
    CGFloat centerY = arc4random() % width;

    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    [self.testView pop_addAnimation:animation forKey:@"center"];
}

- (void)testSpringAnimation {
    NSInteger height = CGRectGetHeight(self.view.bounds);
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_testView.centerX, height)];
    animation.springBounciness = 20;
    animation.springSpeed = 6;
    [self.testView pop_addAnimation:animation forKey:@"spring"];
}

- (void)testOpacityAnimation {
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    animation.fromValue = @(0.0);
    animation.toValue = @(1.0);
    animation.duration = 2;
    [self.testView.layer pop_addAnimation:animation forKey:@"opacity"];
}

- (void)testRequest {
    NSString *urlString = @"http://api.ycapp.yiche.com/yicheapp/getappconfigs/?appid=1";
    [[NetworkManager.defaultManager buildGetRACRequestSignalWithURL:urlString parameters:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)testShapeLayerAnimation {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineCap = kCALineCapRound;
    layer.lineWidth = 1;
    layer.bounds = CGRectZero;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 200)];
    [path addLineToPoint:CGPointMake(200, 300)];
    [path addLineToPoint:CGPointMake(200, 500)];
    layer.path = path.CGPath;
    [self.view.layer addSublayer:layer];
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    [layer pop_addAnimation:animation forKey:@"shape"];
}

@end
