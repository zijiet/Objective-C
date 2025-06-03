//
//  DetailController.m
//  qimo
//
//  Created by LiJiaXin on 25/5/26.
//  Copyright (c) 2025年 LiJiaXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailController.h"
#import "DatabaseManager.h"
#import "Car.h"

@interface DetailController()
@property (weak, nonatomic) IBOutlet UIImageView *caricon;
@property (weak, nonatomic) IBOutlet UITextField *carname;
@property (weak, nonatomic) IBOutlet UITextField *look;

@property (weak, nonatomic) IBOutlet UIImageView *imageView_tomcat;
- (IBAction)btn_click:(id)sender;

@end

@implementation DetailController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.caricon.image=[UIImage imageNamed:self.car.icon];
    self.carname.text=self.car.name;
    
    self.navigationItem.title=@"Car detail";
    
    //loadCount:
    NSInteger viewCount=[[DatabaseManager sharedInstance] loadViewCountForName:self.car.name];
    self.look.text=[NSString stringWithFormat:@"%ld 次",(long)viewCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playAnimation:(int)count imgPreName:(NSString*)imgPreName{
    if(!self.imageView_tomcat.isAnimating){
        NSMutableArray *images=[NSMutableArray array];
        for(int i=0;i<count;i++){
            //获取每一张图片文件名后缀：
            NSString *image_filename=[NSString stringWithFormat:@"%@_%02d.jpg",imgPreName,i];
            //因为图片现在是资源文件形式存在，所以需要获取文件路径才能访问图片文件：
            NSString *imgfilewithPath=[[NSBundle mainBundle] pathForResource:image_filename ofType:nil];
            //根据图片路径找到图片文件后变为图片形式：
            UIImage *image=[UIImage imageWithContentsOfFile:imgfilewithPath];
            
            //将图片都放到图片数组中：
            [images addObject:image];
        }
        self.imageView_tomcat.animationImages=images;
        self.imageView_tomcat.animationRepeatCount=1;
        self.imageView_tomcat.animationDuration=count*0.1;
        [self.imageView_tomcat startAnimating];
        
        [self.imageView_tomcat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:count*0.1];
    }
}

- (IBAction)btn_click:(id)sender {
    NSInteger tag=[sender tag];
    switch (tag) {
        case 1:
            [self playAnimation:40 imgPreName:@"eat"];
            break;
        case 2:
            [self playAnimation:81
                     imgPreName:@"drink"];
            break;
        case 4:
            [self playAnimation:13
                     imgPreName:@"cymbal"];
            break;
        case 5:
            [self playAnimation:28
                     imgPreName:@"fart"];
            break;
        case 6:
            [self playAnimation:24
                     imgPreName:@"pie"];
            break;
        case 7:
            [self playAnimation:56
                     imgPreName:@"scratch"];
            break;
        default:
            break;
    }
}

@end