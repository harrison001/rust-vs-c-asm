// 定义 trait（相当于接口）
trait Speak {
    fn speak(&self);
}

// 定义 struct（存数据）
struct Dog {
    name: String,
}

struct Cat {
    name: String,
}

// 给 struct 实现 trait（绑定行为）
impl Speak for Dog {
    fn speak(&self) {
        println!("{} says: Woof!", self.name);
    }
}

impl Speak for Cat {
    fn speak(&self) {
        println!("{} says: Meow!", self.name);
    }
}

// 给 struct 添加自己的方法（非 trait 的）
impl Dog {
    fn wag_tail(&self) {
        println!("{} is wagging its tail!", self.name);
    }
}

fn main() {
    let d = Dog { name: "Rex".to_string() };
    let c = Cat { name: "Kitty".to_string() };

    d.speak(); // 来自 trait
    d.wag_tail(); // 自己的方法
    c.speak();
}
