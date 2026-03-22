//
//  XTSelectDayView.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTSelectDayView.h"
#import "NSDate+XTCategory.h"

@interface XTSelectDayView()

@property(nonatomic,weak) UIDatePicker *picker;

@end

@implementation XTSelectDayView

- (instancetype)initTit:(NSString *)tit {
    self = [super initWithFrame:CGRectMake(0, 0, XT_Screen_Width, XT_Screen_Height)];
    if(self) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self)
        btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        
        UIView *view = [UIView xt_frame:CGRectMake(0, 0, self.width, 0) color:[UIColor whiteColor]];
        [self addSubview:view];
        
        UILabel *titLab = [UILabel xt_lab:CGRectMake(15, 0, view.width - 30, 45) text:tit font:XT_Font_M(15) textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft tag:0];
        [view addSubview:titLab];
        [view addSubview:[UIView xt_frame:CGRectMake(15, titLab.height, titLab.width, 1) color:XT_RGB(0xE2E2E2, 1.0f)]];
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, titLab.height + 20, view.width, 216)];
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];//NSLocale(localeIdentifier: "en_GB")
        if (@available(iOS 13.4, *)) {
            picker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        picker.datePickerMode = UIDatePickerModeDate;
        picker.backgroundColor = [UIColor whiteColor];
        picker.date = [NSDate date];
        picker.minimumDate = [NSDate dateFromString:@"1960-01-01" Format:@"yyyy-MM-dd"];
        picker.maximumDate = [NSDate dateFromString:@"2040-12-31" Format:@"yyyy-MM-dd"];
        [view addSubview:picker];
        self.picker = picker;
        picker.centerX = self.centerX;
        
        UIButton *submit = [UIButton xt_btn:@"Confirm" font:XT_Font_B(20) textColor:[UIColor whiteColor] cornerRadius:24 tag:0];
        submit.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        [view addSubview:submit];
        submit.frame = CGRectMake(20, CGRectGetMaxY(picker.frame), view.width - 40, 48);
        submit.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)
            NSString *time = [picker.date getDateStringByFormat:@"dd-MM-yyyy"];
            if(self.sureBlock) {
                self.sureBlock(@{
                    @"name":time,
                    @"value":time,
                });
            }
            if(self.closeBlock) {
                self.closeBlock();
            }
            return [RACSignal empty];
        }];
        view.height = CGRectGetMaxY(submit.frame) + 20 + XT_Bottom_Height;
        view.y = self.height - view.height;
        [view xt_rect:view.bounds corners:UIRectCornerTopLeft|UIRectCornerTopRight size:CGSizeMake(15, 15)];
    }
    return self;
}

- (void)xt_value:(NSString *)value{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if(![NSString xt_isEmpty:value]) {
        self.picker.date = [NSDate dateFromString:value Format:@"dd-MM-yyyy"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
