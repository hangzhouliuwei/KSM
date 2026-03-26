//
//  AuthSetModel.h
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/3.
//

#import <Foundation/Foundation.h>
#import "AuthItemModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, kAuthCellType) {
    kAuthCellType_Select = 0,
    kAuthCellType_TextField = 1,
    kAuthCellType_Email = 2,
    kAuthCellType_Date = 3,
    kAuthCellType_Gender = 4,
};
@interface AuthOptionalModel : NSObject
///id
@property(nonatomic)NSString *regntwelveNc;
///title
@property(nonatomic)NSString *fldgtwelveeNc;
///subtitle
@property(nonatomic)NSString *orintwelvearilyNc;
///code
@property(nonatomic)NSString *imeatwelvesurabilityNc;
///cate
@property(nonatomic)NSString *lebotwelveardNc;
@property(nonatomic)NSString *relotwelveomNc;
@property(nonatomic)UIImage *captureImage;

@property(nonatomic)NSInteger tapatwelvexNc;
@property(nonatomic)NSInteger frlltwelveyNc;
@property(nonatomic)NSInteger techtwelveedNc;
@property(nonatomic)BOOL sufotwelvenicNc;
@property(nonatomic)NSString *darytwelvemanNc;
@property(nonatomic)NSInteger phtotwelvetoxicityNc;

@property(nonatomic)AuthItemModel *selectedModel;
@property(nonatomic)NSString *valueStr;
///note
@property(nonatomic)NSArray<AuthItemModel *> *tubotwelvedrillNc;
@property(nonatomic)BOOL needClip;
@property(nonatomic)BOOL showEmail;
@property(nonatomic)BOOL showOCR;
@property(nonatomic)BOOL showCamera;
@property(nonatomic)BOOL isBankPage;
@property(nonatomic)BOOL isWallet;
@property(nonatomic)kAuthCellType type;
@property(nonatomic)CGFloat cellHeight;
@property(nonatomic)CGFloat cellHeightEmail;
@property(nonatomic)CGFloat labelHeight;

@end

NS_ASSUME_NONNULL_END
