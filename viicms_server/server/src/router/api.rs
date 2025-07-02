use actix_web::{get, web, HttpResponse, Responder};
const path:&str = "/v1";
#[get("/test")]
async fn test()->  impl Responder {
    HttpResponse::Ok().body("OK")
}


pub fn vii_api(cfg: &mut web::ServiceConfig) {
    cfg.service(web::scope(path).service(test));
}