fn main() {
    let s = String::from("Hello, world!");

    let (s, l) = calculate_length(s);

    println!("{} {}", s, l);

    let l = calculate_length2(&s);

    println!("{} {}", s, l);


    let mut ms = String::from("Mutable");
    {
        let r1 = &mut ms;
    }
    let r2 = &mut ms;

    // Slices
    let hello = first_word_slice(&s);
    let hello = first_word_slice("Hello world!");
    let hello = first_word_slice(&"Hello world!"[..]);
}


fn calculate_length(s: String) -> (String, usize) {
    let length = s.len();

    (s, length)
}

fn calculate_length2(s: &String) -> usize {
    s.len()
}

fn first_word(s: &String) -> usize {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return i;
        }
    }

    s.len()
}

fn first_word_slice(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }

    s
}
