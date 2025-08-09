trait Foo { fn get(&self) -> u64; }
struct Bar(u64);
impl Foo for Bar { fn get(&self) -> u64 { self.0 } }

fn main() {
    let v: Vec<Box<dyn Foo>> = (0..5_000_000).map(|i| Box::new(Bar(i)) as Box<dyn Foo>).collect();
    let s: u64 = v.iter().map(|x| x.get()).sum();
    println!("{}", s);
}
