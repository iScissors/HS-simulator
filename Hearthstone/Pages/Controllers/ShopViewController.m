//
//  ShopViewController.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/20/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "ShopViewController.h"
#import "UIView+Positioning.h"

@interface ShopViewController()

@property (weak, nonatomic) IBOutlet UIButton *classicPack;

@property (weak, nonatomic) IBOutlet UIButton *gvgPack;

@end

@implementation ShopViewController

#pragma mark Initialization

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configurePackButtons];
}


- (IBAction)returnToMainView:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shopClose" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Support

- (IBAction)selectPack:(id)sender {
    
    if ([sender isEqual:self.classicPack]) {
        [self.classicPack setSelected:YES];
        self.classicPack.userInteractionEnabled = NO;
        [self.gvgPack setSelected:NO];
        self.gvgPack.userInteractionEnabled = YES;
    }
    else {
        [self.classicPack setSelected:NO];
        self.classicPack.userInteractionEnabled = YES;
        [self.gvgPack setSelected:YES];
        self.gvgPack.userInteractionEnabled = NO;
        
    }
}

- (void)configurePackButtons {
    
    self.classicPack.adjustsImageWhenHighlighted = NO;
    [self.classicPack setImage:[UIImage imageNamed:@"classicBlue"] forState:UIControlStateSelected];
    [self.classicPack setImage:[UIImage imageNamed:@"classicGrey"] forState:UIControlStateNormal];
    
    self.gvgPack.adjustsImageWhenHighlighted = NO;
    [self.gvgPack setImage:[UIImage imageNamed:@"gvgBlue"] forState:UIControlStateSelected];
    [self.gvgPack setImage:[UIImage imageNamed:@"gvgGrey"] forState:UIControlStateNormal];
}

@end
