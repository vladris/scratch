#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }

    fn square(size: u32) -> Rectangle {
        Rectangle { width: size, height: size }
    }
}

fn main() {
    let width1 = 30;
    let height1 = 50;

    println!(
        "Area is {} square pixels",
        area1(width1, height1)
    );

    let rect1 = (30, 50);

    println!(
        "Area is {} square pixels",
        area2(rect1)
    );

    let rect2 = Rectangle { width: 30, height: 50 };

    println!(
        "Area is {} square pixels",
        // area3(&rect2)
        rect2.area()
    );

    println!("{:#?}", rect2);

    let rect1 = Rectangle { width: 30, height: 50 };
    let rect2 = Rectangle { width: 10, height: 40 };
    let rect3 = Rectangle { width: 60, height: 45 };
    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3)); 

    let sq = Rectangle::square(3);
}

fn area1(width: u32, height: u32) -> u32 {
    width * height
}

fn area2(dimensions: (u32, u32)) -> u32 {
    dimensions.0 * dimensions.1
}

fn area3(rectangle: &Rectangle) -> u32 {
    rectangle.width * rectangle.height
}
