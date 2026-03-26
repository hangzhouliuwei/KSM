//
//  XTCellModel.m
//  XTApp
//
//  Created by xia on 2024/9/5.
//

#import "XTCellModel.h"
#import "XTCell.h"

@implementation XTCellModel

+ (XTCellModel *)xt_cellClassName:(NSString *)className height:(CGFloat)height model:(id __nullable)model {
    XTCellModel *cellModel = [[XTCellModel alloc] init];
    cellModel.height = height;
    cellModel.xt_data = model;
    Class targetClass = NSClassFromString(className);
    XTCell *cell = [[targetClass alloc] init];
    if (!cell) {
        cell = [[XTCell alloc] init];
    }
    cell.xt_height = height;
    cellModel.indexCell = cell;
    if([cell respondsToSelector:@selector(xt_reloadData:)] ){
        [cell xt_reloadData:model];
    }
    
    return cellModel;
}

+ (XTCellModel *)xt_cellClassName:(NSString *)className height:(CGFloat)height model:(id __nullable)model ID:(NSString *)ID {
    XTCellModel *cellModel = [XTCellModel xt_cellClassName:className height:height model:model];
    cellModel.indexCell.ID = ID;
    return cellModel;
}

@end
