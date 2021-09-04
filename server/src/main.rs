extern crate env_logger;
use actix_files::Files;
use actix_web::{middleware, App, HttpServer};

// Eventually something like this...
// use actix_files as fs;
// use actix_web::{web, App, HttpResponse, HttpServer, Result};
// use askama::Template;
// #[derive(Template)]
// #[template(path = "page.html")]
// struct PageTemplate<'a> {
//     title: &'a str,
//     page: &'a str,
// }
// async fn home() -> Result<HttpResponse> {
//     let body = PageTemplate {
//         title: "Home",
//         page: "Home",
//     }
//     .render()
//     .unwrap();
//     Ok(HttpResponse::Ok().content_type("text/html").body(body))
// }

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Should probably set this... not here?
    std::env::set_var("RUST_LOG", "actix_web=debug");
    env_logger::init();

    println!("listening on 0.0.0.0:8000");
    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            // .service(web::resource("/").route(web::get().to(home)))
            .service(Files::new("/", "../client/dist").index_file("index.html"))
    })
    .bind("0.0.0.0:8000")?
    .run()
    .await
}
