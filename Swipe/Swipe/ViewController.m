//
//  ViewController.m
//  Swipe
//
//  Created by lihonggui on 2016/12/9.
//  Copyright © 2016年 lihonggui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//图片数量的索引
@property(nonatomic,assign) int index;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.index = 1;
   
    /*******轻扫******/
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.imageView addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDowm = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeDowm.direction = UISwipeGestureRecognizerDirectionDown;
    [self.imageView addGestureRecognizer:swipeDowm];
    
    /*******捏合******/
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pin:)];
    pin.delegate = self;
    [self.imageView addGestureRecognizer:pin];
   
    /*******旋转******/
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    
}
-(void)rotation:(UIRotationGestureRecognizer *)rotation
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    rotation.rotation = 0;
}
-(void)pin:(UIPinchGestureRecognizer *)pin
{
    
        
        self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pin.scale, pin.scale);
        
        pin.scale = 1;
            NSLog(@"%f",pin.scale);
   
}
-(void)swipe:(UISwipeGestureRecognizer *)swipePosition
{
    // 添加动画效果
    CATransition *transition = [CATransition animation];
//     CATransition * trans = [CATransition animation];
    //http://www.bubuko.com/infodetail-1157995.html(效果)
    transition.type = @"cube";
    if (swipePosition.direction == UISwipeGestureRecognizerDirectionLeft) {
          self.index ++;
        transition.subtype = kCATransitionFromRight;
    }else if (swipePosition.direction == UISwipeGestureRecognizerDirectionRight) {
        self.index --;
        transition.subtype = kCATransitionFromLeft;

    }else if (swipePosition.direction == UISwipeGestureRecognizerDirectionUp) {
        self.index ++;
        transition.subtype = kCATransitionFromTop;
        
    }else if (swipePosition.direction == UISwipeGestureRecognizerDirectionDown) {
        self.index --;
        transition.subtype = kCATransitionFromBottom;
        
    }

    //判断 index
    if (self.index >5) {
        self.index = 1;
    }else if (self.index < 1) {
        self.index = 5;
    }
     //加载图片
    NSString *imageNamed = [NSString stringWithFormat:@"img%02ld",(long)self.index];
    UIImage *image = [UIImage imageNamed:imageNamed];
    self.imageView.image = image;
    [self.imageView.layer addAnimation:transition forKey:nil];
    NSLog(@"请扫");
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

#warning 设置转场动画
-(void)transitionAnimation:(NSInteger)position
{
//    //创建转场动画
//    CATransition *transition = [[CATransition alloc]init];
//    transition.type = @"cube";
//    
//    switch (position) {
//        case 1:
//            transition.subtype = kCATransitionFromLeft;
//            break;
//        case 2:
//            transition.subtype = kCATransitionFromRight;
//            break;
//        case 3:
//            transition.subtype = kCATransitionFromTop;
//            break;
//        case 4:
//            transition.subtype = kCATransitionFromBottom;
//            break;
//            
//            
//        default:
//            break;
//    }

        //1.创建转场动画对象
//        CATransition *transition=[[CATransition alloc]init];
    
        //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
//        transition.type=@"rippleEffect";
//
//        BOOL bl = YES;
//        
//        //设置子类型
//        if (position == 1) {
//            transition.subtype=kCATransitionFromRight;
//            bl = YES;
//        }else if (position == 2) {
//            transition.subtype=kCATransitionFromLeft;
//            bl = NO;
//        }else if (position == 3) {
//            transition.subtype=kCATransitionFromTop;
//            bl = YES;
//        }else{
//            transition.subtype=kCATransitionFromBottom;
//            bl = NO;
//        }
}
@end
