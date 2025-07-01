mod api;

use actix_web::web;

pub fn vii_router(cfg: &mut web::ServiceConfig) {
    cfg.configure(api::vii_api);
}