struct Car {
    brand: String,
    speed: u32,
}

// 给 Car 添加方法
impl Car {
    fn new(brand: &str) -> Self {
        Car { brand: brand.to_string(), speed: 0 }
    }

    fn drive(&mut self, speed: u32) {
        self.speed = speed;
        println!("{} is driving at {} km/h", self.brand, self.speed);
    }
}

// 定义一个 Trait（接口）
trait Honk {
    fn honk(&self);
}

// 给 Car 实现 Trait
impl Honk for Car {
    fn honk(&self) {
        println!("{} says: Beep Beep!", self.brand);
    }
}

fn main() {
    let mut my_car = Car::new("Tesla");
    my_car.drive(100);
    my_car.honk();
}
