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
#import "CardBackModel.h"
#import "UIImage+animatedGIF.h"

@interface ShopViewController()

@property (weak, nonatomic) IBOutlet UIButton *classicPack;

@property (weak, nonatomic) IBOutlet UIButton *gvgPack;

@property (weak, nonatomic) IBOutlet UICollectionView *backsCollection;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@property (strong, nonatomic) PackModel *packType;

@property (strong, nonatomic) NSString *backType;

@end

@implementation ShopViewController {
    NSMutableArray *cardBacksArray;
}

#pragma mark Initialization

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configurePackButtons];
//    [self configureCardBacks];
    [self showPacks:self];
    [self loadBacksImages];
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

- (IBAction)showPacks:(id)sender {
    [UIView animateWithDuration:1
                     animations:^{
                         self.backsCollection.hidden = YES;
                     } completion:^(BOOL finished) {
                         self.gvgPack.hidden = NO;
                         self.classicPack.hidden = NO;
                     }];

}

- (IBAction)showBacks:(id)sender {
    
    [self.backsCollection reloadData];
    [self.backsCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                 atScrollPosition:(UICollectionViewScrollPositionNone)
                                         animated:NO];
    [UIView animateWithDuration:1
                     animations:^{
                         self.gvgPack.hidden = YES;
                         self.classicPack.hidden = YES;
                     } completion:^(BOOL finished) {
                         self.backsCollection.hidden = NO;
                     }];
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

- (void)loadBacksImages {
    
    cardBacksArray = [NSMutableArray new];
    for (CardBackModel *model in [CardBackModel MR_findAllSortedBy:@"cardBackId" ascending:YES]) {
        NSLog(@"NAME == %@", model.name);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", model.image]];
//        [cardBacksArray addObject:[UIImage animatedImageWithAnimatedGIFURL:url]]; лагает в приложении
//        NSData *data = [NSData dataWithContentsOfURL:url];
        NSMutableDictionary *item = [@{@"image": @(0)} mutableCopy];
        [cardBacksArray addObject:item];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [item setObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:url]] forKey:@"image"];
        });
    }
}

- (BOOL)loadingFinished {
    
    for (NSDictionary *item in cardBacksArray) {
        if ([item[@"image"] isKindOfClass:[NSNumber class]]) {
            self.loadingLabel.hidden = NO;
            return NO;
        }
    }
    self.loadingLabel.hidden = YES;
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)view cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [view dequeueReusableCellWithReuseIdentifier:@"CardBack" forIndexPath:indexPath];
    
    if ([self loadingFinished]) {
        UIImageView *backView = [UIImageView new];
        backView.image = cardBacksArray[indexPath.row][@"image"];
        backView.width = cell.width + cell.width * 0.21896;
        backView.height = cell.height + cell.height * 0.23475;
        backView.x -= backView.width * 0.11765;
        backView.y -= backView.height * 0.15948;
        
        [cell addSubview:backView];
    }
    
    return  cell;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return ([self loadingFinished] ? cardBacksArray.count : 0);
}


@end
