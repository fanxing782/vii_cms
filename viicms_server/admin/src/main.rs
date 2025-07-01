mod router;
use actix_cors::Cors;
use actix_files::Files;
use actix_web::{web, App, HttpServer};

#[actix_web::main]
async fn main()  -> std::io::Result<()> {
    // 未成功加载配置文件，需阻塞下方执行
    let config = core::config::load_config().unwrap();
    let bind_address = config.server.host;
    let port = config.server.port;
    let path = config.server.path;
    let static_path = format!("./static/{}",config.web.theme);
    HttpServer::new(move || {
        App::new()
            .wrap(Cors::permissive())
            .service(web::scope(&path)
                .service(Files::new("/", &static_path).index_file("index.html"))
                .configure(router::vii_router))
    })
        .bind((bind_address, port))?
        .run()
        .await
}
