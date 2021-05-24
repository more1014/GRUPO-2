1
create table authority(
	name varchar(40) primary key
);

2
create table system_user_parking(
	id int4 primary key,
	login varchar(50) not null,
	password varchar(60)not null,
	email varchar(250)not null,
	vehicle varchar(40)not null,
	constraint uk_login unique (login),
	constraint uk_email unique (email)
);

3
create table user_authority(
	name_rol varchar(50),
	id_system_user_parking int4,
	constraint fk_aut_user foreign key (name_rol) references authority (name),
	constraint fk_sys_user foreign key (id_system_user_parking) references system_user_parking (id),
	constraint pk_user primary key (name_rol,id_system_user_parking)
);

4
create table document_type(
	id int4 primary key,
	sigla varchar(10)not null,
	document_name varchar(100)not null,
	condition varchar(40)not null,
	constraint uk_document_type unique (sigla,document_name)
);

5
create table client(
	id int4 primary key,
	id_document_type int4 not null,
	document_number varchar(40)not null,
	first_name varchar(40)not null,
	second_name varchar(40),
	first_last_name varchar(40)not null,
	second_last_name varchar(40),	
	id_system_user_parking int4 not null,
	vehicle_type int4 not null,
	constraint fk_sys_cli foreign key (id_system_user_parking) references system_user_parking (id),
	constraint fk_typ_cli foreign key (id_document_type) references document_type (id),
	constraint uk_cliente unique (id_document_type,document_number),
	constraint uk_user unique (id_system_user_parking)
);

6
create table log_error(
	id int4 primary key,
	log_name varchar(400)not null,
	message varchar(400)not null,
	fecha date not null,
	id_client int4 not null,
	constraint fk_clie_log_erro foreign key (id_client) references client (id)
);

7
create table log_audit(
	id int4 primary key,
	log_name varchar(400)not null,
	message varchar(400)not null,
	fecha date not null,
	id_client int4 not null,
	constraint fk_clie_log_audi foreign key (id_client) references client (id)
);

8
create table service_type(
	id int4 primary key,
	visitant int4 not null,
	employee int4 not null,
	supplier int4 not null
);

9
create table vehicle_type(
	id int4 primary key ,
	id_service_type int4 not null,
	vehicle_person varchar(40) not null,
	plates varchar(10) not null,
	color varchar(20),
	trademark varchar(40),
	property_card int4 not null,
	constraint fk_ser_vety foreign key (id_service_type) references service_type (id),
	constraint uk_vehicle_type unique (id_service_type,vehicle_person,property_card)
);

10
create table person(
	id int4 primary key,
	id_service_type int4 not null,
	id_vehicle_type int4 not null,
	name_person varchar(40) not null,
	id_client int4 not null,
	vehicle_type varchar(10)not null,
	property_card int4 not null,
	constraint fk_ser_per foreign key (id_service_type) references service_type (id),
	constraint fk_vety_per foreign key (id_vehicle_type) references vehicle_type (id),
	constraint fk_cli_per foreign key (id_client) references client (id),
	constraint uk_person unique (id_service_type,id_client,property_card,id_vehicle_type)
);


11
create table parking(
	id int4 primary key,
	place_visitant int4 not null,
	place_employee int4 not null,
	place_supplier int4 not null,
	id_person int4 not null,
	parking_only_place varchar(10) not null,
	constraint fk_per_par foreign key (id_person) references person (id),
	constraint uk_parking unique (parking_only_place)
);


12
create table turn(
	id int4 primary key,
	id_turn int4 not null,
	morning varchar(10)not null,
	afternoon varchar(10)not null,
	nigth varchar(10)not null,
	constraint uk_turn unique (id_turn)
);


13
create table register_input_and_output(
	id int4 primary key,
	id_turn int4 not null,
	condition varchar(40)not null,
	start_time int4 not null,
	end_time int4 not null,
	day date not null,
	id_parking int4 not null,
	constraint fki_par_reino foreign key (id_parking) references parking (id),
	constraint fk_turn_reino foreign key (id_turn) references turn (id),
	constraint uk_regis unique (id_parking,start_time,end_time,condition)
);	


14
create table person_type(
	id int4 primary key,
	id_client int4 not null,
	id_service_type int4 not null,
	id_register_input_and_output int4 not null,
	constraint fk_cli_pety foreign key (id_client) references client (id),
	constraint fk_sety_pety foreign key (id_service_type) references service_type (id),
	constraint fk_reino_pety foreign key (id_register_input_and_output) references register_input_and_output (id),
	constraint uk_pety unique (id_client,id_service_type,id_register_input_and_output)
);