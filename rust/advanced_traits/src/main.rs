// Associated types:
pub trait Iterator {
    type Item;

    fn next(&mut self) -> Option<Self::Item>;
}

struct Counter { }

impl Iterator for Counter {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {
        // ...
        None
    }
}

// Generics vs associated types:
trait GGraph<Node, Edge> {
}

trait AGraph {
    type Node;
    type Edge;
}

fn gdistance<N, E, G: GGraph<N, E>>(graph: &G, start: &N, end: &N) -> u32 {
    // ...
    0
}

fn adistance<G: AGraph>(graph: &G, start: &G::Node, end: &G::Node) -> u32 {
    // ...
    0
}

// Trait objects with associated types:
fn traverse(graph: &AGraph<Node=usize, Edge=(usize, usize)>) {
    // ...
}

// Operator oerloading and default type parameters:
use std::ops::Add;

#[derive(Debug, PartialEq)]
struct Point {
    x: i32,
    y: i32,
}

impl Add for Point {
    type Output = Point;

    fn add(self, other: Point) -> Point {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}

struct Millimiters(u32);
struct Meters(u32);

impl Add for Millimiters {
    type Output = Millimiters;

    fn add(self, other: Millimiters) -> Millimiters {
        Millimiters(self.0 + other.0)
    }
}

impl Add<Meters> for Millimiters {
    type Output = Millimiters;

    fn add(self, other: Meters) -> Millimiters {
        Millimiters(self.0 + (other.0 * 1000))
    }
}

// Disambiguating methods:
trait Pilot {
    fn fly(&self);
}

trait Wizard {
    fn fly(&self);
}

struct Human;

impl Pilot for Human {
    fn fly(&self) {
        println!("This is your captain speaking.");
    }
}

impl Wizard for Human {
    fn fly(&self) {
        println!("Up!");
    }
}

impl Human {
    fn fly(&self) {
        println!("*waving arms*");
    }
}

// Newtype pattern:
use std::fmt;

struct Wrapper(Vec<String>);

impl fmt::Display for Wrapper {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "[{}]", self.0.join(", "))
    }
}

fn main() {
    assert_eq!(Point { x: 1, y: 0 } + Point { x: 2, y : 3 },
               Point { x: 3, y: 3 });

    let person = Human;
    person.fly();
    Pilot::fly(&person);
    Wizard::fly(&person);

    let w = Wrapper(vec![String::from("hello"), String::from("world")]);
    println!("{}", w);
}
