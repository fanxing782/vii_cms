use serde::Deserialize;
use crate::config::default_config::*;

#[derive(Debug, Deserialize)]
pub struct ApplicationConfig {
    #[serde(default)]
    pub server: Server,
    #[serde(default)]
    pub web: Web,
    #[serde(default)]
    pub cors: Cors,
    pub database: DataBase,
}

#[derive(Debug, Deserialize)]
pub struct DataBase {
    #[serde(default = "default_db_type")]
    pub db_type: String,
}

fn default_db_type() -> String {
    "postgres".to_string()
}

#[derive(Debug, Deserialize)]
pub struct Server {
    #[serde(default = "default_port")]
    pub port: u16,
    #[serde(default = "default_path")]
    pub path: String,
    #[serde(default = "default_host")]
    pub host: String,
}

fn default_port() -> u16 {
    DEFAULT_PORT
}
fn default_path() -> String {
    DEFAULT_PATH.to_string()
}
fn default_host() -> String {
    DEFAULT_HOST.to_string()
}
impl Default for Server {
    fn default() -> Self {
        Self {
            port: DEFAULT_PORT,
            path: DEFAULT_PATH.to_string(),
            host: DEFAULT_HOST.to_string(),
        }
    }
}

#[derive(Debug, Deserialize)]
pub struct Web {
    #[serde(default = "default_web_theme")]
    pub theme: String,
    #[serde(default)]
    pub admin: Admin
}
fn default_web_theme() -> String {
    WEB_THEME.to_string()
}

impl Default for Web {
    fn default() -> Self {
        Self {
            theme: default_web_theme(),
            admin: Default::default(),
        }
    }
}

#[derive(Debug, Deserialize)]
pub struct Admin {
    #[serde(default = "default_admin_path")]
    pub path: String,
    #[serde(default = "default_admin_upload_path")]
    pub upload_path: String
}

fn default_admin_path() -> String {
    ADMIN_PATH.to_string()
}
fn default_admin_upload_path() -> String {
    ADMIN_UPLOAD_PATH.to_string()
}

impl Default for Admin {
    fn default() -> Self {
        Self {
            path: default_admin_path(),
            upload_path: default_admin_upload_path(),
        }
    }
}

#[derive(Debug, Deserialize)]
pub struct Cors {
    #[serde(default = "default_cors_enable")]
    pub enable: bool,
    #[serde(default = "default_cors_permissive")]
    pub permissive: bool,
    #[serde(default)]
    pub configurations: Vec<CorsConfigurations>
}

fn default_cors_enable() -> bool {
    CORS_ENABLE
}
fn default_cors_permissive() -> bool {
    CORS_PERMISSIVE
}

impl Default for Cors {
    fn default() -> Self {
        Self {
            enable: default_cors_enable(),
            permissive: default_cors_permissive(),
            configurations: Vec::new(),
        }
    }
}

#[derive(Debug, Clone,Deserialize)]
pub struct CorsConfigurations {
    #[serde(default = "default_cors_path")]
    pub path: String,
    #[serde(default = "default_cors_origins")]
    pub allowed_origins: String,
    #[serde(default = "default_cors_methods")]
    pub allowed_methods: String,
    #[serde(default = "default_cors_headers")]
    pub allowed_headers: String,
    #[serde(default = "default_cors_credentials")]
    pub allow_credentials: bool
}

fn default_cors_path() -> String { "/**".to_string() }
fn default_cors_origins() -> String { "*".to_string() }
fn default_cors_methods() -> String { "*".to_string() }
fn default_cors_headers() -> String { "*".to_string() }
fn default_cors_credentials() -> bool { false }

impl Default for CorsConfigurations {
    fn default() -> Self {
        Self {
            path: default_cors_path(),
            allowed_origins: default_cors_origins(),
            allowed_methods: default_cors_methods(),
            allowed_headers: default_cors_headers(),
            allow_credentials: default_cors_credentials(),
        }
    }
}