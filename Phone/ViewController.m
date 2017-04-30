//
//  ViewController.m
//  Phone
//
//  Created by Jake Graham on 4/24/17.
//  Copyright © 2017 Jake Graham. All rights reserved.
//

#import "ViewController.h"
#import "NetworkHandler.h"

#define COL1 45
#define COL2 145
#define COL3 245

#define ROW1 150
#define ROW2 250
#define ROW3 350
#define ROW4 450
#define ROW5 550

@interface ViewController ()

@end

@implementation ViewController {
    UILabel *numberLabel;
    NSString *extension;
    BOOL extensionEmpty;
    UIButton *deleteButton;
    NetworkHandler *networkHandler;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initButtons];
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 100)];
    numberLabel.text = @"Enter extension";
    numberLabel.textAlignment = NSTextAlignmentCenter;
    extension = @"";
    extensionEmpty = YES;
    [self.view addSubview:numberLabel];
    
    deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *image = [[UIImage imageNamed:@"ic_backspace"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [deleteButton setImage:image forState:UIControlStateNormal];
    [deleteButton setTintColor:[UIColor grayColor]];
    [deleteButton sizeToFit];
    CGRect frame = deleteButton.frame;
    frame = CGRectMake(self.view.frame.size.width - 40, 60, frame.size.width, frame.size.height);
    deleteButton.frame = frame;
    deleteButton.hidden = extensionEmpty;
    [deleteButton addTarget:self action:@selector(backspacePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    networkHandler = [[NetworkHandler alloc] init];
    [networkHandler initNetworkCommunication];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Display

- (void)initButtons {
    [self initButton0];
    [self initButton1];
    [self initButton2];
    [self initButton3];
    [self initButton4];
    [self initButton5];
    [self initButton6];
    [self initButton7];
    [self initButton8];
    [self initButton9];
    [self initButtonP];
    [self initButtonS];
    [self initButtonCall];
}

- (void)initButton1 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL1, ROW1, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"1" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button1Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton2 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL2, ROW1, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"2" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button2Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton3 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL3, ROW1, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"3" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button3Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton4 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL1, ROW2, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"4" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button4Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton5 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL2, ROW2, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"5" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button5Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton6 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL3, ROW2, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"6" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button6Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton7 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL1, ROW3, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"7" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button7Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton8 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL2, ROW3, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"8" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button8Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton9 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL3, ROW3, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"9" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button9Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButton0 {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL2, ROW4, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"0" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button0Pressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButtonP {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL3, ROW4, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"#" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButtonS {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL1, ROW4, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.borderColor = [UIColor brownColor].CGColor;
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 80 / 2.0f;
    [button setTitle:@"*" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonSPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)initButtonCall {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(COL2, ROW5, 80, 80);
    button.backgroundColor = [UIColor colorWithRed:118.0f/255.0f green:250.0f/255.0f blue:118.0f/255.0f alpha:1.0];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 80 / 2.0f;
    
    UIImage *image = [[UIImage imageNamed:@"ic_phone"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0]];
    
    [button addTarget:self action:@selector(buttonCallPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - Button Presses

- (void)button1Pressed {
    NSLog(@"1");
    extension = [extension stringByAppendingString:@"1"];
    [self extensionUpdated];
}

- (void)button2Pressed {
    NSLog(@"2");
    extension = [extension stringByAppendingString:@"2"];
    [self extensionUpdated];
}

- (void)button3Pressed {
    NSLog(@"3");
    extension = [extension stringByAppendingString:@"3"];
    [self extensionUpdated];
}

- (void)button4Pressed {
    NSLog(@"4");
    extension = [extension stringByAppendingString:@"4"];
    [self extensionUpdated];
}

- (void)button5Pressed {
    NSLog(@"5");
    extension = [extension stringByAppendingString:@"5"];
    [self extensionUpdated];
}

- (void)button6Pressed {
    NSLog(@"6");
    extension = [extension stringByAppendingString:@"6"];
    [self extensionUpdated];
}

- (void)button7Pressed {
    NSLog(@"7");
    extension = [extension stringByAppendingString:@"7"];
    [self extensionUpdated];
}

- (void)button8Pressed {
    NSLog(@"8");
    extension = [extension stringByAppendingString:@"8"];
    [self extensionUpdated];
}

- (void)button9Pressed {
    NSLog(@"9");
    extension = [extension stringByAppendingString:@"9"];
    [self extensionUpdated];
}

- (void)button0Pressed {
    NSLog(@"0");
    extension = [extension stringByAppendingString:@"0"];
    [self extensionUpdated];
}

- (void)buttonPPressed {
    NSLog(@"#");
    extension = [extension stringByAppendingString:@"#"];
    [self extensionUpdated];
}

- (void)buttonSPressed {
    NSLog(@"*");
    extension = [extension stringByAppendingString:@"*"];
    [self extensionUpdated];
}

- (void)buttonCallPressed {
    NSLog(@"C");
    [networkHandler dial:extension];
}

- (void)backspacePressed {
    if (deleteButton.hidden == NO) {
        extension = [extension substringToIndex:extension.length - 1];
        [self extensionUpdated];
    }
}

#pragma mark - Extension Display

- (void)extensionUpdated {
    if (extension.length == 0) {
        numberLabel.text = @"Enter extension";
        extensionEmpty = YES;
        deleteButton.hidden = YES;
    } else {
        numberLabel.text = extension;
        extensionEmpty = NO;
        deleteButton.hidden = NO;
    }
}

@end
