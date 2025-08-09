trait Animal { fn speak(&self) -> &'static str; }
struct Dog;  impl Animal for Dog { fn speak(&self) -> &'static str { "woof" } }
struct Cat;  impl Animal for Cat { fn speak(&self) -> &'static str { "meow" } }

// A) 动态分发：运行时通过 vtable 调用（类似虚函数指针）
fn demo_dyn(v: &[Box<dyn Animal>]) {
    for a in v { println!("{}", a.speak()); } // 间接调用，不能内联
}

// B) 静态分发：泛型 + trait bound，编译期单态化（zero-cost）
fn demo_generic<T: Animal>(v: &[T]) {
    for a in v { println!("{}", a.speak()); } // 可内联，通常更快
}

fn main() {
    let zoo_dyn: Vec<Box<dyn Animal>> = vec![Box::new(Dog), Box::new(Cat)];
    demo_dyn(&zoo_dyn);

    let zoo_generic = vec![Dog, Dog, Dog];
    demo_generic(&zoo_generic);
}
