//
//  PUBBaseButton.m
//  PeraUBagProject
//
//  Created by 刘巍 on 2023/12/27.
//

#import "PUBBaseButton.h"

@implementation PUBBaseButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame radius:(CGFloat)radius {
    self = [super initWithFrame:frame];
    if (self) {
        [self showRadius:radius];
        self.titleLabel.font = FONT_BOLD(16);
        self.type = NLButtonTypeNormal;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
        self.title = title;
    }
    return self;
}

- (void)loadUI {
    [self showRadius:self.height/2];
    self.titleLabel.font = FONT_BOLD(16);
    self.type = NLButtonTypeNormal;
}

- (CAGradientLayer *)gradient {
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        _gradient.frame = self.bounds;
        _gradient.colors = @[(id)MainColor.CGColor, (id)COLOR(255, 133, 133).CGColor];
        _gradient.startPoint = CGPointMake(0, 0);
        _gradient.endPoint = CGPointMake(1, 0);
    }
    return _gradient;
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    _title = title;
}

- (void)setType:(NLButtonType)type {
    self.alpha = 1;
    self.enabled = YES;
    self.layer.borderWidth = 0;
    if (type == NLButtonTypeNormal) {
        [self setTitleColor:TextBlackColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)MainColor.CGColor, (id)MainColor.CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeDisable) {
        self.enabled = NO;
        [self setTitleColor:TextBlackColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(16, 180, 142).CGColor, (id)COLOR(16, 180, 142).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
        self.alpha = 0.35;
    }else if (type == NLButtonTypeBorder) {
        [self setTitleColor:MainColor forState:UIControlStateNormal];
        self.layer.borderColor = MainColor.CGColor;
        self.layer.borderWidth = 0.5;
        [self.gradient removeFromSuperlayer];
    }else if (type == NLButtonTypeSimple) {
        [self.gradient removeFromSuperlayer];
        [self setTitleColor:MainColor forState:UIControlStateNormal];
    }else if (type == NLButtonTypeGray) {
        [self setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)ViewLightGrayColor.CGColor, (id)ViewLightGrayColor.CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeGrayWhiteText) {
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)TextLightGrayColor.CGColor, (id)TextLightGrayColor.CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeGrayBorder) {
        self.enabled = YES;
        [self setTitleColor:TextGrayColor forState:UIControlStateNormal];
        self.layer.borderColor = TextLightGrayColor.CGColor;
        self.layer.borderWidth = 0.5;
        [self.gradient removeFromSuperlayer];
    }else if (type == NLButtonTypeGoldGary) {
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(153, 137, 137).CGColor, (id)COLOR(208, 208, 208).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeMember) {
        [self setTitleColor:COLOR(117, 75, 5) forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(255, 225, 175).CGColor, (id)COLOR(237, 184, 97).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeNoMember) {
        self.enabled = YES;
        self.layer.borderWidth = 0;
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(98, 98, 98).CGColor, (id)COLOR(98, 98, 98).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeRedOrange) {
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(255, 98, 98).CGColor, (id)COLOR(237, 184, 97).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeOrangeRed) {
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(255, 130, 92).CGColor, (id)COLOR(255, 47, 45).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeBlackWhite){
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)TextBlackColor.CGColor, (id)TextBlackColor.CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeDiscontWhite){
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(255, 151, 0).CGColor, (id)COLOR(255, 151, 0).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeConfirm){
        [self setTitleColor:COLOR(16, 180, 142) forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(222, 255, 238).CGColor, (id)COLOR(222, 255, 238).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }else if (type == NLButtonTypeCancel){
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.gradient.colors = @[(id)COLOR(16, 180, 142).CGColor, (id)COLOR(16, 180, 142).CGColor];
        [self.layer insertSublayer:self.gradient atIndex:0];
    }
    _type = type;
}


@end
