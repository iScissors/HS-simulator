//
//  ShopViewController.m
//  Hearthstone
//
//  Created by Grachev Yaroslav on 05/20/15.
//  Copyright (c) 2015 Grachev. All rights reserved.
//

#import "ShopViewController.h"
#import "UIView+Positioning.h"
#import "CoreData+MagicalRecord.h"

@interface ShopViewController()

@property (weak, nonatomic) IBOutlet UIButton *classicPack;

@property (weak, nonatomic) IBOutlet UIButton *gvgPack;

@property (strong, nonatomic) PackModel *packType;

@property (strong, nonatomic) NSString *backType;

@end

@implementation ShopViewController

#pragma mark Initialization

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configurePackButtons];
}


- (IBAction)returnToMainView:(id)sender {
    
    if (self.packType)
        self.delegate.packModel = self.packType;
    
//    if (self.backType) {
//        self.delegate.backType = self.packType;
//    }
    
    [self.delegate performSelector:@selector(dismissBlur)];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Pack logic

- (IBAction)selectPack:(id)sender {
    
    if ([sender isEqual:self.classicPack]) {
        self.packType = [PackModel MR_findFirstByAttribute:@"type" withValue:@"Classic"];
        [self.classicPack setSelected:YES];
        self.classicPack.userInteractionEnabled = NO;
        [self.gvgPack setSelected:NO];
        self.gvgPack.userInteractionEnabled = YES;
    }
    else {
        self.packType = [PackModel MR_findFirstByAttribute:@"type" withValue:@"Goblins vs Gnomes"];
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

#pragma mark Backs logic



@end
