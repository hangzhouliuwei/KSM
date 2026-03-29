//
//  PopView.m
// FIexiLend
//
//  Created by jacky on 2024/11/13.
//

#import "PPDefaultCardPopView.h"

@interface PPDefaultCardPopView ()
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, copy) NSString *imageName;
@end

@implementation PPDefaultCardPopView

- (id)initWithFrame:(CGRect)frame image:(NSString *)imageName {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.imageName = imageName;
        [self loadUI];
    }
    return self;
}

- (void)loadUI {
    _suspendImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _suspendImageView.userInteractionEnabled = YES;
    [_suspendImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suspendClickAction)]];
    [self addSubview:_suspendImageView];
    if ([_imageName containsString:@"http"]) {
        [_suspendImageView sd_setImageWithURL:[NSURL URLWithString:_imageName]];
    }else {
        _suspendImageView.image = ImageWithName(_imageName);
    }
}

- (void)suspendClickAction {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    _startPoint = point;
    [[self superview] bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPoint newcenter = CGPointMake(self.center.x + point.x - _startPoint.x, self.center.y + point.y - _startPoint.y);
    float halfX = CGRectGetMidX(self.bounds);
    float halfY = CGRectGetMidY(self.bounds);
    newcenter.x = MAX(halfX, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfX, newcenter.x);
    newcenter.y = MAX(halfY, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfY, newcenter.y);
    self.center = newcenter;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = self.center;
    if (point.x > [self superview].w/2.0) {
        [UIView animateWithDuration:0.2 animations:^{
            if (self.y <= StatusBarHeight) {
                self.y = StatusBarHeight;
            }else if (self.y > [self superview].h - self.h - TabBarHeight - 20) {
                self.y = [self superview].h - self.h - TabBarHeight - 20;
            }
            self.x = [self superview].w - self.w;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            if (self.y <= StatusBarHeight) {
                self.y = StatusBarHeight;
            }else if (self.y > [self superview].h - self.h - TabBarHeight - 20) {
                self.y = [self superview].h - self.h - TabBarHeight - 20;
            }
            self.x = 0;
        }];
    }
}

@end
