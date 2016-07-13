//
//  DSTableViewCell3.h
//  arthome
//
//  Created by maiziedu on 7/9/16.
//  Copyright © 2016 qizhiwenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedCellsClass)(id, NSString *title, NSString *subMenuTitle);


@interface DSTableViewCell3 : UITableViewCell

- (void)setSelectedState:(BOOL) state ;

@property (copy, nonatomic) SelectedCellsClass selectedCellsClass;

@end
