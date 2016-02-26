//
//  MainViewController.m
//  KbFocusTest
//
//  Created by Sergei Epatov on 2/26/16.
//

#import "MainViewController.h"

static NSString * const kDefaultText = @"Press Up, Down, Left, Right on Bluetooth keyboard";

@interface MainViewController ()
@property (strong) UILabel *label;
@property (assign) BOOL keyWasRecentlyPressed;
@property (strong) CADisplayLink *displayLink;
@property (strong) NSArray *kbCommands;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createLabel];
    [self createKBEvents];
    [self createDisplayLink];
}

- (void)viewWillLayoutSubviews {
    self.label.frame = self.view.bounds;
}

- (NSArray<UIKeyCommand *> *)keyCommands {
    return self.kbCommands;
}

#pragma mark -
#pragma mark Callbacks

- (void)setText:(NSString *)text {
    self.label.text = text;
    self.label.alpha = 1.0;
    self.keyWasRecentlyPressed = YES;
}

- (void)onKeyCommandLeft:(UIKeyCommand *)keyComand {
    [self setText:@"Left"];
}

- (void)onKeyCommandRight:(UIKeyCommand *)keyComand {
    [self setText:@"Right"];
}

- (void)onKeyCommandUp:(UIKeyCommand *)keyComand {
    [self setText:@"Up"];
}

- (void)onKeyCommandDown:(UIKeyCommand *)keyComand {
    [self setText:@"Down"];
}
                        
- (void)onDisplayLink:(id)sender {
    if (self.keyWasRecentlyPressed) {
        self.label.alpha = self.label.alpha * 0.75;
        if (self.label.alpha < 0.01) {
            [self setText:kDefaultText];
            self.keyWasRecentlyPressed = NO;
        }
    }
}

#pragma mark -
#pragma mark Creation helpers

- (void)createLabel {
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:30];
    self.label.text = kDefaultText;
    self.label.layer.borderWidth = 4.0;
    self.label.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:self.label];
}

- (void)createKBEvents {
    self.kbCommands = @
    [
     [UIKeyCommand keyCommandWithInput:UIKeyInputLeftArrow modifierFlags:0 action:@selector(onKeyCommandLeft:)],
     [UIKeyCommand keyCommandWithInput:UIKeyInputRightArrow modifierFlags:0 action:@selector(onKeyCommandRight:)],
     [UIKeyCommand keyCommandWithInput:UIKeyInputUpArrow modifierFlags:0 action:@selector(onKeyCommandUp:)],
     [UIKeyCommand keyCommandWithInput:UIKeyInputDownArrow modifierFlags:0 action:@selector(onKeyCommandDown:)]
     ];
}

- (void)createDisplayLink {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink:)];
    self.displayLink.frameInterval = 3;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
