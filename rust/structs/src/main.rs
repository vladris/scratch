struct User {
    username: String,
    email: String,
    sign_in_count: u64,
    active: bool,
}

fn main() {
    let mut user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someone"),
        sign_in_count: 0,
        active: true,
    };

    user1.email = String::from("someoneelse@example.com");

    let user1 = build_user(String::from("someone"), String::from("someone@example.com"));

    let user2 = User {
        email: String::from("a@b.com"),
        username: String::from("a"),
        ..user1
    };

    struct Point(i32, i32, i32);

    let origin = Point(0, 0, 0);
}

fn build_user(username: String, email: String) -> User {
    User {
        username, // field init shorthand syntax
        email,
        sign_in_count: 1,
        active: true,
    }
}
