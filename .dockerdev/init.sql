CREATE USER postgres WITH SUPERUSER;
CREATE USER railsapp_user WITH SUPERUSER;
CREATE DATABASE railsapp_development OWNER railsapp_user;
CREATE DATABASE railsapp_test OWNER railsapp_user;
