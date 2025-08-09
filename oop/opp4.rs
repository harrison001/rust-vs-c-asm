// 父“接口”
trait Animal {
    // “虚函数”：提供默认实现，可在子类型里覆盖
    fn speak(&self) -> String { String::from("...") }
}

// 子“接口”继承父接口（supertrait）
trait Pet: Animal {
    fn name(&self) -> &str;
    // 也可以再给默认实现
    fn intro(&self) -> String {
        format!("I'm {} and I say {}", self.name(), self.speak())
    }
}

// 具体类型1：Dog
struct Dog { name: String }
impl Animal for Dog {
    // 覆盖默认实现（override）
    fn speak(&self) -> String { String::from("woof") }
}
impl Pet for Dog {
    fn name(&self) -> &str { &self.name }
}

// 具体类型2：Cat（不覆盖 speak，沿用 Animal 的默认实现）
struct Cat { name: String }
impl Animal for Cat {} // 使用默认的 speak() -> "..."
impl Pet for Cat {
    fn name(&self) -> &str { &self.name }
}

fn main() {
    let d = Dog { name: "Rex".into() };
    let c = Cat { name: "Mimi".into() };
    // 多态（见下一节会用 trait object 更明显）
    println!("{}", d.intro()); // I'm Rex and I say woof
    println!("{}", c.intro()); // I'm Mimi and I say ...
}
