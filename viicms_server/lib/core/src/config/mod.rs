use std::fs;
use toml::from_str;
use super::config::application_config::ApplicationConfig;
pub mod application_config;

pub fn load_config() -> Result<ApplicationConfig, Box<dyn std::error::Error>>{
    let toml_str = fs::read_to_string("conf/application.toml")?;
    let config: ApplicationConfig = from_str(&toml_str)?;
    Ok(config)
}