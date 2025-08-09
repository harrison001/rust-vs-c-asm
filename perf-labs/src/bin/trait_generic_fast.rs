trait Foo { fn get(&self) -> u64; }
#[inline(always)]
fn sum<T: Foo>(v: &[T]) -> u64 { v.iter().map(|x| x.get()).sum() }

struct Bar(u64);
impl Foo for Bar { #[inline(always)] fn get(&self) -> u64 { self.0 } }

fn main() {
    let v: Vec<Bar> = (0..5_000_000).map(Bar).collect();
    println!("{}", sum(&v));
}
