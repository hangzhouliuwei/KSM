//
//  CapsuleButton.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/8/26.
//

#import "PLPCapsuleButton.h"

@implementation PLPCapsuleButton
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGradientLayer];
        self.layer.cornerRadius = frame.size.height / 2.0;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}
- (void)setupGradientLayer {
    if (!self.gradientLayer) {
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.colors = @[
            (id)kHexColor(0x008BFD).CGColor,
            (id)kHexColor(0x2D60F5).CGColor
        ];
        self.gradientLayer.startPoint = CGPointMake(0, 0.5);
        self.gradientLayer.endPoint = CGPointMake(1, 0.5);
        self.gradientLayer.cornerRadius = self.height / 2.0;
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
}
- (void)setSolidBackgroundColor:(UIColor *)color {
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // Disable animations for immediate changes
    self.gradientLayer.hidden = YES; // Hide the gradient layer
    self.backgroundColor = color;
    [CATransaction commit];
}

- (void)resetToGradientBackgroundColor {
    [CATransaction begin];
    [CATransaction setDisableActions:YES]; // Disable animations for immediate changes
    self.gradientLayer.hidden = NO; // Show the gradient layer
    self.backgroundColor = [UIColor clearColor];
    [CATransaction commit];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)resetGradientBackground {
}

@end
