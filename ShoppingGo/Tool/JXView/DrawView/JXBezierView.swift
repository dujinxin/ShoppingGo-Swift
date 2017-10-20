//
//  JXBezierView.swift
//  ShoppingGo
//
//  Created by 杜进新 on 2017/7/27.
//  Copyright © 2017年 杜进新. All rights reserved.
//

/*
 关于 UIBezierPath
 
 UIBezierPath这个类在UIKit中， 是Core Graphics框架关于path的一个封装，使用此类可以定义简单的形状，比如我们常用到，矩形，圆形，椭圆，弧，或者不规则的多边形
 
 UIBezierPath 基本使用方法
 
 UIBezierPath对象是CGPathRef数据类型的封装。path如果是基于矢量形状的，都用直线或曲线去创建。我们一般使用UIBezierPath都是在重写view的drawRect方法这种情形。我们用直线去创建矩形或多边形，使用曲线创建弧或者圆。创建和使用path对象步骤：
 1、 重写View的drawRect方法
 2、 创建UIBezierPath的对象
 3、 使用方法moveToPoint: 设置初始点
 4、 根据具体要求使用UIBezierPath类方法绘图（比如要画线、矩形、圆、弧？等）
 5、 设置UIBezierPath对象相关属性 （比如lineWidth、lineJoinStyle、aPath.lineCapStyle、color）
 6、 使用stroke 或者 fill方法结束绘图

 其他基本使用方法
 
 在介绍其他使用方法之前，我们先来看一下  path的几个属性，以便下面我进行设置。
 1、[color set];设置线条颜色，也就是相当于画笔颜色
 2、path.lineWidth = 5.0;这个很好理解了，就是划线的宽度
 3、path.lineCapStyle这个线段起点是终点的样式，这个样式有三种：
 （
     1、kCGLineCapButt该属性值指定不绘制端点， 线条结尾处直接结束。这是默认值。
     2、kCGLineCapRound 该属性值指定绘制圆形端点， 线条结尾处绘制一个直径为线条宽度的半圆。
     3、kCGLineCapSquare 该属性值指定绘制方形端点。 线条结尾处绘制半个边长为线条宽度的正方形。需要说明的是，这种形状的端点与“butt”形状的端点十分相似，只是采用这种形式的端点的线条略长一点而已
 ）
 4、path.lineJoinStyle这个属性是用来设置两条线连结点的样式，同样它也有三种样式供我们选择
 (
     1、kCGLineJoinMiter 斜接
     2、kCGLineJoinRound 圆滑衔接
     3、kCGLineJoinBevel 斜角连接
 ）
 5、[path stroke];用 stroke 得到的是不被填充的 view ，
    [path fill]; 用 fill 得到的内部被填充的 view。
 
 */

import UIKit

class JXBezierView: UIView {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))//设置起始点
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))//终点
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        var rect1 = rect
        rect1.size.height -= 10
        rect1.origin.y += 10
    
        
        path.stroke()
        
    }
}

class JXBezierSingleLineView: UIView {
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))//设置起始点
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))//终点
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}
/// polygon 多边形
class JXBezierPolygonView: UIView {
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: rect.size.height / 2))//设置起始点
        path.addLine(to: CGPoint(x: rect.size.width / 2, y: 0))//终点
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2))//终点
        path.addLine(to: CGPoint(x: rect.size.width / 2, y: rect.size.height))//终点
        path.close() //关闭路径，最后的一个点与起始点相连
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}
/// rectangle 矩形 有两种绘制方法，一种就是上文的，一条一条连线；还有就是通过 init(rect: CGRect)
class JXBezierRectangleView: UIView {
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(rect: rect)
 
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}
/// rectangle 圆形，椭圆，由传入的CGRect决定，正方形为圆，矩形为椭圆
class JXBezierCircleEllipseView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}
/// Circle 圆形,扇形，圆弧
/// 圆形还是扇形由startAngle，endAngle来决定
/// 弧还是形由stroke或fill来定
class JXBezierCircleAngleView: UIView {
    override func draw(_ rect: CGRect) {
        /// ArcCenter: 原点
        /// radius: 半径
        /// startAngle: 开始角度
        /// endAngle: 结束角度
        /// clockwise: 是否顺时针方向
        let path = UIBezierPath(arcCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2), radius: min(rect.size.width, rect.size.height) / 2, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
        
        //UIColor.yellow.setFill()//填充颜色
        //path.fill()
    }
}
/// roundRect 圆角矩形
class JXBezierRoundRectView: UIView {
    override func draw(_ rect: CGRect) {
        /// cornerRadius 圆角半径
        let path = UIBezierPath(roundedRect: rect, cornerRadius: min(rect.size.width, rect.size.height) / 2)
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        path.stroke()
        
        //UIColor.red.setFill()//填充颜色
        //path.fill()
    }
}
/// roundRect 圆角矩形,可以自由指定圆角位置
class JXBezierRoundRectCustomView: UIView {
    override func draw(_ rect: CGRect) {
        /// cornerRadius 圆角半径
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 20, height: 20))
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        
//        UIColor.red.setStroke()//线条颜色
//        path.stroke()
        
        UIColor.red.setFill()//填充颜色
        path.fill()
    }
}

/// twice bezier curve 二次贝塞尔曲线
class JXBezierTwiceBezierCurveView: UIView {
    override func draw(_ rect: CGRect) {
        /// cornerRadius 圆角半径
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addQuadCurve(to: CGPoint(x: rect.width / 2, y: rect.height / 2), controlPoint: CGPoint(x: rect.width / 4, y: 0))
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}
/// three bezier curve 三次贝塞尔曲线
class JXBezierThreeBezierCurveView: UIView {
    override func draw(_ rect: CGRect) {
        /// cornerRadius 圆角半径
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
    
        path.addCurve(to: CGPoint(x: rect.width, y: rect.height / 2), controlPoint1: CGPoint(x: rect.width / 4, y: 0), controlPoint2: CGPoint(x: rect.width / 4 * 3, y: rect.height))
        
        path.lineWidth = 2;//线宽
        path.lineCapStyle = .butt//端点样式
        path.lineJoinStyle = .miter//连接点样式
        UIColor.red.setStroke()//线条颜色
        
        path.stroke()
    }
}

class JXTestView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Drawing code
//        let path = UIBezierPath()
//        //path.move(to: CGPoint(x: 0, y: 0))//设置起始点
//        //path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))//终点
//        
//        path.lineWidth = 2;//线宽
//        path.lineCapStyle = .butt//端点样式
//        path.lineJoinStyle = .miter//连接点样式
//        UIColor.red.setStroke()//线条颜色
        
        var rect1 = rect
        rect1.size.height -= 10
        rect1.origin.y += 10
        
        UIColor.red.setFill()
        
        
        let bezier2 = UIBezierPath()
        
        bezier2.move(to: CGPoint(x: rect.width - (20 + 10), y: 10))
        bezier2.addLine(to: CGPoint(x: rect.width - 20, y: 0))
        bezier2.addLine(to: CGPoint(x: rect.width - (20 - 10), y: 10))
        bezier2.close()
        //bezier2.fill()

        let bezier1 = UIBezierPath(roundedRect: rect1, cornerRadius: 5)
        bezier1.append(bezier2)
        bezier1.fill()
        
    }
}
