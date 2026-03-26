//
//  EmailPopView.m
//  PhilipLoanProject
//
//  Created by xiafei zhao on 2024/9/4.
//

#import "EmailPopView.h"

@implementation EmailPopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self generate];
        self.backgroundColor = kGrayColor_C9C9C9;
        self.layer.cornerRadius = 12;
        self.dataSource = [NSMutableArray array];
        [_tableView reloadData];
    }
    return self;
}

-(void)reloadEmaiViewWithStr:(NSString *)valueStr
{
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:[self filterEmailSuffixWithStr:valueStr]];
    [self.tableView reloadData];
}


-(NSArray *)filterEmailSuffixWithStr:(NSString *)inputText
{
    NSArray *array =@[@"gmail.com",@"icloud.com",@"yahoo.com",@"outlook.com"];
    NSMutableArray *resultArray = [NSMutableArray array];
    if ([inputText containsString:@"@"]) {
        NSString *prefix = [inputText componentsSeparatedByString:@"@"].firstObject;
        NSString *suffixPart = [inputText componentsSeparatedByString:@"@"].lastObject;
        for (NSString *suffix in array) {
            if ([suffix hasPrefix:suffixPart]) {
                NSString *str = [NSString stringWithFormat:@"%@%@%@",prefix,@"@",suffix];
                [resultArray addObject:str];
            }
        }
    }else
    {
        for (NSString *suffix in array) {
            NSString *str = [NSString stringWithFormat:@"%@%@%@",inputText,@"@",suffix];
            [resultArray addObject:str];
        }
    }
    return resultArray;
}


-(void)generate
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15, self.width, self.height - 30) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.rowHeight = 30;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.tableView];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tapItemBlk) {
        self.tapItemBlk(_dataSource[indexPath.row]);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = kBlackColor_333333;
    cell.backgroundColor = UIColor.clearColor;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
