
create type user_type as enum ('alumno', 'profesor');

create type alumn_type as enum('por_cursar', 'cursando', 'graduado');

create type cobro_pago_type as enum ('remesa30','remesa3060','total');

create type asign_type as enum('en_curso','realizada');

create type cobro_est_type as enum('cobrado','pendiente');

create table usuarios(
	usuario_id serial primary key,
	nombre varchar(150) not null,
	password varchar(255) not null,
	tipo user_type not null,
	email varchar(100) not null unique,
	telefono varchar(20) not null,
	descripcion varchar(255) not null,
	fecha_registro date not null
	);

create table alumnos(
	usuario_id int primary key,  
	estado alumn_type not null,
	dni varchar(20) not null unique,
	foreign key (usuario_id) references usuarios(usuario_id)
	);

create table profesores(
	usuario_id int primary key, 
	categoria varchar(100),
	foreign key (usuario_id) references usuarios(usuario_id)
	);

create table bootcamps(
	bootcamp_id serial primary key,
	descripcion varchar(150) not null,
	tiempo_duracion int not null,
	precio decimal(10,2) not null,
	fecha_inicio date not null
	);

create table cobros(
	cobros_id serial primary key,
	estado cobro_est_type not null,
	fecha_pago date not null,
	pago decimal(10,2) not null,
	bootcamp_id int not null,
	usuario_id int not null,
	foreign key (bootcamp_id) references bootcamps(bootcamp_id),
	foreign key (usuario_id) references usuarios(usuario_id)
	);
	
create table modulos(
	modulos_id serial primary key,
	descripcion varchar(255) not null,
	bootcamp_id int not null,
	foreign key (bootcamp_id) references bootcamps(bootcamp_id)
	);

create table asignatura(
	asignatura_id serial primary key,
	descripcion varchar(255) not null,
	estado asign_type not null 
	);

create table alumnos_bootcamps (
    usuario_id int not null,
    bootcamp_id int not null,
    estado varchar(100) not null,
    fecha_finalizacion date not null,
    primary key (usuario_id, bootcamp_id),
    foreign key (usuario_id) references alumnos(usuario_id),
    foreign key (bootcamp_id) references bootcamps(bootcamp_id)
	);

create table alumnos_modulos (
    usuario_id int not null,
    modulos_id int not null,
    estado varchar(100) not null,
    fecha_finalizacion date not null,
    intento int not null ,
    primary key (usuario_id, modulos_id),
    foreign key (usuario_id) references alumnos(usuario_id),
    foreign key (modulos_id) references modulos(modulos_id)
	);

create table asignatura_modulos (
    asignatura_id int not null,
    modulos_id int not null,
    primary key (asignatura_id, modulos_id),
    foreign key (asignatura_id) references asignatura(asignatura_id),
    foreign key (modulos_id) references modulos(modulos_id)
	);

create table profesores_asignatura (
    usuario_id int not null,
    asignatura_id int not null,
    primary key (usuario_id, asignatura_id),
    foreign key (usuario_id) references profesores(usuario_id),
    foreign key (asignatura_id) references asignatura(asignatura_id)
	);

