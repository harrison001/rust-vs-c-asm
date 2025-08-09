use tokio::task;

#[tokio::main]
async fn main() {
    let mut hs = vec![];
    for _ in 0..100_000 {
        hs.push(task::spawn(async { 1 }));
    }
    for h in hs { let _ = h.await; }
    println!("done");
}
