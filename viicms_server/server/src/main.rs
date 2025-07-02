mod router;

use actix_cors::Cors;
use actix_files::Files;
use actix_web::{web, App, HttpServer};
use std::collections::HashSet;

const ADMIN_FOLDER: &str = "./static/admin";

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let config = core::config::load_config().unwrap();
    let bind_address = config.server.host;
    let port = config.server.port;
    let api_path = config.server.path;
    let admin_path = config.web.admin.path;
    let static_path = format!("./static/{}", config.web.theme);

    let cors_enable = config.cors.enable;
    let cors_permissive = config.cors.permissive;
    let configurations = config.cors.configurations.clone();

    HttpServer::new(move || {
        let cors = if cors_enable && cors_permissive {
            Cors::permissive()
        } else if cors_enable {
            let origins_set: HashSet<String> = configurations.iter()
                .flat_map(|conf| conf.allowed_origins.split(','))
                .map(|s| s.trim().to_string())
                .collect();

            let mut cors_builder = Cors::default()
                .allow_any_method()
                .supports_credentials()
                .max_age(3600);

            cors_builder = cors_builder.allowed_origin_fn(move |origin, _| {
                origin.to_str()
                    .map(|origin_str| origins_set.contains(origin_str))
                    .unwrap_or(false)
            });

            if let Some(conf) = config.cors.configurations.first() {
                cors_builder = cors_builder.allowed_headers(
                    conf.allowed_headers.split(',')
                        .map(|s| s.trim())
                        .collect::<Vec<_>>()
                );
            }
            cors_builder
        } else {
            Cors::default()
        };

        App::new()
            .wrap(cors)
            // 接口路由
            .service(web::scope(&api_path).configure(router::vii_router))
            // 后台管理页面
            .service(Files::new(&admin_path, ADMIN_FOLDER).index_file("index.html"))
            // 用户前台
            .service(Files::new("/", &static_path).index_file("index.html"))
    })
        .bind((bind_address, port))?
        .run()
        .await
}