# Practice service with Rust

### Notes

Using with logger:

```rust
// init the logger first

fn main() {
    env_logger::init();
    
    debug!("hello")
}

// run the program with the variable RUST_LOG to define the log level of the application
```