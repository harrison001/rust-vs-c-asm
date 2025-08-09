use tokio::io::{self, AsyncReadExt}; // 引入 trait，才有 read_to_end 等方法
use tokio::fs::File;

#[tokio::main]
async fn main() -> io::Result<()> {
    let mut f = File::open("Cargo.toml").await?;
    let mut buf = Vec::new();
    f.read_to_end(&mut buf).await?;        // 这是 trait 提供的扩展方法
    println!("bytes: {}", buf.len());
    Ok(())
}
