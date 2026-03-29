//
//  PPNormalCardLinkmanCell.m
// FIexiLend
//
//  Created by jacky on 2024/11/19.
//

#import "PPNormalCardLinkmanCell.h"
#import <ContactsUI/ContactsUI.h>
#import "PPNormalCardRelationAlert.h"
#import "PPIconTitleButtonView.h"

@interface PPNormalCardLinkmanCell () <CNContactPickerDelegate>
@property (nonatomic, strong) UILabel *nameValueLabelConfigHelper;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *infoDescLabelConfigHelper;
@property (nonatomic, strong) UILabel *phoneValueLabelConfigHelper;
@property (nonatomic, strong) PPNormalCardRelationAlert *alert;
@property (nonatomic, strong) UIView *itemBg;
@property (nonatomic, strong) PPIconTitleButtonView *relationValueViewlConfigHelper;


@end

@implementation PPNormalCardLinkmanCell

- (id)initWithFrame:(CGRect)frame data:(NSDictionary *)dic {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.data = [NSMutableDictionary dictionary];
        self.data[p_mobile] = dic[p_filled][p_mobile];
        self.data[p_name] = dic[p_filled][p_name];
        self.data[p_relation] = dic[p_filled][p_relation];
        self.data[p_note] = dic[p_relation];
        [self loadUI:dic];
    }
    return self;
}

- (void)infoTap:(UIButton*)sender {
    [self showLinkMan];
}

- (void)relationAction {
    NSArray *noteList = self.data[p_note];
    kWeakself;
    _alert = [[PPNormalCardRelationAlert alloc] initWithData:noteList selected:[self.data[p_relation] stringValue] title:@"Relation Ship"];
    _alert.selectBlock = ^(NSDictionary *dic) {
        weakSelf.data[p_relation] = dic[p_key];
            [weakSelf refreshData];
        };
    [_alert show];
}


- (void)loadUI:(NSDictionary *)dic {
    
    _infoDescLabelConfigHelper = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.w, 38)];
    _infoDescLabelConfigHelper.backgroundColor = rgba(247, 251, 255, 1);

    _infoDescLabelConfigHelper.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_infoDescLabelConfigHelper];
    _infoDescLabelConfigHelper.text = dic[p_title];
    _infoDescLabelConfigHelper.textColor = TextBlackColor;
    _infoDescLabelConfigHelper.font = FontBold(14);
    
    UILabel *relationDesc = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, _infoDescLabelConfigHelper.bottom, self.w - 2*LeftMargin, 50)];
    relationDesc.textColor = TextGrayColor;
    relationDesc.font = Font(14);
    [self addSubview:relationDesc];
    relationDesc.text = @"Relationship";

    
    _relationValueViewlConfigHelper = [[PPIconTitleButtonView alloc] initWithFrame:CGRectMake(0, _infoDescLabelConfigHelper.bottom, self.w - LeftMargin, 50) title:@"Please select" color:TextGrayColor font:14 icon:@"arrow_bot"];
    _relationValueViewlConfigHelper.type = HaoBtnType4;
    [_relationValueViewlConfigHelper addTarget:self action:@selector(relationAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_relationValueViewlConfigHelper];
    
    UIView *lineGrayView = [[UIView alloc] initWithFrame:CGRectMake(16, 90, self.w - 32, 0.8)];
    [self addSubview:lineGrayView];
    lineGrayView.backgroundColor = LineGrayColor;

    
    _itemBg = [[UIView alloc] initWithFrame:CGRectMake(16, lineGrayView.bottom + 7, self.w - 32, 58)];
    [self addSubview:_itemBg];
    _itemBg.backgroundColor = rgba(239, 246, 255, 1);

        
    UIImageView *linkIcon = [[UIImageView alloc] initWithFrame:CGRectMake(_itemBg.w - 26 - LeftMargin, 13, 26, 32)];
    [_itemBg addSubview:linkIcon];
    linkIcon.image = ImageWithName(@"linkman_icon");

    
    _nameValueLabelConfigHelper = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, _itemBg.w - 80, 24)];
    _nameValueLabelConfigHelper.textColor = rgba(51, 51, 51, 1);
    _nameValueLabelConfigHelper.font = Font(12);
    _nameValueLabelConfigHelper.text = @"Name";

    [_itemBg addSubview:_nameValueLabelConfigHelper];
    
    _phoneValueLabelConfigHelper = [[UILabel alloc] initWithFrame:CGRectMake(10, _nameValueLabelConfigHelper.bottom, _itemBg.w - 80, 17)];
    _phoneValueLabelConfigHelper.font = Font(12);

    _phoneValueLabelConfigHelper.text = @"Phone Number";
    _phoneValueLabelConfigHelper.textColor = rgba(51, 51, 51, 1);
    [_itemBg addSubview:_phoneValueLabelConfigHelper];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(infoTap:)]];
    [self refreshData];
}


- (void)refreshData {
    NSString *name = _data[p_name];
    NSString *mobile = _data[p_mobile];
    NSInteger relation = [_data[p_relation] integerValue];
    if (name.length == 0 || mobile.length == 0) {
        _phoneValueLabelConfigHelper.text = @"Phone Number";
        _nameValueLabelConfigHelper.font = Font(12);
        _nameValueLabelConfigHelper.text = @"Name";
        _infoDescLabelConfigHelper.backgroundColor = rgba(247, 251, 255, 1);

        _phoneValueLabelConfigHelper.font = Font(12);
        _itemBg.backgroundColor = rgba(239, 246, 255, 1);
    }else {
        _nameValueLabelConfigHelper.font = FontBold(14);
        _phoneValueLabelConfigHelper.font = FontBold(14);
        _nameValueLabelConfigHelper.text = name;
        _phoneValueLabelConfigHelper.text = mobile;

        _infoDescLabelConfigHelper.backgroundColor = rgba(255, 248, 226, 1);
        _itemBg.backgroundColor = rgba(255, 243, 205, 1);
    }
    if (relation > 0) {
        NSArray *noteList = self.data[p_note];
        for (NSDictionary *dic in noteList) {
            NSInteger key = [dic[p_key] integerValue];
            NSString *name = dic[p_name];
            if (key == relation) {
                self.relationValueViewlConfigHelper.title = notNull(name);
            }
        }
    }
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    
    NSString *name = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
    NSString *phone = [contactProperty.value stringValue];
    self.data[p_name] = name;

    self.data[p_mobile] = phone;
    [self refreshData];
}


- (void)showLinkMan {
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
    contactPicker.modalPresentationStyle = UIModalPresentationFullScreen;

    [Page present:contactPicker animated:YES completion:nil];
}
@end
