//
//  XTMarqueeView.h
//  XTApp
//
//  Created by xia on 2024/9/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XTMarqueeView;

typedef NS_ENUM(NSUInteger, XTMarqueeViewDirection) {
    XTMarqueeViewDirectionUpward,   // scroll from bottom to top
    XTMarqueeViewDirectionLeftward  // scroll from right to left
};

#pragma mark - XTMarqueeViewDelegate
@protocol XTMarqueeViewDelegate <NSObject>
- (NSUInteger)numberOfDataForMarqueeView:(XTMarqueeView*)marqueeView;
- (void)createItemView:(UIView*)itemView forMarqueeView:(XTMarqueeView*)marqueeView;
- (void)updateItemView:(UIView*)itemView atIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView;
@optional
- (NSUInteger)numberOfVisibleItemsForMarqueeView:(XTMarqueeView*)marqueeView;   // only for [XTMarqueeViewDirectionUpward]
- (CGFloat)itemViewWidthAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView;   // only for [XTMarqueeViewDirectionLeftward]
- (CGFloat)itemViewHeightAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView;   // only for [XTMarqueeViewDirectionUpward] and [useDynamicHeight = YES]
- (void)didTouchItemViewAtIndex:(NSUInteger)index forMarqueeView:(XTMarqueeView*)marqueeView;
@end
@interface XTMarqueeView : UIView

@property (nonatomic, weak) id<XTMarqueeViewDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval timeIntervalPerScroll;
@property (nonatomic, assign) NSTimeInterval timeDurationPerScroll; // only for [XTMarqueeViewDirectionUpward] and [useDynamicHeight = NO]
@property (nonatomic, assign) BOOL useDynamicHeight;    // only for [XTMarqueeViewDirectionUpward]
@property (nonatomic, assign) float scrollSpeed;    // only for [XTMarqueeViewDirectionLeftward] or [XTMarqueeViewDirectionUpward] with [useDynamicHeight = YES]
@property (nonatomic, assign) float itemSpacing;    // only for [XTMarqueeViewDirectionLeftward]
@property (nonatomic, assign) BOOL stopWhenLessData;    // do not scroll when all data has been shown
@property (nonatomic, assign) BOOL clipsToBounds;
@property (nonatomic, assign, getter=isTouchEnabled) BOOL touchEnabled;
@property (nonatomic, assign) XTMarqueeViewDirection direction;
- (instancetype)initWithDirection:(XTMarqueeViewDirection)direction;
- (instancetype)initWithFrame:(CGRect)frame direction:(XTMarqueeViewDirection)direction;
- (void)reloadData;
- (void)start;
- (void)pause;

@end

#pragma mark - XTMarqueeViewTouchResponder(Private)
@protocol XTMarqueeViewTouchResponder <NSObject>
- (void)touchesBegan;
- (void)touchesEndedAtPoint:(CGPoint)point;
- (void)touchesCancelled;
@end

#pragma mark - XTMarqueeViewTouchReceiver(Private)
@interface XTMarqueeViewTouchReceiver : UIView
@property (nonatomic, weak) id<XTMarqueeViewTouchResponder> touchDelegate;
@end

#pragma mark - UUMarqueeItemView(Private)
@interface UUMarqueeItemView : UIView   // UUMarqueeItemView's [tag] is the index of data source. if none data source then [tag] is -1
@property (nonatomic, assign) BOOL didFinishCreate;
@property (nonatomic, assign) CGFloat width;    // cache the item width, only for [XTMarqueeViewDirectionLeftward]
@property (nonatomic, assign) CGFloat height;   // cache the item height, only for [XTMarqueeViewDirectionUpward]
- (void)clear;

@end

NS_ASSUME_NONNULL_END
