use serde::{Serialize, Deserialize};

#[derive(Serialize, Deserialize)]
struct User { id: u64, name: String }

fn main() {
    let u = User { id: 1, name: "Alice".into() };
    let s = serde_json::to_string(&u).unwrap();
    println!("{s}");
}
