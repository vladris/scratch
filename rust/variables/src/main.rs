const MAX_POINTS: u32 = 100_000;

fn main() {
    let mut x = 5;
    println!("The value of x is: {}", x);
    x = 6;
    println!("The value of x is: {}", x);

    let y = 5;
    let y = y + 1;
    let y = y * 2;

    println!("The value of y is: {}", y);

    let spaces = "    ";
    let spaces = spaces.len();

    let tup = (500, 6.4, 1);
    let (t1, t2, t3) = tup;

    println!("The values are: {} {} {}", t1, t2, t3);
    println!("The values are: {} {} {}", tup.0, tup.1, tup.2);

    let a = [1, 2, 3, 4, 5];
    println!("{} {}", a[0], a[1]);

    another_function();
}

fn another_function() {
    println!("Another function");
}
