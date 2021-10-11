drop database if exists gym;

create database if not exists gym;

use gym;

create table membresia(
	id bigint unsigned not null auto_increment,
    tipo varchar(30) not null,
    precio double not null,
    constraint pk_id primary key(id),
    constraint uq_tipo unique(tipo)
);

create table forma_pago(
	id bigint unsigned not null auto_increment,
    nombre varchar(50) not null,
    constraint pk_id primary key(id),
    constraint uq_nombre unique(nombre)
);

create table entrenador(
	id bigint unsigned not null auto_increment,
    nombre varchar(120) not null,
    sexo enum("MASCULINO", "FEMENINO", "OTRO") not null,
    fecha_nacimiento date not null,
    correo varchar(120) not null,
    telefono varchar(15) not null,
    usuario varchar(50) not null,
    contrasena varchar(60) not null,
    fecha_registro date not null,
    constraint pk_id primary key(id)
);

insert into entrenador values(1, "SIN ENTRENADOR", "OTRO", "","","","","","");

create table cliente(
	id bigint unsigned not null auto_increment,
    id_entrenador bigint unsigned not null default 1,
    nombre varchar(120) not null,
    sexo enum("MASCULINO", "FEMENINO", "OTRO") not null,
    fecha_nacimiento date not null,
    correo varchar(120) not null,
    telefono varchar(15) not null,
    usuario varchar(50) not null,
    contrasena varchar(60) not null,
    fecha_registro date not null,
    constraint pk_id primary key(id),
    constraint fk_id_entrenador_cliente foreign key (id_entrenador) references entrenador(id)
);

create table pago_membresia(
	id bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    id_membresia bigint unsigned not null,
    id_forma_pago bigint unsigned not null,
    fecha_venta date not null,
    fecha_inicio date not null,
    fecha_fin date not null,
    precio double not null,
    constraint pk_id primary key(id),
    constraint fk_id_cleinte_pago_membresia foreign key(id_cliente) references cliente(id),
    constraint fk_id_membresia_pago_membresia foreign key(id_membresia) references membresia(id),
    constraint fk_id_forma_pago_pago_membresia foreign key(id_forma_pago) references forma_pago(id)
);

create table equipo(
	id bigint unsigned not null auto_increment,
    nombre varchar(100) not null,
    foto varchar(100) not null,
    precio double not null,
    cantidad int unsigned not null,
    constraint pk_id primary key(id)
);

create table rutina(
	id bigint unsigned not null auto_increment,
    id_cliente bigint unsigned not null,
    plantilla boolean not null,
    constraint pk_id primary key(id),
    constraint fk_rutina_cliente foreign key(id_cliente) references cliente(id)
);

create table ejercicio(
	id bigint unsigned not null auto_increment,
    nombre varchar(100) not null,
    foto varchar(100) not null,
    video varchar(100) not null,
    instrucciones text not null,
    id_equipo bigint unsigned not null,
    constraint pk_id primary key(id),
    constraint fk_id_equipo_ejercicio foreign key(id_equipo) references equipo(id)
);

create table plantilla(
	id bigint unsigned not null auto_increment,
    id_rutina bigint unsigned not null,
    nombre varchar(100) not null,
    constraint pk_id primary key(id),
    constraint fk_id_rutina_plantilla foreign key(id_rutina) references rutina(id)
);

create table serie(
	id bigint unsigned not null auto_increment,
    id_rutina bigint unsigned not null,
    id_ejercicio bigint unsigned not null,
    peso double not null,
    repeticiones tinyint unsigned not null,
    unidad varchar(30) not null,
    peso_levantado double not null,
    repeticiones_hechas tinyint unsigned not null,
    constraint pk_id primary key(id),
    constraint fk_id_rutina_serie foreign key(id_rutina) references rutina(id),
    constraint fk_id_ejercicio_serie foreign key(id_ejercicio) references ejercicio(id)
);