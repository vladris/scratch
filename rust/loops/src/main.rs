fn main() {
    /*
    loop {
        println!("again!");
    }
    */

    let mut number = 3;

    while number != 0 {
        println!("{}!", number);
        number = number - 1;
    }

    let a = [10, 20, 30, 40, 50];

    for element in a.iter() {
        println!("{}", element);
    }

    for number in (1..4).rev() {
        println!("{}", number);
    }

    println!("{}", fib(10));
}

fn fib(n: i32) -> i32 {
    if n == 0 { return 0; }

    let mut a = 0;
    let mut b = 1;

    for _ in 2..n {
        let c = a + b;
        a = b;
        b = c;
    }

    b
}
