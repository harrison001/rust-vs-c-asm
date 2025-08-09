use tokio::task;
use futures::future::join_all;

#[tokio::main]
async fn main() {
    let batches = 100;
    let per = 1000; // 100k total
    let mut hs = vec![];
    for _ in 0..batches {
        hs.push(task::spawn(async move {
            let mut acc = 0u64;
            for _ in 0..per { acc += 1; }
            acc
        }));
    }
    let _sum: u64 = join_all(hs).await.into_iter().map(Result::unwrap).sum();
    println!("done");
}
