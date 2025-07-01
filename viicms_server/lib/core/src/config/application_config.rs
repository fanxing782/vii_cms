use serde::Deserialize;

#[derive(Debug, Deserialize)]
pub struct ApplicationConfig{
    pub server: Server,
    pub database: DataBase,
    pub web:Web
}

#[derive(Debug, Deserialize)]
pub struct Server{
    pub port:u16,
    pub path:String,
    pub host:String,
}

#[derive(Debug, Deserialize)]
pub struct DataBase{
    pub db_type:String
}
#[derive(Debug, Deserialize)]
pub struct Web{
    pub theme:String,
    pub upload_path:String
}
