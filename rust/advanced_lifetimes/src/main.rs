// Lifetime subtyping:
struct Context<'s>(&'s str);

struct Parser<'c, 's: 'c> {
    context: &'c Context<'s>,
}

impl<'c, 's> Parser<'c, 's> {
    fn parse(&self) -> Result<(), &'s str> {
        Err(&self.context.0[1..])
    }
}

fn parse_context(context: Context) -> Result<(), &str> {
    Parser { context: &context }.parse()
}

// Lifetime bounds:
struct Ref<'a, T: 'a>(&'a T);

struct StaticRef<T: 'static>(&'static T);

// Trait object lifetimes:
trait Foo { }

struct Bar<'a> {
    x: &'a i32,
}

impl<'a> Foo for Bar<'a> { }


fn main() {
    let num = 5;

    let obj = Box::new(Bar { x: &num }) as Box<Foo>;
}
