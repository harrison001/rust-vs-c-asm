use regex::Regex;

fn main() -> Result<(), regex::Error> {
    let re = Regex::new(r"^\w+@\w+\.\w+$")?;  // impl 里提供的构造函数
    println!("{}", re.is_match("foo@bar.com")); // 调用方法
    Ok(())
}
