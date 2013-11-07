//
//  UZInputCandidateAccessory.m
//  InputCandidateView
//
//  Created by sonson on 2013/11/07.
//  Copyright (c) 2013年 sonson. All rights reserved.
//

#import "UZInputCandidateAccessory.h"

@interface UZInputCandidateAccessoryCell : UICollectionViewCell {
	IBOutlet UILabel *_label;
}
@property (nonatomic, readonly) UILabel *label;
@end

@interface UZInputCandidateAccessory() <UICollectionViewDataSource, UICollectionViewDelegate> {
	UIView				*_contentView;
	UICollectionView	*_collectionView;
	NSArray				*_titleList;
	NSArray				*_titleSizeList;
}
@end

@implementation UZInputCandidateAccessoryCell

- (void)privateInit {
	self.backgroundColor = [UIColor clearColor];
	self.contentView.backgroundColor = [UIColor clearColor];
	_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	_label.backgroundColor = [UIColor clearColor];
	_label.textColor = [UIColor colorWithRed:0 green:120.0/255.0f blue:255.0/255.0f alpha:1];
	[_label setFont:[UIFont systemFontOfSize:18]];
	[self.contentView addSubview:_label];
	_label.translatesAutoresizingMaskIntoConstraints = NO;
	[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_label  attribute:NSLayoutAttributeCenterX  relatedBy:NSLayoutRelationEqual  toItem:self.contentView  attribute:NSLayoutAttributeCenterX  multiplier:1  constant:0 ] ] ;
	[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_label  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual  toItem:self.contentView  attribute:NSLayoutAttributeCenterY multiplier:1  constant:0 ] ] ;
	[self.contentView updateConstraints];
	self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
	self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f blue:227/255.0f alpha:1];
}

- (void)prepareForReuse {
	[super prepareForReuse];
	[self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self privateInit];
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[self privateInit];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor colorWithRed:254.0/255.0f green:254.0/255.0f blue:254.0/255.0f alpha:1] setFill];
	CGContextFillRect(context, rect);
	[[UIColor colorWithRed:203.0/255.0f green:203.0/255.0f blue:203.0/255.0f alpha:1] setFill];
	CGContextFillRect(context, CGRectMake(0, 0, rect.size.width, 0.5));
	CGContextFillRect(context, CGRectMake(rect.size.width - 0.5, 0, 0.5, rect.size.height));
	CGContextFillRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

@end

@implementation UZInputCandidateAccessory

- (void)setStrings:(NSArray*)strings {
	_titleList = [NSArray arrayWithArray:strings];
	NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
	NSMutableArray *buf = [NSMutableArray arrayWithCapacity:[_titleList count]];
	for (NSString *string in _titleList) {
		CGSize s = [string sizeWithAttributes:attributes];
		s.width = floor(s.width) + 20;
		s.height = 35;
		[buf addObject:[NSValue valueWithCGSize:s]];
	}
	_titleSizeList = [NSArray arrayWithArray:buf];
	[_collectionView reloadData];
}

- (UIView*)candidateAccessoryView {
	return _contentView;
}

- (id)init {
    self = [super init];
    if (self) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		layout.minimumLineSpacing = 0;
		_contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 35) collectionViewLayout:layout];
		_collectionView.alwaysBounceHorizontal = YES;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = [UIColor colorWithRed:203/255.0f green:203/255.0f blue:203/255.0f alpha:1];
		[_collectionView registerClass:[UZInputCandidateAccessoryCell class] forCellWithReuseIdentifier:@"UZInputCandidateAccessoryCell"];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		//_collectionView.contentInset = UIEdgeInsetsMake(0, 44, 0, 0);
		[_contentView addSubview:_collectionView];
		_collectionView.translatesAutoresizingMaskIntoConstraints = NO;
		NSDictionary *views = NSDictionaryOfVariableBindings(_contentView, _collectionView);
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==0)-[_collectionView]-(==0)-|"
																				 options:0 metrics:0 views:views]];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(==0)-[_collectionView]-(==0)-|"
																				 options:0 metrics:0 views:views]];
		[_contentView updateConstraints];
    }
    return self;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
	return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [[_titleSizeList objectAtIndex:indexPath.item] CGSizeValue];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	[collectionView deselectItemAtIndexPath:indexPath animated:YES];
	if ([self.delegate respondsToSelector:@selector(inputCandidateAccessory:selectedString:)])
		[self.delegate inputCandidateAccessory:self selectedString:[_titleList objectAtIndex:indexPath.item]];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [_titleList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UZInputCandidateAccessoryCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"UZInputCandidateAccessoryCell" forIndexPath:indexPath];
	cell.label.text = [_titleList objectAtIndex:indexPath.item];
	cell.label.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
