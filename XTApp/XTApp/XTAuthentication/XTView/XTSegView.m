//
//  XTSegView.m
//  XTApp
//
//  Created by xia on 2024/9/11.
//

#import "XTSegView.h"
#import "XTSegBtn.h"

@interface XTSegView()

@property(nonatomic,strong) NSMutableArray <XTSegBtn *>*btnList;

@end

@implementation XTSegView

- (instancetype)initArr:(NSArray <NSDictionary *>*)arr
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor
                 select:(NSInteger)select {
    return [self initArr:arr font:font selectFont:selectFont color:color selectColor:selectColor bgColor:bgColor selectBgColor:selectBgColor cornerRadius:0 select:select];
}
- (instancetype)initArr:(NSArray <NSDictionary *>*)arr
                   font:(UIFont *)font
             selectFont:(UIFont *)selectFont
                  color:(UIColor *)color
            selectColor:(UIColor *)selectColor
                bgColor:(UIColor *)bgColor
          selectBgColor:(UIColor *)selectBgColor
           cornerRadius:(NSInteger)cornerRadius
                 select:(NSInteger)select {
    self = [super init];
    if(self) {
        XTSegBtn *lastBtn = nil;
        for(NSInteger i = 0 ; i < arr.count ; i ++) {
            NSDictionary *dic = arr[i];
            NSString *name = dic[@"name"];
            XTSegBtn *btn = [[XTSegBtn alloc] initTit:name font:font selectFont:selectFont color:color selectColor:selectColor bgColor:bgColor selectBgColor:selectBgColor];
            if(cornerRadius > 0){
                btn.layer.cornerRadius = cornerRadius;
            }
            [self addSubview:btn];
            [self.btnList addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if(lastBtn){
                    make.left.equalTo(lastBtn.mas_right);
                }
                else {
                    make.left.equalTo(self.mas_left);
                }
                make.top.bottom.equalTo(self);
                make.width.equalTo(self).multipliedBy(1.0f/arr.count);
            }];
            btn.index = i;
            if(select == i) {
                btn.enabled = NO;
                self.indexBtn = btn;
            }
            [btn addTarget:self action:@selector(xt_select:) forControlEvents:UIControlEventTouchUpInside];
            lastBtn = btn;
        }
    }
    return self;
}

- (void)xt_select:(XTSegBtn *)btn {
    self.indexBtn.enabled = YES;
    self.indexBtn = btn;
    self.indexBtn.enabled = NO;
    if(self.block) {
        self.block(self.indexBtn.index);
    }
}
-(void)reloadSeg:(NSInteger)index {
    XTSegBtn *btn = self.btnList[index];
    self.indexBtn.enabled = YES;
    self.indexBtn = btn;
    self.indexBtn.enabled = NO;
}

- (NSMutableArray<XTSegBtn *> *)btnList {
    if(!_btnList) {
        _btnList = [NSMutableArray array];
    }
    return _btnList;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
