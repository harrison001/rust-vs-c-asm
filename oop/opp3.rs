// “基类”的角色：公共状态 + 公共方法
struct Base {
    id: u64,
}
impl Base {
    fn id(&self) -> u64 { self.id }
    fn common_logic(&self) -> String { format!("Base#{}", self.id) }
}

// “子类”的角色：包含 Base（组合），并扩展自己的行为
struct Derived {
    base: Base,         // 组合：持有 Base
    extra: String,      // 自己的扩展字段
}

impl Derived {
    fn new(id: u64, extra: &str) -> Self {
        Self { base: Base { id }, extra: extra.into() }
    }
    // 委托“基类”的公共方法
    fn id(&self) -> u64 { self.base.id() }
    fn common_logic(&self) -> String { self.base.common_logic() }
    // 自己新增/覆盖的方法（想“改写”就别直接委托，写自己的实现）
    fn describe(&self) -> String {
        format!("Derived({}, extra={})", self.common_logic(), self.extra)
    }
}

fn main() {
    let d = Derived::new(42, "more");
    println!("{}", d.id());           // 来自 Base（委托）
    println!("{}", d.describe());     // 子类扩展
}
