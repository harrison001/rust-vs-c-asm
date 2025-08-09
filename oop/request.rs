use reqwest::Client;

#[tokio::main]
async fn main() -> Result<(), reqwest::Error> {
    let client = Client::builder()
        .user_agent("my-agent")
        .build()?;                          // 来自 impl Client

    let resp = client.get("https://httpbin.org/get")
        .send().await?                      // 方法链（impl 里实现）
        .text().await?;
    println!("{resp}");
    Ok(())
}
