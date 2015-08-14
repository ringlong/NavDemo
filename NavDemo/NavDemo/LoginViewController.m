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
#import "RRToolkit.h"
#import "NetworkManager.h"
#import "AnimationButton.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

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
    
//    [[self.userName.rac_textSignal startWith:@"key is > 3"] filter:^BOOL(NSString *value) {
//        NSLog(@"OK");
//        return value.length > 3;
//    }];
//    
//    self.login.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal combineLatest:@[self.userName.rac_textSignal, self.password.rac_textSignal] reduce:^(NSString *userName, NSString *password){
//        return @(userName.length > 6 && password.length > 6);
//    }] signalBlock:^RACSignal *(UIButton *input) {
//        NSLog(@"button pressed : %@", input);
//        return [RACSignal empty];
//    }];
    /*
    NSArray *strings = @[@"asassasa", @"a", @"bbbb", @"ac"];
    RACSequence *results = [[strings.rac_sequence filter:^BOOL(NSString *value) {
        return value.length >= 2;
    }] map:^id(NSString *string) {
        return [string stringByAppendingString:@"tt"];
    }];
    
    NSLog(@"%@", results.array);
     */
//    NSAttributedString *title =
//    [[NSAttributedString alloc] initWithString:@"   8\nlogin"
//                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],
//                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]}];
    [self.login setTitle:@"8\nlogin" forState:UIControlStateNormal];    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(testRequest)];
    
    NSString *testString = @"有人问一位登山家为什么要去登山——谁都知道登山这件事既危险，又没什么实际的好处，他回答道：“因为那座山峰在那里。”我喜欢这个答案，因👿👿👿👿👿👿👿👿为里面包含着幽默感——明明是自己想要登山，偏说是山在那里使他心里痒痒。除此之外，我还喜欢这位登山家干的事，没来由地往悬崖上爬。它会导致肌肉疼痛，还要冒摔出脑子的危险，所以一般人尽量避免爬山。用热力学的角度来看，这是个反熵的现象，所发趋害避利肯定反熵。    　　现在把登山和写作相提并论，势必要招致反对。这是因为最近十年来中国有过小说热、诗歌热、文化热，无论哪一种热都会导致大量的人投身写作，别人常把我看成此类人士中的一个，并且告abcd诫我说，现在都是什么年月了，你还写小说（言下之意是眼下是经商热，我该下海去经商了）？但是我的情形不一样。前三种热发生时，我222222正在美国念书，丝毫没有受到感染。我们家的家训是不准孩子学文科，一律去学理工。因为这些缘故，立志写作在我身上是个不折不扣的反熵过程。我到现在也弄不明白自己为什么要干这件事，除了它是个反熵过程这一点。    　　有关我立志写作是个反熵过程，还有进一步解释的必要。写作是个笼统的字眼，还要看写什么东西。写畅销小说、爱情小诗等等热门东西，应该列入熵增过程之列。我写的东西一点不热门，不但挣不了钱，有时还要倒贴一些。严肃作家的“严肃”二字，就该做如此理解。据我所知，这世界上有名的严肃作家，大多是凑合也算不上。这样说明了以后，大家都能明白我确实在一个反熵过程中。";
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setParagraphSpacing:3];
    [style setLineSpacing:3];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:testString attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: style}];
    self.textLabel.attributedText = attrString;
}

- (void)showMenu:(AnimationButton *)sender {
    sender.showMenu = !sender.showMenu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(UIButton *)sender {
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"TIPS" message:@"Attention Please" delegate:nil cancelButtonTitle:@"CANCLE" otherButtonTitles:@"OK", @"TEST", nil];
//    [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *index) {
//        if (index.integerValue == 1) {
//            [self testOpacityAnimation];
//        } else if (index.integerValue == 0){
//            
//        } else {
//            NSLog(@"TEST");
//        }
//    }];
//    [alert show];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    dateFormatter.locale = frLocale;
    
    dateFormatter.doesRelativeDateFormatting = YES;
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*3];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSLog(@"dateString: %@", dateString);
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


- (void)testCaulater {
//    NSInteger a = 10000;
//     @(a & 1);
}


@end
