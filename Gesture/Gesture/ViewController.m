//
//  ViewController.m
//  Gesture
//
//  Created by lihonggui on 2016/12/9.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
/*
 手势操作:长安,短按
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     创建轻拍操作
     */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    //图片添加手势操作
    [self.imageView addGestureRecognizer:tap];
    //屏幕添加手势操作
    [self.view addGestureRecognizer:tap];
    
    /*
     创建拖动操作
     */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
    pan.delegate = self;
    //拖拽手指数
//    pan.minimumNumberOfTouches = 2;
//    pan.maximumNumberOfTouches = 20;
    [pan addTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    
    
    /*
     长按
     */
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    //双指是长按
//    longPress.numberOfTouchesRequired = 2;
    //长按时间
    longPress.minimumPressDuration = 1;
    [self.imageView addGestureRecognizer:longPress];
    
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    NSLog(@"点我啊");
    NSLog(@"%lu",(unsigned long)tap.numberOfTouchesRequired);
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    //点在指定的范围移动
    CGPoint point =  [pan translationInView:self.view];
    //赋值
//    self.imageView.transform = CGAffineTransformMakeTranslation(point.x, point.y);
    //拖拽初始位置
    [pan setTranslation:CGPointZero inView:pan.view];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, point.x, point.y);
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress
{
    #warning 要配合手势状态
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        //长按:图片闪一下
        [UIView animateWithDuration:0.6 animations:^{
            self.imageView.alpha = 0.3;
        } completion:^(BOOL finished) {
            self.imageView.alpha = 1;
        }];
        NSLog(@"长按----");
    }else if (longPress.state == UIGestureRecognizerStateChanged) {
        NSLog(@"长按松开");
    }else {
        NSLog(@"长按结束");
    }
}


@end
