//
//  BagVerifyContactModel.h
//  NewBag
//
//  Created by Jacky on 2024/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BagContactRelationEnumModel : BagBaseModel
///名字
@property(nonatomic, copy) NSString *antineoplastonF;
///关系
@property(nonatomic, assign) NSInteger sovranF;
@end

@interface BagContactRelationModel : BagBaseModel
///名字
@property(nonatomic, copy) NSString *antineoplastonF;
///号码
@property(nonatomic, copy) NSString *guerrillaF;
///关系
@property(nonatomic, assign) NSInteger brandyballF;
@end

@interface BagContactItmeModel : BagBaseModel
@property(nonatomic, copy) NSArray <BagContactRelationEnumModel*>*brandyballF;
@property(nonatomic, strong) BagContactRelationModel *incessantF;
@property(nonatomic, copy) NSArray <NSDictionary*>*definingF;;
///标题
@property(nonatomic, copy) NSString *mudslingerF;
@end

@interface BagVerifyContactModel : BagBaseModel

@property(nonatomic, copy) NSArray <BagContactItmeModel*>*heterogenistF;
///倒计时
@property(nonatomic, assign) NSInteger analectaF;
@end

NS_ASSUME_NONNULL_END
