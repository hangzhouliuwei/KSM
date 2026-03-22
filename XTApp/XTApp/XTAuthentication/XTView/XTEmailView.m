//
//  XTEmailView.m
//  XTApp
//
//  Created by xia on 2024/9/8.
//

#import "XTEmailView.h"

#define rowH 30

@interface XTEmailView()

@property(nonatomic,weak) UITextField *textField;
@property(nonatomic,strong) NSArray *emailList;
@property(nonatomic,strong) NSMutableArray <UIButton *>*btnList;

@end

@implementation XTEmailView

- (instancetype)init {
    self = [super init];
    if(self) {
 
        self.backgroundColor = XT_RGB(0x02CC56, 1.0f);
        self.layer.cornerRadius = 8;
        @weakify(self)
        UIView *lastView;
        for (NSInteger i = 0 ; i < self.emailList.count ; i ++) {
            UIButton *btn = [UIButton xt_btn:@"" font:XT_Font(12) textColor:[UIColor whiteColor] cornerRadius:0 tag:0];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.contentEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 7);
            [self addSubview:btn];
            [self.btnList addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                if(lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                }
                else {
                    make.top.equalTo(self.mas_top);
                }
                make.height.mas_equalTo(rowH);
            }];
            btn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
                @strongify(self)
                if(self.block) {
                    self.block([btn titleForState:UIControlStateNormal]);
                }
                return [RACSignal empty];
            }];
            lastView = btn;
        }
        
    }
    return self;
}
- (void)xt_showTextField:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(handleKeyBoardNotification:)
    name:UIKeyboardWillShowNotification
    object:nil];
    
    self.textField = textField;
}
-(void)handleKeyBoardNotification:(NSNotification *)sender {
    
    // 获取键盘高度，关键的一句
    
    NSValue *value = [sender.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    CGSize keyboardSize = [value CGRectValue].size;
//    XTLog(@"%f",keyboardSize.height);
    UIView *view = self.textField;
    BOOL search = YES;
    while (search) {
        view = view.superview;
        if([view isKindOfClass:[UITableView class]]) {
            search = NO;
        }
    }
    [view addSubview:self];
    
    CGRect rect = [self.textField.superview convertRect:self.textField.frame toView:XT_AppDelegate.window];
    
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.right.equalTo(self.textField.mas_right).offset(-18);
        if((CGRectGetMaxY(rect) + keyboardSize.height + self.emailList.count * rowH) > XT_Screen_Height){
            make.bottom.equalTo(self.textField.mas_top);
        }
        else {
            make.top.equalTo(self.textField.mas_bottom);
        }
        make.height.mas_equalTo(self.emailList.count * rowH);
    }];
    @weakify(self)
    [self.textField.rac_textSignal subscribeNext:^(NSString *content){
        @strongify(self)
        [self xt_reloadText];
    }];
    [self xt_reloadText];
}

- (void)xt_reloadText {
    NSString *text = XT_Object_To_Stirng(self.textField.text);
    text = [text componentsSeparatedByString:@"@"].firstObject;
    for (NSInteger i = 0 ; i < self.emailList.count ; i ++) {
        if(i >= self.btnList.count) {
            return;
        }
        UIButton *btn = self.btnList[i];
        [btn setTitle:[NSString stringWithFormat:@"%@@%@",XT_Object_To_Stirng(text),XT_Object_To_Stirng(self.emailList[i])] forState:UIControlStateNormal];
    }
}

- (void)xt_remove {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    self.textField = nil;
    if(self.superview) {
        [self removeFromSuperview];
    }
}

- (NSArray *)emailList {
    if(!_emailList) {
        _emailList = @[
            @"gmail.com",
            @"icloud.com",
            @"yahoo.com",
            @"outlook.com",
        ];
    }
    return _emailList;
}

- (NSMutableArray<UIButton *> *)btnList {
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
