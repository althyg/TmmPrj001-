//
//  ScreeningViewController.m
//  arthome
//
//  Created by qzwh on 16/7/7.
//  Copyright © 2016年 qizhiwenhua. All rights reserved.
//

#import "ScreeningViewController.h"
#import "ScreeningCell.h"
#import "ScreeningPriceCell.h"



#import "DSTableViewCell0.h"
#import "DSTableViewCell1.h"
#import "DSTableViewCell2.h"
#import "DSTableViewCell3.h"

@interface ScreeningViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    
    NSString *sc_title;
    NSString *sc_subTitle;
}


@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ScreeningViewController

- (void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

#pragma mark - 创建UI
- (void)initUI {
    self.navigationItem.title = @"艺术品筛选";
    self.view.backgroundColor=COLOR_ffffff;
    //清空选择按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithPurpleTitle:@"清空选择" target:self action:@selector(cleanOnclick)];
   
    //创建UITableView
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    UIView *c_tableFooderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(self.view.frame), DEF_RESIZE_UI(40))];
    confirmButton.backgroundColor = [UIColor redColor];
    [confirmButton setTitle:@"完成" forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [c_tableFooderView addSubview:confirmButton];
    
    
    _tableView.tableFooterView = c_tableFooderView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //注册
    [_tableView registerClass:[ScreeningPriceCell class] forCellReuseIdentifier:@"ScreeningPriceCell"];
    [_tableView registerClass:[DSTableViewCell0 class] forCellReuseIdentifier:@"DSTableViewCell0"];
    [_tableView registerClass:[DSTableViewCell1 class] forCellReuseIdentifier:@"DSTableViewCell1"];
    [_tableView registerClass:[DSTableViewCell2 class] forCellReuseIdentifier:@"DSTableViewCell2"];
    [_tableView registerClass:[DSTableViewCell3 class] forCellReuseIdentifier:@"DSTableViewCell3"];
    
    
    [self.view addSubview:_tableView];
    [self addGestureOnTalbeView];
}

#pragma mark - 清空所有选择
- (void)cleanOnclick{

    NSLog(@"清空所有");

    NSArray *cells = [_tableView visibleCells];
    for (UITableViewCell *cell in cells) {
        
        if ([cell isKindOfClass:[DSTableViewCell0 class]]) {
            
            DSTableViewCell0 *cell0 = (DSTableViewCell0 *)cell;
            [cell0 setSelectedState: NO];
            
        } else if ([cell isKindOfClass:[DSTableViewCell1 class]]) {
            
            DSTableViewCell1 *cell1 = (DSTableViewCell1 *)cell;
            [cell1 setSelectedState: NO];
        } else if ([cell isKindOfClass:[DSTableViewCell2 class]]) {
            
            DSTableViewCell2 *cell2 = (DSTableViewCell2 *)cell;
            [cell2 setSelectedState: NO];
        } else if ([cell isKindOfClass:[DSTableViewCell3 class]]) {
            
            DSTableViewCell3 *cell3 = (DSTableViewCell3 *)cell;
            [cell3 setSelectedState: NO];
        } else if ([cell isKindOfClass:[ScreeningPriceCell class]]) {
            
            ScreeningPriceCell *price_Cell = (ScreeningPriceCell *)cell;
            [price_Cell clearTextContent];
        }
    }

}

#pragma mark - UITableViewDataSourceDelegate
#pragma mark - UITableViewDataSoureDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
    } else {
        
        return 1;
    }
    
}
//返回每一个cell的显示内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            DSTableViewCell0 *cell0 = [tableView dequeueReusableCellWithIdentifier:@"DSTableViewCell0" forIndexPath:indexPath];
            
            cell0.selectedCellsClass = ^(id s_Class, NSString *title, NSString *subMenuTitle) {
                
                NSLog(@"%@", s_Class);
                sc_title = title;
                sc_subTitle = subMenuTitle;
                [self setSelectedCell:s_Class];
            };
            
            cell = cell0;

        } else if (indexPath.row == 1) {
            DSTableViewCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"DSTableViewCell1" forIndexPath:indexPath];
            
            
            cell1.selectedCellsClass = ^(id s_Class, NSString *title, NSString *subMenuTitle) {
                
                NSLog(@"%@", s_Class);
                sc_title = title;
                sc_subTitle = subMenuTitle;
                [self setSelectedCell:s_Class];
            };

            
            cell = cell1;
            
        } else if (indexPath.row == 2) {
            DSTableViewCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"DSTableViewCell2" forIndexPath:indexPath];
            
            cell2.selectedCellsClass = ^(id s_Class, NSString *title, NSString *subMenuTitle) {
                
                NSLog(@"%@", s_Class);
                sc_title = title;
                sc_subTitle = subMenuTitle;
                [self setSelectedCell:s_Class];
            };

            
            cell = cell2;
            
        } else if (indexPath.row == 3) {
            DSTableViewCell3 *cell3 = [tableView dequeueReusableCellWithIdentifier:@"DSTableViewCell3" forIndexPath:indexPath];
            
            cell3.selectedCellsClass = ^(id s_Class, NSString *title, NSString *subMenuTitle){
                
                NSLog(@"%@", s_Class);
                sc_title = title;
                sc_subTitle = subMenuTitle;
                [self setSelectedCell:s_Class];
            };

            
            
            cell = cell3;
            
        }

    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            ScreeningPriceCell *price_Cell = [tableView dequeueReusableCellWithIdentifier:@"ScreeningPriceCell" forIndexPath:indexPath];
            
            
            price_Cell.intervalPriceNumber = ^(NSInteger minPrice, NSInteger maxPrice) {
                
                NSLog(@"输入的价格区间，最小值 = %ld, 最大值 = %ld", minPrice, maxPrice);
                
            };
            
            price_Cell.keyboardShowBlock = ^(CGFloat animationDuration, CGRect keyboardRect) {
                
                [self keyboardShowAnimate:animationDuration withRect:keyboardRect];
            };
            
            price_Cell.keyboardHideBlock = ^(CGFloat animationDuration, CGRect keyboardRect){
                [self keyboardHideAnimate:animationDuration withRect:keyboardRect];
            };
            
            
            cell = price_Cell;

        }
    }
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}
//返回透视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }else{
        
        return 40;
    }
}
//返回角视图高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        return DEF_RESIZE_UI(60);
    } else {
        return DEF_RESIZE_UI(160);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *tv_headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 40)];
        UILabel *lTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 40)];
        lTitle.text = @"画品分类";
        lTitle.font = [UIFont systemFontOfSize:12];
        [lTitle setTextColor:COLOR_cccccc];
        [tv_headerView addSubview:lTitle];
        return tv_headerView;
    }else{
        UIView *ts_headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 40)];
        UILabel *lTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 40)];
        lTitle.text = @"价格区间";
        lTitle.font = [UIFont systemFontOfSize:12];
        [lTitle setTextColor:COLOR_cccccc];
        [ts_headerView addSubview:lTitle];
        
        return ts_headerView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        return 10;
    }else{
        
        return 100;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            DSTableViewCell0 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: YES];
        } else if (indexPath.row == 1) {
            
            DSTableViewCell1 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: YES];
        } else if (indexPath.row == 2) {
            
            DSTableViewCell2 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: YES];
        } else if (indexPath.row == 3) {
            
            DSTableViewCell3 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: YES];
        }
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            DSTableViewCell0 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: NO];
        } else if (indexPath.row == 1) {
            
            DSTableViewCell1 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: NO];
        } else if (indexPath.row == 2) {
            
            DSTableViewCell2 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: NO];
        } else if (indexPath.row == 3) {
            
            DSTableViewCell3 *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            [selectedCell setSelectedState: NO];
        }
    }
}


- (void)setSelectedCell:(id) s_Class {
    
    if ([s_Class isKindOfClass:[DSTableViewCell0 class]]) {
        
        DSTableViewCell0 *cell0 = (DSTableViewCell0 *)s_Class;
        [cell0 setSelectedState: YES];

    } else if ([s_Class isKindOfClass:[DSTableViewCell1 class]]) {
        
        DSTableViewCell0 *cell1 = (DSTableViewCell0 *)s_Class;
        [cell1 setSelectedState: YES];
    } else if ([s_Class isKindOfClass:[DSTableViewCell2 class]]) {
        
        DSTableViewCell0 *cell2 = (DSTableViewCell0 *)s_Class;
        [cell2 setSelectedState: YES];
    } else if ([s_Class isKindOfClass:[DSTableViewCell3 class]]) {
        
        DSTableViewCell0 *cell3 = (DSTableViewCell0 *)s_Class;
        [cell3 setSelectedState: YES];
    }
    
    NSArray *cells = [_tableView visibleCells];
    for (UITableViewCell *cell in cells) {
        
        if (cell != s_Class) {
            
            if ([cell isKindOfClass:[DSTableViewCell0 class]]) {
                
                DSTableViewCell0 *cell0 = (DSTableViewCell0 *)cell;
                [cell0 setSelectedState: NO];
                
            } else if ([cell isKindOfClass:[DSTableViewCell1 class]]) {
                
                DSTableViewCell1 *cell1 = (DSTableViewCell1 *)cell;
                [cell1 setSelectedState: NO];
            } else if ([cell isKindOfClass:[DSTableViewCell2 class]]) {
                
                DSTableViewCell2 *cell2 = (DSTableViewCell2 *)cell;
                [cell2 setSelectedState: NO];
            } else if ([cell isKindOfClass:[DSTableViewCell3 class]]) {
                
                DSTableViewCell3 *cell3 = (DSTableViewCell3 *)cell;
                [cell3 setSelectedState: NO];
            } else if ([cell isKindOfClass:[ScreeningPriceCell class]]) {
                
                ScreeningPriceCell *price_Cell = (ScreeningPriceCell *)cell;
                [price_Cell clearTextContent];
            }
        }
    
    }
}


#pragma mark - 键盘显示动画

- (void)addGestureOnTalbeView {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useTapGestureHideKeyboard:)];
    tapGesture.enabled = NO;
    [_tableView addGestureRecognizer:tapGesture];
}

- (void)enableGestureOnTableView {
    
    for (UITapGestureRecognizer *tap in _tableView.gestureRecognizers) {
        tap.enabled = YES;
    }
}

- (void)unEnableGestureOnTableView {
    
    for (UITapGestureRecognizer *tap in _tableView.gestureRecognizers) {
        
        if ([tap isKindOfClass:[UITapGestureRecognizer class]]) {
            tap.enabled = NO;
        }
        
    }
}

- (void)useTapGestureHideKeyboard:(UITapGestureRecognizer *)tap {
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UITableView *mTableView = (UITableView *)tap.view;
    ScreeningPriceCell *cell = [mTableView cellForRowAtIndexPath:indexPath];
    [cell resignAllTextField];
}

- (void)keyboardShowAnimate:(CGFloat)duration withRect:(CGRect) rect {
    
    [self enableGestureOnTableView];
    [UIView animateWithDuration:duration animations:^{
        
        CGRect oldFrame = _tableView.frame;
        CGRect newFrame = oldFrame;
        newFrame.size.height = newFrame.size.height - rect.size.height;
        _tableView.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardHideAnimate:(CGFloat)duration withRect:(CGRect) rect {
    
    [UIView animateWithDuration:duration animations:^{
        
        CGRect newFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        _tableView.frame = newFrame;
        
    } completion:^(BOOL finished) {
        
        [self unEnableGestureOnTableView];
    }];
}

#pragma mark - 完成

- (void)confirmButtonPressed {
    // 执行完成对应的操作
    
    if (sc_title.length != 0 && sc_subTitle.length != 0) {
        
        
        // 这里执行搜索操作
    }
}

@end
