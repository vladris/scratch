use std::collections::HashMap;

fn main() {
    let (mean, median, mode) = mean_median_mode(vec![1, 2, 3, 4, 5, 4, 6]);
    println!("{} {} {}", mean, median, mode);
    println!("{}", pig_latin(&String::from("hello world apple")));
}

fn mean_median_mode(mut numbers: Vec<i32>) -> (f32, i32, i32) {
    let mean = numbers.iter().fold(0f32, |sum, val| sum + (*val as f32)) / (numbers.len() as f32);

    numbers.sort();
    let median = numbers[numbers.len() / 2];

    let mut items = HashMap::new();
    for i in numbers.iter() {
        let count = items.entry(i).or_insert(0);
        *count += 1;
    }

    let mode = *items.keys().fold(
        *items.keys().last().unwrap(),
        |max, key| if items[key] > items[max] { key } else { max }
    );
    
    (mean, median, mode)
}

fn pig_latin(s: &String) -> String {
    let mut result: Vec<String> = vec![];

    for word in s.split_whitespace() {
        let mut word = String::from(word);
        let fst = word.remove(0);
        match String::from("aeiouAEIOU").find(fst) {
            Some(_) => { word = fst.to_string() + &word + "-hay"; }
            None => { word = word + "-" + &fst.to_string() + "ay"; }
        }

        result.push(word);
    }

    result.join(" ")
}


