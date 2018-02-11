fn main() {
    another_function(5, 6);
    expr();

    let x = plus_one(1);
    println!("x is {}", x);

    let number = 6;

    if number < 5 {
        println!("true");
    } else {
        println!("false");
    }

    if number % 4 == 0 {
        println!("number divisible by 4");
    } else if number % 3 == 0 {
        println!("number divisible by 3");
    } else if number % 2 == 0 {
        println!("number divisible by 2");
    } else {
        println!("number not divisible by 4, 3, or 2");
    }

    let condition = true;
    let number = if condition { 5 } else { 6 };

    println!("number is {}", number);
}

fn another_function(x: i32, y: i32) {
    println!("x is: {}", x);
    println!("y is: {}", y);
}

fn expr() {
    let x = 5;

    let y = {
        let x = 3;
        x + 1
    };

    println!("The value of y is: {}", y);
}

fn five() -> i32 {
    5
}

fn plus_one(x: i32) -> i32 {
    x + 1
}
