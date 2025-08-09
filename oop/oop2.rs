// 定义 trait，相当于接口
trait Drawable {
    fn draw(&self);
    fn area(&self) -> f64 {
        // 默认实现
        0.0
    }
}

// 一个结构体（类）
struct Circle {
    radius: f64,
}

// 为结构体实现 trait
impl Drawable for Circle {
    fn draw(&self) {
        println!("Drawing a circle with radius {}", self.radius);
    }
    fn area(&self) -> f64 {
        std::f64::consts::PI * self.radius * self.radius
    }
}

fn main() {
    let c = Circle { radius: 3.0 };

    // 静态分发（编译期确定）
    c.draw();
    println!("Area: {}", c.area());

    // 动态分发（运行时确定，类似虚函数）
    let obj: Box<dyn Drawable> = Box::new(c);
    obj.draw();
    println!("Area: {}", obj.area());
}
