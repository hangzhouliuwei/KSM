//
//  XTAssistiveView.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTAssistiveView.h"

#define viewW 48
#define viewH 48
#define space 10

#define MinX 0
#define MaxX (XT_Screen_Width - viewW)

#define MinY XT_StatusBar_Height
#define MaxY (XT_Screen_Height - viewH - XT_Bottom_Height)

@interface XTAssistiveView()
///拖动开始的位置
@property(nonatomic) NSInteger startY;
@property(nonatomic) NSInteger startX;
///拖动结束的位置
@property(nonatomic) NSInteger touchY;
@property(nonatomic) NSInteger touchX;

@property(nonatomic,copy) NSString *url;
@property(nonatomic,strong) UIImageView *img;

@end


@implementation XTAssistiveView

+(instancetype)xt_share {
    static XTAssistiveView *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc]init];
    });
    return shareInstance;
}

- (id)init {
    self = [super init];
    if(self) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(reloadLocation:)];
        [self addGestureRecognizer:pan];
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(XT_Screen_Width - viewW - space, XT_StatusBar_Height, viewW, viewH);
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            [[XTRoute xt_share] goHtml:self.url success:nil];
            return [RACSignal empty];
        }];
        
        [self addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(void)xt_showIcon:(NSString *)icon url:(NSString *)url {
    self.url = url;
    [self.img sd_setImageWithURL:[NSURL URLWithString:icon] placeholderImage:XT_Img(@"xt_customer_logo")];
    self.hidden = NO;
    [XT_AppDelegate.window addSubview:self];
}

-(void)reloadLocation:(UIPanGestureRecognizer *)pan{
    CGPoint panPoint = [pan locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    if(pan.state == UIGestureRecognizerStateBegan){
        self.startY = panPoint.y;
        self.startX = panPoint.x;
        CGPoint selfPoint = [pan locationInView:self];
        self.touchY = selfPoint.y;
        self.touchX = selfPoint.x;
    }
    else if(pan.state == UIGestureRecognizerStateChanged){
        self.frame = CGRectMake(panPoint.x - self.touchX, panPoint.y - self.touchY, self.width, self.height);
    }
    else if(pan.state == UIGestureRecognizerStateEnded){
        float x = self.x < MinX ? MinX : (self.x > MaxX ? MaxX : self.x);
        float y = self.y < MinY ? MinY : (self.y > MaxY ? MaxY : self.y);
        if(x != self.x || y != self.y){
            [UIView animateWithDuration:0.3
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:10
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                self.frame = CGRectMake(x, y, self.width, self.height);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (UIImageView *)img {
    if(!_img) {
        _img = [UIImageView new];
        _img.contentMode = UIViewContentModeScaleAspectFit;
        _img.clipsToBounds = YES;
    }
    return _img;
}

@end
