//
//  DMTableViewCell.h
//  Demo001
//
//  Created by maiziedu on 7/8/16.
//  Copyright © 2016 Alatan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCellsClass)(id, NSString *title, NSString *subMenuTitle);


@interface DSTableViewCell0 : UITableViewCell

- (void)setSelectedState:(BOOL) state ;

@property (copy, nonatomic) SelectedCellsClass selectedCellsClass;
@end
