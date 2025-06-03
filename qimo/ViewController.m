//
//  ViewController.m
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#import "ViewController.h"
#import "DetailController.h"
#import "DatabaseManager.h"
#import "Car.h"
#import "CarGroup.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSArray *groups;


@end

@implementation ViewController
-(NSMutableArray *)groups{
    if(_groups==nil){
        NSString *filenamewithpath=[[NSBundle mainBundle]pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:filenamewithpath];
        
        NSMutableArray *groupArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray){
            CarGroup *group=[CarGroup groupWithDict:dict];
            [groupArray addObject:group];
        }
        _groups=groupArray;
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableview.rowHeight=60;
     self.navigationItem.title=@"Car List";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CarGroup *group=self.groups[section];
    return group.cars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"car"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"car"];
    }
    
    CarGroup *group=self.groups[indexPath.section];
    Car *car=group.cars[indexPath.row];
    
    cell.imageView.image=[UIImage imageNamed:car.icon];
    cell.textLabel.text=car.name;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CarGroup *group=self.groups[section];
    return group.title;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"two" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc=segue.destinationViewController;
    if([vc isKindOfClass:[DetailController class]]){
        DetailController *detailVc=(DetailController *)vc;
        NSIndexPath *path=[self.tableView indexPathForSelectedRow];
        CarGroup *group=self.groups[path.section];
        Car *car=group.cars[path.row];
        detailVc.car=car;
        
        //update lookcount:
        [[DatabaseManager sharedInstance] updateViewCountForCarName:car.name];
    }
}

@end
